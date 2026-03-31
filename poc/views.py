from django.shortcuts import render
from django.utils import timezone

from .models import Sprint, Task


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
        entregas = Task.objects.filter(sprint=selected_sprint).select_related(
            "squad"
        ).prefetch_related("taskimage_set").order_by("-created_at")
    else:
        selected_sprint = None
        entregas = Task.objects.none()

    context = {
        "sprints": sprints,
        "selected_index": selected_index,
        "selected_sprint": selected_sprint,
        "entregas": entregas,
    }
    return render(request, "poc/home.html", context)


def cadastro(request):
    return render(request, "poc/cadastro.html")
