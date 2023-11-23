CREATE DATABASE  IF NOT EXISTS `projeto_financeiro_vendas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projeto_financeiro_vendas`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: projeto_financeiro_vendas
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cep`
--

DROP TABLE IF EXISTS `cep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cep` (
  `CEP` varchar(20) NOT NULL,
  `UF` varchar(5) NOT NULL,
  `CIDADE` varchar(150) NOT NULL,
  `BAIRRO` varchar(150) NOT NULL,
  `LOGRADOURO` varchar(150) NOT NULL,
  PRIMARY KEY (`CEP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cep`
--

LOCK TABLES `cep` WRITE;
/*!40000 ALTER TABLE `cep` DISABLE KEYS */;
/*!40000 ALTER TABLE `cep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `ID_CLIENTE` int auto_increment,
  `NOME` varchar(100) NOT NULL,
  `CNPJ` bigint NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `TELEFONE` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condicao_pagamento`
--

DROP TABLE IF EXISTS `condicao_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condicao_pagamento` (
  `ID_CONDICAO` int auto_increment,
  `DESCRICAO` varchar(40) NOT NULL,
  `QTD_PARCELAS` int NOT NULL,
  `ENTRADA` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID_CONDICAO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condicao_pagamento`
--

LOCK TABLES `condicao_pagamento` WRITE;
/*!40000 ALTER TABLE `condicao_pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `condicao_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecos_clientes`
--

DROP TABLE IF EXISTS `enderecos_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecos_clientes` (
  `ID_ENDERECO_CLIENTE` int auto_increment,
  `ID_CLIENTE` int NOT NULL,
  `ID_TIPO_ENDERECO` int NOT NULL,
  `CEP` varchar(20) NOT NULL,
  `NUMERO` int NOT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_ENDERECO_CLIENTE`),
  KEY `END_CLIENTE_FK` (`ID_CLIENTE`),
  KEY `CLIENTE_ENDERECO_TIPO_FK` (`ID_TIPO_ENDERECO`),
  KEY `END_CLIENTE_CEP_FK` (`CEP`),
  CONSTRAINT `FK_ENDERECO_CLIENTE_E_TIPO_END` FOREIGN KEY (`ID_TIPO_ENDERECO`) REFERENCES `tipo_endereco` (`ID_TIPO_ENDERECO`),
  CONSTRAINT `FK_ENDERECO_END_CLIEN_CEP` FOREIGN KEY (`CEP`) REFERENCES `cep` (`CEP`),
  CONSTRAINT `FK_ENDERECO_END_CLIEN_CLIENTES` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `clientes` (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecos_clientes`
--

LOCK TABLES `enderecos_clientes` WRITE;
/*!40000 ALTER TABLE `enderecos_clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `enderecos_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecos_fornecedores`
--

DROP TABLE IF EXISTS `enderecos_fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecos_fornecedores` (
  `ID_ENDERECO_FORNECEDOR` int auto_increment,
  `CEP` varchar(20) NOT NULL,
  `ID_FORNECEDOR` int NOT NULL,
  `ID_TIPO_ENDERECO` int NOT NULL,
  `NUMERO` int NOT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_ENDERECO_FORNECEDOR`),
  KEY `END_FORNECEDOR_CEP_FK` (`CEP`),
  KEY `END_FORNECEDOR_FK` (`ID_FORNECEDOR`),
  KEY `FORNECEDOR_ENDERECO_TIPO_FK` (`ID_TIPO_ENDERECO`),
  CONSTRAINT `FK_ENDERECO_END_FORNE_CEP` FOREIGN KEY (`CEP`) REFERENCES `cep` (`CEP`),
  CONSTRAINT `FK_ENDERECO_END_FORNE_FORNECED` FOREIGN KEY (`ID_FORNECEDOR`) REFERENCES `fornecedores` (`ID_FORNECEDOR`),
  CONSTRAINT `FK_ENDERECO_FORNECEDO_TIPO_END` FOREIGN KEY (`ID_TIPO_ENDERECO`) REFERENCES `tipo_endereco` (`ID_TIPO_ENDERECO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecos_fornecedores`
--

LOCK TABLES `enderecos_fornecedores` WRITE;
/*!40000 ALTER TABLE `enderecos_fornecedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `enderecos_fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forecast`
--

DROP TABLE IF EXISTS `forecast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forecast` (
  `ID_FORECAST` int auto_increment,
  `DATA_RECEBIDO` date NOT NULL,
  `VALOR_ENTRADA_PREVISTO` decimal(16,2) NOT NULL,
  `VALOR_ENTRADA_REALIZADO` decimal(16,2) NOT NULL,
  `VALOR_SAIDA_PREVISTO` decimal(16,2) NOT NULL,
  `VALOR_SAIDA_REALIZADO` decimal(16,2) NOT NULL,
  `SALDO_DIARIO` decimal(16,2) NOT NULL,
  PRIMARY KEY (`ID_FORECAST`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forecast`
--

LOCK TABLES `forecast` WRITE;
/*!40000 ALTER TABLE `forecast` DISABLE KEYS */;
/*!40000 ALTER TABLE `forecast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedores` (
  `ID_FORNECEDOR` int auto_increment,
  `NOME_FORNECEDOR` varchar(100) NOT NULL,
  `CNPJ_FORNECEDOR` bigint NOT NULL,
  `EMAIL_FORNECEDOR` varchar(100) NOT NULL,
  `TELEFONE_FORNECEDOR` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_FORNECEDOR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_pagamento`
--

DROP TABLE IF EXISTS `historico_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_pagamento` (
  `ID_HIST_PAGAMENTO` int auto_increment,
  `ID_PROG_PAGAMENTO` int NOT NULL,
  `ID_NF_ENTRADA` int NOT NULL,
  `NUM_PARCELAS` int NOT NULL,
  `DATA_VENCIMENTO` date NOT NULL,
  `DATA_PGT_EFETUADO` date NOT NULL,
  `VALOR_PARCELA` decimal(16,2) NOT NULL,
  `VALOR_PARCELA_PAGO` decimal(16,2) NOT NULL
  PRIMARY KEY (`ID_HIST_PAGAMENTO`),
  KEY `HIST_PAGO_PROGRAMACAO_FK` (`ID_PROG_PAGAMENTO`),
  CONSTRAINT `FK_HISTORIC_HIST_PAGO_PROGRAMA` FOREIGN KEY (`ID_PROG_PAGAMENTO`) REFERENCES `programacao_pagamento` (`ID_PROG_PAGAMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_pagamento`
--

LOCK TABLES `historico_pagamento` WRITE;
/*!40000 ALTER TABLE `historico_pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_recebimento`
--

DROP TABLE IF EXISTS `historico_recebimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_recebimento` (
  `ID_HIST_RECEBIMENTO` int auto_increment,
  `ID_PROG_RECEBIMENTO` int NOT NULL,
  `ID_DESCONTO` int NOT NULL,
  `DATA_RECEBIDO` date NOT NULL,
  `VALOR_TOTAL_EM_HAVER` decimal(16,2) NOT NULL,
  `VALOR_PAGO` decimal(16,2) NOT NULL,
  PRIMARY KEY (`ID_HIST_RECEBIMENTO`),
  KEY `HIST_RECEBIDO_PROGRAMACAO_FK` (`ID_PROG_RECEBIMENTO`),
  KEY `TIPO_DESC_HISTORICO_FK` (`ID_DESCONTO`),
  CONSTRAINT `FK_HISTORIC_HIST_RECE_PROGRAMA` FOREIGN KEY (`ID_PROG_RECEBIMENTO`) REFERENCES `programacao_recebimento` (`ID_PROG_RECEBIMENTO`),
  CONSTRAINT `FK_HISTORIC_TIPO_DESC_TIPO_DES` FOREIGN KEY (`ID_DESCONTO`) REFERENCES `tipo_desconto` (`ID_DESCONTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_recebimento`
--

LOCK TABLES `historico_recebimento` WRITE;
/*!40000 ALTER TABLE `historico_recebimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_recebimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_recebimento_divergente`
--

DROP TABLE IF EXISTS `historico_recebimento_divergente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_recebimento_divergente` (
  `ID_HIST_RECEB_DIVERGENTE` int NOT NULL,
  `ID_PROG_RECEBIMENTO` int DEFAULT NULL,
  `ID_DESCONTO` int DEFAULT NULL,
  `DATA_RECEBIDO` date DEFAULT NULL,
  `VALOR_TOTAL_EM_HAVER` decimal(16,2) DEFAULT NULL,
  `VALOR_PAGO` decimal(16,2) DEFAULT NULL,
  `MOTIVO` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_recebimento_divergente`
--

LOCK TABLES `historico_recebimento_divergente` WRITE;
/*!40000 ALTER TABLE `historico_recebimento_divergente` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_recebimento_divergente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_fiscais_entrada`
--

DROP TABLE IF EXISTS `notas_fiscais_entrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas_fiscais_entrada` (
  `ID_NF_ENTRADA` int auto_increment,
  `ID_FORNECEDOR` int NOT NULL,
  `ID_CONDICAO` int NOT NULL,
  `NUMERO_NF` int NOT NULL,
  `DATA_EMISSAO` date NOT NULL,
  `VALOR_NET` decimal(16,2) NOT NULL,
  `VALOR_TRIBUTO` decimal(16,2) NOT NULL,
  `VALOR_TOTAL` decimal(16,2) NOT NULL,
  `NOME_ITEM` varchar(100) NOT NULL,
  `QTD_ITEM` int NOT NULL,
  PRIMARY KEY (`ID_NF_ENTRADA`),
  KEY `FORNECEDOR_NF_FK` (`ID_FORNECEDOR`),
  KEY `NF_ENTRADA_CONDICAO_FK` (`ID_CONDICAO`),
  CONSTRAINT `FK_NOTAS_FI_FORNECEDO_FORNECED` FOREIGN KEY (`ID_FORNECEDOR`) REFERENCES `fornecedores` (`ID_FORNECEDOR`),
  CONSTRAINT `FK_NOTAS_FI_NF_ENTRAD_CONDICAO` FOREIGN KEY (`ID_CONDICAO`) REFERENCES `condicao_pagamento` (`ID_CONDICAO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_fiscais_entrada`
--

LOCK TABLES `notas_fiscais_entrada` WRITE;
/*!40000 ALTER TABLE `notas_fiscais_entrada` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas_fiscais_entrada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_fiscais_saida`
--

DROP TABLE IF EXISTS `notas_fiscais_saida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas_fiscais_saida` (
  `ID_NF_SAIDA` int auto_increment,
  `ID_CLIENTE` int NOT NULL,
  `ID_CONDICAO` int NOT NULL,
  `NUMERO_NF` int NOT NULL,
  `DATA_EMISSAO` date NOT NULL,
  `VALOR_NET` decimal(16,2) NOT NULL,
  `VALOR_TRIBUTO` decimal(16,2) NOT NULL,
  `VALOR_TOTAL` decimal(16,2) NOT NULL,
  `NOME_ITEM` varchar(100) NOT NULL,
  `QTD_ITEM` int NOT NULL,
  PRIMARY KEY (`ID_NF_SAIDA`),
  KEY `CLIENTES_NF_FK` (`ID_CLIENTE`),
  KEY `NF_SAIDA_CONDICAO_FK` (`ID_CONDICAO`),
  CONSTRAINT `FK_NOTAS_FI_CLIENTES__CLIENTES` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `clientes` (`ID_CLIENTE`),
  CONSTRAINT `FK_NOTAS_FI_NF_SAIDA__CONDICAO` FOREIGN KEY (`ID_CONDICAO`) REFERENCES `condicao_pagamento` (`ID_CONDICAO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_fiscais_saida`
--

LOCK TABLES `notas_fiscais_saida` WRITE;
/*!40000 ALTER TABLE `notas_fiscais_saida` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas_fiscais_saida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programacao_pagamento`
--

DROP TABLE IF EXISTS `programacao_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programacao_pagamento` (
  `ID_PROG_PAGAMENTO` int auto_increment,
  `ID_NF_ENTRADA` int NOT NULL,
  `DATA_VENCIMENTO` date NOT NULL,
  `NUM_PARCELAS` int NOT NULL,
  `VALOR_PARCELA` decimal(16,2) NOT NULL,
  `STATUS_PAGAMENTO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID_PROG_PAGAMENTO`),
  KEY `NF_ENTRADA_PROGRAMACAO_FK` (`ID_NF_ENTRADA`),
  CONSTRAINT `FK_PROGRAMA_NF_ENTRAD_NOTAS_FI` FOREIGN KEY (`ID_NF_ENTRADA`) REFERENCES `notas_fiscais_entrada` (`ID_NF_ENTRADA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programacao_pagamento`
--

LOCK TABLES `programacao_pagamento` WRITE;
/*!40000 ALTER TABLE `programacao_pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `programacao_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programacao_recebimento`
--

DROP TABLE IF EXISTS `programacao_recebimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programacao_recebimento` (
  `ID_PROG_RECEBIMENTO` int auto_increment,
  `ID_NF_SAIDA` int NOT NULL,
  `DATA_VENCIMENTO` date NOT NULL,
  `NUM_PARCELA` int NOT NULL,
  `VALOR_PARCELA` decimal(16,2) NOT NULL,
  `STATUS_RECEBIMENTO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID_PROG_RECEBIMENTO`),
  KEY `NF_SAIDA_PROGRAMACAO_FK` (`ID_NF_SAIDA`),
  CONSTRAINT `FK_PROGRAMA_NF_SAIDA__NOTAS_FI` FOREIGN KEY (`ID_NF_SAIDA`) REFERENCES `notas_fiscais_saida` (`ID_NF_SAIDA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programacao_recebimento`
--

LOCK TABLES `programacao_recebimento` WRITE;
/*!40000 ALTER TABLE `programacao_recebimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `programacao_recebimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysdiagrams`
--

DROP TABLE IF EXISTS `sysdiagrams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysdiagrams` (
  `name` varchar(160) NOT NULL,
  `principal_id` int NOT NULL,
  `diagram_id` int NOT NULL,
  `version` int DEFAULT NULL,
  `definition` longblob,
  PRIMARY KEY (`diagram_id`),
  UNIQUE KEY `UK_principal_name` (`principal_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysdiagrams`
--

LOCK TABLES `sysdiagrams` WRITE;
/*!40000 ALTER TABLE `sysdiagrams` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysdiagrams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_desconto`
--

DROP TABLE IF EXISTS `tipo_desconto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_desconto` (
  `ID_DESCONTO` int auto_increment,
  `DESCRICAO` varchar(40) NOT NULL,
  `MINIMO_DIAS` int NOT NULL,
  `MAXIMO_DIAS` int NOT NULL,
  `MINIMO` decimal(5,2) NOT NULL,
  `MAXIMO` decimal(5,2) NOT NULL,
  `APROVADOR` varchar(100) NOT NULL,
  `DATA_APROVACAO` date NOT NULL,
  `TIPO_DESCONTO` tinyint(1) NOT NULL,
  `STATUS_APROVACAO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID_DESCONTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_desconto`
--

LOCK TABLES `tipo_desconto` WRITE;
/*!40000 ALTER TABLE `tipo_desconto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_desconto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_endereco`
--

DROP TABLE IF EXISTS `tipo_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_endereco` (
  `ID_TIPO_ENDERECO` int auto_increment,
  `DESCRICAO` varchar(100) NOT NULL,
  `SIGLA` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_TIPO_ENDERECO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_endereco`
--

LOCK TABLES `tipo_endereco` WRITE;
/*!40000 ALTER TABLE `tipo_endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_endereco` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-24  8:40:18
