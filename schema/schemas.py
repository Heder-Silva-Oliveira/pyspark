from pyspark.sql.types import StructType, StructField, StringType, IntegerType, LongType, DateType , DecimalType, TimestampType, ByteType, ShortType, DoubleType 

schemaNotaFiscalSaida = StructType([
    StructField("ID_CLIENTE", IntegerType(), False),
    StructField("ID_CONDICAO", IntegerType(), False),
    StructField("NUMERO_NF", IntegerType(), False),
    StructField("DATA_EMISSAO", DateType(), False),
    StructField("VALOR_NET", DecimalType(16,2), False),
    StructField("VALOR_TRIBUTO", DecimalType(16,2), False),
    StructField("VALOR_TOTAL", DecimalType(16,2), False),
    StructField("NOME_ITEM", StringType(), False),
    StructField("QTD_ITEM", IntegerType(), False)
])
schemaVendas = StructType([
    StructField("NOME", StringType(), True),
    StructField("CNPJ", StringType(), True),
    StructField("EMAIL", StringType(), True),
    StructField("TELEFONE", StringType(), True),
    StructField("NUMERO_NF", LongType(), True),
    StructField("DATA_EMISSAO", DateType(), True),
    StructField("VALOR_NET", DecimalType(16,2), True),
    StructField("VALOR_TRIBUTO", DecimalType(16,2), True),
    StructField("VALOR_TOTAL", DecimalType(16,2), True),
    StructField("NOME_ITEM", StringType(), True),
    StructField("QTD_ITEM", IntegerType(), True),
    StructField("CONDICAO_PAGAMENTO", StringType(), True),
    StructField("CEP", IntegerType(), True),
    StructField("NUM_ENDERECO", IntegerType(), True),
    StructField("COMPLEMENTO", StringType(), True),
    StructField("TIPO_ENDERECO", StringType(), True),
    StructField("DATA_PROCESSAMENTO",TimestampType(), True)
])
schemaVendasRejeitadas = StructType([
    StructField("NOME", StringType(), True),
    StructField("CNPJ", StringType(), True),
    StructField("EMAIL", StringType(), True),
    StructField("TELEFONE", StringType(), True),
    StructField("NUMERO_NF", LongType(), True),
    StructField("DATA_EMISSAO", DateType(), True),
    StructField("VALOR_NET", DecimalType(16,2), True),
    StructField("VALOR_TRIBUTO", DecimalType(16,2), True),
    StructField("VALOR_TOTAL", DecimalType(16,2), True),
    StructField("NOME_ITEM", StringType(), True),
    StructField("QTD_ITEM", IntegerType(), True),
    StructField("CONDICAO_PAGAMENTO", StringType(), True),
    StructField("CEP", IntegerType(), True),
    StructField("NUM_ENDERECO", IntegerType(), True),
    StructField("COMPLEMENTO", StringType(), True),
    StructField("TIPO_ENDERECO", StringType(), True),
    StructField("DATA_PROCESSAMENTO",TimestampType(), True),
    StructField("MOTIVO", StringType(), True),
])
#--------------------------
schemaEnderecoCliente = StructType([
    StructField("ID_CLIENTE",IntegerType(), False),
    StructField("ID_TIPO_ENDERECO", IntegerType(), False),
    StructField("CEP", StringType(), False),
    StructField("NUMERO", IntegerType(), False),
    StructField("COMPLEMENTO", StringType(), True)
])
schemaCliente = StructType([
    StructField("NOME", StringType(), False),
    StructField("CNPJ", StringType(), False),
    StructField("EMAIL", StringType(), False),
    StructField("TELEFONE", StringType(), False)
])
schema_condicao = StructType([
    StructField("ID_CONDICAO", IntegerType(), True),
    StructField("DESCRICAO", StringType(), True),
    StructField("QTD_PARCELAS", IntegerType(), True),
    StructField("ENTRADA", IntegerType(), True),
])


# Defina um esquema para o DataFrame de notas fiscais
schema_nfe = StructType([
    StructField("ID_NF_SAIDA", IntegerType(), True),
    StructField("DATA_EMISSAO", DateType(), True),
    StructField("VALOR_NET", DecimalType(16, 2), True),
    StructField("VALOR_TRIBUTO", DecimalType(16, 2), True),
    StructField("VALOR_TOTAL", DecimalType(16, 2), True),
    StructField("NOME_ITEM", StringType(), True),
    StructField("QTD_ITEM", IntegerType(), True),
    StructField("ID_CONDICAO", IntegerType(), True),
    StructField("DATA_PROCESSADO", DateType(), True)  # Corrigi o tipo de dados para corresponder ao CSV
])

schema_parcelas= StructType([
    StructField("ID_NF_SAIDA", IntegerType(), False),  
    StructField("DATA_VENCIMENTO", DateType(), False),  
    StructField("NUM_PARCELA", IntegerType(), False),     
    StructField("VALOR_PARCELA", DecimalType(16, 2), False),
    StructField("STATUS_RECEBIMENTO", ByteType(), False),
])
schema_recebimento = StructType([
    StructField("NUMERO_NF", IntegerType(), False),
    StructField("VALOR_RECEBIDO", DecimalType(16, 2), True),  
    StructField("DATA_RECEBIMENTO", DateType(), False),  
    StructField("DATA_VENCIMENTO", DateType(), False),
    StructField("DATA_PROCESSAMENTO", DateType(), False)       
  
])
schema_historico = StructType([
    StructField("ID_PROG_RECEBIMENTO", IntegerType(), False),
    StructField("ID_DESCONTO", IntegerType(), False),
    StructField("DATA_RECEBIDO", DateType(), False),    
    StructField("VALOR_TOTAL_EM_HAVER", DecimalType(16, 2), False),  
    StructField("VALOR_PAGO", DecimalType(16, 2), False)    
  
])

shr = StructType([
                    StructField("ID_HIST_RECEBIMENTO", IntegerType(), True),
                    StructField("ID_PROG_RECEBIMENTO", IntegerType(), True),
                    StructField("ID_DESCONTO", IntegerType(), True),
                    StructField("DATA_RECEBIDO", DateType(), True),
                    StructField("VALOR_TOTAL_EM_HAVER", DecimalType(16,2), True),
                    StructField("VALOR_PAGO", DecimalType(16,2), True)
])

shp = StructType([
                    StructField("ID_HIST_PAGAMENTO", IntegerType(), True),
                    StructField("ID_PROG_PAGAMENTO", IntegerType(), True),
                    StructField("ID_NF_ENTRADA", IntegerType(), True),
                    StructField("NUM_PARCELAS", IntegerType(), True),
                    StructField("DATA_VENCIMENTO", DateType(), True),
                    StructField("DATA_PGT_EFETUADO", DateType(), True),
                    StructField("VALOR_PARCELA",DecimalType(16,2), True),
                    StructField("VALOR_PARCELA_PAGO", DecimalType(16,2), True),
                    
])
