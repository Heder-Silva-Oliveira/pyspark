#IMPORTS
from pyspark.sql import SparkSession
from dateutil.relativedelta import relativedelta
from connection.conect import driver_jar_path,mysql_password,mysql_properties,mysql_url,mysql_driver,mysql_user
from pyspark.sql.types import StructType, StructField, IntegerType, DateType , DecimalType, BooleanType, ShortType, DoubleType 
 
spark = SparkSession.builder.appName("processamento").config("spark.driver.extraClassPath", driver_jar_path).getOrCreate()



schemaparcela = StructType([
    StructField("NUMERO_NF", IntegerType(), True),
    StructField("DATA_VENCIMENTO", DateType(), True),
    StructField("VALOR_PARCELA", DecimalType(8,2), True),
    StructField("NUM_PARCELAS", ShortType(), True),
    StructField("STATUS", ShortType(), True)
])

schemaProgramacaoPagamento = StructType([
    StructField("ID_NF_ENTRADA", IntegerType(), False),
    StructField("DATA_VENCIMENTO", DateType(), False),
    StructField("NUM_PARCELAS", IntegerType(), False),
    StructField("VALOR_PARCELA", DecimalType(8,2), False),
    StructField("STATUS_PAGAMENTO", ShortType(), False)
])


def gerar_parcelas(param_nf):
    
    parcelas = spark.createDataFrame([], schema = schemaparcela)

    def calculo(param):
        numero_parcela = 1
        final = spark.createDataFrame([], schema = schemaparcela)
        while numero_parcela <= param['QTD_PARCELAS']:
            data_recebimento = param['DATA_EMISSAO'] + relativedelta(months=(numero_parcela - param['ENTRADA']))
            new_row = spark.createDataFrame([(param['NUMERO_NF'], data_recebimento, (param['VALOR_TOTAL']/param['QTD_PARCELAS']), numero_parcela, 0)], schema = schemaparcela)
            final = final.union(new_row)
            numero_parcela += 1
        return final

    linhas_nf_parcela = param_nf.collect()

    for linha in linhas_nf_parcela:
        parcelas = parcelas.union(calculo(linha))
    
    return parcelas
 

#P R O G R A M A C A O    P A G A M E N T O --------------------------------------------------------------------------------------------------------------------------------------------------------

nf_entrada_bd = spark.read.format('jdbc')\
    .option('url', mysql_url)\
    .option('dbtable', 'notas_fiscais_entrada')\
    .option('user', mysql_user)\
    .option('password', mysql_password)\
    .option('driver', mysql_driver)\
    .option('encrypt','false').load()
    

condicao_pagamento_bd = spark.read.format('jdbc')\
    .option('url', mysql_url)\
    .option('dbtable', 'condicao_pagamento')\
    .option('user', mysql_user)\
    .option('password', mysql_password)\
    .option('driver', mysql_driver)\
    .option('encrypt','false').load()    
    
    
programacao_pagamento_final_bd = spark.read.format('jdbc')\
    .option('url', mysql_url)\
    .option('dbtable', 'programacao_pagamento')\
    .option('user', mysql_user)\
    .option('password', mysql_password)\
    .option('driver', mysql_driver)\
    .option('encrypt','false').load()
    
nf_entrada = nf_entrada_bd.join(condicao_pagamento_bd, "ID_CONDICAO", "inner")   

nf_entrada = nf_entrada.select("NUMERO_NF", "DATA_EMISSAO", "VALOR_TOTAL", "QTD_PARCELAS", "ENTRADA")
    
programacao_pagamento = gerar_parcelas(nf_entrada)

programacao_pagamento = programacao_pagamento.join(nf_entrada_bd, "NUMERO_NF", "inner")

programacao_pagamento.show(5)

programacao_pagamento = programacao_pagamento.select("ID_NF_ENTRADA", "DATA_VENCIMENTO", "NUM_PARCELAS", "VALOR_PARCELA", "STATUS")

programacao_pagamento_final = spark.createDataFrame(programacao_pagamento.collect(), schema = schemaProgramacaoPagamento)

programacao_pagamento_existente = programacao_pagamento_final.join(programacao_pagamento_final_bd, on=['ID_NF_ENTRADA','DATA_VENCIMENTO','NUM_PARCELAS','VALOR_PARCELA'], how='inner')\
.select('ID_NF_ENTRADA', 'DATA_VENCIMENTO', 'NUM_PARCELAS', 'VALOR_PARCELA', programacao_pagamento_final['STATUS_PAGAMENTO'])

programacao_pagamento_final = programacao_pagamento_final.subtract(programacao_pagamento_existente)

programacao_pagamento_final.write.jdbc(url = mysql_url,table = 'programacao_pagamento',mode = 'append', properties = mysql_properties)

programacao_pagamento_final_bd.show(10)
  


