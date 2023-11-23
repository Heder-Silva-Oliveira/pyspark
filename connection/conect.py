import os

# Busca as variaveis com as credências
mysql_user = os.environ.get("MYSQL_USER")
mysql_password = os.environ.get("MYSQL_PASSWORD")
mysql_driver = os.environ.get("MYSQL_DRIVER")
driver_jar_path = "/usr/share/java/mysql-connector-java-8.1.0.jar"
# Conexão
mysql_url = "jdbc:mysql://localhost:3306/projeto_financeiro_vendas"
mysql_url_stage = "jdbc:mysql://localhost:3306/stage_vendas"

mysql_properties = {
    "user": mysql_user,
    "password": mysql_password,
    "driver": mysql_driver
}