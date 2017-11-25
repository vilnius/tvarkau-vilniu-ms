-- MySQL dump 10.13  Distrib 5.5.58, for debian-linux-gnu (x86_64)
--
-- Host: db    Database: tvarkau_miesta_tst_api
-- ------------------------------------------------------
-- Server version	5.7.20

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

--
-- Table structure for table `PRS_DVS_CFG`
--

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

--
-- Table structure for table `PRS_EXECUTOR`
--

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

--
-- Table structure for table `PRS_MAIL_CFG`
--

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

--
-- Table structure for table `PRS_MAIL_TEMPLATES`
--

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

--
-- Table structure for table `PRS_MAIN_CFG`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PRS_PROBLEM_TYPES`
--

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

--
-- Table structure for table `PRS_REG_AVILYS`
--

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

--
-- Table structure for table `PRS_REG_AVILYS_TX_LOGS`
--

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

--
-- Table structure for table `PRS_REG_FILES`
--

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

--
-- Table structure for table `PRS_REG_FILES_ANSWER`
--

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

--
-- Table structure for table `PRS_REG_PROBLEMS`
--

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

--
-- Table structure for table `PRS_STATUS_LOGS`
--

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

--
-- Table structure for table `PRS_STATUS_TYPES`
--

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

--
-- Table structure for table `PRS_USERS`
--

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

--
-- Table structure for table `api_auth_tokens`
--

DROP TABLE IF EXISTS `api_auth_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_auth_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `last_used` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_api_auth_tokens_on_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(191) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-24 20:35:27
INSERT INTO schema_migrations (version) VALUES ('20170224201725');

INSERT INTO schema_migrations (version) VALUES ('20170225093150');

INSERT INTO schema_migrations (version) VALUES ('20170225094828');

INSERT INTO schema_migrations (version) VALUES ('20170305081145');

INSERT INTO schema_migrations (version) VALUES ('20170306205609');

INSERT INTO schema_migrations (version) VALUES ('20170306205918');

INSERT INTO schema_migrations (version) VALUES ('20170319101708');

INSERT INTO schema_migrations (version) VALUES ('20170323134021');

INSERT INTO schema_migrations (version) VALUES ('20170323185850');

INSERT INTO schema_migrations (version) VALUES ('20170402082635');

INSERT INTO schema_migrations (version) VALUES ('20170709164545');

