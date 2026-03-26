import mysql.connector
from mysql.connector import Error

try:
    conexao = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='sportbridge'
    )

    if conexao.is_connected():
        db_info = conexao.get_server_info()
        print(f"Conectado ao servidor MySQL versão {db_info}")
        cursor = conexao.cursor()
        cursor.execute("select database();")
        linha = cursor.fetchone()
        print(f"Você está conectado ao banco: {linha}")

        # Consultando registros para teste:
        cursor.execute("select * from squad;")
        dados = cursor.fetchall()
        for linha in dados:
            print(linha)

except Error as e:
    print(f"Erro ao conectar ao MySQL: {e}")

finally:
    if 'conexao' in locals() and conexao.is_connected():
        cursor.close()
        conexao.close()
        print("Conexão encerrada.")