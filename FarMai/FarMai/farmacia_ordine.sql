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
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `ID` int NOT NULL,
  `Numero_carta` char(16) NOT NULL,
  `Data` date NOT NULL,
  `Circuito` varchar(30) NOT NULL,
  `Note` varchar(500) NOT NULL,
  `Indirizzo` varchar(50) NOT NULL,
  `Destinatario` varchar(30) NOT NULL,
  `Prezzo_totale` decimal(10,2) NOT NULL,
  `Sconto` int DEFAULT NULL,
  `Numero_tracking` varchar(30) NOT NULL,
  `MetodoSpedizione` enum('Spedizione standard','Spedizione express','Ritiro in negozio') DEFAULT NULL,
  `Email_cliente` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Email_cliente` (`Email_cliente`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`Email_cliente`) REFERENCES `cliente` (`Email`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ordine_chk_1` CHECK (((`Sconto` > 0) and (`Sconto` < 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (1,'1234567890123456','2024-04-18','Visa','Ordine numero 1','Via Roma 1','Mario Rossi',50.00,5,'TRK123456','Spedizione standard','mariorossi.4@gmail.com'),(2,'9876543210987654','2024-04-19','Mastercard','Ordine numero 2','Via Milano 2','Laura Bianchi',80.00,10,'TRK987654','Spedizione express','laura.bianchi@example.com'),(3,'1111222233334444','2024-04-20','American Express','Ordine numero 3','Via Napoli 3','Giuseppe Verdi',120.00,15,'TRK111122','Ritiro in negozio','giuseppe.verdi@example.com'),(4,'5555666677778888','2024-04-21','Visa','Ordine numero 4','Via Firenze 4','Anna Rossi',90.00,10,'TRK555566','Spedizione standard','anna.rossi@example.com'),(5,'9999888877776666','2024-04-22','Mastercard','Ordine numero 5','Via Bari 5','Luca Ferrari',70.00,8,'TRK999988','Spedizione express','luca.ferrari@example.com'),(6,'4444333322221111','2024-04-23','Visa','Ordine numero 6','Via Torino 6','Elena Rossi',100.00,12,'TRK444433','Spedizione standard','elena.rossi@example.com'),(7,'7777666655554444','2024-04-24','American Express','Ordine numero 7','Via Milano 7','Marco Galli',110.00,5,'TRK777766','Spedizione express','marco.galli@example.com'),(8,'8888999911112222','2024-04-25','Visa','Ordine numero 8','Via Bologna 8','Francesca Moretti',60.00,5,'TRK888899','Ritiro in negozio','francesca.moretti@example.com'),(9,'3333222211110000','2024-04-26','Mastercard','Ordine numero 9','Via Venezia 9','Davide Rossi',95.00,10,'TRK333322','Spedizione standard','davide.rossi@example.com'),(10,'0000111122223333','2024-04-27','Visa','Ordine numero 10','Via Firenze 10','Sara Gallo',75.00,7,'TRK000011','Spedizione express','sara.gallo@example.com');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
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
