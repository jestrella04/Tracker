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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `id_user` varchar(45) NOT NULL,
  `id_status` int(11) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`,`id_status`,`date_start`),
  KEY `fk_activity_id_status_idx` (`id_status`),
  CONSTRAINT `fk_activity_id_status` FOREIGN KEY (`id_status`) REFERENCES `status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_id_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tracker_sl`@`localhost`*/ /*!50003 TRIGGER `activity_BEFORE_INSERT` BEFORE INSERT ON `activity` FOR EACH ROW BEGIN

	SET NEW.`date_start` = NOW();

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES ('company_email','email','Company Email','domain@company.ltd','Address to use in all the outbound emails sent by the application.'),('company_logo','text','Company Logo','logo-main.png','Image file for the company logo. Should be located in \"public/assets/img\" directory.'),('company_logo_favicon','text','Company Favicon','favicon.png','Image file for the company favicon logo. Should be located in \"public/assets/img\" directory.'),('company_logo_nav','text','Company Nav Logo','logo-nav.png','Monochrome image file for the company logo. Should be located in \"public/assets/img\" directory.'),('company_name','text','Company Name','My Company','Name of the company to be used throughout the application.'),('session_timeout','number','Session Timeout','5','Time (in minutes) after a session becomes inactive after an inactivity period.'),('session_timeout_delete','number','Session Timeout Delete','10','Time (in minutes) after inactive sessions are automatically deleted.');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_data_type`
--

DROP TABLE IF EXISTS `custom_data_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_data_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_data_type`
--

