# POCSB

POC de aplicação web com Django — homepage com grid de sprints e entregas, página de cadastro, layout inspirado no SportBridge.

## Pré-requisitos

- Python 3.12 ou superior
- Git
- Docker Desktop

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

### 2. Suba o banco de dados MySQL via Docker

O projeto inclui um `docker-compose.yml` que cria um container MySQL já com a base `sportbridge` populada automaticamente.

**macOS / Linux:**

```bash
docker compose up -d
```

**Windows (PowerShell):**

```powershell
docker compose up -d
```

Aguarde alguns segundos para o MySQL inicializar. Para verificar se está pronto:

```bash
docker ps
```

O container `sportbridge-mysql` deve aparecer com status **Up** e **(healthy)**.

### 3. Configure o ambiente Python e rode o servidor

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

> Se o PowerShell bloquear a ativação do venv, execute `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` e tente novamente.

**Windows (CMD):**

```cmd
python -m venv .venv
.venv\Scripts\activate.bat
pip install -r requirements.txt
python manage.py runserver
```

### 4. Acesse no navegador

| Página   | URL                             |
|----------|---------------------------------|
| Home     | http://127.0.0.1:8000/          |
| Cadastro | http://127.0.0.1:8000/cadastro/ |

## Parar e reiniciar

Para parar o servidor Django, pressione `Ctrl+C` no terminal.

Para parar o container MySQL (os dados persistem no volume Docker):

```bash
docker compose down
```

Para subir novamente:

```bash
docker compose up -d
```

## Estrutura do projeto

```
POC_SB/
├── core/               # Configurações Django (settings, urls, wsgi)
├── poc/                # App principal
│   ├── static/poc/     # CSS e logo
│   ├── templates/poc/  # Templates (base, home, cadastro)
│   ├── models.py       # Models (Sprint, Squad, Task, TaskImage)
│   ├── views.py        # Views com queries ao banco
│   └── urls.py         # Rotas do app
├── db_project/         # SQL dump e modelo do banco
├── docker-compose.yml  # Container MySQL
├── manage.py
└── requirements.txt
```

## Integração com o banco de dados (MySQL)

O `docker-compose.yml` cuida de tudo automaticamente: cria a base `sportbridge`, aplica o schema e insere os dados de seed definidos em `db_project/sportbridge.sql`.

As credenciais padrão configuradas em `core/settings.py` são:

| Parâmetro | Valor       |
|-----------|-------------|
| HOST      | localhost   |
| PORT      | 3306        |
| USER      | root        |
| PASSWORD  | (vazio)     |
| DATABASE  | sportbridge |

Para testar a conexão manualmente:

```bash
python teste_db.py
```
