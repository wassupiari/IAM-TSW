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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `Email` varchar(30) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `CF` char(16) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Nome` varchar(30) NOT NULL,
  `Cognome` varchar(30) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `CAP` char(9) NOT NULL,
  `Citta` varchar(30) NOT NULL,
  `Via` varchar(30) NOT NULL,
  `Provincia` varchar(30) NOT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('a@a.com','asd','asd','356a192b7913b04c54574d18c28d46e6395428ab','asd','ad','123','123','savia','via','si'),('admin@farmai.it','root','cfq21313131','d033e22ae348aeb5660fc2140aec35850c4da997','iari','normanno','3442299015','80','saviano','via del frasso','NA'),('anna.rossi@example.com','anna94','RSSNNA94C11F724R','annapassword','Anna','Rossi','+39 347 2468135','50100','Firenze','Via Firenze 4','FI'),('davide.rossi@example.com','daviderossi','RSSDVD90C03F458Y','davidepwd','Davide','Rossi','+39 333 1230987','30100','Venezia','Via Venezia 9','VE'),('elena.rossi@example.com','elena78','RSSLNE78C07F405M','elenapwd','Elena','Rossi','+39 329 8765432','10100','Torino','Via Torino 6','TO'),('francesca.moretti@example.com','francy91','MRTFNC91C14F707L','francescapwd','Francesca','Moretti','+39 348 6543210','40100','Bologna','Via Bologna 8','BO'),('giuseppe.verdi@example.com','giuseppino','VRDGPP95C10F843U','strongpwd','Giuseppe','Verdi','+39 333 5432109','80100','Napoli','Via Napoli 3','NA'),('iari@gmail.com','admin','asadsa','40bd001563085fc35165329ea1ff5c5ecbdbbeef','iari','normanno','123','80','saviano','via del frasso ','NA'),('laura.bianchi@example.com','laura89','BNCLRA89C13F306X','securepwd','Laura','Bianchi','+39 345 9876543','20123','Milano','Via Milano 2','MI'),('luca.ferrari@example.com','ferrari84','FRRLCU84C09F509P','ferrariluca','Luca','Ferrari','+39 320 1357924','70100','Bari','Via Bari 5','BA'),('marco.galli@example.com','marco77','GLLMRC77C08F406N','marcopwd','Marco','Galli','+39 347 9876543','20100','Milano','Via Milano 7','MI'),('mariorossi.4@gmail.com','Mario4','RSSMRA86C12F205T','password123','Mario','Rossi','+39 333 1234567','00123','Roma','Via Roma 1','RM'),('sara.gallo@example.com','sara88','GLLSRA88C15F856J','sarapassword','Sara','Gallo','+39 347 4567890','50100','Firenze','Via Firenze 10','FI');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
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
