CREATE DATABASE  IF NOT EXISTS `stage_vendas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `stage_vendas`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: stage_vendas
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
  `CEP` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `UF_ENDERECO` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CIDADE_ENDERECO` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `BAIRRO_ENDERECO` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NOME_ENDERECO` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
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
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `NOME_FORNECEDOR` varchar(100) DEFAULT NULL,
  `CNPJ_FORNECEDOR` varchar(100) DEFAULT NULL,
  `EMAIL_FORNECEDOR` varchar(100) DEFAULT NULL,
  `TELEFONE_FORNECEDOR` varchar(20) DEFAULT NULL,
  `NUMERO_NF` varchar(100) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `VALOR_NET` decimal(20,2) DEFAULT NULL,
  `VALOR_TRIBUTO` decimal(20,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,2) DEFAULT NULL,
  `NOME_ITEM` varchar(100) DEFAULT NULL,
  `QTD_ITEM` int DEFAULT NULL,
  `CONDICAO_PAGAMENTO` varchar(100) DEFAULT NULL,
  `CEP` int DEFAULT NULL,
  `NUM_ENDERECO` int DEFAULT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  `TIPO_ENDERECO` varchar(100) DEFAULT NULL,
  `DATA_PROCESSAMENTO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `count_fk`
--

DROP TABLE IF EXISTS `count_fk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `count_fk` (
  `etapa` varchar(20) DEFAULT NULL,
  `quantidade` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `count_fk`
--

LOCK TABLES `count_fk` WRITE;
/*!40000 ALTER TABLE `count_fk` DISABLE KEYS */;
INSERT INTO `count_fk` VALUES ('Antes',15),('Depois',15),('Antes',15),('Depois',15);
/*!40000 ALTER TABLE `count_fk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evidencias`
--

DROP TABLE IF EXISTS `evidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidencias` (
  `NOME` varchar(100) DEFAULT NULL,
  `OBJETO` varchar(100) DEFAULT NULL,
  `BANCO` varchar(100) DEFAULT NULL,
  `STATUS_CRIACAO` varchar(50) DEFAULT NULL,
  `DATA_CRIACAO` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NUM_LINHA` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evidencias`
--

LOCK TABLES `evidencias` WRITE;
/*!40000 ALTER TABLE `evidencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `evidencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos_efetuados`
--

