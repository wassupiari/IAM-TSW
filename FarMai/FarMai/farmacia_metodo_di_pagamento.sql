CREATE DATABASE  IF NOT EXISTS `farmacia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `farmacia`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: farmacia
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `metodo_di_pagamento`
--

DROP TABLE IF EXISTS `metodo_di_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodo_di_pagamento` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Numero_carta` char(16) NOT NULL,
  `Data_scadenza` date NOT NULL,
  `CVV` char(4) NOT NULL,
  `Circuito` varchar(30) NOT NULL,
  `Email_cliente` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Email_cliente` (`Email_cliente`),
  CONSTRAINT `metodo_di_pagamento_ibfk_1` FOREIGN KEY (`Email_cliente`) REFERENCES `cliente` (`Email`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo_di_pagamento`
--

LOCK TABLES `metodo_di_pagamento` WRITE;
/*!40000 ALTER TABLE `metodo_di_pagamento` DISABLE KEYS */;
INSERT INTO `metodo_di_pagamento` VALUES (1,'1234567890123456','2025-12-31','123','Visa','mariorossi.4@gmail.com'),(2,'9876543210987654','2026-11-30','456','Mastercard','laura.bianchi@example.com'),(3,'1111222233334444','2024-10-31','789','American Express','giuseppe.verdi@example.com'),(4,'5555666677778888','2023-09-30','012','Visa','anna.rossi@example.com'),(5,'9999888877776666','2027-08-31','345','Mastercard','luca.ferrari@example.com'),(6,'4444333322221111','2028-07-31','678','Visa','elena.rossi@example.com'),(7,'7777666655554444','2029-06-30','901','American Express','marco.galli@example.com'),(8,'8888999911112222','2030-05-31','234','Visa','francesca.moretti@example.com'),(9,'3333222211110000','2031-04-30','567','Mastercard','davide.rossi@example.com'),(10,'0000111122223333','2032-03-31','890','Visa','iari@gmail.com');
/*!40000 ALTER TABLE `metodo_di_pagamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-26 16:39:05
