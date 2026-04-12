from datetime import datetime, time as dtime
from pathlib import Path
from urllib.parse import urlencode
import uuid

from django.conf import settings
from django.contrib import messages
from django.db import IntegrityError
from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
from django.shortcuts import redirect, render
from django.urls import reverse
from django.utils import timezone

from .forms import EntregaForm
from .models import Sprint, Squad, Task, TaskImage


def _to_aware(value):
    if value is None:
        return None
    if timezone.is_naive(value):
        return timezone.make_aware(value, timezone.get_current_timezone())
    return value


def _date_end_of_day(d):
    if d is None:
        return None
    combined = datetime.combine(d, dtime(23, 59, 59))
    return _to_aware(combined)


def _local_date(dt):
    if timezone.is_aware(dt):
        return timezone.localtime(dt).date()
    return dt.date()


def _create_squad_nova(nome: str) -> Squad:
    return Squad.objects.create(
        name=nome,
        mission="-",
        created_at=timezone.now(),
        is_active=1,
    )


def _get_current_sprint(sprints_qs):
    today = timezone.now().date()
    current = sprints_qs.filter(
        start_date__lte=today,
        end_date__gte=today,
    ).first()

    if current:
        sprints_list = list(sprints_qs)
        return current, sprints_list.index(current)

    return sprints_qs.first(), 0


def _default_sprint(request):
    sprints = Sprint.objects.all().order_by("start_date")
    if not sprints.exists():
        return None
    sid = request.GET.get("sprint_id")
    if sid:
        found = sprints.filter(id=sid).first()
        if found:
            return found
    chosen, _ = _get_current_sprint(sprints)
    return chosen


def index(request):
    sprints = Sprint.objects.all().order_by("start_date")

    selected_sprint_id = request.GET.get("sprint_id")
    if selected_sprint_id:
        selected_sprint = sprints.filter(id=selected_sprint_id).first()
        sprints_list = list(sprints)
        selected_index = (
            sprints_list.index(selected_sprint)
            if selected_sprint in sprints_list
            else 0
        )
    else:
        selected_sprint, selected_index = _get_current_sprint(sprints)

    if sprints.exists() and 0 <= selected_index < len(sprints):
        selected_sprint = sprints[selected_index]
        period_start = _local_date(selected_sprint.start_date)
        period_end = _local_date(selected_sprint.end_date)
        entregas = (
            Task.objects.filter(
                completed_at__isnull=False,
                completed_at__date__gte=period_start,
                completed_at__date__lte=period_end,
            )
            .select_related("squad")
            .prefetch_related("taskimage_set")
            .order_by("-completed_at", "-created_at")
        )
    else:
        selected_sprint = None
        entregas = Task.objects.none()

    return render(
        request,
        "poc/home.html",
        {
            "sprints": sprints,
            "selected_index": selected_index,
            "selected_sprint": selected_sprint,
            "entregas": entregas,
        },
    )


def cadastro(request):
    pode_cadastrar = Sprint.objects.exists()
    default_sp = _default_sprint(request) if pode_cadastrar else None

    if request.method == "POST":
        form = EntregaForm(request.POST, request.FILES)
        if form.is_valid():
            data = form.cleaned_data
            sprint = data["sprint"]
            try:
                squad = _create_squad_nova(data["squad_nome"])
            except IntegrityError:
                form.add_error(
                    "squad_nome",
                    "Não foi possível criar a squad com este nome (pode já existir no banco). Tente outro nome.",
                )
            else:
                deadline = _to_aware(sprint.end_date)
                completed_at = _date_end_of_day(data.get("entrega_data"))
                task = Task.objects.create(
                    title=data["title"],
                    description=data.get("description") or None,
                    priority="medium",
                    created_at=timezone.now(),
                    deadline=deadline,
                    completed_at=completed_at,
                    squad=squad,
                    sprint=sprint,
                )
                upload = request.FILES.get("image")
                if upload:
                    ext = Path(upload.name).suffix[:32] or ".bin"
                    safe = f"{uuid.uuid4().hex}{ext}"
                    rel_path = f"tasks/{safe}"
                    default_storage.save(rel_path, ContentFile(upload.read()))
                    base = settings.MEDIA_URL.rstrip("/")
                    public_url = f"{base}/{rel_path}"
                    cap = Path(upload.name).name[:150] or "Imagem"
                    TaskImage.objects.create(
                        url=public_url,
                        caption=cap,
                        uploaded_at=timezone.now(),
                        task=task,
                    )
                messages.success(request, "Entrega cadastrada com sucesso.")
                base_url = reverse("poc:index")
                query = urlencode({"sprint_id": str(task.sprint_id)})
                return redirect(f"{base_url}?{query}")
    else:
        initial = {}
        if default_sp is not None:
            initial["sprint"] = default_sp.pk
        form = EntregaForm(initial=initial)

    return render(
        request,
        "poc/cadastro.html",
        {
            "form": form,
            "pode_cadastrar": pode_cadastrar,
        },
    )
