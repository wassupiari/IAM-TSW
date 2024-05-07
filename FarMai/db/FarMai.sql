CREATE DATABASE  IF NOT EXISTS `farmacia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `farmacia`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.1.0    Database: farmacia
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
  `Password` varchar(30) NOT NULL,
  `Nome` varchar(30) NOT NULL,
  `Cognome` varchar(30) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `CAP` char(5) NOT NULL,
  `Città` varchar(30) NOT NULL,
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
INSERT INTO `cliente` VALUES ('anna.rossi@example.com','anna94','RSSNNA94C11F724R','annapassword','Anna','Rossi','+39 347 2468135','50100','Firenze','Via Firenze 4','FI'),('davide.rossi@example.com','daviderossi','RSSDVD90C03F458Y','davidepwd','Davide','Rossi','+39 333 1230987','30100','Venezia','Via Venezia 9','VE'),('elena.rossi@example.com','elena78','RSSLNE78C07F405M','elenapwd','Elena','Rossi','+39 329 8765432','10100','Torino','Via Torino 6','TO'),('francesca.moretti@example.com','francy91','MRTFNC91C14F707L','francescapwd','Francesca','Moretti','+39 348 6543210','40100','Bologna','Via Bologna 8','BO'),('giuseppe.verdi@example.com','giuseppino','VRDGPP95C10F843U','strongpwd','Giuseppe','Verdi','+39 333 5432109','80100','Napoli','Via Napoli 3','NA'),('laura.bianchi@example.com','laura89','BNCLRA89C13F306X','securepwd','Laura','Bianchi','+39 345 9876543','20123','Milano','Via Milano 2','MI'),('luca.ferrari@example.com','ferrari84','FRRLCU84C09F509P','ferrariluca','Luca','Ferrari','+39 320 1357924','70100','Bari','Via Bari 5','BA'),('marco.galli@example.com','marco77','GLLMRC77C08F406N','marcopwd','Marco','Galli','+39 347 9876543','20100','Milano','Via Milano 7','MI'),('mariorossi.4@gmail.com','Mario4','RSSMRA86C12F205T','password123','Mario','Rossi','+39 333 1234567','00123','Roma','Via Roma 1','RM'),('sara.gallo@example.com','sara88','GLLSRA88C15F856J','sarapassword','Sara','Gallo','+39 347 4567890','50100','Firenze','Via Firenze 10','FI');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composto`
--

DROP TABLE IF EXISTS `composto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `composto` (
  `Prezzo` decimal(10,2) DEFAULT NULL,
  `Quantità` int NOT NULL,
  `IVA` int DEFAULT NULL,
  `ID_ordine` varchar(30) NOT NULL,
  `ID_prodotto` int NOT NULL,
  PRIMARY KEY (`ID_ordine`,`ID_prodotto`),
  KEY `ID_prodotto` (`ID_prodotto`),
  CONSTRAINT `composto_ibfk_1` FOREIGN KEY (`ID_ordine`) REFERENCES `ordine` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `composto_ibfk_2` FOREIGN KEY (`ID_prodotto`) REFERENCES `prodotto` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `composto_chk_1` CHECK ((`IVA` = 10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composto`
--

