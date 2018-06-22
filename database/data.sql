-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: tracker_sl
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT  IGNORE INTO `config` VALUES ('company_email','email','Company Email','domain@company.ltd','Address to use in all the outbound emails sent by the application.'),('company_logo','text','Company Logo','logo-main.png','Image file for the company logo. Should be located in \"public/assets/img\" directory.'),('company_logo_favicon','text','Company Favicon','favicon.png','Image file for the company favicon logo. Should be located in \"public/assets/img\" directory.'),('company_logo_nav','text','Company Nav Logo','logo-nav.png','Monochrome image file for the company logo. Should be located in \"public/assets/img\" directory.'),('company_name','text','Company Name','My Company','Name of the company to be used throughout the application.'),('session_timeout','number','Session Timeout','5','Time (in minutes) after a session becomes inactive after an inactivity period.'),('session_timeout_delete','number','Session Timeout Delete','10','Time (in minutes) after inactive sessions are automatically deleted.');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT  IGNORE INTO `status` VALUES (1,'Available',1,1),(2,'On Training',3,1),(3,'Testing/QA',3,1),(4,'On Call',2,1),(5,'On Lunch',5,1),(7,'Administrative Tasks',4,1),(8,'On Meeting',3,1),(9,'Inactive',6,0),(10,'Other',3,1),(11,'Operations Tasks',4,1),(12,'Sales Tasks',4,1),(14,'On Break',5,1),(15,'Installations',3,1),(16,'Proposals',4,1),(17,'Boarding',4,1),(18,'Workflow',4,1),(19,'Certifications',3,1),(20,'Batches',3,1),(21,'Follow Ups',4,1),(22,'Accounting',4,1),(23,'Implementation',3,1),(24,'Integrations',3,1),(25,'RRHH',4,1);
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT  IGNORE INTO `task` VALUES (1,'Reports','Access all the available reports.'),(2,'Directory','Access the phone directory.'),(3,'GTA','Allow to use GTA accounts.'),(4,'Change User Status','Allow to change the status for other users.'),(5,'List All','List all users regardless of the department.'),(6,'Manage Users','Allow to create and edit users.'),(7,'Manage Roles','Allow to create, edit and delete roles.'),(8,'Manage Status','Allow to create, edit and delete status.'),(9,'Configuration','Allow to update global application settings.');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-22 11:25:56
