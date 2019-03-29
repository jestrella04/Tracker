-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: tracker_sl
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.10.2

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
-- Dumping routines for database 'tracker_sl'
--
/*!50003 DROP FUNCTION IF EXISTS `fx_is_user_online` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jestrella`@`localhost` FUNCTION `fx_is_user_online`(
	userId VARCHAR(45)
) RETURNS int(11)
BEGIN
	RETURN (SELECT COUNT(`id_user`) AS `is_online` FROM `session` WHERE `id_user` = userId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_session`(
	IN userId VARCHAR(45)
)
BEGIN
	DECLARE statusId INT;
	DECLARE userDefaultStatusId INT;
    DECLARE userCurrentStatus INT;
    
    SET statusId = (SELECT `id_status` FROM `user` WHERE `id` = userId);
    
    IF statusId > 0 THEN
		SET userDefaultStatusId = statusId;
	ELSE
		SET userDefaultStatusId = (SELECT `id_status` FROM `department` WHERE `id` = (SELECT `id_department` FROM `user` WHERE `id` = userId));
	END IF;
    
    IF EXISTS(SELECT `id_user` FROM `session` WHERE `id_user` = userId) THEN
		SET userCurrentStatus = (SELECT `id_status` FROM `session` WHERE `id_user` = userId);

        IF userCurrentStatus = 9 THEN
            CALL `sp_update_session`(userId, userDefaultStatusId);
            CALL `sp_update_session_user_status_change`(userId, userDefaultStatusId);
		END IF;
    ELSE
		INSERT INTO `session`
		(
			`id_user`,
			`id_status`,
            `queued`
        )
		VALUES
		(
			userId,
			userDefaultStatusId,
            1
        );
        
        CALL `sp_update_activity`(userId, userDefaultStatusId);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_insert_user`(
	IN userId VARCHAR(45),
    IN roleId INT,
    IN departmentId INT,
    IN officeId INT,
    IN statusId INT,
    IN userName VARCHAR(45),
    IN userEmail VARCHAR(45),
    IN userPassword VARCHAR(255),
    OUT insertedId VARCHAR(45)
)
BEGIN
	DECLARE realStatusId INT;

    IF (statusId > 0) THEN
		SET realStatusId = statusId;
    END IF;
    
	INSERT INTO `user`
	(
		`id`,
		`id_role`,
		`id_department`,
        `id_office`,
        `id_status`,
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
        officeId,
        realStatusId,
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_activity_daily`(
	IN `dateStart` DATE,
    IN `dateEnd` DATE,
    IN `myId` VARCHAR(45),
    IN `myOfficeId` INT,
    IN `utcOffset` CHAR(6)
)
BEGIN
	DECLARE userId VARCHAR(45);
    DECLARE officeId INT;

    IF (NOT ISNULL(myId)) THEN
		SET userId = myId;
    END IF;
    
    IF (NOT ISNULL(myOfficeId)) THEN
		SET officeId = myOfficeId;
	END IF;

	SELECT
		t.`id_user` AS `user`,
        t.`date_` AS `date`,
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
			ANY_VALUE(DATE_FORMAT(convert_tz(`date_start`, '+00:00', utcOffset), '%m-%d-%Y')) AS `date_`,
			ANY_VALUE(DATE_FORMAT(MIN(convert_tz(`date_start`, '+00:00', utcOffset)), '%h:%i %p')) AS `start_`,
			ANY_VALUE(DATE_FORMAT(MAX(convert_tz(`date_end`, '+00:00', utcOffset)), '%h:%i %p')) AS `end_`,
			ANY_VALUE(TIMEDIFF(MAX(`date_end`), MIN(`date_start`))) AS `total_`,
			ANY_VALUE(SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`)))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND (officeId IS NULL OR `id_office` = officeId)
		AND `date_start` > convert_tz(dateStart, utcOffset, '+00:00')
		AND `date_end` < convert_tz(dateEnd, utcOffset, '+00:00')
		AND `date_end` IS NOT NULL
		GROUP BY `id_user`, DATE(convert_tz(`date_start`, '+00:00', utcOffset))
	)
	AS t

	LEFT JOIN
	(
		SELECT
			`id_user`,
			ANY_VALUE(DATE_FORMAT(convert_tz(`date_start`, '+00:00', utcOffset), '%m-%d-%Y')) AS `date_`,
			ANY_VALUE(DATE_FORMAT(MIN(convert_tz(`date_start`, '+00:00', utcOffset)), '%h:%i %p')) AS `start_`,
			ANY_VALUE(DATE_FORMAT(MAX(convert_tz(`date_end`, '+00:00', utcOffset)), '%h:%i %p')) AS `end_`,
			ANY_VALUE(TIMEDIFF(MAX(`date_end`), MIN(`date_start`))) AS `total_`,
			ANY_VALUE(SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`)))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND (officeId IS NULL OR `id_office` = officeId)
		AND `date_start` > convert_tz(dateStart, utcOffset, '+00:00')
		AND `date_end` < convert_tz(dateEnd, utcOffset, '+00:00')
		AND `id_status` = 5
        AND `date_end` IS NOT NULL
		GROUP BY `id_user`, DATE(convert_tz(`date_start`, '+00:00', utcOffset))
	)
	AS l
	ON t.`id_user` = l.`id_user` AND t.`date_` = l.`date_`

	LEFT JOIN
	(
		SELECT
			`id_user`,
            ANY_VALUE(DATE_FORMAT(convert_tz(`date_start`, '+00:00', utcOffset), '%m-%d-%Y')) AS `date_`,
			ANY_VALUE(SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`)))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND (officeId IS NULL OR `id_office` = officeId)
		AND `date_start` > convert_tz(dateStart, utcOffset, '+00:00')
		AND `date_end` < convert_tz(dateEnd, utcOffset, '+00:00')
		AND `id_status` = 14
        AND `date_end` IS NOT NULL
		GROUP BY `id_user`, DATE(convert_tz(`date_start`, '+00:00', utcOffset))
	)
	AS b
	ON l.`id_user` = b.`id_user` AND l.`date_` = b.`date_`
    ORDER BY ANY_VALUE(`date`), `user`;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_activity_detailed`(
	IN `dateStart` DATE,
    IN `dateEnd` DATE,
    IN `myId` VARCHAR(45),
    IN `myOfficeId` INT,
    IN `utcOffset` CHAR(6)
)
BEGIN
	DECLARE userId VARCHAR(45);
    DECLARE officeId INT;
    
    IF (NOT ISNULL(myId)) THEN
		SET userId = myId;
    END IF;
    
    IF (NOT ISNULL(myOfficeId)) THEN
		SET officeId = myOfficeId;
	END IF;
    
	SELECT
		`id_user`,
		(SELECT `name` FROM `status` WHERE `status`.`id` = `id_status`) AS `status_name`,
		DATE_FORMAT(convert_tz(`date_start`, '+00:00', utcOffset), '%m-%d-%Y') AS `date_`,
		DATE_FORMAT(convert_tz(`date_start`, '+00:00', utcOffset), '%h:%i %p') AS `start_`,
		DATE_FORMAT(convert_tz(`date_end`, '+00:00', utcOffset), '%h:%i %p') AS `end_`,
		TIMEDIFF(`date_end`, `date_start`) AS `total_`
	FROM `activity`
	WHERE (userId IS NULL OR `id_user` = userId)
	AND (officeId IS NULL OR `id_office` = officeId)
	AND `date_start` > convert_tz(dateStart, utcOffset, '+00:00')
	AND `date_end` < convert_tz(dateEnd, utcOffset, '+00:00')
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_activity_range`(
	IN `dateStart` DATE,
	IN `dateEnd` DATE,
	IN `myId` VARCHAR(45),
    IN `myOfficeId` INT,
    IN `utcOffset` CHAR(6)
)
BEGIN
	DECLARE userId VARCHAR(45);
    DECLARE officeId INT;
    
    IF (NOT ISNULL(myId)) THEN
		SET userId = myId;
    END IF;
    
    IF (NOT ISNULL(myOfficeId)) THEN
		SET officeId = myOfficeId;
	END IF;

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
			SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND (officeId IS NULL OR `id_office` = officeId)
        AND `date_start` > convert_tz(dateStart, utcOffset, '+00:00')
		AND `date_end` < convert_tz(dateEnd, utcOffset, '+00:00')
        AND `date_end` IS NOT NULL
		GROUP BY `id_user`
		ORDER BY `id_user`
	)
	AS t

	LEFT JOIN
	(
		SELECT
			`id_user`,
			TIMEDIFF(MAX(`date_end`), MIN(`date_start`)) AS `total_`,
			SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, `date_start`, `date_end`))) AS `neto_`
		FROM `activity`
		WHERE (userId IS NULL OR `id_user` = userId)
        AND (officeId IS NULL OR `id_office` = officeId)
        AND `date_start` > convert_tz(dateStart, utcOffset, '+00:00')
		AND `date_end` < convert_tz(dateEnd, utcOffset, '+00:00')
        AND `id_status` = 5
        AND `date_end` IS NOT NULL
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
        AND (officeId IS NULL OR `id_office` = officeId)
        AND `date_start` > convert_tz(dateStart, utcOffset, '+00:00')
		AND `date_end` < convert_tz(dateEnd, utcOffset, '+00:00')
        AND `id_status` = 14
        AND `date_end` IS NOT NULL
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_office` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_select_office`(
	IN myId INT
)
BEGIN
	DECLARE officeId INT;

    IF (NOT ISNULL(myId) AND myId > 0) THEN
		SET officeId = myId;
    END IF;

	SELECT
		`id`,
		`name`,
		`description`,
        `address`,
        `phone`
	FROM `office`
    WHERE officeId IS NULL OR `id` = officeId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
	ORDER BY s2.`priority` ASC, s1.`date_last_status_change` ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
        `id_office`,
        (SELECT `name` FROM `office` WHERE `office`.`id` = `id_office`) AS `office_name`,
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_settings_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jestrella`@`localhost` PROCEDURE `sp_settings_update`(
	IN settingName VARCHAR(40),
    IN settingValue VARCHAR(255)
)
BEGIN
	UPDATE `settings` SET `value` = settingsValue WHERE `name` = settingName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_session`(
	IN userId VARCHAR(45),
    IN statusId INT
)
BEGIN
	#statusId is not used at the moment        
    UPDATE `session`
	SET
		`queued` = 1
	WHERE `id_user` = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_session_reorder_queue`()
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE userId VARCHAR(45);
    DECLARE statusId INT;

	DECLARE cur CURSOR FOR
        SELECT s1.`id_user`, s1.`id_status`
		FROM (SELECT `id_user`, `id_status`, `date_last_status_change` FROM `session`) AS s1
		LEFT JOIN(SELECT `id`, `priority` FROM `status`) AS s2
		ON s1.`id_status` = s2.`id`
		ORDER BY s2.`priority`ASC, s1.`date_last_status_change` ASC;

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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tracker_sl`@`localhost` PROCEDURE `sp_update_user_session_activity`(
	IN userId VARCHAR(45)
)
BEGIN
	UPDATE `session` SET `date_last_activity` = NOW() WHERE `id_user` = userId;
    SELECT `date_last_activity` FROM `session` WHERE `id_user` = userId;
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

-- Dump completed on 2019-03-28 17:47:49
