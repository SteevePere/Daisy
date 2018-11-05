-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: Daisy
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-0+deb9u1

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
-- Temporary table structure for view `current_dept_emp`
--

DROP TABLE IF EXISTS `current_dept_emp`;
/*!50001 DROP VIEW IF EXISTS `current_dept_emp`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `current_dept_emp` (
  `emp_no` tinyint NOT NULL,
  `dept_no` tinyint NOT NULL,
  `from_date` tinyint NOT NULL,
  `to_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `dept_no` char(4) NOT NULL,
  `dept_name` varchar(40) NOT NULL,
  PRIMARY KEY (`dept_no`),
  UNIQUE KEY `dept_name` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('d009','Customer Service'),('d005','Development'),('d002','Finance'),('d003','Human Resources'),('d001','Marketing/Distribution'),('d004','Production'),('d006','Quality Management'),('d008','Research'),('d007','Sales');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_emp`
--

DROP TABLE IF EXISTS `dept_emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_emp` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_emp_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_emp_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_emp`
--

LOCK TABLES `dept_emp` WRITE;
/*!40000 ALTER TABLE `dept_emp` DISABLE KEYS */;
INSERT INTO `dept_emp` VALUES (10002,'d007','1996-08-03','9999-01-01'),(10003,'d004','1995-12-03','9999-01-01'),(10004,'d004','1986-12-01','9999-01-01'),(10005,'d003','1989-09-12','9999-01-01'),(10006,'d005','1990-08-05','9999-01-01'),(10007,'d008','1989-02-10','9999-01-01'),(10008,'d005','1998-03-11','2000-07-31'),(10009,'d006','1985-02-18','9999-01-01'),(10010,'d004','1996-11-24','2000-06-26'),(10010,'d006','2000-06-26','9999-01-01');
/*!40000 ALTER TABLE `dept_emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `dept_emp_latest_date`
--

DROP TABLE IF EXISTS `dept_emp_latest_date`;
/*!50001 DROP VIEW IF EXISTS `dept_emp_latest_date`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `dept_emp_latest_date` (
  `emp_no` tinyint NOT NULL,
  `from_date` tinyint NOT NULL,
  `to_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dept_manager`
--

DROP TABLE IF EXISTS `dept_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_manager`
--

LOCK TABLES `dept_manager` WRITE;
/*!40000 ALTER TABLE `dept_manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `dept_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL DEFAULT '9999-01-01',
  `grid_no` int(11) DEFAULT '1',
  `birth_date` date DEFAULT '9999-01-01',
  PRIMARY KEY (`emp_no`),
  KEY `fk_employees_salaries_grid_idx` (`grid_no`),
  CONSTRAINT `fk_employees_salaries_grid` FOREIGN KEY (`grid_no`) REFERENCES `salaries_grid` (`grid_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (10001,'Barack','Obama','F','0000-00-00',1,'2000-01-01'),(10002,'Bezalel','Simmel','F','1985-11-21',NULL,'1984-05-06'),(10003,'Parto','Bamford','M','1986-08-28',NULL,'1987-03-05'),(10004,'Chirstian','Koblick','M','1986-12-01',NULL,'1964-07-27'),(10005,'Kyoich','Maliniaka','F','1989-09-12',NULL,'1958-01-01'),(10006,'Anneke','Preusig','F','1989-06-02',NULL,'1994-01-15'),(10007,'Tzvetan','Zielinski','M','1989-02-10',NULL,'1956-01-23'),(10008,'Saniya','Kalloufi','F','1994-09-15',NULL,'1985-06-13'),(10009,'Sumant','Peac','M','1985-02-18',NULL,'1975-02-06'),(10010,'Duangkaew','Piveteaux','F','1989-08-24',NULL,'1981-08-20'),(10011,'UnitTest','UnitTest','F','9999-01-01',1,'2000-12-12'),(10012,'d','d','F','9999-01-01',1,'2018-11-14'),(10013,'UnitTest','UnitTest','F','9999-01-01',1,'2000-12-12'),(10014,'UnitTest','UnitTest','F','9999-01-01',1,'2000-12-12'),(10015,'d','d','F','9999-01-01',1,'2018-11-07'),(10016,'f','f','M','9999-01-01',1,'2018-11-05'),(10017,'UnitTest','UnitTest','F','9999-01-01',1,'2000-12-12'),(10018,'UnitTest','UnitTest','F','9999-01-01',1,'2000-12-12');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaries`
--

DROP TABLE IF EXISTS `salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salaries` (
  `emp_no` int(11) NOT NULL,
  `salary` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`from_date`),
  CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries`
--

LOCK TABLES `salaries` WRITE;
/*!40000 ALTER TABLE `salaries` DISABLE KEYS */;
INSERT INTO `salaries` VALUES (10002,65828,'1996-08-03','1997-08-03'),(10002,65909,'1997-08-03','1998-08-03'),(10002,67534,'1998-08-03','1999-08-03'),(10002,69366,'1999-08-03','2000-08-02'),(10002,71963,'2000-08-02','2001-08-02'),(10002,72527,'2001-08-02','9999-01-01'),(10003,40006,'1995-12-03','1996-12-02'),(10003,43616,'1996-12-02','1997-12-02'),(10003,43466,'1997-12-02','1998-12-02'),(10003,43636,'1998-12-02','1999-12-02'),(10003,43478,'1999-12-02','2000-12-01'),(10003,43699,'2000-12-01','2001-12-01'),(10003,43311,'2001-12-01','9999-01-01'),(10004,40054,'1986-12-01','1987-12-01'),(10004,42283,'1987-12-01','1988-11-30'),(10004,42542,'1988-11-30','1989-11-30'),(10004,46065,'1989-11-30','1990-11-30'),(10004,48271,'1990-11-30','1991-11-30'),(10004,50594,'1991-11-30','1992-11-29'),(10004,52119,'1992-11-29','1993-11-29'),(10004,54693,'1993-11-29','1994-11-29'),(10004,58326,'1994-11-29','1995-11-29'),(10004,60770,'1995-11-29','1996-11-28'),(10004,62566,'1996-11-28','1997-11-28'),(10004,64340,'1997-11-28','1998-11-28'),(10004,67096,'1998-11-28','1999-11-28'),(10004,69722,'1999-11-28','2000-11-27'),(10004,70698,'2000-11-27','2001-11-27'),(10004,74057,'2001-11-27','9999-01-01'),(10005,78228,'1989-09-12','1990-09-12'),(10005,82621,'1990-09-12','1991-09-12'),(10005,83735,'1991-09-12','1992-09-11'),(10005,85572,'1992-09-11','1993-09-11'),(10005,85076,'1993-09-11','1994-09-11'),(10005,86050,'1994-09-11','1995-09-11'),(10005,88448,'1995-09-11','1996-09-10'),(10005,88063,'1996-09-10','1997-09-10'),(10005,89724,'1997-09-10','1998-09-10'),(10005,90392,'1998-09-10','1999-09-10'),(10005,90531,'1999-09-10','2000-09-09'),(10005,91453,'2000-09-09','2001-09-09'),(10005,94692,'2001-09-09','9999-01-01'),(10006,40000,'1990-08-05','1991-08-05'),(10006,42085,'1991-08-05','1992-08-04'),(10006,42629,'1992-08-04','1993-08-04'),(10006,45844,'1993-08-04','1994-08-04'),(10006,47518,'1994-08-04','1995-08-04'),(10006,47917,'1995-08-04','1996-08-03'),(10006,52255,'1996-08-03','1997-08-03'),(10006,53747,'1997-08-03','1998-08-03'),(10006,56032,'1998-08-03','1999-08-03'),(10006,58299,'1999-08-03','2000-08-02'),(10006,60098,'2000-08-02','2001-08-02'),(10006,59755,'2001-08-02','9999-01-01'),(10007,56724,'1989-02-10','1990-02-10'),(10007,60740,'1990-02-10','1991-02-10'),(10007,62745,'1991-02-10','1992-02-10'),(10007,63475,'1992-02-10','1993-02-09'),(10007,63208,'1993-02-09','1994-02-09'),(10007,64563,'1994-02-09','1995-02-09'),(10007,68833,'1995-02-09','1996-02-09'),(10007,70220,'1996-02-09','1997-02-08'),(10007,73362,'1997-02-08','1998-02-08'),(10007,75582,'1998-02-08','1999-02-08'),(10007,79513,'1999-02-08','2000-02-08'),(10007,80083,'2000-02-08','2001-02-07'),(10007,84456,'2001-02-07','2002-02-07'),(10007,88070,'2002-02-07','9999-01-01'),(10008,46671,'1998-03-11','1999-03-11'),(10008,48584,'1999-03-11','2000-03-10'),(10008,52668,'2000-03-10','2000-07-31'),(10009,60929,'1985-02-18','1986-02-18'),(10009,64604,'1986-02-18','1987-02-18'),(10009,64780,'1987-02-18','1988-02-18'),(10009,66302,'1988-02-18','1989-02-17'),(10009,69042,'1989-02-17','1990-02-17'),(10009,70889,'1990-02-17','1991-02-17'),(10009,71434,'1991-02-17','1992-02-17'),(10009,74612,'1992-02-17','1993-02-16'),(10009,76518,'1993-02-16','1994-02-16'),(10009,78335,'1994-02-16','1995-02-16'),(10009,80944,'1995-02-16','1996-02-16'),(10009,82507,'1996-02-16','1997-02-15'),(10009,85875,'1997-02-15','1998-02-15'),(10009,89324,'1998-02-15','1999-02-15'),(10009,90668,'1999-02-15','2000-02-15'),(10009,93507,'2000-02-15','2001-02-14'),(10009,94443,'2001-02-14','2002-02-14'),(10009,94409,'2002-02-14','9999-01-01'),(10010,72488,'1996-11-24','1997-11-24'),(10010,74347,'1997-11-24','1998-11-24'),(10010,75405,'1998-11-24','1999-11-24'),(10010,78194,'1999-11-24','2000-11-23'),(10010,79580,'2000-11-23','2001-11-23'),(10010,80324,'2001-11-23','9999-01-01');
/*!40000 ALTER TABLE `salaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaries_grid`
--

DROP TABLE IF EXISTS `salaries_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salaries_grid` (
  `grid_no` int(11) NOT NULL AUTO_INCREMENT,
  `seniority_year_req` int(11) NOT NULL,
  `min_salary` float NOT NULL,
  `max_salary` float NOT NULL,
  `dept_no` char(4) NOT NULL,
  PRIMARY KEY (`grid_no`),
  KEY `fk_employees_departments_idx` (`dept_no`),
  CONSTRAINT `fk_employees_departments` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries_grid`
--

LOCK TABLES `salaries_grid` WRITE;
/*!40000 ALTER TABLE `salaries_grid` DISABLE KEYS */;
INSERT INTO `salaries_grid` VALUES (1,1,38000,39000,'d001'),(2,2,39000,40000,'d001'),(3,3,40000,41000,'d001'),(4,4,41000,42000,'d001'),(5,5,42000,50000,'d001'),(6,6,43000,55000,'d001'),(7,7,44000,60000,'d001'),(8,8,45000,75000,'d001'),(9,9,46000,85000,'d001'),(10,10,50000,100000,'d001'),(11,1,38000,39000,'d002'),(12,2,39000,40000,'d002'),(13,3,40000,41000,'d002'),(14,4,41000,42000,'d002'),(15,5,42000,50000,'d002'),(16,6,43000,55000,'d002'),(17,7,44000,60000,'d002'),(18,8,45000,75000,'d002'),(19,9,46000,85000,'d002'),(20,10,50000,100000,'d002'),(21,1,38000,39000,'d003'),(22,2,39000,40000,'d003'),(23,3,40000,41000,'d003'),(24,4,41000,42000,'d003'),(25,5,42000,50000,'d003'),(26,6,43000,55000,'d003'),(27,7,44000,60000,'d003'),(28,8,45000,75000,'d003'),(29,9,46000,85000,'d003'),(30,10,50000,100000,'d003'),(31,1,38000,39000,'d004'),(32,2,39000,40000,'d004'),(33,3,40000,41000,'d004'),(34,4,41000,42000,'d004'),(35,5,42000,50000,'d004'),(36,6,43000,55000,'d004'),(37,7,44000,60000,'d004'),(38,8,45000,75000,'d004'),(39,9,46000,85000,'d004'),(40,10,50000,100000,'d004'),(41,1,38000,39000,'d005'),(42,2,39000,40000,'d005'),(43,3,40000,41000,'d005'),(44,4,41000,42000,'d005'),(45,5,42000,50000,'d005'),(46,6,43000,55000,'d005'),(47,7,44000,60000,'d005'),(48,8,45000,75000,'d005'),(49,9,46000,85000,'d005'),(50,10,50000,100000,'d005'),(51,1,38000,39000,'d006'),(52,2,39000,40000,'d006'),(53,3,40000,41000,'d006'),(54,4,41000,42000,'d006'),(55,5,42000,50000,'d006'),(56,6,43000,55000,'d006'),(57,7,44000,60000,'d006'),(58,8,45000,75000,'d006'),(59,9,46000,85000,'d006'),(60,10,50000,100000,'d006'),(61,1,38000,39000,'d007'),(62,2,39000,40000,'d007'),(63,3,40000,41000,'d007'),(64,4,41000,42000,'d007'),(65,5,42000,50000,'d007'),(66,6,43000,55000,'d007'),(67,7,44000,60000,'d007'),(68,8,45000,75000,'d007'),(69,9,46000,85000,'d007'),(70,10,50000,100000,'d007'),(71,1,38000,39000,'d008'),(72,2,39000,40000,'d008'),(73,3,40000,41000,'d008'),(74,4,41000,42000,'d008'),(75,5,42000,50000,'d008'),(76,6,43000,55000,'d008'),(77,7,44000,60000,'d008'),(78,8,45000,75000,'d008'),(79,9,46000,85000,'d008'),(80,10,50000,100000,'d008'),(81,1,38000,39000,'d009'),(82,2,39000,40000,'d009'),(83,3,40000,41000,'d009'),(84,4,41000,42000,'d009'),(85,5,42000,50000,'d009'),(86,6,43000,55000,'d009'),(87,7,44000,60000,'d009'),(88,8,45000,75000,'d009'),(89,9,46000,85000,'d009'),(90,10,50000,100000,'d009');
/*!40000 ALTER TABLE `salaries_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titles`
--

DROP TABLE IF EXISTS `titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titles` (
  `emp_no` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`emp_no`,`title`,`from_date`),
  CONSTRAINT `titles_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titles`
--

LOCK TABLES `titles` WRITE;
/*!40000 ALTER TABLE `titles` DISABLE KEYS */;
INSERT INTO `titles` VALUES (10002,'Staff','1996-08-03','9999-01-01'),(10003,'Senior Engineer','1995-12-03','9999-01-01'),(10004,'Engineer','1986-12-01','1995-12-01'),(10004,'Senior Engineer','1995-12-01','9999-01-01'),(10005,'Senior Staff','1996-09-12','9999-01-01'),(10005,'Staff','1989-09-12','1996-09-12'),(10006,'Senior Engineer','1990-08-05','9999-01-01'),(10007,'Senior Staff','1996-02-11','9999-01-01'),(10007,'Staff','1989-02-10','1996-02-11'),(10008,'Assistant Engineer','1998-03-11','2000-07-31'),(10009,'Assistant Engineer','1985-02-18','1990-02-18'),(10009,'Engineer','1990-02-18','1995-02-18'),(10009,'Senior Engineer','1995-02-18','9999-01-01'),(10010,'Engineer','1996-11-24','9999-01-01');
/*!40000 ALTER TABLE `titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `current_dept_emp`
--

/*!50001 DROP TABLE IF EXISTS `current_dept_emp`*/;
/*!50001 DROP VIEW IF EXISTS `current_dept_emp`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_dept_emp` AS select `l`.`emp_no` AS `emp_no`,`d`.`dept_no` AS `dept_no`,`l`.`from_date` AS `from_date`,`l`.`to_date` AS `to_date` from (`dept_emp` `d` join `dept_emp_latest_date` `l` on(((`d`.`emp_no` = `l`.`emp_no`) and (`d`.`from_date` = `l`.`from_date`) and (`l`.`to_date` = `d`.`to_date`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dept_emp_latest_date`
--

/*!50001 DROP TABLE IF EXISTS `dept_emp_latest_date`*/;
/*!50001 DROP VIEW IF EXISTS `dept_emp_latest_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dept_emp_latest_date` AS select `dept_emp`.`emp_no` AS `emp_no`,max(`dept_emp`.`from_date`) AS `from_date`,max(`dept_emp`.`to_date`) AS `to_date` from `dept_emp` group by `dept_emp`.`emp_no` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-04  9:19:13
