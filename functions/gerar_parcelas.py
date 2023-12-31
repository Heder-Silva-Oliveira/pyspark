from dateutil.relativedelta import relativedelta
from pyspark.sql import SparkSession
from pyspark.sql.functions import col
from schema.schemas import schema_parcelas
from connection.conect import driver_jar_path,mysql_properties,mysql_url

def gerar_parcelas():

    spark = SparkSession.builder.appName("programacao").config("spark.driver.extraClassPath", driver_jar_path).getOrCreate()

    # Carregar tabelas
    condicao=spark.read.jdbc(url=mysql_url, table='condicao_pagamento', properties=mysql_properties)
    nfe=spark.read.jdbc(url=mysql_url, table='notas_fiscais_saida', properties=mysql_properties)

    nfe_parcelas = nfe.select(col("ID_NF_SAIDA"),col("DATA_EMISSAO"), col("VALOR_TOTAL"),col("ID_CONDICAO"))

    #DataFrame vazio com o esquema correto
    programacao_recebimento = spark.createDataFrame([], schema=schema_parcelas)
    nfe_parcelas.show()
    # Função para gerar parcelas retorna todas as parcelas de todas as notas fiscais
    def gerar_parcelas(param_nf):

        parcelas = spark.createDataFrame([], schema=schema_parcelas)

        #Função para calcular as parcelas de cada nota fiscal
        def calculo(param):
            num_parcela = 1
            resultado = spark.createDataFrame([], schema=schema_parcelas)
            while num_parcela <= condicao.filter(condicao['ID_CONDICAO'] == param['ID_CONDICAO']).select('QTD_PARCELAS').first()[0]:
                vencimento = param['DATA_EMISSAO'] + relativedelta(months=num_parcela-condicao.filter(condicao['ID_CONDICAO'] == param['ID_CONDICAO']).select('ENTRADA').first()[0])
                valor_parcela = param['VALOR_TOTAL']/ condicao.filter(condicao['ID_CONDICAO'] == param['ID_CONDICAO']).select('QTD_PARCELAS').first()[0]
                novo_dataframe = spark.createDataFrame([(param['ID_NF_SAIDA'], vencimento, num_parcela, valor_parcela, 0)], schema=schema_parcelas)
                resultado = resultado.union(novo_dataframe)
                num_parcela += 1
            return resultado #Retorna o conjunto de parcelas por nota fiscal
        
        # Busca linha por linha do lote de notas
        linhas_nfe_parcelas = param_nf.collect()
        
        for linha in linhas_nfe_parcelas: # Exerce a função de cursor do SQL
            parcelas = parcelas.union(calculo(linha))

        return parcelas #todas as parcelas do conjunto de notas

    # Exiba as parcelas geradas
    programacao_recebimento = programacao_recebimento.union(gerar_parcelas(nfe)).coalesce(1)
    print('Programação recebimento')
    programacao_recebimento.printSchema()
    programacao_recebimento.write.jdbc(url=mysql_url, table='programacao_recebimento', mode='append', properties=mysql_properties)
    '''
    caminho = 'programacao_recebimento'
    programacao_recebimento.write.csv(caminho, header='True', mode='overwrite')
    '''
