-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: Tracker
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.26-MariaDB-0+deb9u1

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
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES ('company_logo','text','Company Logo','','Image file for the company logo. Should be located in \"public/assets/img\" directory.'),('company_name','text','Company Name','','Name of the company to be used throughout the application.'),('session_timeout','number','Session Timeout','5','Time (in minutes) after a session becomes inactive after an inactivity period.'),('session_timeout_delete','number','Session Timeout Delete','10','Time (in minutes) after inactive sessions are automatically deleted.'),('site_url','text','Site URL','','Full URL of the site as seen in a browser.'),('smtp_password','password','SMTP Password','','SMTP password (if server requires authentication).'),('smtp_port','number','SMTP Port','','SMTP server port as especified by your email provider.'),('smtp_server','text','SMTP Server','','SMTP server URL to be used for outcoming emails.'),('smtp_user','text','SMTP user','','SMTP user (if server requires authentication).');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `custom_data_type`
--

LOCK TABLES `custom_data_type` WRITE;
/*!40000 ALTER TABLE `custom_data_type` DISABLE KEYS */;
INSERT INTO `custom_data_type` VALUES (1,'Extensions','Local extension numbers.'),(2,'Miami Extensions','Miami extension numbers.'),(3,'External Numbers','External phone numbers.'),(4,'GTA','GTA session handling.');
/*!40000 ALTER TABLE `custom_data_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `custom_data_value`
--

LOCK TABLES `custom_data_value` WRITE;
/*!40000 ALTER TABLE `custom_data_value` DISABLE KEYS */;
INSERT INTO `custom_data_value` VALUES (1,'Basilio Guzmán','530',''),(1,'Daniel Mejía','512',''),(1,'Darnyl Vargas','521',''),(1,'Dorally Jiménez','515',''),(1,'Dulce María Rusch','527',''),(1,'Eduvigis Paulino','516',''),(1,'Edwin Lugo','503',''),(1,'Erickson Checo','531',''),(1,'Gabriela Rodríguez','529',''),(1,'Jennifer Candelario','501',''),(1,'Joan Guzmán','525',''),(1,'Jonathan Estrella','507',''),(1,'Juan Alberto Rodríguez','505',''),(1,'Karina Lagos','506',''),(1,'Manuela Peralta','523',''),(1,'María Hernández','526',''),(1,'Nathanael Aybar','508',''),(1,'Pedro Santos','518',''),(1,'Roberto Cabrera','511',''),(1,'Ruby Morel','519',''),(1,'Scarlette Perdomo','522',''),(1,'Vielka Medina','504',''),(2,'Alysson Guerra','222',''),(2,'Beatriz','212',''),(2,'Christine Speedy','','954-815-6040'),(2,'Christopher Justice','','678-938-1136'),(2,'Danny Domínguez','217','305-608-6550'),(2,'Dave Roberts','','360-513-9238'),(2,'Ervin Salar','206','786-253-2253'),(2,'Everyone (Level II)','607','773-236-7974'),(2,'Gary Smith','','869-766-2273'),(2,'Gene Lage','','678-777-8665'),(2,'German González','210','954-778-1865'),(2,'German González Jr.','224','954-940-2330'),(2,'Hector Miranda','204','305-733-4418'),(2,'Javier Torres','272','786-370-3885'),(2,'Jenisel Rodriguez','213',''),(2,'Joey Orozco','232','786.390.0305'),(2,'Jorge Fernández','252','786-255-9400'),(2,'José Hernández','214','305-310-0003'),(2,'Karl Díaz','','305-788-7989'),(2,'Kelia Rodríguez','215',''),(2,'Mercy Fernández','208',''),(2,'Pamela Farrel','','615-310-9771'),(2,'Paola Báez','219',''),(2,'Polo Pomares','','305-609-5445'),(2,'Receptionist','201',''),(2,'Robin Simmons','203','786-999-3249'),(2,'Sebastian Pacheco','225','786-570-0583'),(2,'Stephen Pineda','233','305-431-3242'),(2,'Steve Brown','','813-493-8488'),(2,'Tom Alas','234',''),(2,'Zoila Sotelo','221',''),(3,'Answering Service','1-305-270-4000',''),(3,'AutoNation Help Desk','1-877-744-2237',''),(3,'CDK Implementation Support','1-866-668-5394',''),(3,'Chase Paymentech (Trx Verification)','1-800-254-9556','Transaction Verification'),(3,'Chase Paymentech (Voice Auth - AMEX)','1-800-555-5707 ','Voice Authorization for AMEX cards.'),(3,'Chase Paymentech (Voice Auth - Discover)','1-800-347-1111','Voice Authorization for Discover cards.'),(3,'Chase Paymentech (Voice Auth - Visa/MC)','1-800-555-5707 ','Voice Authorization for Visa and MC.'),(3,'Customer Care (FD Canada)','1-888-263-1938',''),(3,'Digital Currency Support','1-847-498-9955','Ext. 2'),(3,'EPX (Voice Auth)','1-866-660-7065','Voice Authorization for all cards.'),(3,'EPX Customer Service','1-866-581-5239',''),(3,'FAPS chargeback','1-800-701-2831','Ext. 2672'),(3,'FDC Software Vendor Support','1-866-832-5279',''),(3,'First Data (Trx Verification)','1-866-597-5721','Transaction Verification'),(3,'First Data (Voice Auth)','1-800-228-1122','Voice Authorization for all cards.'),(3,'First Data - Chargebacks (Nashville)','1-888-292-2608','Chargeback information (FD NASHVILLE 434 merchants)'),(3,'First Data - Chargebacks (Omaha)','?1-800-672-5008','Chargeback information (FD OMAHA 518564, 530960490 merchants)'),(3,'North ISO Clover Support','1-844-864-5450',''),(3,'Penske Help Desk','1-877-824-6381',''),(3,'TSYS (Voice Auth)','1-800-228-5882','Voice Authorization for all cards.'),(3,'TSYS Help Desk','1-800-552-8227',''),(3,'TSYS Help Desk (Alt)','1-480-333-7600',''),(3,'TTech','1-877-838-4031',''),(3,'UTA','1-954-431-5256',''),(3,'Vantiv (Trx Verification)','1-877-744-5300','Transaction Verification'),(3,'Vantiv (Voice Auth - AMEX)','1-800-528-2121','Voice Authorization for AMEX.'),(3,'Vantiv (Voice Auth)','1-800-991-9911','Voice Authorization for Visa, MC and Discover.'),(3,'Vantiv - Chargebacks','1-800-667-9573','Chargeback Information'),(3,'Vantiv Help Desk','1-866-622-2390',''),(4,'CS1','','GTA session 1'),(4,'CS2','','GTA session 2'),(4,'CS3','','GTA session 3'),(4,'CS4','','GTA session 4'),(4,'CS5','','GTA session 5'),(4,'CS6','','GTA session 6'),(4,'CS7','','GTA session 7'),(4,'CS8','','GTA session 8');
/*!40000 ALTER TABLE `custom_data_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,1,'Tech Support','',1),(2,3,'QA','',0),(3,12,'Telemarketing','',0),(4,7,'Management','',0),(5,11,'Operations','',0),(6,1,'Training & Implementation','',1),(7,12,'Sales','',0),(9,19,'Certifications','',0),(11,20,'Batches','',1),(12,21,'Customer Relations','',1),(14,22,'Accounting','',0),(15,10,'Payvana','',0),(16,10,'Digital Currencies','',0),(17,24,'Integrations','',0),(18,25,'Human Resources','',0);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `department_allowed_status`
--

LOCK TABLES `department_allowed_status` WRITE;
/*!40000 ALTER TABLE `department_allowed_status` DISABLE KEYS */;
INSERT INTO `department_allowed_status` VALUES (1,1,1),(1,2,1),(1,4,1),(1,5,1),(1,7,1),(1,8,1),(1,10,1),(1,14,1),(1,15,1),(2,2,1),(2,3,1),(2,5,1),(2,7,1),(2,8,1),(2,10,1),(2,14,1),(3,5,1),(3,8,1),(3,12,1),(3,14,1),(4,1,1),(4,2,1),(4,4,1),(4,5,1),(4,7,1),(4,8,1),(4,10,1),(4,14,1),(5,5,1),(5,8,1),(5,11,1),(5,14,1),(5,16,1),(5,17,1),(5,18,1),(6,1,1),(6,2,1),(6,4,1),(6,5,1),(6,8,1),(6,10,1),(6,14,1),(6,15,1),(6,23,1),(7,5,1),(7,12,1),(7,14,1),(9,1,1),(9,2,1),(9,3,1),(9,4,1),(9,5,1),(9,7,1),(9,8,1),(9,10,1),(9,14,1),(9,15,1),(9,19,1),(11,1,1),(11,2,1),(11,4,1),(11,5,1),(11,7,1),(11,8,1),(11,10,1),(11,14,1),(11,15,1),(11,20,1),(12,1,1),(12,2,1),(12,4,1),(12,5,1),(12,7,1),(12,8,1),(12,10,1),(12,14,1),(12,21,1),(14,5,1),(14,8,1),(14,10,1),(14,14,1),(14,22,1),(15,2,1),(15,5,1),(15,8,1),(15,10,1),(15,14,1),(16,2,1),(16,5,1),(16,8,1),(16,10,1),(16,14,1),(17,2,1),(17,3,1),(17,5,1),(17,7,1),(17,8,1),(17,10,1),(17,14,1),(17,24,1),(18,5,1),(18,8,1),(18,10,1),(18,14,1),(18,25,1);
/*!40000 ALTER TABLE `department_allowed_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Administrator',NULL),(4,'Tech Support - Power User',NULL),(5,'Standard User',NULL),(6,'Tech Support',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role_allowed_task`
--

LOCK TABLES `role_allowed_task` WRITE;
/*!40000 ALTER TABLE `role_allowed_task` DISABLE KEYS */;
INSERT INTO `role_allowed_task` VALUES (1,1,1),(1,2,1),(1,3,1),(1,4,1),(1,5,1),(1,6,1),(1,7,1),(1,8,1),(1,9,1),(1,10,1),(4,2,1),(4,3,1),(4,4,1),(4,10,1),(5,2,1),(6,2,1),(6,3,1),(6,10,1);
/*!40000 ALTER TABLE `role_allowed_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Available',1,1),(2,'On Training',3,1),(3,'Testing/QA',3,1),(4,'On Call',2,1),(5,'On Lunch',5,1),(7,'Administrative Tasks',4,1),(8,'On Meeting',3,1),(9,'Inactive',6,0),(10,'Other',3,1),(11,'Operations Tasks',4,1),(12,'Sales Tasks',4,1),(14,'On Break',5,1),(15,'Installations',3,1),(16,'Proposals',4,1),(17,'Boarding',4,1),(18,'Workflow',4,1),(19,'Certifications',3,1),(20,'Batches',3,1),(21,'Follow Ups',4,1),(22,'Accounting',4,1),(23,'Implementation',3,1),(24,'Integrations',3,1),(25,'RRHH',4,1);
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Reports','Access all the available reports.'),(2,'Directory','Access the phone directory.'),(3,'GTA','Allow to use the predefined GTA accounts.'),(4,'Change User Status','Allow to change other users status.'),(5,'List All','List all users regardless of the department.'),(6,'Manage Users','Allow to create and edit users.'),(7,'Manage Roles','Allow to create, edit and delete roles.'),(8,'Manage Status','Allow to create, edit and delete status.'),(9,'Configuration','Allow to update global settings.'),(10,'Call Center','Allow access to the call center features.');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-17 12:43:43