DROP TABLE IF EXISTS `pagamentos_efetuados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentos_efetuados` (
  `ID_NF_ENTRADA` int NOT NULL,
  `DATA_VENCIMENTO` date NOT NULL,
  `DATA_PGT_EFETUADO` date NOT NULL,
  `VALOR_PARCELA_PAGO` decimal(16,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos_efetuados`
--

LOCK TABLES `pagamentos_efetuados` WRITE;
/*!40000 ALTER TABLE `pagamentos_efetuados` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamentos_efetuados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recebimento`
--

DROP TABLE IF EXISTS `recebimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recebimento` (
  `NUMERO_NF` int DEFAULT NULL,
  `VALOR_RECEBIDO` decimal(20,2) DEFAULT NULL,
  `DATA_VENCIMENTO` date DEFAULT NULL,
  `DATA_RECEBIMENTO` date DEFAULT NULL,
  `DATA_PROCESSAMENTO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recebimento`
--

LOCK TABLES `recebimento` WRITE;
/*!40000 ALTER TABLE `recebimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `recebimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recebimento_final`
--

DROP TABLE IF EXISTS `recebimento_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recebimento_final` (
  `ID_PROG_RECEBIMENTO` int DEFAULT NULL,
  `ID_DESCONTO` int DEFAULT NULL,
  `DATA_RECEBIDO` date DEFAULT NULL,
  `VALOR_TOTAL_EM_HAVER` decimal(16,2) DEFAULT NULL,
  `VALOR_PAGO` decimal(16,2) DEFAULT NULL,
  `MOTIVO` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recebimento_final`
--

LOCK TABLES `recebimento_final` WRITE;
/*!40000 ALTER TABLE `recebimento_final` DISABLE KEYS */;
/*!40000 ALTER TABLE `recebimento_final` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recebimento_rejeitado`
--

DROP TABLE IF EXISTS `recebimento_rejeitado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recebimento_rejeitado` (
  `NUMERO_NF` int DEFAULT NULL,
  `VALOR_RECEBIDO` decimal(16,2) DEFAULT NULL,
  `DATA_VENCIMENTO` date DEFAULT NULL,
  `DATA_RECEBIMENTO` date NOT NULL,
  `DATA_PROCESSAMENTO` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recebimento_rejeitado`
--

LOCK TABLES `recebimento_rejeitado` WRITE;
/*!40000 ALTER TABLE `recebimento_rejeitado` DISABLE KEYS */;
/*!40000 ALTER TABLE `recebimento_rejeitado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teste_ubuntu`
--

DROP TABLE IF EXISTS `teste_ubuntu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teste_ubuntu` (
  `nome` varchar(30) DEFAULT NULL,
  `valor` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teste_ubuntu`
--

LOCK TABLES `teste_ubuntu` WRITE;
/*!40000 ALTER TABLE `teste_ubuntu` DISABLE KEYS */;
INSERT INTO `teste_ubuntu` VALUES ('mouse',20),('caneca',10);
/*!40000 ALTER TABLE `teste_ubuntu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tratamento_compras`
--

DROP TABLE IF EXISTS `tratamento_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamento_compras` (
  `NOME_FORNECEDOR` varchar(100) DEFAULT NULL,
  `CNPJ_FORNECEDOR` varchar(100) DEFAULT NULL,
  `EMAIL_FORNECEDOR` varchar(100) DEFAULT NULL,
  `TELEFONE_FORNECEDOR` varchar(20) DEFAULT NULL,
  `NUMERO_NF` varchar(100) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `VALOR_NET` decimal(20,2) DEFAULT NULL,
  `VALOR_TRIBUTO` decimal(20,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,2) DEFAULT NULL,
  `NOME_ITEM` varchar(100) DEFAULT NULL,
  `QTD_ITEM` int DEFAULT NULL,
  `CONDICAO_PAGAMENTO` varchar(100) DEFAULT NULL,
  `CEP` int DEFAULT NULL,
  `NUM_ENDERECO` int DEFAULT NULL,
  `COMPLEMENTO` varchar(100) NOT NULL,
  `TIPO_ENDERECO` varchar(100) DEFAULT NULL,
  `DATA_PROCESSAMENTO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tratamento_compras`
--

LOCK TABLES `tratamento_compras` WRITE;
/*!40000 ALTER TABLE `tratamento_compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `tratamento_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tratamento_compras_final`
--

DROP TABLE IF EXISTS `tratamento_compras_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamento_compras_final` (
  `NOME_FORNECEDOR` varchar(100) DEFAULT NULL,
  `CNPJ_FORNECEDOR` varchar(100) DEFAULT NULL,
  `EMAIL_FORNECEDOR` varchar(100) DEFAULT NULL,
  `TELEFONE_FORNECEDOR` varchar(20) DEFAULT NULL,
  `NUMERO_NF` varchar(100) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `VALOR_NET` decimal(20,2) DEFAULT NULL,
  `VALOR_TRIBUTO` decimal(20,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,2) DEFAULT NULL,
  `NOME_ITEM` varchar(100) DEFAULT NULL,
  `QTD_ITEM` int DEFAULT NULL,
  `ID_CONDICAO_PAGAMENTO` int NOT NULL,
  `CEP` int DEFAULT NULL,
  `NUM_ENDERECO` int DEFAULT NULL,
  `COMPLEMENTO` varchar(100) NOT NULL,
  `TIPO_ENDERECO` varchar(100) DEFAULT NULL,
  `DATA_PROCESSAMENTO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tratamento_compras_final`
--

LOCK TABLES `tratamento_compras_final` WRITE;
/*!40000 ALTER TABLE `tratamento_compras_final` DISABLE KEYS */;
/*!40000 ALTER TABLE `tratamento_compras_final` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validacao_compras`
--

DROP TABLE IF EXISTS `validacao_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validacao_compras` (
  `DATA_PROCESSAMENTO` date DEFAULT NULL,
  `DATA_EMISAO` date DEFAULT NULL,
  `NUMERO_NF` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validacao_compras`
--

LOCK TABLES `validacao_compras` WRITE;
/*!40000 ALTER TABLE `validacao_compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `validacao_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validacao_compras_rejeitados`
--

DROP TABLE IF EXISTS `validacao_compras_rejeitados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validacao_compras_rejeitados` (
  `NOME_FORNECEDOR` varchar(100) DEFAULT NULL,
  `CNPJ_FORNECEDOR` varchar(100) DEFAULT NULL,
  `EMAIL_FORNECEDOR` varchar(100) DEFAULT NULL,
  `TELEFONE_FORNECEDOR` varchar(20) DEFAULT NULL,
  `NUMERO_NF` varchar(100) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `VALOR_NET` decimal(20,2) DEFAULT NULL,
  `VALOR_TRIBUTO` decimal(20,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,2) DEFAULT NULL,
  `NOME_ITEM` varchar(100) DEFAULT NULL,
  `QTD_ITEM` int DEFAULT NULL,
  `CONDICAO_PAGAMENTO`varchar(100) DEFAULT NULL,
  `CEP` int DEFAULT NULL,
  `NUM_ENDERECO` int DEFAULT NULL,
  `COMPLEMENTO` varchar(100) NOT NULL,
  `TIPO_ENDERECO` varchar(100) DEFAULT NULL,
  `DATA_PROCESSAMENTO` date DEFAULT NULL,
  `MOTIVO` varchar(100) DEFAULT NULL,
  `CNPJ_VALIDO` boolean DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validacao_compras_rejeitados`
--

LOCK TABLES `validacao_compras_rejeitados` WRITE;
/*!40000 ALTER TABLE `validacao_compras_rejeitados` DISABLE KEYS */;
/*!40000 ALTER TABLE `validacao_compras_rejeitados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validacao_vendas`
--

DROP TABLE IF EXISTS `validacao_vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validacao_vendas` (
  `DATA_PROCESSAMENTO` datetime(6) DEFAULT NULL,
  `NUMERO_NF` varchar(100) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validacao_vendas`
--

LOCK TABLES `validacao_vendas` WRITE;
/*!40000 ALTER TABLE `validacao_vendas` DISABLE KEYS */;
/*!40000 ALTER TABLE `validacao_vendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendas`
--

DROP TABLE IF EXISTS `vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendas` (
  `NOME_CLIENTE` varchar(100) DEFAULT NULL,
  `CNPJ_CLIENTE` varchar(100) DEFAULT NULL,
  `EMAIL_CLIENTE` varchar(100) DEFAULT NULL,
  `TELEFONE_CLIENTE` varchar(20) DEFAULT NULL,
  `NUMERO_NF` varchar(100) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `VALOR_NET` decimal(20,2) DEFAULT NULL,
  `VALOR_TRIBUTO` decimal(20,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,2) DEFAULT NULL,
  `NOME_ITEM` varchar(100) DEFAULT NULL,
  `QTD_ITEM` int DEFAULT NULL,
  `CONDICAO_PAGAMENTO` varchar(100) DEFAULT NULL,
  `CEP` int DEFAULT NULL,
  `NUM_ENDERECO` int DEFAULT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  `TIPO_ENDERECO` varchar(100) DEFAULT NULL,
  `DATA_PROCESSAMENTO` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendas`
--

LOCK TABLES `vendas` WRITE;
/*!40000 ALTER TABLE `vendas` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendas_rejeitadas`
--


DROP TABLE IF EXISTS `vendas_rejeitadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendas_rejeitadas` (
  `NOME` varchar(100) DEFAULT NULL,
  `CNPJ` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `TELEFONE` varchar(20) DEFAULT NULL,
  `NUMERO_NF` int DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `VALOR_NET` decimal(16,2) DEFAULT NULL,
  `VALOR_TRIBUTO` decimal(16,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(16,2) DEFAULT NULL,
  `NOME_ITEM` varchar(100) DEFAULT NULL,
  `QTD_ITEM` int DEFAULT NULL,
  `CONDICAO_PAGAMENTO` varchar(100) DEFAULT NULL,
  `CEP` int DEFAULT NULL,
  `NUM_ENDERECO` int DEFAULT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  `TIPO_ENDERECO` varchar(100) DEFAULT NULL,
  `DATA_PROCESSAMENTO` datetime(6) DEFAULT NULL,
  `MOTIVO` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendas_rejeitadas`
--

LOCK TABLES `vendas_rejeitadas` WRITE;
/*!40000 ALTER TABLE `vendas_rejeitadas` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendas_rejeitadas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-24  9:04:47
