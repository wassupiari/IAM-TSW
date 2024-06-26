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
  `Quantita` int NOT NULL,
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
INSERT INTO `prodotto` VALUES (135001,'Supradyn Difese 50+','asda',12.50,'Salute e cura della persona',5,'images/VitaminaC.jpg',10,'Compresse',100),(135002,'PAMPERS NATUR.4(7-18Kg)19pz','I pannolini Pampers Naturello sono dotati di un morbido rivestimento esterno in cotone e di un filtrante a contatto con la pelle prodotto al 50% con materiale derivato dalle piante. I pannolini Naturello sono dermatologicamente testati e non hanno profumazione in quanto vengono prodotti senza fare uso dei 26 allergeni del profumo elencati dall\'UE. Tutti i pannolini Naturello vengono prodotti con energia rinnovabile.in vendita online su farmaciaguacci.it  Taglia 4 (7-18 kg).',25.99,'Mamme e bambini',5,'images/Pannolino.jpg',10,'Compresse',200),(135003,'CLOREXYDERM Shampoo 4% 250ml','per la pulizia della cute e del pelo degli animali da compagnia quando all?azione pulente si voglia associare un?energica azione disinfettante.in vendita online su farmaciaguacci.it ',8.75,'Igiene e benessere',NULL,'images/Shampoo.jpg',10,'Sciroppi',150),(135004,'Eau Thermale Avene Spray Corpo Bambini SPF 50+','Protezione solare molto alta per la pelle sensibile dei bambini, per viso e corpo.in vendita online su farmaciaguacci.it  Nel cuore dello Spray bambini SPF 50+, Ã¨ presente l\'associazione esclusiva Sunsitive protection',15.00,'Salute e cura della persona',10,'images/Crema_solare.jpg',10,'Pomate',80),(135005,'DENTOSAN Dentifricio Sensitive 75ml','previene la formazione della carie, controlla le irritazione gengivali',3.99,'Igiene e benessere',15,'images/Dentifricio.jpg',10,'Compresse',300),(135006,'THE\'Rosso Tisana 20 Bust.ABOCA','Un filtro Ã¨ sufficiente per preparare una tazza di infuso (circa 100 ml). Versare l\'acqua portata ad ebollizione in una tazza contenente la bustina filtro, mantenere in infusione dai 5 ai 7 minuti, avendo cura di tenere coperto il recipiente per evitare la dispersione delle sostanze piÃº volatili',6.50,'Salute e cura della persona',NULL,'images/Tisana.jpg',10,'Sciroppi',120),(135007,'Balsamo labbra','Balsamo labbra idratante',2.99,'Salute e cura della persona',20,'images/Balsamo.jpg',10,'Pomate',250),(135008,'Integratore ferro','Integratore di ferro',18.99,'Salute e cura della persona',5,'images/Integratore.jpg',10,'Compresse',150),(135009,'Lozione corpo','Lozione idratante per il corpo',10.75,'Igiene e benessere',NULL,'images/Lozione.jpg',10,'Pomate',0),(135010,'Okitask 40mg Granulato 20 Bustine','Okitask Ã¨ un antidolorifico che si puÃ² assumere in caso di mal di testa, mal di denti, dolori mestruali, nevralgie di varia natura e dolori alle articolazioni. Grazie all\'azione di Ketoprofene, il principio attivo contenuto in queste bustine di granulato, i sintomi del dolore vengono alleviati in breve tempo, e si recupera una condizione di sollievo dal fastidio.',7.50,'Salute e cura della persona',10,'images/Analgesico.jpg',10,'Compresse',200);
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

-- Dump completed on 2024-06-26 16:39:05