LOCK TABLES `composto` WRITE;
/*!40000 ALTER TABLE `composto` DISABLE KEYS */;
INSERT INTO `composto` VALUES (10.00,2,10,'ORD001',135001),(20.00,1,10,'ORD001',135002),(15.00,3,10,'ORD002',135003),(25.00,2,10,'ORD002',135004),(18.00,2,10,'ORD003',135005),(30.00,1,10,'ORD003',135006),(22.00,3,10,'ORD004',135007),(35.00,1,10,'ORD004',135008),(28.00,2,10,'ORD005',135009),(40.00,2,10,'ORD005',135010);
/*!40000 ALTER TABLE `composto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fattura`
--

DROP TABLE IF EXISTS `fattura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fattura` (
  `SDI` char(7) NOT NULL,
  `Importo` decimal(10,2) NOT NULL,
  `Data_scadenza` date NOT NULL,
  `Data_emissione` date NOT NULL,
  `Stato_pagamento` enum('PAGATA','IN ATTESA DEL PAGAMENTO') DEFAULT NULL,
  `IVA` int DEFAULT NULL,
  `ID_ordine` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`SDI`),
  KEY `ID_ordine` (`ID_ordine`),
  CONSTRAINT `fattura_ibfk_1` FOREIGN KEY (`ID_ordine`) REFERENCES `ordine` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fattura_chk_1` CHECK ((`IVA` = 10)),
  CONSTRAINT `fattura_chk_2` CHECK ((`Data_scadenza` > `Data_emissione`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fattura`
--

LOCK TABLES `fattura` WRITE;
/*!40000 ALTER TABLE `fattura` DISABLE KEYS */;
INSERT INTO `fattura` VALUES ('0123456',70.00,'2024-04-27','2024-04-19','IN ATTESA DEL PAGAMENTO',10,NULL),('1234567',100.00,'2024-04-18','2024-04-10','PAGATA',10,NULL),('2345678',150.00,'2024-04-19','2024-04-11','IN ATTESA DEL PAGAMENTO',10,NULL),('3456789',120.00,'2024-04-20','2024-04-12','IN ATTESA DEL PAGAMENTO',10,NULL),('4567890',80.00,'2024-04-21','2024-04-13','PAGATA',10,NULL),('5678901',200.00,'2024-04-22','2024-04-14','PAGATA',10,NULL),('6789012',90.00,'2024-04-23','2024-04-15','IN ATTESA DEL PAGAMENTO',10,NULL),('7890123',110.00,'2024-04-24','2024-04-16','PAGATA',10,NULL),('8901234',95.00,'2024-04-25','2024-04-17','IN ATTESA DEL PAGAMENTO',10,NULL),('9012345',130.00,'2024-04-26','2024-04-18','PAGATA',10,NULL);
/*!40000 ALTER TABLE `fattura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indirizzo`
--

DROP TABLE IF EXISTS `indirizzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indirizzo` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Città` varchar(30) NOT NULL,
  `CAP` char(5) NOT NULL,
  `via` varchar(30) NOT NULL,
  `Email_cliente` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Email_cliente` (`Email_cliente`),
  CONSTRAINT `indirizzo_ibfk_1` FOREIGN KEY (`Email_cliente`) REFERENCES `cliente` (`Email`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indirizzo`
--

LOCK TABLES `indirizzo` WRITE;
/*!40000 ALTER TABLE `indirizzo` DISABLE KEYS */;
INSERT INTO `indirizzo` VALUES (1,'Roma','00123','Via dei Fori Imperiali 12','mariorossi.4@gmail.com'),(2,'Milano','20123','Corso Buenos Aires 34','laura.bianchi@example.com'),(3,'Napoli','80100','Via Toledo 56','giuseppe.verdi@example.com'),(4,'Firenze','50100','Piazza della Signoria 8','anna.rossi@example.com'),(5,'Bari','70100','Via Sparano 20','luca.ferrari@example.com'),(6,'Torino','10100','Via Po 17','elena.rossi@example.com'),(7,'Milano','20100','Corso Magenta 78','marco.galli@example.com'),(8,'Bologna','40100','Piazza Maggiore 14','francesca.moretti@example.com'),(9,'Venezia','30100','San Marco 12','davide.rossi@example.com'),(10,'Firenze','50100','Via de Tornabuoni 25','sara.gallo@example.com');
/*!40000 ALTER TABLE `indirizzo` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `metodo_di_pagamento` VALUES (1,'1234567890123456','2025-12-31','123','Visa','mariorossi.4@gmail.com'),(2,'9876543210987654','2026-11-30','456','Mastercard','laura.bianchi@example.com'),(3,'1111222233334444','2024-10-31','789','American Express','giuseppe.verdi@example.com'),(4,'5555666677778888','2023-09-30','012','Visa','anna.rossi@example.com'),(5,'9999888877776666','2027-08-31','345','Mastercard','luca.ferrari@example.com'),(6,'4444333322221111','2028-07-31','678','Visa','elena.rossi@example.com'),(7,'7777666655554444','2029-06-30','901','American Express','marco.galli@example.com'),(8,'8888999911112222','2030-05-31','234','Visa','francesca.moretti@example.com'),(9,'3333222211110000','2031-04-30','567','Mastercard','davide.rossi@example.com'),(10,'0000111122223333','2032-03-31','890','Visa','sara.gallo@example.com');
/*!40000 ALTER TABLE `metodo_di_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `ID` varchar(30) NOT NULL,
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
INSERT INTO `ordine` VALUES ('ORD001','1234567890123456','2024-04-18','Visa','Ordine numero 1','Via Roma 1','Mario Rossi',50.00,5,'TRK123456','Spedizione standard','mariorossi.4@gmail.com'),('ORD002','9876543210987654','2024-04-19','Mastercard','Ordine numero 2','Via Milano 2','Laura Bianchi',80.00,10,'TRK987654','Spedizione express','laura.bianchi@example.com'),('ORD003','1111222233334444','2024-04-20','American Express','Ordine numero 3','Via Napoli 3','Giuseppe Verdi',120.00,15,'TRK111122','Ritiro in negozio','giuseppe.verdi@example.com'),('ORD004','5555666677778888','2024-04-21','Visa','Ordine numero 4','Via Firenze 4','Anna Rossi',90.00,10,'TRK555566','Spedizione standard','anna.rossi@example.com'),('ORD005','9999888877776666','2024-04-22','Mastercard','Ordine numero 5','Via Bari 5','Luca Ferrari',70.00,8,'TRK999988','Spedizione express','luca.ferrari@example.com'),('ORD006','4444333322221111','2024-04-23','Visa','Ordine numero 6','Via Torino 6','Elena Rossi',100.00,12,'TRK444433','Spedizione standard','elena.rossi@example.com'),('ORD007','7777666655554444','2024-04-24','American Express','Ordine numero 7','Via Milano 7','Marco Galli',110.00,5,'TRK777766','Spedizione express','marco.galli@example.com'),('ORD008','8888999911112222','2024-04-25','Visa','Ordine numero 8','Via Bologna 8','Francesca Moretti',60.00,5,'TRK888899','Ritiro in negozio','francesca.moretti@example.com'),('ORD009','3333222211110000','2024-04-26','Mastercard','Ordine numero 9','Via Venezia 9','Davide Rossi',95.00,10,'TRK333322','Spedizione standard','davide.rossi@example.com'),('ORD010','0000111122223333','2024-04-27','Visa','Ordine numero 10','Via Firenze 10','Sara Gallo',75.00,7,'TRK000011','Spedizione express','sara.gallo@example.com');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `ID` int NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Descrizione` varchar(500) NOT NULL,
  `Prezzo` decimal(10,2) NOT NULL,
  `Categoria` enum('Mamme e bambini','Salute e cura della persona','Igiene e benessere') DEFAULT NULL,
  `Sconto` int DEFAULT NULL,
  `Immagine` varchar(100) DEFAULT NULL,
  `IVA` int DEFAULT NULL,
  `Formato` enum('Compresse','Pomate','Sciroppi') DEFAULT NULL,
  `Quantità` int NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `prodotto_chk_1` CHECK ((`IVA` = 10)),
  CONSTRAINT `prodotto_chk_2` CHECK (((`Sconto` > 0) and (`Sconto` < 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (135001,'Supradyn Difese 50+','asda',12.50,'Salute e cura della persona',5,'images/VitaminaC.jpg',10,'Compresse',100),(135002,'PAMPERS NATUR.4(7-18Kg)19pz','I pannolini Pampers Naturello sono dotati di un morbido rivestimento esterno in cotone e di un filtrante a contatto con la pelle prodotto al 50% con materiale derivato dalle piante. I pannolini Naturello sono dermatologicamente testati e non hanno profumazione in quanto vengono prodotti senza fare uso dei 26 allergeni del profumo elencati dall\'UE. Tutti i pannolini Naturello vengono prodotti con energia rinnovabile.in vendita online su farmaciaguacci.it  Taglia 4 (7-18 kg).',25.99,'Mamme e bambini',5,'images/Pannolino.jpg',10,'Compresse',200),(135003,'CLOREXYDERM Shampoo 4% 250ml','per la pulizia della cute e del pelo degli animali da compagnia quando all?azione pulente si voglia associare un?energica azione disinfettante.in vendita online su farmaciaguacci.it ',8.75,'Igiene e benessere',NULL,'images/Shampoo.jpg',10,'Sciroppi',150),(135004,'Eau Thermale Avene Spray Corpo Bambini SPF 50+','Protezione solare molto alta per la pelle sensibile dei bambini, per viso e corpo.in vendita online su farmaciaguacci.it  Nel cuore dello Spray bambini SPF 50+, è presente l\'associazione esclusiva Sunsitive protection',15.00,'Salute e cura della persona',10,'images/Crema_solare.jpg',10,'Pomate',80),(135005,'DENTOSAN Dentifricio Sensitive 75ml','previene la formazione della carie, controlla le irritazione gengivali',3.99,'Igiene e benessere',15,'images/Dentifricio.jpg',10,'Compresse',300),(135006,'THE\'Rosso Tisana 20 Bust.ABOCA','Un filtro è sufficiente per preparare una tazza di infuso (circa 100 ml). Versare l\'acqua portata ad ebollizione in una tazza contenente la bustina filtro, mantenere in infusione dai 5 ai 7 minuti, avendo cura di tenere coperto il recipiente per evitare la dispersione delle sostanze piú volatili',6.50,'Salute e cura della persona',NULL,'images/Tisana.jpg',10,'Sciroppi',120),(135007,'Balsamo labbra','Balsamo labbra idratante',2.99,'Salute e cura della persona',20,'images/Balsamo.jpg',10,'Pomate',250),(135008,'Integratore ferro','Integratore di ferro',18.99,'Salute e cura della persona',5,'images/Integratore.jpg',10,'Compresse',150),(135009,'Lozione corpo','Lozione idratante per il corpo',10.75,'Igiene e benessere',NULL,'images/Lozione.jpg',10,'Pomate',0),(135010,'Analgesico','Analgesico per il mal di testa',7.50,'Salute e cura della persona',10,'images/Analgesico.png',10,'Compresse',200);
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-07 11:54:37
