
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `PRS_DVS_CFG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_DVS_CFG` (
  `ID` int(3) NOT NULL AUTO_INCREMENT,
  `CITY_ID` int(3) NOT NULL,
  `LABEL` varchar(50) NOT NULL,
  `DVS_NAME` char(50) DEFAULT NULL,
  `ENDPOINT` char(50) DEFAULT NULL,
  `USER` char(50) DEFAULT NULL,
  `PSW` char(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MUNICIPAL_ID` (`CITY_ID`),
  CONSTRAINT `fk_PRS_DVS_CFG_PRS_MAIN_CFG1` FOREIGN KEY (`CITY_ID`) REFERENCES `PRS_MAIN_CFG` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_EXECUTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_EXECUTOR` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `TYPE_ID` int(4) NOT NULL COMMENT 'Problemos tipas',
  `CITY_ID` int(3) NOT NULL COMMENT 'Miestas',
  `DEP_NAME` text NOT NULL COMMENT 'Strukturinis padalinys',
  `STRUCTURE_OID` varchar(40) NOT NULL COMMENT 'Strukturinio padalinio OrgName',
  `JOURNAL_OID` varchar(40) NOT NULL COMMENT 'Registro OID',
  `FILE_OID` varchar(40) NOT NULL COMMENT 'Bylos OID',
  `TEMPLATE_OID` varchar(40) NOT NULL COMMENT 'Sablono OID',
  PRIMARY KEY (`ID`),
  KEY `TYPE_ID` (`TYPE_ID`),
  KEY `CITY_ID` (`CITY_ID`),
  CONSTRAINT `fk_PRS_EXECUTOR_PRS_MAIN_CFG1` FOREIGN KEY (`CITY_ID`) REFERENCES `PRS_MAIN_CFG` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRS_EXECUTOR_PRS_PROBLEM_TYPES1` FOREIGN KEY (`TYPE_ID`) REFERENCES `PRS_PROBLEM_TYPES` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_MAIL_CFG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_MAIL_CFG` (
  `ID` int(3) NOT NULL AUTO_INCREMENT,
  `CITY_ID` int(3) NOT NULL COMMENT 'Municipality ID',
  `SERVER` varchar(40) NOT NULL COMMENT 'Pasto adresas',
  `USER` varchar(50) DEFAULT NULL COMMENT 'Vartojo vardas',
  `PASSWORD` varchar(40) NOT NULL COMMENT 'QldtVTNFQjU=',
  `FROM_EMAIL` varchar(40) NOT NULL,
  `FROM_NAME` varchar(255) NOT NULL,
  `SMTP_PORT` int(8) NOT NULL,
  `SMTP_SECURE` varchar(3) NOT NULL,
  `MAIN_EMAIL` tinyint(1) NOT NULL DEFAULT '0',
  `SMTP_AUTH` varchar(10) NOT NULL,
  `VALID` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CITY_ID` (`CITY_ID`),
  KEY `VALID` (`VALID`),
  CONSTRAINT `fk_PRS_MAIL_CFG_PRS_MAIN_CFG1` FOREIGN KEY (`CITY_ID`) REFERENCES `PRS_MAIN_CFG` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_MAIL_TEMPLATES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_MAIL_TEMPLATES` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CITY_ID` int(3) NOT NULL,
  `EMAIL_TEXT` longtext NOT NULL COMMENT 'Elektroninio laiško tekstas, galima naudoti HTML tagus bei kintamuosius, kurie yra aprašyti',
  `EMAIL_SUBJECT` varchar(500) NOT NULL COMMENT 'Laiško tema',
  `USAGE` varchar(100) DEFAULT NULL COMMENT 'Kada naudojamas laiškas',
  PRIMARY KEY (`ID`),
  KEY `LICENCE_TYPE` (`CITY_ID`),
  CONSTRAINT `fk_PRS_MAIL_TEMPLATES_PRS_MAIN_CFG1` FOREIGN KEY (`CITY_ID`) REFERENCES `PRS_MAIN_CFG` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_MAIN_CFG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_MAIN_CFG` (
  `ID` int(3) NOT NULL AUTO_INCREMENT COMMENT 'Miesto ID',
  `CITY_FULL_NAME` varchar(45) NOT NULL COMMENT 'Miesto pilnas pavadinimas',
  `CITY_SYSTEM_NAME` varchar(25) NOT NULL COMMENT 'Miesto sisteminis vardas',
  `CITY_NAME` varchar(50) NOT NULL COMMENT 'Normal regular city name in Lithuanina, with first cap',
  `CITY_LAT` varchar(20) DEFAULT NULL COMMENT 'Miesto koordinatės googlemaps',
  `CITY_LNG` varchar(20) DEFAULT NULL COMMENT 'Miesto koordinatės googlemaps',
  `CITY_LABEL` varchar(45) DEFAULT NULL COMMENT 'Miesto pavadinimas, kuris bus atvaizduotas miesto pasirinkimo meniu',
  `MAP_ITEMS_SHOW` int(3) NOT NULL DEFAULT '30' COMMENT 'Zemelapyje ivedimo apribojimas date(now) - MAP_ITEMS_SHOW',
  `PAGE_SIZE` int(4) NOT NULL COMMENT 'Puslapiavime pranesimu skaicius',
  `IS_ACTIVE` tinyint(1) DEFAULT '0' COMMENT 'Ar aktyvus miestas',
  `LOGO_IMAGE` varchar(100) DEFAULT NULL,
  `SITE_MAIN_COLOR` varchar(10) DEFAULT NULL,
  `SITE_SECOND_COLOR` varchar(10) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL COMMENT 'Kontaktinis tel. nr. pagal miesta',
  `MAIL` varchar(50) DEFAULT NULL COMMENT 'kontaktinis meilas pagal miesta',
  PRIMARY KEY (`ID`),
  KEY `PAGE_SIZE` (`PAGE_SIZE`),
  KEY `IS_ACTIVE` (`IS_ACTIVE`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_PROBLEM_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_PROBLEM_TYPES` (
  `ID` int(4) NOT NULL AUTO_INCREMENT,
  `PROBLEM_TYPE` varchar(255) NOT NULL COMMENT 'Pranesimo tipas',
  `SHORT_LABEL` varchar(255) NOT NULL COMMENT 'Trumpintas problemos tipo pavadinimas',
  `CITY_ID` int(3) NOT NULL COMMENT 'Miesto kodas',
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Ar aktyvuotas pranesimo tipas 1/0 - Taip/Ne',
  `SHOW_REGISTER` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Rodomoas tik reigstruotiems varottojams ',
  `ATTACHMENT` int(1) NOT NULL DEFAULT '0' COMMENT 'nuotrauka butina 1- taip, 0- ne',
  PRIMARY KEY (`ID`),
  KEY `MUNICIPAL_ID` (`CITY_ID`),
  KEY `IS_USED` (`ACTIVE`),
  KEY `SHORT_LABEL` (`SHORT_LABEL`),
  CONSTRAINT `fk_PRS_PROBLEM_TYPES_PRS_MAIN_CFG1` FOREIGN KEY (`CITY_ID`) REFERENCES `PRS_MAIN_CFG` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_REG_AVILYS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_REG_AVILYS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL,
  `AVILYS_OID` varchar(50) DEFAULT NULL,
  `AVILYS_REG_NR` varchar(50) NOT NULL,
  `REG_DATE` datetime DEFAULT NULL,
  `LAST_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PROBLEM_ID_UNIQUE` (`PROBLEM_ID`),
  CONSTRAINT `fk_PRS_REG_AVILYS_PRS_REG_PROBLEMS1` FOREIGN KEY (`PROBLEM_ID`) REFERENCES `PRS_REG_PROBLEMS` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_REG_AVILYS_TX_LOGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_REG_AVILYS_TX_LOGS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TX_DATE` datetime DEFAULT NULL,
  `PROBLEM_ID` int(11) NOT NULL,
  `DATA_ARRAY` text,
  `XML_IN` text,
  `XML_OUT` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Avilio transakcijos';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_REG_FILES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_REG_FILES` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL,
  `FILE_TYPE` varchar(255) NOT NULL,
  `SAVED_AS` varchar(255) NOT NULL DEFAULT '' COMMENT 'laikinas',
  `THUMBNAIL` varchar(255) DEFAULT NULL,
  `BUCKET` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `problem_id` (`PROBLEM_ID`),
  CONSTRAINT `fk_PRS_REG_FILES_PRS_REG_PROBLEMS1` FOREIGN KEY (`PROBLEM_ID`) REFERENCES `PRS_REG_PROBLEMS` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_REG_FILES_ANSWER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_REG_FILES_ANSWER` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL,
  `FILE_TYPE` varchar(10) NOT NULL,
  `FILE_NAME` varchar(255) NOT NULL DEFAULT '',
  `SAVED_AS` varchar(255) NOT NULL DEFAULT '' COMMENT 'laikinas',
  `THUMBNAIL` varchar(255) NOT NULL,
  `BUCKET` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `problem_id` (`PROBLEM_ID`),
  CONSTRAINT `fk_PRS_REG_FILES_ANSWER_PRS_REG_PROBLEMS1` FOREIGN KEY (`PROBLEM_ID`) REFERENCES `PRS_REG_PROBLEMS` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_REG_PROBLEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_REG_PROBLEMS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_TYPE_ID` int(4) NOT NULL,
  `CITY_ID` int(3) NOT NULL COMMENT 'Pranesimas kuriam miestui priklauso',
  `VERSION` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Kaip pranešta: 1- web versija, 2 - naujas app, 3 - senas app',
  `ADDRESS` varchar(255) NOT NULL,
  `ADDRESS_POSTCODE` varchar(10) NOT NULL,
  `ADDRESS_STREET` varchar(500) NOT NULL,
  `ADDRESS_HOUSE_NO` varchar(10) NOT NULL,
  `COORDS_GOOGLE_LAT` float(10,6) DEFAULT NULL,
  `COORDS_GOOGLE_LNG` float(10,6) DEFAULT NULL,
  `COORDS_LKS_X` double DEFAULT NULL,
  `COORDS_LKS_Y` double DEFAULT NULL,
  `DESCRIPTION` text NOT NULL,
  `REG_DATE` datetime NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `STATUS_ID` int(3) NOT NULL,
  `COMPLETE_DATE` datetime DEFAULT NULL,
  `ANSWER` longtext,
  `CAR_PLATE_NO` varchar(255) DEFAULT NULL,
  `VIOLATION_DATETIME` varchar(100) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `NUM_LIKE` int(10) NOT NULL DEFAULT '0',
  `NUM_DISLIKE` int(10) NOT NULL DEFAULT '0',
  `REPORTER_NAME` varchar(255) DEFAULT NULL,
  `REPORTER_EMAIL` varchar(255) DEFAULT NULL,
  `REPORTER_ADDRESS` varchar(255) DEFAULT NULL,
  `REPORTER_PHONE` varchar(20) DEFAULT NULL,
  `REPORTER_CODE` int(11) DEFAULT NULL,
  `REPORTER_BIRTHDATE` varchar(15) DEFAULT NULL,
  `EXECUTOR_ORG_OLD` varchar(255) DEFAULT NULL COMMENT 'pagalbinis laukas pasitikrinimui po importo',
  `EXECUTOR_OLD` varchar(120) DEFAULT NULL COMMENT 'pagalbinis laukas pasitikrinimui po importo',
  `PROBLEM_TYPE_STRING` text COMMENT 'pagalbinis laukas pasitikrinimui iš mob app',
  PRIMARY KEY (`ID`),
  KEY `problem_type` (`PROBLEM_TYPE_ID`),
  KEY `user_id` (`USER_ID`),
  KEY `CITY_ID` (`CITY_ID`),
  KEY `STATUS_ID` (`STATUS_ID`),
  KEY `COORDS_GOOGLE_LAT` (`COORDS_GOOGLE_LAT`),
  KEY `COORDS_GOOGLE_LNG` (`COORDS_GOOGLE_LNG`),
  KEY `REPORTER_CODE` (`REPORTER_CODE`),
  CONSTRAINT `fk_PRS_REG_PROBLEMS_PRS_MAIN_CFG1` FOREIGN KEY (`CITY_ID`) REFERENCES `PRS_MAIN_CFG` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRS_REG_PROBLEMS_PRS_PROBLEM_TYPES1` FOREIGN KEY (`PROBLEM_TYPE_ID`) REFERENCES `PRS_PROBLEM_TYPES` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRS_REG_PROBLEMS_PRS_STATUS_TYPES1` FOREIGN KEY (`STATUS_ID`) REFERENCES `PRS_STATUS_TYPES` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_STATUS_LOGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_STATUS_LOGS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL,
  `NEW_STATUS_ID` int(2) NOT NULL,
  `DATE` datetime NOT NULL,
  `EMAIL_RECEIVER` varchar(150) DEFAULT NULL,
  `EMAIL_SUBJECT` text,
  `EMAIL_BODY` mediumtext,
  PRIMARY KEY (`ID`),
  KEY `PROBLEM_ID` (`PROBLEM_ID`),
  KEY `NEW_STATUS_ID` (`NEW_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Status changes, sent emails';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_STATUS_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_STATUS_TYPES` (
  `ID` int(3) NOT NULL AUTO_INCREMENT,
  `STATUS` varchar(255) NOT NULL,
  `COLOR` varchar(7) NOT NULL,
  `AVILYS_SATUS` varchar(255) NOT NULL,
  `ACTIVE` int(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ACTIVE` (`ACTIVE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PRS_USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRS_USERS` (
  `ID` int(9) NOT NULL AUTO_INCREMENT,
  `FACEBOOK_ID` varchar(255) DEFAULT NULL,
  `GOOGLE_ID` varchar(100) DEFAULT NULL,
  `FULL_NAME` varchar(255) DEFAULT NULL COMMENT 'Fizinio asmens vardas ir pavardė',
  `BLACKLIST` int(1) DEFAULT '0' COMMENT 'Įtrauktas į juodąjį sąrašą - 1, neįtrauktas - 0',
  `ID_VLN_DB` int(10) DEFAULT NULL COMMENT 'ID, kuris yra Vilniaus DB user_logins',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT 'Pask. prisijungimo data',
  `EMAIL` varchar(255) DEFAULT NULL,
  `CITY_ID` int(9) NOT NULL,
  `PERSONAL_CODE` bigint(20) DEFAULT NULL COMMENT 'Fizinio a.k.',
  `PHONE` char(15) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(128) DEFAULT NULL,
  `SALT` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `BLACKLIST` (`BLACKLIST`),
  KEY `CITY_ID` (`CITY_ID`),
  KEY `ID_VLN_DB` (`ID_VLN_DB`),
  KEY `FACEBOOK_ID` (`FACEBOOK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) CHARACTER SET utf8 NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varbinary(25) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_cities_on_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `oauth_access_grants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_grants` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resource_owner_id` int(11) NOT NULL,
  `application_id` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_in` int(11) NOT NULL,
  `redirect_uri` text NOT NULL,
  `created_at` datetime NOT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `scopes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_oauth_access_grants_on_token` (`token`),
  KEY `index_oauth_access_grants_on_application_id` (`application_id`),
  CONSTRAINT `fk_rails_b4b53e07b8` FOREIGN KEY (`application_id`) REFERENCES `oauth_applications` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resource_owner_id` int(11) DEFAULT NULL,
  `application_id` bigint(20) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `expires_in` int(11) DEFAULT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `scopes` varchar(255) DEFAULT NULL,
  `previous_refresh_token` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_oauth_access_tokens_on_token` (`token`),
  UNIQUE KEY `index_oauth_access_tokens_on_refresh_token` (`refresh_token`),
  KEY `index_oauth_access_tokens_on_application_id` (`application_id`),
  KEY `index_oauth_access_tokens_on_resource_owner_id` (`resource_owner_id`),
  CONSTRAINT `fk_rails_732cb83ab7` FOREIGN KEY (`application_id`) REFERENCES `oauth_applications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `oauth_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_applications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `redirect_uri` text NOT NULL,
  `scopes` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_oauth_applications_on_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `report_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_photos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `report_id` int(11) DEFAULT NULL,
  `photo` json DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_report_photos_on_uuid` (`uuid`),
  KEY `index_report_photos_on_report_id` (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `report_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `short_label` varchar(255) DEFAULT NULL,
  `requires_photos` int(11) NOT NULL DEFAULT '0',
  `requires_viisp_auth` tinyint(1) NOT NULL DEFAULT '0',
  `requires_license_plate_no` tinyint(1) NOT NULL DEFAULT '0',
  `requires_registered_at` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_report_types_on_city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ref_no` varchar(100) DEFAULT NULL,
  `report_type_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `description` text,
  `answer` mediumtext,
  `license_plate_no` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address_postcode` varchar(10) DEFAULT NULL,
  `address_street` varchar(255) DEFAULT NULL,
  `address_house_no` varchar(10) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `registered_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_reports_on_ref_no` (`ref_no`),
  KEY `index_reports_on_user_id` (`user_id`),
  KEY `index_reports_on_report_type_id` (`report_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(191) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statuses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `color` varchar(7) NOT NULL,
  `avilys_status` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_statuses_on_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `personal_code` bigint(20) DEFAULT NULL,
  `facebook_id` varchar(100) DEFAULT NULL,
  `google_id` varchar(100) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `guest` tinyint(1) NOT NULL DEFAULT '0',
  `blacklisted` tinyint(1) NOT NULL DEFAULT '0',
  `encrypted_password` varchar(255) NOT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `failed_attempts` int(11) NOT NULL DEFAULT '0',
  `unlock_token` varchar(255) DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_users_on_unlock_token` (`unlock_token`),
  UNIQUE KEY `index_users_on_personal_code` (`personal_code`),
  UNIQUE KEY `index_users_on_facebook_id` (`facebook_id`),
  UNIQUE KEY `index_users_on_google_id` (`google_id`),
  KEY `index_users_on_guest` (`guest`),
  KEY `index_users_on_city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `schema_migrations` (version) VALUES
('20170224201725'),
('20170225093150'),
('20170225094828'),
('20170305081145'),
('20170306205609'),
('20170306205918'),
('20170319101708'),
('20170323134021'),
('20170323185850'),
('20170402082635'),
('20170709164545'),
('20171125112707'),
('20171125122351'),
('20171126101908'),
('20171212214057'),
('20171214192931'),
('20171214193807'),
('20171216124253'),
('20171216141002'),
('20171219193843'),
('20180104191653'),
('20180112204016');


