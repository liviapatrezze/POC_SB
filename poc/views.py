# from datetime import date, timedelta
#
# from django.shortcuts import render
#
#
# def _build_sprints(year: int = 2026) -> list[dict]:
#     sprints = []
#     current = date(year, 1, 1)
#     end_of_year = date(year, 12, 31)
#     while current <= end_of_year:
#         sprint_end = current + timedelta(days=14)
#         if sprint_end > end_of_year:
#             sprint_end = end_of_year
#         sprints.append({
#             "start": current,
#             "end": sprint_end,
#             "label": f"{current.strftime('%d/%m/%Y')} - {sprint_end.strftime('%d/%m/%Y')}",
#         })
#         current = sprint_end + timedelta(days=1)
#     return sprints
#
#
# def index(request):
#     sprints = _build_sprints()
#     selected_index = 2
#     selected_sprint = sprints[selected_index]
#
#     entregas = [
#         {
#             "squad": "Squad - Plataforma",
#             "date": "04/01/2026",
#             "title": "Entrega do botão de comprar",
#             "description": (
#                 "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "
#                 "sed do eiusmod tempor incididunt ut labore et dolore magna "
#                 "aliqua. Ut enim ad minim veniam, quis nostrud exercitation "
#                 "ullamco laboris nisi ut aliquip ex ea commodo consequat. "
#                 "Duis aute irure dolor in reprehenderit in voluptate velit "
#                 "esse cillum dolore eu fugiat nulla pariatur. Excepteur sint "
#                 "occaecat cupidatat non proident, sunt in culpa qui officia "
#                 "deserunt mollit anim id est laborum."
#             ),
#         },
#     ]
#
#     context = {
#         "sprints": sprints,
#         "selected_index": selected_index,
#         "selected_sprint": selected_sprint,
#         "entregas": entregas,
#     }
#     return render(request, "poc/home.html", context)
#
#
# def cadastro(request):
#     return render(request, "poc/cadastro.html")





from django.shortcuts import render
from django.utils import timezone
from .models import Sprint, Task


def get_current_sprint_info(sprints_queryset):
    today = timezone.now().date()
    current_sprint = sprints_queryset.filter(
        start_date__lte=today,
        end_date__gte=today
    ).first()

    if current_sprint:
        sprints_list = list(sprints_queryset)
        idx = sprints_list.index(current_sprint)
        return current_sprint, idx

    # Fallback
    return sprints_queryset.first(), 0


def index(request):
    # Monta listagem de botões e define qual deve estar ativo (de acordo com a data atual)
    sprints_db = Sprint.objects.all().order_by('start_date')
    selected_sprint_id = request.GET.get('sprint_id')

    if selected_sprint_id:
        selected_sprint = sprints_db.filter(id=selected_sprint_id).first()
        sprints_list = list(sprints_db)
        selected_index = sprints_list.index(selected_sprint) if selected_sprint in sprints_list else 0
    else:
        selected_sprint, selected_index = get_current_sprint_info(sprints_db)


    # Selecionamos a sprint com base no índice
    if sprints_db.exists() and 0 <= selected_index < len(sprints_db):
        selected_sprint = sprints_db[selected_index]
        entregas_reais = Task.objects.filter(sprint=selected_sprint).order_by('-created_at')
    else:
        selected_sprint = None
        entregas_reais = []

    context = {
        "sprints": sprints_db,
        "selected_index": selected_index,
        "selected_sprint": selected_sprint,
        "entregas": entregas_reais,
    }
    return render(request, "poc/home.html", context)


def cadastro(request):
    return render(request, "poc/cadastro.html")