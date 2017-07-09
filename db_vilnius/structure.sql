# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Database: tvarkau_miesta
# Generation Time: 2017-07-12 19:02:54 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table PRS_DVS_CFG
# ------------------------------------------------------------

CREATE TABLE `PRS_DVS_CFG` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CITY_ID` int(2) NOT NULL,
  `LABEL` varchar(50) NOT NULL,
  `DVS_NAME` char(50) DEFAULT NULL,
  `ENDPOINT` char(50) DEFAULT NULL,
  `USER` char(50) DEFAULT NULL,
  `PSW` char(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MUNICIPAL_ID` (`CITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table PRS_EXECUTOR
# ------------------------------------------------------------

CREATE TABLE `PRS_EXECUTOR` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `TYPE_ID` int(11) NOT NULL,
  `CITY_ID` int(10) NOT NULL,
  `DEP_NAME` text NOT NULL,
  `STRUCTURE_OID` varchar(40) NOT NULL,
  `JOURNAL_OID` varchar(40) NOT NULL,
  `FILE_OID` varchar(40) NOT NULL,
  `TEMPLATE_OID` varchar(40) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `TYPE_ID` (`TYPE_ID`),
  KEY `CITY_ID` (`CITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table PRS_MUNICIPALITIES
# ------------------------------------------------------------

CREATE TABLE `PRS_MUNICIPALITIES` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `VMI_CODE` int(2) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `IS_ACTIVE` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `VMI_CODE` (`VMI_CODE`),
  KEY `IS_ACTIVE` (`IS_ACTIVE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table PRS_PROBLEM_TYPES
# ------------------------------------------------------------

CREATE TABLE `PRS_PROBLEM_TYPES` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_TYPE` varchar(255) NOT NULL,
  `CITY_ID` int(2) NOT NULL DEFAULT '1',
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `MUNICIPAL_ID` (`CITY_ID`),
  KEY `IS_USED` (`ACTIVE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table PRS_REG_AVILYS
# ------------------------------------------------------------

CREATE TABLE `PRS_REG_AVILYS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL,
  `AVILYS_OID` varchar(50) NOT NULL,
  `AVILYS_REG_NR` varchar(50) NOT NULL,
  `IS_MOBILE` tinyint(1) NOT NULL DEFAULT '0',
  `REG_DATE` datetime DEFAULT NULL,
  `LAST_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`PROBLEM_ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table PRS_REG_FILES
# ------------------------------------------------------------

CREATE TABLE `PRS_REG_FILES` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL,
  `FILE_TYPE` varchar(255) NOT NULL,
  `FILE_NAME` varchar(255) NOT NULL DEFAULT '',
  `SAVED_AS` varchar(255) NOT NULL DEFAULT '' COMMENT 'laikinas',
  `THUMBNAIL` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `problem_id` (`PROBLEM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table PRS_REG_PROBLEMS
# ------------------------------------------------------------

CREATE TABLE `PRS_REG_PROBLEMS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CITY_ID` tinyint(1) NOT NULL DEFAULT '1',
  `ADDRESS` varchar(255) NOT NULL,
  `ADDRESS_POSTCODE` varchar(10) NOT NULL,
  `ADDRESS_STREET` varchar(500) NOT NULL,
  `ADDRESS_HOUSE_NO` varchar(10) NOT NULL,
  `COORDS_GOOGLE_LAT` float(10,6) DEFAULT NULL,
  `COORDS_GOOGLE_LNG` float(10,6) DEFAULT NULL,
  `COORDS_LKS_X` double NOT NULL,
  `COORDS_LKS_Y` double NOT NULL,
  `PROBLEM_TYPE_ID` int(11) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `REG_DATE` datetime NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `EXECUTOR_ID` int(11) DEFAULT NULL,
  `STATUS_ID` int(11) DEFAULT NULL,
  `COMPLETE_DATE` datetime DEFAULT NULL,
  `ANSWER` longtext,
  `CAR_PLATE_NO` varchar(255) DEFAULT NULL,
  `VIOLATION_DATETIME` varchar(100) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `problem_type` (`PROBLEM_TYPE_ID`),
  KEY `user_id` (`USER_ID`),
  KEY `CITY_ID` (`CITY_ID`),
  KEY `STATUS_ID` (`STATUS_ID`),
  KEY `EXECUTOR_ID` (`EXECUTOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table PRS_STATUS_LOGS
# ------------------------------------------------------------

CREATE TABLE `PRS_STATUS_LOGS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL,
  `NEW_STATUS_ID` int(2) NOT NULL,
  `DATE` datetime NOT NULL,
  `EMAIL_RECEIVER` varchar(150) NOT NULL,
  `EMAIL_SUBJECT` text NOT NULL,
  `EMAIL_BODY` mediumtext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Status changes, sent emails';



# Dump of table PRS_STATUS_TYPES
# ------------------------------------------------------------

CREATE TABLE `PRS_STATUS_TYPES` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STATUS` varchar(255) NOT NULL,
  `COLOR` varchar(7) NOT NULL,
  `AVILYS_SATUS` varchar(255) NOT NULL,
  `ACTIVE` int(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table PRS_USERS
# ------------------------------------------------------------

CREATE TABLE `PRS_USERS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SESSION_ID` varchar(255) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `PHONE` varchar(255) NOT NULL,
  `BIRTHDATE` varchar(255) NOT NULL,
  `PERSONAL_CODE` varchar(255) NOT NULL,
  `PHONE_IMEI` varchar(255) NOT NULL,
  `VALID` tinyint(1) NOT NULL DEFAULT '1',
  KEY `user_id` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
