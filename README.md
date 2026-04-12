# POCSB

POC em Django de uma aplicação web inspirada no SportBridge: **relatório de entregas** por período (sprint) e **cadastro de novas entregas** com upload opcional de imagem. O front usa layout próprio (header, navegação, cards) alinhado à identidade visual do projeto.

## Funcionalidades

- **Relatório (`/`):** botões por sprint (intervalo de datas vindo do banco). Ao selecionar um período, a lista mostra apenas entregas cuja **data do campo Data do cadastro** (`completed_at`) cai entre o início e o fim da sprint — não usa a data de criação do registro nem apenas o vínculo `sprint_id` para filtrar a lista.
- **Cadastro (`/cadastro/`):** título, descrição, nome da squad (texto; cria um novo registro em `squad`), data opcional, imagem opcional. A sprint do cadastro fica em campo oculto (pré-preenchida pela sprint atual ou por `?sprint_id=` na URL).
- **Mídia:** uploads servidos em desenvolvimento via `MEDIA_URL` (pasta `media/` no projeto).

## Pré-requisitos

- Python 3.12 ou superior
- Git
- Docker Desktop (para MySQL local via `docker compose`)

## Instalação do Docker

### macOS

1. Baixe o instalador em [https://docs.docker.com/desktop/setup/install/mac-install/](https://docs.docker.com/desktop/setup/install/mac-install/) (escolha **Apple Silicon** ou **Intel** conforme seu Mac).
2. Abra o arquivo `.dmg` baixado e arraste o Docker para a pasta **Applications**.
3. Abra o Docker Desktop pelo Launchpad ou Spotlight. Na primeira execução, aceite os termos de uso.
4. Aguarde até o ícone da baleia na barra de menus indicar **Docker Desktop is running**.
5. Verifique no terminal:

```bash
docker --version
```

### Windows

1. Baixe o instalador em [https://docs.docker.com/desktop/setup/install/windows-install/](https://docs.docker.com/desktop/setup/install/windows-install/).
2. Execute o arquivo `Docker Desktop Installer.exe` e siga o assistente de instalação.
3. Se solicitado, ative o **WSL 2** (o próprio instalador oferece essa opção). Caso necessário, abra o PowerShell como administrador e execute:

```powershell
wsl --install
```

4. Reinicie o computador após a instalação.
5. Abra o Docker Desktop pelo menu Iniciar. Na primeira execução, aceite os termos de uso.
6. Aguarde até o ícone da baleia na bandeja do sistema indicar **Docker Desktop is running**.
7. Verifique no terminal:

```powershell
docker --version
```

## Instalação e execução do projeto

### 1. Clone o repositório

```bash
git clone https://github.com/liviapatrezze/POC_SB.git
cd POC_SB
```

### 2. Suba o MySQL com Docker

O `docker-compose.yml` sobe o MySQL, cria o banco `sportbridge` e executa `db_project/sportbridge.sql` na primeira inicialização do volume. Esse arquivo contém **apenas o schema** (tabelas e chaves), **sem dados de exemplo**.

**macOS / Linux:**

```bash
docker compose up -d
```

**Windows (PowerShell):**

```powershell
docker compose up -d
```

Confira o container:

```bash
docker ps
```

O serviço `sportbridge-mysql` deve aparecer como **Up** e **(healthy)**.

**Banco vazio:** é preciso existir ao menos uma **sprint** cadastrada para o relatório exibir botões e para o formulário de cadastro ficar habilitado. Inclua sprints (e demais dados) via SQL, admin Django ou ferramenta cliente do MySQL.

**Recriar o banco do zero** (apaga dados do volume):

```bash
docker compose down -v
docker compose up -d
```

### 3. Ambiente Python e servidor Django

**macOS / Linux:**

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python manage.py runserver
```

**Windows (PowerShell):**

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python manage.py runserver
```

> Se o PowerShell bloquear o venv: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`.

**Windows (CMD):**

```cmd
python -m venv .venv
.venv\Scripts\activate.bat
pip install -r requirements.txt
python manage.py runserver
```

Validação rápida do projeto (com MySQL acessível):

```bash
python manage.py check
```

### 4. Acesse no navegador

| Página    | URL                             |
|-----------|---------------------------------|
| Relatório | http://127.0.0.1:8000/          |
| Cadastro  | http://127.0.0.1:8000/cadastro/ |

## Parar e reiniciar

- Servidor Django: `Ctrl+C` no terminal.
- MySQL mantendo dados:

```bash
docker compose down
```

- Subir de novo:

```bash
docker compose up -d
```

## Estrutura do projeto

```
POC_SB/
├── core/                 # Projeto Django (settings, urls, wsgi)
├── poc/                  # App principal
│   ├── static/poc/       # CSS e assets (ex.: logo)
│   ├── templates/poc/    # base, home (relatório), cadastro
│   ├── models.py         # Sprint, Squad, SquadMember, Task, TaskImage (managed=False)
│   ├── forms.py          # EntregaForm
│   ├── views.py          # index, cadastro
│   └── urls.py
├── db_project/
│   └── sportbridge.sql   # Schema inicial para o container MySQL
├── docker-compose.yml
├── manage.py
└── requirements.txt      # Django 6, mysql-connector-python, etc.
```

## Banco de dados (MySQL)

Configuração padrão em `core/settings.py`:

| Parâmetro | Valor       |
|-----------|-------------|
| HOST      | localhost   |
| PORT      | 3306        |
| USER      | root        |
| PASSWORD  | (vazio)     |
| DATABASE  | sportbridge |

Os models da app `poc` usam `managed = False` e refletem tabelas já existentes no MySQL; migrações Django não criam essas tabelas.

## Stack principal

- Django 6.x
- MySQL 9 (imagem oficial via Docker)
- Driver: `mysql-connector-python`
