from pyspark.sql import SparkSession
from pyspark.sql.functions import datediff,  expr, col, when
from connection.conect import driver_jar_path,mysql_password,mysql_properties,mysql_url,mysql_user
from schema.schemas import schema_recebimento, schema_historico
import mysql.connector

def historico():
    # Criar a sessão Spark
    spark = SparkSession.builder \
        .appName("Teste mysql") \
        .config("spark.driver.extraClassPath", driver_jar_path) \
        .getOrCreate()
    programacao_recebimento = spark.read.jdbc(url=mysql_url, table="programacao_recebimento", properties=mysql_properties)
    tipo_desconto = spark.read.jdbc(url=mysql_url, table="tipo_desconto", properties=mysql_properties)
    nf_saida_final = spark.read.jdbc(url=mysql_url, table='notas_fiscais_saida', properties=mysql_properties)
    # Ler dados do MySQL em um DataFrame Spark
    # Conexão
    conn = mysql.connector.connect(
        host="localhost",
        user=mysql_user,
        password=mysql_password,
        database="projeto_financeiro_vendas",
        auth_plugin='mysql_native_password'
    )

    # Ler csv pagamento
    recebimento = spark.read.options(header='true').schema(schema_recebimento).csv('data/recebimento.csv')
    # Seleciona os recebimentos
    ids_nf = recebimento.join(nf_saida_final,(nf_saida_final['NUMERO_NF'] == recebimento['NUMERO_NF']),'inner')\
        .select(nf_saida_final.ID_NF_SAIDA,nf_saida_final.NUMERO_NF,recebimento.VALOR_RECEBIDO,recebimento.DATA_RECEBIMENTO,recebimento.DATA_VENCIMENTO)

    alterar=programacao_recebimento.join(ids_nf, (ids_nf['ID_NF_SAIDA'] == programacao_recebimento['ID_NF_SAIDA'])\
    &(ids_nf.DATA_VENCIMENTO == programacao_recebimento.DATA_VENCIMENTO), 'inner')\
        .select(*programacao_recebimento,ids_nf.VALOR_RECEBIDO,ids_nf.DATA_RECEBIMENTO)
    # Calcula o desconto e o range

    df_desconto = alterar.withColumn("DIAS_DIFERENCA", datediff(alterar["DATA_RECEBIMENTO"], alterar["DATA_VENCIMENTO"]))

    # Cria a coluna DESCONTO com base na condição
    df_desconto = df_desconto.withColumn("TIPO", when(col("DIAS_DIFERENCA") <= 0, False).otherwise(True))

    # Crie uma nova coluna chamada "PORCENTAGEM" calculando (VALOR_RECEBIDO / VALOR_PARCELA) * 100
    df_desconto = df_desconto.withColumn("PORCENTAGEM", expr("((VALOR_RECEBIDO / VALOR_PARCELA) * 100)-100"))

    df_joined = df_desconto.join(tipo_desconto, how='inner')

    # Aplique as condições para verificar se DIAS_DIFERENCA e PORCENTAGEM estão dentro dos intervalos
    resultado = df_joined.filter(
        (col("DIAS_DIFERENCA").between(col("MINIMO_DIAS"), col("MAXIMO_DIAS"))) &
        (col("PORCENTAGEM").between(col("MINIMO"), col("MAXIMO")))
    ).drop('TIPO')

    final = resultado.join(df_desconto, df_desconto.TIPO == resultado.TIPO_DESCONTO).drop(*df_desconto)\
    .select('ID_PROG_RECEBIMENTO','ID_DESCONTO','DATA_RECEBIMENTO','VALOR_PARCELA','VALOR_RECEBIDO')
    historico =spark.createDataFrame(final.collect(),schema=schema_historico)
    #historico.printSchema()


    # Insert pagamento no historico
    historico.write.jdbc(url=mysql_url, table="historico_recebimento", mode="append", properties=mysql_properties)

    lista_alterar = historico.collect()


    #UPDATE PROGRAMACAO_RECEBIMENTO

    for id in lista_alterar:
        cursor = conn.cursor()
        update=(f'UPDATE programacao_recebimento set STATUS_RECEBIMENTO = 1 WHERE ID_PROG_RECEBIMENTO = {id["ID_PROG_RECEBIMENTO"]}')
        cursor.execute(update)
        conn.commit()
        cursor.close()

    # Fecha a conexão com servidor
    conn.close()


    # Encerra a sessão Spark
    spark.stop()

