LOCK TABLES `custom_data_type` WRITE;
/*!40000 ALTER TABLE `custom_data_type` DISABLE KEYS */;
INSERT INTO `custom_data_type` VALUES (1,'Extensions','Local extension numbers.'),(2,'Miami Extensions','Miami extension numbers.'),(3,'External Numbers','External phone numbers.'),(4,'GTA','GTA session handling.');
/*!40000 ALTER TABLE `custom_data_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_data_value`
--

DROP TABLE IF EXISTS `custom_data_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_data_value` (
  `id_data_type` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_data_type`,`name`,`value`),
  CONSTRAINT `fk_data_value_id_data_type` FOREIGN KEY (`id_data_type`) REFERENCES `custom_data_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_data_value`
--

LOCK TABLES `custom_data_value` WRITE;
/*!40000 ALTER TABLE `custom_data_value` DISABLE KEYS */;
INSERT INTO `custom_data_value` VALUES (1,'Basilio Guzmán','530',''),(1,'Daniel Mejía','512',''),(1,'Darnyl Vargas','521',''),(1,'Dorally Jiménez','515',''),(1,'Dulce María Rusch','527',''),(1,'Eduvigis Paulino','516',''),(1,'Edwin Lugo','503',''),(1,'Erickson Checo','531',''),(1,'Gabriela Rodríguez','529',''),(1,'Jennifer Candelario','501',''),(1,'Joan Guzmán','525',''),(1,'Jonathan Estrella','507',''),(1,'Juan Alberto Rodríguez','505',''),(1,'Karina Lagos','506',''),(1,'Manuela Peralta','523',''),(1,'María Hernández','526',''),(1,'Nathanael Aybar','508',''),(1,'Pedro Santos','518',''),(1,'Roberto Cabrera','511',''),(1,'Ruby Morel','519',''),(1,'Scarlette Perdomo','522',''),(1,'Vielka Medina','504',''),(2,'Alysson Guerra','222',''),(2,'Beatriz','212',''),(2,'Christine Speedy','','954-815-6040'),(2,'Christopher Justice','','678-938-1136'),(2,'Danny Domínguez','217','305-608-6550'),(2,'Dave Roberts','','360-513-9238'),(2,'Ervin Salar','206','786-253-2253'),(2,'Everyone (Level II)','607','773-236-7974'),(2,'Gary Smith','','869-766-2273'),(2,'Gene Lage','','678-777-8665'),(2,'German González','210','954-778-1865'),(2,'German González Jr.','224','954-940-2330'),(2,'Hector Miranda','204','305-733-4418'),(2,'Javier Torres','272','786-370-3885'),(2,'Jenisel Rodriguez','213',''),(2,'Joey Orozco','232','786.390.0305'),(2,'Jorge Fernández','252','786-255-9400'),(2,'José Hernández','214','305-310-0003'),(2,'Karl Díaz','','305-788-7989'),(2,'Kelia Rodríguez','215',''),(2,'Linda Chapin','','978-201-6262'),(2,'Mercy Fernández','208',''),(2,'Pamela Farrel','','615-310-9771'),(2,'Paola Báez','219',''),(2,'Polo Pomares','','305-609-5445'),(2,'Receptionist','201',''),(2,'Robert Jones','298',NULL),(2,'Robin Simmons','203','786-999-3249'),(2,'Rudet Fountain','','404-386-9586'),(2,'Sebastian Pacheco','225','786-570-0583'),(2,'Stephen Pineda','233','305-431-3242'),(2,'Steve Brown','','813-493-8488'),(2,'Tom Alas','234',''),(2,'Zoila Sotelo','221',''),(3,'Answering Service','1-305-270-4000',''),(3,'AutoNation Service Desk','1-877-744-2237',''),(3,'CDK Implementation Support','1-866-668-5394',''),(3,'Chase Paymentech (Trx Verification)','1-800-254-9556','Transaction Verification'),(3,'Chase Paymentech (Voice Auth - AMEX)','1-800-555-5707 ','Voice Authorization for AMEX cards.'),(3,'Chase Paymentech (Voice Auth - Discover)','1-800-347-1111','Voice Authorization for Discover cards.'),(3,'Chase Paymentech (Voice Auth - Visa/MC)','1-800-555-5707 ','Voice Authorization for Visa and MC.'),(3,'Customer Care (FD Canada)','1-888-263-1938',''),(3,'Digital Currency Support','1-847-498-9955','Ext. 2'),(3,'EPX (Voice Auth)','1-866-660-7065','Voice Authorization for all cards.'),(3,'EPX Customer Service','1-866-581-5239',''),(3,'FAPS chargeback','1-800-701-2831','Ext. 2672'),(3,'FDC Software Vendor Support','1-866-832-5279',''),(3,'First Data (Trx Verification)','1-866-597-5721','Transaction Verification'),(3,'First Data (Voice Auth)','1-800-228-1122','Voice Authorization for all cards.'),(3,'First Data - Chargebacks (Nashville)','1-888-292-2608','Chargeback information (FD NASHVILLE 434 merchants)'),(3,'First Data - Chargebacks (Omaha)','?1-800-672-5008','Chargeback information (FD OMAHA 518564, 530960490 merchants)'),(3,'North ISO Clover Support','1-844-864-5450',''),(3,'Penske Help Desk','1-877-824-6381',''),(3,'TSYS (Voice Auth)','1-800-228-5882','Voice Authorization for all cards.'),(3,'TSYS Help Desk','1-800-552-8227',''),(3,'TSYS Help Desk (Alt)','1-480-333-7600',''),(3,'TTech','1-877-838-4031',''),(3,'UTA','1-954-431-5256',''),(3,'Vantiv (Trx Verification)','1-877-744-5300','Transaction Verification'),(3,'Vantiv (Voice Auth - AMEX)','1-800-528-2121','Voice Authorization for AMEX.'),(3,'Vantiv (Voice Auth)','1-800-991-9911','Voice Authorization for Visa, MC and Discover.'),(3,'Vantiv - Chargebacks','1-800-667-9573','Chargeback Information'),(3,'Vantiv Help Desk','1-866-622-2390',''),(4,'CS1','','GTA session 1'),(4,'CS2','','GTA session 2'),(4,'CS3','','GTA session 3'),(4,'CS4','','GTA session 4'),(4,'CS5','','GTA session 5'),(4,'CS6','','GTA session 6'),(4,'CS7','','GTA session 7'),(4,'CS8','','GTA session 8');
/*!40000 ALTER TABLE `custom_data_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_status` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `inqueue` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_department_id_status_idx` (`id_status`),
  CONSTRAINT `fk_department_id_status` FOREIGN KEY (`id_status`) REFERENCES `status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,1,'Tech Support','',1),(2,3,'QA','',0),(4,7,'Management','',0),(5,11,'Operations','',0),(6,1,'Training & Implementation','',1),(7,12,'Sales','',0),(11,20,'Batches','',1),(14,22,'Accounting','',0),(15,10,'Payvana','',0),(17,24,'Integrations','',0),(18,25,'Human Resources','',0);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_allowed_status`
--

DROP TABLE IF EXISTS `department_allowed_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_allowed_status` (
  `id_department` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_department`,`id_status`),
  KEY `fk_department_allowed_status_id_status_idx` (`id_status`),
  CONSTRAINT `fk_department_allowed_status_id_department` FOREIGN KEY (`id_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_allowed_status_id_status` FOREIGN KEY (`id_status`) REFERENCES `status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_allowed_status`
--

LOCK TABLES `department_allowed_status` WRITE;
/*!40000 ALTER TABLE `department_allowed_status` DISABLE KEYS */;
INSERT INTO `department_allowed_status` VALUES (1,1,1),(1,2,1),(1,4,1),(1,5,1),(1,7,1),(1,8,1),(1,10,1),(1,14,1),(1,15,1),(2,2,1),(2,3,1),(2,5,1),(2,7,1),(2,8,1),(2,10,1),(2,14,1),(4,1,1),(4,2,1),(4,4,1),(4,5,1),(4,7,1),(4,8,1),(4,10,1),(4,14,1),(5,5,1),(5,8,1),(5,11,1),(5,14,1),(5,16,1),(5,17,1),(5,18,1),(6,1,1),(6,2,1),(6,4,1),(6,5,1),(6,8,1),(6,10,1),(6,14,1),(6,15,1),(6,23,1),(7,5,1),(7,12,1),(7,14,1),(11,1,1),(11,2,1),(11,4,1),(11,5,1),(11,7,1),(11,8,1),(11,10,1),(11,14,1),(11,15,1),(11,20,1),(14,5,1),(14,8,1),(14,10,1),(14,14,1),(14,22,1),(15,2,1),(15,5,1),(15,8,1),(15,10,1),(15,14,1),(17,2,1),(17,3,1),(17,5,1),(17,7,1),(17,8,1),(17,10,1),(17,14,1),(17,24,1),(18,5,1),(18,8,1),(18,10,1),(18,14,1),(18,25,1);
/*!40000 ALTER TABLE `department_allowed_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Administrator',NULL),(5,'Standard User',NULL),(6,'Tech Support',NULL),(7,'Customer Service',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_allowed_task`
--

DROP TABLE IF EXISTS `role_allowed_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_allowed_task` (
  `id_role` int(11) NOT NULL,
  `id_task` int(11) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_role`,`id_task`),
  KEY `fk_role_allowed_task_id_task_idx` (`id_task`),
  CONSTRAINT `fk_role_allowed_task_id_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_allowed_task_id_task` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_allowed_task`
--

LOCK TABLES `role_allowed_task` WRITE;
/*!40000 ALTER TABLE `role_allowed_task` DISABLE KEYS */;
INSERT INTO `role_allowed_task` VALUES (1,1,1),(1,2,1),(1,3,1),(1,4,1),(1,5,1),(1,6,1),(1,7,1),(1,8,1),(1,9,1),(5,2,1),(6,2,1),(6,3,1);
/*!40000 ALTER TABLE `role_allowed_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id_user` varchar(45) NOT NULL,
  `id_status` int(11) NOT NULL,
  `ordinal` int(11) NOT NULL,
  `absolute` int(11) NOT NULL,
  `date_last_activity` datetime NOT NULL,
  `date_last_status_change` datetime NOT NULL,
  `queued` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_user`),
  KEY `fk_session_id_status_idx` (`id_status`),
  CONSTRAINT `fk_session_id_status` FOREIGN KEY (`id_status`) REFERENCES `status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_id_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tracker_sl`@`localhost`*/ /*!50003 TRIGGER `session_BEFORE_INSERT` BEFORE INSERT ON `session` FOR EACH ROW BEGIN

	IF (NEW.`id_status` <> 9) THEN

		SET NEW.`date_last_activity` = NOW();

		SET NEW.`date_last_status_change` = NOW();

	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Available',1,1),(2,'On Training',3,1),(3,'Testing/QA',3,1),(4,'On Call',2,1),(5,'On Lunch',5,1),(7,'Administrative Tasks',4,1),(8,'On Meeting',3,1),(9,'Inactive',6,0),(10,'Other',3,1),(11,'Operations Tasks',4,1),(12,'Sales Tasks',4,1),(14,'On Break',5,1),(15,'Installations',3,1),(16,'Proposals',4,1),(17,'Boarding',4,1),(18,'Workflow',4,1),(19,'Certifications',3,1),(20,'Batches',3,1),(21,'Follow Ups',4,1),(22,'Accounting',4,1),(23,'Implementation',3,1),(24,'Integrations',3,1),(25,'RRHH',4,1);
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Reports','Access all the available reports.'),(2,'Directory','Access the phone directory.'),(3,'GTA','Allow to use GTA accounts.'),(4,'Change User Status','Allow to change the status for other users.'),(5,'List All','List all users regardless of the department.'),(6,'Manage Users','Allow to create and edit users.'),(7,'Manage Roles','Allow to create, edit and delete roles.'),(8,'Manage Status','Allow to create, edit and delete status.'),(9,'Configuration','Allow to update global application settings.');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(45) NOT NULL,
  `id_role` int(11) NOT NULL,
  `id_department` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_is_default` tinyint(4) NOT NULL DEFAULT '1',
  `password_last_update` datetime NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_user_id_role_idx` (`id_role`),
  KEY `fk_user_id_department_idx` (`id_department`),
  CONSTRAINT `fk_user_id_department` FOREIGN KEY (`id_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tracker_sl'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_department` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_delete_department`(
	IN departmentId INT
)
BEGIN
	DELETE FROM `department_allowed_status` WHERE `id_department` = departmentId;
	DELETE FROM `department` WHERE `id` = departmentId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_role` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_delete_role`(
	IN roleId INT
)
BEGIN
	DELETE FROM `role_allowed_task` WHERE `id_role` = roleId;
	DELETE FROM `role` WHERE `id` = roleId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_session` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_delete_session`(
	IN userId VARCHAR(45)
)
BEGIN
    CALL `sp_update_custom_data_value_clear`(4, userId);
    DELETE FROM `session` WHERE `id_user` = userId;
    CALL `sp_update_activity`(userId, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_session_inactive` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_delete_session_inactive`()
BEGIN
	DELETE FROM `session` WHERE `id_status` = 9 AND `date_last_activity` < DATE_SUB(NOW(), INTERVAL (SELECT `value` FROM `config` WHERE `id` = 'session_timeout_delete') MINUTE);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_status` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_delete_status`(
	IN statusId INT
)
BEGIN
	DELETE FROM `status` WHERE `id` = statusId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_custom_data_type` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_custom_data_type`(
    IN dataTypeName VARCHAR(45),
    IN dataTypeDescr VARCHAR(255),
    OUT insertedId INT
)
BEGIN
	INSERT INTO `custom_data_type`
	(
		`id`,
		`name`,
		`description`
    )
	VALUES
	(
		NULL,
		dataTypeName,
		dataTypeDescr
    );

	SET insertedId = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_custom_data_value` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_custom_data_value`(
    IN dataTypeId INT,
    IN dataValueName VARCHAR(45),
    IN dataValueVal VARCHAR(45),
    IN dataValueDescr VARCHAR(255),
    OUT insertedId INT
)
BEGIN
	INSERT INTO `custom_data_value`
	(
		`id_data_type`,
		`name`,
		`value`,
		`description`
    )
	VALUES
	(
		dataTypeId,
		dataValueName,
		dataValueVal,
        dataValueDescr
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_department` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_department`(
	IN statusId INT,
    IN departmentName VARCHAR(45),
    IN departmentDesc VARCHAR(255),
    IN departmentInQueue TINYINT,
    OUT insertedId INT
)
BEGIN
	INSERT INTO `department`
	(
		`id`,
		`id_status`,
		`name`,
		`description`,
		`inqueue`
    )
	VALUES
	(
		NULL,
		statusId,
		departmentName,
		departmentDesc,
		departmentInQueue
    );

	SET insertedId = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_department_allowed_status` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_department_allowed_status`(
	IN departmentId INT,
    IN statusId INT,
    IN enabled TINYINT
)
BEGIN
	IF EXISTS(SELECT `id_department` FROM `department_allowed_status` WHERE `id_department` = departmentId AND `id_status` = statusId) THEN
		UPDATE `department_allowed_status`
        SET `enabled` = enabled
        WHERE `id_department` = departmentId AND `id_status` = statusId;
	ELSE
		INSERT INTO `department_allowed_status`
		(
			`id_department`,
			`id_status`,
			`enabled`
        )
		VALUES
		(
			departmentId,
			statusId,
			enabled
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_role` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_role`(
    IN roleName VARCHAR(45),
    IN roleDesc VARCHAR(255),
    OUT insertedId INT
)
BEGIN
	INSERT INTO `role`
	(
		`id`,
		`name`,
		`description`
    )
	VALUES
	(
		NULL,
		roleName,
		roleDesc
    );

	SET insertedId = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_role_allowed_task` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_role_allowed_task`(
	IN roleId INT,
    IN taskId INT,
    IN enabled TINYINT
)
BEGIN
	IF EXISTS(SELECT `id_role` FROM `role_allowed_task` WHERE `id_role` = roleId AND `id_task` = taskId) THEN
		UPDATE `role_allowed_task`
        SET `enabled` = enabled
        WHERE `id_role` = roleId AND `id_task` = taskId;
	ELSE
		INSERT INTO `role_allowed_task`
		(
			`id_role`,
			`id_task`,
			`enabled`
        )
		VALUES
		(
			roleId,
			taskId,
			enabled
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_session` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_session`(
	IN userId VARCHAR(45)
)
BEGIN
	SET @userDefaultStatusId = (SELECT `id_status` FROM `department` WHERE `id` = (SELECT `id_department` FROM `user` WHERE `id` = userId));

    IF EXISTS(SELECT `id_user` FROM `session` WHERE `id_user` = userId) THEN
		SET @userCurrentStatus = (SELECT `id_status` FROM `session` WHERE `id_user` = userId);

        IF @userCurrentStatus = 9 THEN
            CALL `sp_update_session`(userId, @userDefaultStatusId);
		END IF;

    ELSE        
        CALL `sp_select_session_next_ordinal`(@userDefaultStatusId, @nextOrdinal);
        CALL `sp_select_session_next_absolute`(@nextAbsolute);
        
		INSERT INTO `session`
		(
			`id_user`,
			`id_status`,
			`ordinal`,
			`absolute`,
            `queued`
        )
		VALUES
		(
			userId,
			@userDefaultStatusId,
			@nextOrdinal,
			@nextAbsolute,
            1
        );
        
        CALL `sp_update_activity`(userId, @userDefaultStatusId); 
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_status` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_status`(
    IN statusName VARCHAR(45),
    IN statusPriority INT,
    OUT insertedId INT
)
BEGIN
	INSERT INTO `status`
	(
		`id`,
		`name`,
		`priority`,
        `enabled`
    )
	VALUES
	(
		NULL,
		statusName,
		statusPriority,
        1
    );

	SET insertedId = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_user` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_user`(
	IN userId VARCHAR(45),
    IN roleId INT,
    IN departmentId INT,
    IN userName VARCHAR(45),
    IN userEmail VARCHAR(45),
    IN userPassword VARCHAR(255),
    OUT insertedId VARCHAR(45)
)
BEGIN
	INSERT INTO `user`
	(
		`id`,
		`id_role`,
		`id_department`,
		`name`,
		`email`,
		`password`,
		`password_is_default`,
		`password_last_update`,
		`enabled`
    )
	VALUES
	(
		userId,
		roleId,
		departmentId,
		userName,
		userEmail,
		userPassword,
		1,
		NOW(),
		1
    );

    SET insertedId = (SELECT `id` FROM `user` WHERE `id` = userId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_activity_daily` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_activity_daily`(
	IN `dateStart` DATE,
    IN `dateEnd` DATE,
    IN `myId` VARCHAR(45)
)
BEGIN
	DECLARE userId VARCHAR(45);

    IF (NOT ISNULL(myId)) THEN
		SET userId = myId;
    END IF;
    
    SET @endDate = DATE_ADD(dateEnd, INTERVAL 1 DAY);

	SELECT
		t.`id_user`,
		t.`date_`,
		t.`start_` AS `labor_start`,
		l.`start_` AS `lunch_start`,
		l.`end_` AS `lunch_end`,
		t.`end_` AS `labor_end`,
		b.`neto_` AS `break_total`,
		l.`neto_` AS `lunch_total`,
		t.`total_` AS `labor_total`,
		TIMEDIFF(t.`neto_`, SEC_TO_TIME((TIME_TO_SEC(IFNULL(l.`neto_`, 0)) + TIME_TO_SEC(IFNULL(b.`neto_`, 0))))) AS `labor_net`
	FROM
	(
		SELECT
			`id_user`,
            DATE_FORMAT(`date_start`, '%m-%d-%Y') AS `date_`,
            DATE_FORMAT(MIN(`date_start`), '%h:%i %p') AS `start_`,
            DATE_FORMAT(MAX(`date_end`), '%h:%i %p') AS `end_`,
            TIMEDIFF(MAX(`date_end`), MIN(`date_start`)) AS `total_`,
            SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND `date_start` AND `date_end` BETWEEN dateStart AND @endDate
        AND `date_end` IS NOT NULL
		GROUP BY `id_user`, DATE(`date_start`)
		ORDER BY `date_start`, `id_user`
	)
	AS t

	LEFT JOIN
	(
		SELECT
			`id_user`,
			DATE_FORMAT(`date_start`, '%m-%d-%Y') AS `date_`,
			DATE_FORMAT(MIN(`date_start`), '%h:%i %p') AS `start_`,
			DATE_FORMAT(MAX(`date_end`), '%h:%i %p') AS `end_`,
			TIMEDIFF(MAX(`date_end`), MIN(`date_start`)) AS `total_`,
			SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND`date_start` AND `date_end` BETWEEN dateStart AND @endDate
        AND `id_status` = 5 AND `date_end` IS NOT NULL
		GROUP BY `id_user`, DATE(`date_start`)
		ORDER BY `date_start`, `id_user`
	)
	AS l
	ON t.`id_user` = l.`id_user` AND t.`date_` = l.`date_`

	LEFT JOIN
	(
		SELECT
			`id_user`,
			DATE_FORMAT(`date_start`, '%m-%d-%Y') AS `date_`,
			SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND `date_start` AND `date_end` BETWEEN dateStart AND @endDate
        AND `id_status` = 14 AND `date_end` IS NOT NULL
		GROUP BY `id_user`, DATE(`date_start`)
		ORDER BY `date_start`, `id_user`
	)
	AS b
	ON l.`id_user` = b.`id_user` AND l.`date_` = b.`date_`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_activity_detailed` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_activity_detailed`(
	IN dateStart DATE,
    IN dateEnd DATE,
    IN myId VARCHAR(45)
)
BEGIN
	DECLARE userId VARCHAR(45);

    IF (NOT ISNULL(myId)) THEN
		SET userId = myId;
    END IF;
    
    SET @endDate = DATE_ADD(dateEnd, INTERVAL 1 DAY);

	SELECT
		`id_user`,
		(SELECT `name` FROM `status` WHERE `status`.`id` = `id_status`) AS `status_name`,
		DATE_FORMAT(`date_start`, '%m-%d-%Y') AS `date_`,
		DATE_FORMAT(`date_start`, '%h:%i %p') AS `start_`,
		DATE_FORMAT(`date_end`, '%h:%i %p') AS `end_`,
		TIMEDIFF(`date_end`, `date_start`) AS `total_`
	FROM `activity`
	WHERE (userId IS NULL OR `id_user` = userId)
    AND `date_start` AND `date_end` BETWEEN dateStart AND @endDate
    AND `date_end` IS NOT NULL
	ORDER BY `date_start`, `id_user`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_activity_range` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_activity_range`(
	IN `dateStart` DATE,
	IN `dateEnd` DATE,
	IN `myId` VARCHAR(45)
)
BEGIN
	DECLARE userId VARCHAR(45);

    IF (NOT ISNULL(myId)) THEN
		SET userId = myId;
    END IF;
    
    SET @endDate = DATE_ADD(dateEnd, INTERVAL 1 DAY);

	SELECT
		t.`id_user`,
		t.`neto_` AS `labor_total`,
		l.`neto_` AS `lunch_total`,
		b.`neto_` AS `break_total`,
		TIMEDIFF(t.`neto_`, SEC_TO_TIME((TIME_TO_SEC(IFNULL(l.`neto_`, 0)) + TIME_TO_SEC(IFNULL(b.`neto_`, 0))))) AS `labor_net`
	FROM
	(
		SELECT
			`id_user`,
			SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND,
			`date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND `date_start` AND `date_end` BETWEEN dateStart AND @endDate
        AND `date_end` IS NOT NULL
		GROUP BY `id_user`
		ORDER BY `id_user`
	)
	AS t

	LEFT JOIN
	(
		SELECT
			`id_user`,
			TIMEDIFF(MAX(`date_end`),
			MIN(`date_start`)) AS `total_`,
			SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND `date_start` AND `date_end` BETWEEN dateStart AND @endDate
        AND `id_status` = 5 AND `date_end` IS NOT NULL
		GROUP BY `id_user`
		ORDER BY `id_user`
	)
	AS l
	ON t.`id_user` = l.`id_user`

	LEFT JOIN
	(
		SELECT
			`id_user`,
            SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND `date_start` AND `date_end` BETWEEN dateStart AND @endDate
        AND `id_status` = 14 AND `date_end` IS NOT NULL
		GROUP BY `id_user`
		ORDER BY `id_user`
	)

	AS b
	ON l.`id_user` = b.`id_user`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_config` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_config`()
BEGIN
	SELECT * FROM `config`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_custom_data_value` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_custom_data_value`(
	IN myId INT
)
BEGIN    
	SELECT
		`name`,
        `value`,
		`description`
	FROM `custom_data_value`
    WHERE
		`id_data_type` = myId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_department` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_department`(
	IN myId INT
)
BEGIN
	DECLARE apartmentId INT;

    IF (NOT ISNULL(myId) AND myId > 0) THEN
		SET apartmentId = myId;
    END IF;

	SELECT
		`id`,
        `id_status`,
        (SELECT `name` FROM `status` WHERE `status`.`id` = `id_status`) AS `status_name`,
		`name`,
		`description`,
        `inqueue`
	FROM `department`
    WHERE apartmentId IS NULL OR `id` = apartmentId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_department_allowed_status` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_department_allowed_status`(
	IN myId INT
)
BEGIN
	SELECT
		`id_status`,
		(SELECT `name` FROM `status` WHERE `id` = `id_status`) AS `status_name`
	FROM `department_allowed_status`
    WHERE `id_department` = myId
	AND `enabled` > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_role` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_role`(
	IN myId INT
)
BEGIN
	DECLARE roleId INT;

    IF (NOT ISNULL(myId) AND myId > 0) THEN
		SET roleId = myId;
    END IF;

	SELECT
		`id`,
		`name`,
		`description`
	FROM `role`
    WHERE roleId IS NULL OR `id` = roleId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_role_allowed_task` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_role_allowed_task`(
	IN myId INT
)
BEGIN
	SELECT
		`id_task`,
		(SELECT `name` FROM `task` WHERE `id` = `id_task`) AS `task_name`
	FROM `role_allowed_task`
    WHERE `id_role` = myId
	AND `enabled` > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_session` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_session`(
	IN userId VARCHAR(45)
)
BEGIN
	SET @inQueue = (SELECT `inqueue` FROM `department` WHERE `department`.`id` = (SELECT `id_department` FROM `user` WHERE `user`.`id` = userId));
	SET @listAll = (SELECT `enabled` FROM `role_allowed_task` WHERE `id_role` = (SELECT `id_role` FROM `user` WHERE `id` = userId) AND `id_task` = 5);
    
	SELECT 
		s1.`id_user`, 
        s1.`id_status`, 
        s2.`name` AS `status_name`, 
        s3.`name` AS `user_name`, 
        s2.`priority`,
        s1.`ordinal`, 
        s1.`absolute`,
        s1.`date_last_activity`, 
        s1.`date_last_status_change`, 
        s1.`queued`
	FROM (
		SELECT * FROM `session` WHERE (
		CASE
			WHEN @listAll > 0 THEN `id_user` IS NOT NULL
			WHEN @inQueue > 0 THEN `id_user` IN (SELECT `id` FROM `user` WHERE `id_department` IN (SELECT `id` FROM `department` WHERE `inqueue` > 0))
			WHEN @inQueue = 0 THEN `id_user` IN (SELECT `id` FROM `user` WHERE `id_department` = (SELECT `id_department` FROM `user` WHERE `id` = userId))
		END
	)) AS s1
	LEFT JOIN(SELECT `id`, `name`, `priority` FROM `status`) AS s2
	ON s1.`id_status` = s2.`id`
    LEFT JOIN(SELECT `id`, `name` FROM `user`) AS s3
    ON s1.`id_user` = s3.`id`
	ORDER BY s2.`priority`, s1.`ordinal`, s1.`absolute` ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_session_next_absolute` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_session_next_absolute`(
	OUT maxAbsolute INT
)
BEGIN
	SET maxAbsolute = (SELECT IFNULL((SELECT MAX(`absolute`) FROM `session` WHERE `queued` > 0), 0 )) + 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_session_next_ordinal` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_session_next_ordinal`(
	IN statusId INT,
    OUT maxOrdinal INT
)
BEGIN
	SET maxOrdinal = (SELECT IFNULL((SELECT MAX(s1.`ordinal`) FROM (
		SELECT `id_status`, `ordinal` FROM `session` WHERE `queued` > 0) AS s1
		LEFT JOIN(SELECT `id`, `priority` FROM `status`) AS s2
		ON s1.`id_status` = s2.`id`
		WHERE s2.`priority` = (SELECT `priority` FROM `status` WHERE `status`.`id` = statusId)
	), 0)) + 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_status` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_status`(
	IN myId INT
)
BEGIN
	DECLARE statusId INT;
    
    IF (NOT ISNULL(myId) AND myId > 0) THEN
		SET statusId = myId;
    END IF;

	SELECT
		`id`,
		`name`,
        `priority`,
		`enabled`
	FROM `status`
    WHERE statusId IS NULL OR `id` = statusId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_task` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_task`(
	IN myId INT
)
BEGIN
	DECLARE taskId INT;

    IF (NOT ISNULL(myId) AND myId > 0) THEN
		SET taskId = myId;
    END IF;

	SELECT
		`id`,
		`name`,
		`description`
	FROM `task`
    WHERE taskId IS NULL OR `id` = taskId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_user` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_user`(
	IN myId VARCHAR(45)
)
BEGIN
	DECLARE userId VARCHAR(45);

    IF (NOT ISNULL(myId)) THEN
		SET userId = myId;
    END IF;

	SELECT
		`id`,
		`id_role`,
        (SELECT `name` FROM `role` WHERE `role`.`id` = `id_role`) AS `role_name`,
		`id_department`,
        (SELECT `name` FROM `department` WHERE `department`.`id` = `id_department`) AS `department_name`,
		`name`,
		`email`,
		`password_is_default`,
		`password_last_update`,
		`enabled`
	FROM `user`
    WHERE userId IS NULL OR `id` = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_user_by_email` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_user_by_email`(
	IN emailAddress VARCHAR(45)
)
BEGIN
	SELECT
		`id`,
		`id_role`,
        (SELECT `name` FROM `role` WHERE `role`.`id` = `id_role`) AS `role_name`,
		`id_department`,
        (SELECT `name` FROM `department` WHERE `department`.`id` = `id_department`) AS `department_name`,
		`name`,
		`email`,
		`password_is_default`,
		`password_last_update`,
		`enabled`
	FROM `user`
    WHERE `email` = emailAddress;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_user_password_hash` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_user_password_hash`(
	IN userId VARCHAR(45)
)
BEGIN
	SELECT `password` FROM `user` WHERE `id` = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_activity` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_activity`(
	IN userId VARCHAR(45),
	IN statusId INT
)
BEGIN
	UPDATE `activity` 
    SET `date_end` = NOW() 
    WHERE `id_user` = userId 
	AND `date_end` IS NULL;
    
	IF (statusId <> 0 AND statusId <> 9) THEN
		INSERT INTO `activity`(`id_user`, `id_status`) VALUES(userId, statusId);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_config` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_config`(
	IN configId VARCHAR(45),
    IN configVal VARCHAR(255)
)
BEGIN
	UPDATE `config` SET `value` = configVal WHERE `id` = configId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_custom_data_type` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_custom_data_type`(
	IN dataTypeId INT,
    IN dataTypeName VARCHAR(45),
    IN dataTypeDescr VARCHAR(255)
)
BEGIN
	UPDATE`custom_data_type`
	SET
		`name` = dataTypeName,
		`description` = dataTypeDescr
	WHERE `id` = dataTypeId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_custom_data_value` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_custom_data_value`(
	IN dataTypeId INT,
    IN dataValueName VARCHAR(45),
    IN dataValueVal VARCHAR(45),
    IN dataValueDescr VARCHAR(255)
)
BEGIN
	UPDATE `custom_data_value`
	SET
		`value` = dataValueVal/*,
		`description` = dataValueDescr*/
	WHERE `id_data_type` = dataTypeId AND `name` = dataValueName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_custom_data_value_clear` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_custom_data_value_clear`(
	IN customDataType INT,
	IN customDataValue VARCHAR(45)
)
BEGIN
	UPDATE `custom_data_value` SET `value` = '' WHERE `id_data_type` = customDataType AND `value` = customDataValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_session`(
	IN userId VARCHAR(45),
    IN statusId INT
)
BEGIN
    CALL `sp_select_session_next_ordinal`(statusId, @nextOrdinal);
	CALL `sp_select_session_next_absolute`(@nextAbsolute);
        
    UPDATE `session`
	SET
		`ordinal` = @nextOrdinal,
		`absolute` = @nextAbsolute,
		`queued` = 1
	WHERE `id_user` = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_clean_reorder` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_session_clean_reorder`()
BEGIN
	CALL `sp_update_session_set_inactive`();
	CALL `sp_delete_session_inactive`();
    UPDATE `session` SET `queued` = 0;
	CALL `sp_update_session_reorder_queue`();
    DELETE FROM `session` WHERE `queued` = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_reorder_queue` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_session_reorder_queue`()
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE userId VARCHAR(45);
    DECLARE statusId INT;

	DECLARE cur CURSOR FOR
        SELECT s1.`id_user`, s1.`id_status`
		FROM (SELECT `id_user`, `id_status`, `ordinal`, `absolute` FROM `session`) AS s1
		LEFT JOIN(SELECT `id`, `priority` FROM `status`) AS s2
		ON s1.`id_status` = s2.`id`
		ORDER BY s2.`priority`, s1.`ordinal`, s1.`absolute` ASC;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
		getUserQueue: LOOP
			FETCH cur INTO userId, statusId;

			IF done THEN
				LEAVE getUserQueue;
			END IF;

            CALL `sp_update_session`(userId, statusId);
		END LOOP getUserQueue;
	CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_set_inactive` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_session_set_inactive`()
BEGIN    
    DECLARE done INT DEFAULT 0;
    DECLARE userId VARCHAR(45);
	DECLARE cur CURSOR FOR

	SELECT `id_user` FROM `session`
	WHERE `id_status` <> 9 AND `date_last_activity` < DATE_SUB(NOW(), INTERVAL (SELECT `value` FROM `config` WHERE `id` = 'session_timeout') MINUTE);

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;    
		getUserId: LOOP
			FETCH cur INTO userId;

			IF done THEN
				LEAVE getUserId;
			END IF;

			CALL `sp_update_session_user_status_change`(userId, 9);
		END LOOP getUserId;
	CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_user_status_change` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_session_user_status_change`(
	IN userId VARCHAR(45),
    IN statusId INT
)
BEGIN
	UPDATE `session` SET `id_status` = statusId WHERE `id_user` = userId;

    IF (statusId = 5 OR statusId = 9 OR statusId = 14) THEN
        CALL `sp_update_custom_data_value_clear`(4, userId);
    END IF;

    SET @currentDate = NOW();
    SET @prevStatus = (SELECT `id_status` FROM `activity` WHERE `id_user` = userId AND `date_end` IS NULL ORDER BY `date_start` DESC LIMIT 0, 1);
    SET @dateStart = (SELECT `date_start` FROM `activity` WHERE `id_user` = userId AND `date_end` IS NULL ORDER BY `date_start` DESC LIMIT 0, 1);
    
    UPDATE `session` SET `date_last_status_change` = @currentDate WHERE `id_user` = userId;
    
    UPDATE `activity` SET `date_end` = @currentDate        
	WHERE `id_user` = userId
    AND `id_status` = @prevStatus
    AND `date_start` = @dateStart;

    IF (statusId <> 9 AND statusId <> 0) THEN
		INSERT INTO `activity`
		(
			`id_user`,
			`id_status`,
			`date_start`
        )
		VALUES
		(
			userId,
			statusId,
			@currentDate
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_user_password` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_user_password`(
	IN userId VARCHAR(45),
    IN userPasswordHash VARCHAR(255),
    IN isDefault TINYINT
)
BEGIN
	UPDATE `user`
    SET 
		`password` = userPasswordHash,
        `password_is_default` = isDefault,
        `password_last_update` = NOW()
	WHERE `id` = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_user_session_activity` */;
ALTER DATABASE `tracker_sl` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_user_session_activity`(
	IN userId VARCHAR(45)
)
BEGIN
	UPDATE `session` SET `date_last_activity` = NOW() WHERE `id_user` = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tracker_sl` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-11 16:53:24
