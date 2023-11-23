#IMPORTS
from pyspark.sql import SparkSession
from pyspark.sql.functions import col,trim,lit
import pymysql
from connection.conect import driver_jar_path,mysql_password,mysql_properties,mysql_url,mysql_driver,mysql_user, mysql_url_stage


from pyspark.sql.types import StructType, StructField, IntegerType, DateType , DecimalType, BooleanType, ShortType, DoubleType 
 
spark = SparkSession.builder.appName("pagamento").config("spark.driver.extraClassPath", driver_jar_path).getOrCreate()



def limpar_tabela(tabela):
    colunas = tabela.columns
    for coluna in colunas:
        tabela = tabela.withColumn(coluna, trim(col(coluna))) 
    tabela_limpa = tabela.na.drop()
    tabela_limpa_final = tabela_limpa.dropDuplicates()
    #tabela_limpa_final = tabela_duplicados.withColumn("MOTIVO", lit("OK"))

    dados_repetidos = tabela.subtract(tabela_limpa_final)
    dados_repetidos_motivo = dados_repetidos.withColumn("MOTIVO", lit("Dado Repetido"))

    deletados = tabela.subtract (tabela_limpa)
    deletados_motivo = deletados.withColumn("MOTIVO", lit("Dado Nulo"))

    deletados_final = deletados_motivo.union(dados_repetidos_motivo)
    return tabela_limpa_final, deletados_final 

schemaPagamento = StructType([
    StructField("ID_NF_ENTRADA", IntegerType(), True),
    StructField("DATA_VENCIMENTO", DateType(), True),
    StructField("DATA_PGT_EFETUADO", DateType(), True),
    StructField("VALOR_PARCELA_PAGO", DecimalType(8,2), True)
])
'''
ID_HIST_PAGAMENTO	int AI PK
	ID_PROG_PAGAMENTO	int
	ID_NF_ENTRADA	int
	NUM_PARCELAS	int
	DATA_VENCIMENTO	date
	DATA_PGT_EFETUADO	date
	VALOR_PARCELA	decimal(16,2)
	VALOR_PARCELA_PAGO	decimal(16,2)
'''

programacao_pagamento_final_bd = spark.read.format('jdbc')\
    .option('url', mysql_url)\
    .option('dbtable', 'programacao_pagamento')\
    .option('user', mysql_user)\
    .option('password', mysql_password)\
    .option('driver', mysql_driver)\
    .option('encrypt','false').load()

#P A G A M E N T O --------------------------------------------------------------------------------------------------------------------------------------------------------
pagamento = spark.read.options(header='True').csv('data/pagamentos_efetuados.csv')
pagamento_limpo, pagamento_deletado = limpar_tabela(pagamento)

pagamento_final_bd = spark.read.format('jdbc')\
    .option('url', mysql_url_stage)\
    .option('dbtable', 'pagamentos_efetuados')\
    .option('user', mysql_user)\
    .option('password', mysql_password)\
    .option('driver', mysql_driver)\
    .option('encrypt','false').load()

pagamento_limpo = pagamento_limpo.withColumn("ID_NF_ENTRADA", col("ID_NF_ENTRADA").cast("integer")).withColumn("DATA_VENCIMENTO",\
col("DATA_VENCIMENTO").cast("date")).withColumn("DATA_PGT_EFETUADO", col("DATA_PGT_EFETUADO").cast("date")).withColumn("VALOR_PGT_EFETUADO",\
col("VALOR_PGT_EFETUADO").cast("decimal(10,2)")).select("ID_NF_ENTRADA", "DATA_VENCIMENTO", "DATA_PGT_EFETUADO", "VALOR_PGT_EFETUADO")

pagamento_final = spark.createDataFrame(pagamento_limpo.collect(), schema = schemaPagamento)

pagamento_final.write.jdbc(url = mysql_url_stage,table = 'pagamentos_efetuados',mode = 'overwrite', properties = mysql_properties)

pagamento_final_bd.show(5)

#H I S T O R I C O   P A G A M E N T O--------------------------------------------------------------------------------------------------------------------------------------------------------
historico_pagamento_final_bd = spark.read.format('jdbc')\
    .option('url', mysql_url)\
    .option('dbtable', 'historico_pagamento')\
    .option('user', mysql_user)\
    .option('password', mysql_password)\
    .option('driver', mysql_driver)\
    .option('encrypt','false').load()
