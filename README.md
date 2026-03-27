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

## Integração com o banco de dados (Mysql)

1. Faça a instalação do Mysql (https://dev.mysql.com/downloads/installer/) e do Workbench (https://dev.mysql.com/downloads/workbench/) em seu computador.


2. Abra o arquivo *POC_SB/db_project/SportBridge_model.mwb* utilizando o Workbench. 
 
    a) Faça a sincronização: acesse o menu *Database* → *Synchronize Model...* e forneça as credenciais de acesso ao Mysql local no frame que será aberto.

```cmd
    Hostname: localhost (ou 127.0.0.1)
    Username: root
    Password: *sua senha no Mysql*
```
OBS: Tutoriais podem ajudar no uso do Workbench para manipulação do banco de dados.



3. Após a criação da base, o projeto deve ser atualizado. No cmd, acesse a raíz do projeto e execute o seguinte comando Git:

```cmd
    git pull
```

a) Certifique-se de que o arquivo *requirements.txt* contenha a linha 'mysql-connector-python>=8.0.30'.

b) Verifique se as credenciais de acesso ao Mysql estão corretas em *POC_SB/core/settings.py*.

```cmd
    DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',     # Motor do banco
        'NAME': 'sportbridge',                  # Nome da base de dados criada no MySQL
        'USER': 'root',                         # Geralmente 'root' em ambiente local
        'PASSWORD': '',                         # Senha do seu usuário MySQL - geralmente vazio
        'HOST': 'localhost',                    # Ou o IP do servidor (ex: '127.0.0.1')
        'PORT': '3306',                         # Porta padrão do MySQL
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
        },
    }
}
```

4. Execute o comando de atualização de dependências na raíz do projeto.
```cmd
pip freeze > requirements.txt
```

5. Popule a tabela *squad* com um ou mais registros e faça o teste! 

Pelo cmd, acesse a raíz do projeto e execute:
```cmd
    python teste_db.py
```

6. Se tudo estiver certo, deve aparecer a seguinte mensagem:
```cmd
    t_server_info. Reason:
        The property counterpart 'server_info' should be used instead.

    db_info = conexao.get_server_info()
    Conectado ao servidor MySQL versão 9.1.0
    Você está conectado ao banco: ('sportbridge',)
    (1, 'Alunos Univesp', 'Composto por alunos da disciplina PI.', 'Responsáveis pelo desenvolvimento do app de controle de entregue de task em cada sprint.', 'Whatsapp', datetime.datetime(2026, 3, 26, 17, 25, 22), 1)
    Conexão encerrada.
```