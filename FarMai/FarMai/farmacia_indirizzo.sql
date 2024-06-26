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
-- Table structure for table `indirizzo`
--

DROP TABLE IF EXISTS `indirizzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indirizzo` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Citta` varchar(30) NOT NULL,
  `CAP` char(9) NOT NULL,
  `via` varchar(30) NOT NULL,
  `Email_cliente` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Email_cliente` (`Email_cliente`),
  CONSTRAINT `indirizzo_ibfk_1` FOREIGN KEY (`Email_cliente`) REFERENCES `cliente` (`Email`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indirizzo`
--

LOCK TABLES `indirizzo` WRITE;
/*!40000 ALTER TABLE `indirizzo` DISABLE KEYS */;
INSERT INTO `indirizzo` VALUES (1,'Roma','00123','Via dei Fori Imperiali 12','mariorossi.4@gmail.com'),(2,'Milano','20123','Corso Buenos Aires 34','laura.bianchi@example.com'),(3,'Napoli','80100','Via Toledo 56','giuseppe.verdi@example.com'),(4,'Firenze','50100','Piazza della Signoria 8','anna.rossi@example.com'),(5,'Bari','70100','Via Sparano 20','luca.ferrari@example.com'),(6,'Torino','10100','Via Po 17','elena.rossi@example.com'),(7,'Milano','20100','Corso Magenta 78','marco.galli@example.com'),(8,'Bologna','40100','Piazza Maggiore 14','francesca.moretti@example.com'),(9,'Venezia','30100','San Marco 12','davide.rossi@example.com'),(10,'Firenze','50100','Via de Tornabuoni 25','sara.gallo@example.com'),(11,'saviano','80','via del frasso ','iari@gmail.com'),(12,'savia','123','via','a@a.com');
/*!40000 ALTER TABLE `indirizzo` ENABLE KEYS */;
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