#historico_pagamento_final_bd = historico_pagamento_final_bd.drop('ID_HIST_PAGAMENTO')    

historico_pagamento = programacao_pagamento_final_bd.join(pagamento_final_bd, [programacao_pagamento_final_bd.ID_NF_ENTRADA == pagamento_final_bd.ID_NF_ENTRADA,\
programacao_pagamento_final_bd.DATA_VENCIMENTO == pagamento_final_bd.DATA_VENCIMENTO, programacao_pagamento_final_bd.STATUS_PAGAMENTO == 0], "inner")\
.select(programacao_pagamento_final_bd.ID_PROG_PAGAMENTO, programacao_pagamento_final_bd.ID_NF_ENTRADA,programacao_pagamento_final_bd.NUM_PARCELAS,\
programacao_pagamento_final_bd.DATA_VENCIMENTO,pagamento_final_bd.DATA_PGT_EFETUADO, programacao_pagamento_final_bd.VALOR_PARCELA, \
pagamento_final_bd.VALOR_PARCELA_PAGO)


historico_pagamento_existente = historico_pagamento.join(historico_pagamento_final_bd, on=['ID_PROG_PAGAMENTO'], how='inner').select(\
    historico_pagamento.ID_PROG_PAGAMENTO, historico_pagamento.ID_NF_ENTRADA, historico_pagamento.NUM_PARCELAS, historico_pagamento.DATA_VENCIMENTO,\
    historico_pagamento.DATA_PGT_EFETUADO, historico_pagamento.VALOR_PARCELA, historico_pagamento.VALOR_PARCELA_PAGO)


historico_pagamento = historico_pagamento.subtract(historico_pagamento_existente)

conn = pymysql.connect(
    host="localhost",
    user=mysql_user,
    password=mysql_password,
    database='projeto_financeiro_vendas'
)

historico_pagamento_update = historico_pagamento.select('ID_PROG_PAGAMENTO')
rdd = historico_pagamento_update.rdd

cursor = conn.cursor()

for linha in rdd.collect():
    valor = linha[0]
    print(valor)
    query = f"UPDATE programacao_pagamento SET STATUS_PAGAMENTO = 1 WHERE ID_PROG_PAGAMENTO = {valor}"
    cursor.execute(query)
    conn.commit()
cursor.close()
conn.close()


historico_pagamento = programacao_pagamento_final_bd.join(pagamento_final_bd, [programacao_pagamento_final_bd.ID_NF_ENTRADA == pagamento_final_bd.ID_NF_ENTRADA,\
programacao_pagamento_final_bd.DATA_VENCIMENTO == pagamento_final_bd.DATA_VENCIMENTO, programacao_pagamento_final_bd.STATUS_PAGAMENTO == 1], "inner")\
.select(programacao_pagamento_final_bd.ID_PROG_PAGAMENTO, programacao_pagamento_final_bd.ID_NF_ENTRADA,programacao_pagamento_final_bd.NUM_PARCELAS,\
programacao_pagamento_final_bd.DATA_VENCIMENTO,pagamento_final_bd.DATA_PGT_EFETUADO, programacao_pagamento_final_bd.VALOR_PARCELA, \
pagamento_final_bd.VALOR_PARCELA_PAGO)

historico_pagamento_existente = historico_pagamento.join(historico_pagamento_final_bd, on=['ID_PROG_PAGAMENTO'], how='inner').select(\
    historico_pagamento.ID_PROG_PAGAMENTO, historico_pagamento.ID_NF_ENTRADA, historico_pagamento.NUM_PARCELAS, historico_pagamento.DATA_VENCIMENTO,\
    historico_pagamento.DATA_PGT_EFETUADO, historico_pagamento.VALOR_PARCELA, historico_pagamento.VALOR_PARCELA_PAGO)

historico_pagamento = historico_pagamento.subtract(historico_pagamento_existente)

historico_pagamento.write.jdbc(url = mysql_url,table = 'historico_pagamento',mode = 'append', properties = mysql_properties)

historico_pagamento_final_bd.show()