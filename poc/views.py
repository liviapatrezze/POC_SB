from datetime import date, timedelta

from django.shortcuts import render


def _build_sprints(year: int = 2026) -> list[dict]:
    sprints = []
    current = date(year, 1, 1)
    end_of_year = date(year, 12, 31)
    while current <= end_of_year:
        sprint_end = current + timedelta(days=14)
        if sprint_end > end_of_year:
            sprint_end = end_of_year
        sprints.append({
            "start": current,
            "end": sprint_end,
            "label": f"{current.strftime('%d/%m/%Y')} - {sprint_end.strftime('%d/%m/%Y')}",
        })
        current = sprint_end + timedelta(days=1)
    return sprints


def index(request):
    sprints = _build_sprints()
    selected_index = 2
    selected_sprint = sprints[selected_index]

    entregas = [
        {
            "squad": "Squad - Plataforma",
            "date": "04/01/2026",
            "title": "Entrega do botão de comprar",
            "description": (
                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "
                "sed do eiusmod tempor incididunt ut labore et dolore magna "
                "aliqua. Ut enim ad minim veniam, quis nostrud exercitation "
                "ullamco laboris nisi ut aliquip ex ea commodo consequat. "
                "Duis aute irure dolor in reprehenderit in voluptate velit "
                "esse cillum dolore eu fugiat nulla pariatur. Excepteur sint "
                "occaecat cupidatat non proident, sunt in culpa qui officia "
                "deserunt mollit anim id est laborum."
            ),
        },
    ]

    context = {
        "sprints": sprints,
        "selected_index": selected_index,
        "selected_sprint": selected_sprint,
        "entregas": entregas,
    }
    return render(request, "poc/home.html", context)


def cadastro(request):
    return render(request, "poc/cadastro.html")
