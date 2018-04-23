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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jon`@`localhost`*/ /*!50003 TRIGGER `activity_BEFORE_INSERT` BEFORE INSERT ON `activity` FOR EACH ROW BEGIN
	SET NEW.`date_start` = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jon`@`localhost`*/ /*!50003 TRIGGER `session_BEFORE_INSERT` BEFORE INSERT ON `session` FOR EACH ROW BEGIN
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Dumping routines for database 'Tracker'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_delete_department`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_role` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_delete_role`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_session` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_delete_session`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_session_inactive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_delete_session_inactive`()
BEGIN
	DELETE FROM `session` WHERE `id_status` = 9 AND `date_last_activity` < DATE_SUB(NOW(), INTERVAL (SELECT `value` FROM `config` WHERE `id` = 'session_timeout_delete') MINUTE);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_delete_status`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_custom_data_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_custom_data_type`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_custom_data_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_custom_data_value`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_department`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_department_allowed_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_department_allowed_status`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_role` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_role`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_role_allowed_task` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_role_allowed_task`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_session` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_session`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_status`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_insert_user`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_activity_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_activity_daily`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_activity_detailed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_activity_detailed`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_activity_range` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_activity_range`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_config`()
BEGIN
	SELECT * FROM `config`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_custom_data_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_custom_data_value`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_department`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_department_allowed_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_department_allowed_status`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_role` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_role`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_role_allowed_task` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_role_allowed_task`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_session` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_session`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_session_next_absolute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_session_next_absolute`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_session_next_ordinal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_session_next_ordinal`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_status`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_task` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_task`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_user`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_user_by_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_user_by_email`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_user_password_hash` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_select_user_password_hash`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_activity`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_config`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_custom_data_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_custom_data_type`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_custom_data_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_custom_data_value`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_custom_data_value_clear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_custom_data_value_clear`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_session`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_clean_reorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_session_clean_reorder`()
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_reorder_queue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_session_reorder_queue`()
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_set_inactive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_session_set_inactive`()
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_session_user_status_change` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_session_user_status_change`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_user_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_user_password`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_user_session_activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jon`@`localhost` PROCEDURE `sp_update_user_session_activity`(
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-23 15:23:00
