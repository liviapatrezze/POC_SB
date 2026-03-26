# POCSB

POC de aplicação web com Django — homepage com grid de sprints e entregas, página de cadastro, layout inspirado no SportBridge.

## Pré-requisitos

- Python 3.12 ou superior
- Git

## Instalação e execução

### macOS / Linux

```bash
git clone https://github.com/SEU-USUARIO/POC_SB.git
cd POC_SB

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

python manage.py runserver
```

### Windows (PowerShell)

```powershell
git clone https://github.com/SEU-USUARIO/POC_SB.git
cd POC_SB

python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt

python manage.py runserver
```

> Se o PowerShell bloquear a ativação do venv, execute `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` e tente novamente.

### Windows (CMD)

```cmd
git clone https://github.com/SEU-USUARIO/POC_SB.git
cd POC_SB

python -m venv .venv
.venv\Scripts\activate.bat
pip install -r requirements.txt

python manage.py runserver
```

## Acesso

Após iniciar o servidor, abra no navegador:

| Página    | URL                            |
|-----------|--------------------------------|
| Home      | http://127.0.0.1:8000/         |
| Cadastro  | http://127.0.0.1:8000/cadastro/|

## Estrutura do projeto

```
POC_SB/
├── core/           # Configurações Django (settings, urls, wsgi)
├── poc/            # App principal
│   ├── static/poc/ # CSS e logo
│   ├── templates/  # Templates (base, home, cadastro)
│   ├── views.py    # Views com dados de sprints e entregas
│   └── urls.py     # Rotas do app
├── manage.py
└── requirements.txt
```
