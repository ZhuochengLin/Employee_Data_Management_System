CREATE DATABASE  IF NOT EXISTS `cs5200_employee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs5200_employee`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: cs5200_employee
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add department',7,'add_department'),(26,'Can change department',7,'change_department'),(27,'Can delete department',7,'delete_department'),(28,'Can view department',7,'view_department'),(29,'Can add employee',8,'add_employee'),(30,'Can change employee',8,'change_employee'),(31,'Can delete employee',8,'delete_employee'),(32,'Can view employee',8,'view_employee'),(33,'Can add salary',9,'add_salary'),(34,'Can change salary',9,'change_salary'),(35,'Can delete salary',9,'delete_salary'),(36,'Can view salary',9,'view_salary'),(37,'Can add manager',10,'add_manager'),(38,'Can change manager',10,'change_manager'),(39,'Can delete manager',10,'delete_manager'),(40,'Can view manager',10,'view_manager'),(41,'Can add job title',11,'add_jobtitle'),(42,'Can change job title',11,'change_jobtitle'),(43,'Can delete job title',11,'delete_jobtitle'),(44,'Can view job title',11,'view_jobtitle'),(45,'Can add employee works at',12,'add_employeeworksat'),(46,'Can change employee works at',12,'change_employeeworksat'),(47,'Can delete employee works at',12,'delete_employeeworksat'),(48,'Can view employee works at',12,'view_employeeworksat'),(49,'Can add sale staff',13,'add_salestaff'),(50,'Can change sale staff',13,'change_salestaff'),(51,'Can delete sale staff',13,'delete_salestaff'),(52,'Can view sale staff',13,'view_salestaff'),(53,'Can add order',14,'add_order'),(54,'Can change order',14,'change_order'),(55,'Can delete order',14,'delete_order'),(56,'Can view order',14,'view_order'),(57,'Can add system user',15,'add_systemuser'),(58,'Can change system user',15,'change_systemuser'),(59,'Can delete system user',15,'delete_systemuser'),(60,'Can view system user',15,'view_systemuser');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$216000$aO8UFawiFAfI$lT6T68L8M5Ic2/ikgUU83PzMnhBFP4kV8/PVaeyZChk=','2020-12-10 15:58:07.396598',1,'admin','','','admin@demo.com',1,1,'2020-12-07 03:16:15.339113'),(12,'pbkdf2_sha256$216000$uqxkA8BueVcU$JNluh4beoHGjSKuTFn254csKCylxFv4yH9nuNjFoIyo=','2020-12-11 02:42:06.922964',0,'admin_access','','','',0,1,'2020-12-10 15:54:54.377491'),(13,'pbkdf2_sha256$216000$9vGU1wanQlAu$y8Wl58KdA9Eqi6xbWhTXpIXN4wFfri27xASYpzU4i2c=',NULL,0,'guest_access','','','',0,1,'2020-12-10 15:57:58.763631');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-12-10 04:21:12.559994','2','test',3,'',4,1),(2,'2020-12-10 04:22:41.990829','3','test',3,'',4,1),(3,'2020-12-10 04:24:27.079710','4','test',3,'',4,1),(4,'2020-12-10 04:27:27.513963','5','test',3,'',4,1),(5,'2020-12-10 04:28:16.118331','6','test',3,'',4,1),(6,'2020-12-10 04:28:55.985209','7','test',3,'',4,1),(7,'2020-12-10 04:29:33.125691','8','test',3,'',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'navigation','department'),(8,'navigation','employee'),(12,'navigation','employeeworksat'),(11,'navigation','jobtitle'),(10,'navigation','manager'),(14,'navigation','order'),(9,'navigation','salary'),(13,'navigation','salestaff'),(15,'navigation','systemuser'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-12-07 02:24:15.031400'),(2,'auth','0001_initial','2020-12-07 02:24:15.219400'),(3,'admin','0001_initial','2020-12-07 02:24:16.297404'),(4,'admin','0002_logentry_remove_auto_add','2020-12-07 02:24:16.457404'),(5,'admin','0003_logentry_add_action_flag_choices','2020-12-07 02:24:16.467404'),(6,'contenttypes','0002_remove_content_type_name','2020-12-07 02:24:16.595399'),(7,'auth','0002_alter_permission_name_max_length','2020-12-07 02:24:16.815404'),(8,'auth','0003_alter_user_email_max_length','2020-12-07 02:24:16.910421'),(9,'auth','0004_alter_user_username_opts','2020-12-07 02:24:16.926402'),(10,'auth','0005_alter_user_last_login_null','2020-12-07 02:24:17.000401'),(11,'auth','0006_require_contenttypes_0002','2020-12-07 02:24:17.006401'),(12,'auth','0007_alter_validators_add_error_messages','2020-12-07 02:24:17.015403'),(13,'auth','0008_alter_user_username_max_length','2020-12-07 02:24:17.108401'),(14,'auth','0009_alter_user_last_name_max_length','2020-12-07 02:24:17.200401'),(15,'auth','0010_alter_group_name_max_length','2020-12-07 02:24:17.223400'),(16,'auth','0011_update_proxy_permissions','2020-12-07 02:24:17.234434'),(17,'auth','0012_alter_user_first_name_max_length','2020-12-07 02:24:17.330400'),(18,'sessions','0001_initial','2020-12-07 02:24:17.367402'),(19,'navigation','0001_initial','2020-12-07 02:25:25.457929'),(20,'navigation','0002_auto_20201206_2203','2020-12-07 03:03:28.059343'),(21,'navigation','0003_auto_20201206_2353','2020-12-07 04:53:39.365177'),(22,'navigation','0004_auto_20201208_2045','2020-12-09 01:45:08.200981'),(23,'navigation','0005_delete_manager','2020-12-09 23:18:14.937049'),(24,'navigation','0006_order_salestaff','2020-12-09 23:30:26.699519'),(25,'navigation','0007_order_status','2020-12-10 00:34:50.192069'),(26,'navigation','0008_auto_20201209_1943','2020-12-10 00:44:05.824678'),(27,'navigation','0009_order_unit_price','2020-12-10 00:44:35.638182'),(28,'navigation','0010_remove_order_account','2020-12-10 00:53:14.293079'),(29,'navigation','0011_systemuser','2020-12-10 03:26:11.159951'),(30,'navigation','0012_delete_systemuser','2020-12-10 03:47:58.267105'),(31,'navigation','0013_systemuser','2020-12-10 03:54:03.584283'),(32,'navigation','0014_auto_20201209_2256','2020-12-10 03:56:48.914273');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3b6drb49xo63fvkkyfe3nhpcua7p7242','.eJxVjMsKwyAQAP_Fc5FdX8Eee-83iLpuTVsMxOQU-u9FyKG9zgxziBD3rYa9lzXMJK4Clbj8whTzq7Rh6BnbY5F5ads6JzkSedou7wuV9-1s_wY19jq-TJoQjbaovDeGXQaPbBN4UDpOmhUAMVHkBOghOWfZZJ6MRW8Uic8X56Q3Yg:1knOd1:3ZEWzMwnOxsm4vg066DM9LSojG_dqHdz1r_dr1wQwRQ','2020-12-24 16:17:15.309865');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_department`
--

DROP TABLE IF EXISTS `navigation_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `navigation_department_name_8e24eb26_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_department`
--

LOCK TABLES `navigation_department` WRITE;
/*!40000 ALTER TABLE `navigation_department` DISABLE KEYS */;
INSERT INTO `navigation_department` VALUES (3,'Data Analysis'),(1,'Finance'),(2,'Marketing'),(4,'Sale');
/*!40000 ALTER TABLE `navigation_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_employee`
--

DROP TABLE IF EXISTS `navigation_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` varchar(50) NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`first_name`,`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_employee`
--

LOCK TABLES `navigation_employee` WRITE;
/*!40000 ALTER TABLE `navigation_employee` DISABLE KEYS */;
INSERT INTO `navigation_employee` VALUES (1,'Georgi','Facello','1995-01-07','M','2000-01-01'),(2,'Bezalel','Simmel','1990-05-23','F','2001-01-01'),(3,'Parto','Bamford','1992-02-01','M','2003-05-06'),(4,'Chirstian','Chirstian','1985-05-28','M','1998-08-22'),(5,'Kyoichi','Maliniak','1993-05-06','M','2006-12-01');
/*!40000 ALTER TABLE `navigation_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_employeeworksat`
--

DROP TABLE IF EXISTS `navigation_employeeworksat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_employeeworksat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `department_id` int NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navigation_employeew_department_id_b5abd43d_fk_navigatio` (`department_id`),
  KEY `navigation_employeew_employee_id_57291af4_fk_navigatio` (`employee_id`),
  CONSTRAINT `navigation_employeew_department_id_b5abd43d_fk_navigatio` FOREIGN KEY (`department_id`) REFERENCES `navigation_department` (`id`),
  CONSTRAINT `navigation_employeew_employee_id_57291af4_fk_navigatio` FOREIGN KEY (`employee_id`) REFERENCES `navigation_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_employeeworksat`
--

LOCK TABLES `navigation_employeeworksat` WRITE;
/*!40000 ALTER TABLE `navigation_employeeworksat` DISABLE KEYS */;
INSERT INTO `navigation_employeeworksat` VALUES (1,'2000-01-01','2000-10-01',1,1),(2,'2000-10-01','9999-01-01',2,1),(3,'2001-01-01','9999-01-01',2,2),(4,'2003-05-06','9999-01-01',3,3),(5,'1998-08-22','1999-01-22',2,4),(6,'1999-01-22','9999-01-01',4,4);
/*!40000 ALTER TABLE `navigation_employeeworksat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_sale_staff` BEFORE INSERT ON `navigation_employeeworksat` FOR EACH ROW BEGIN

	DECLARE sale_dept_id INT;
    
    SELECT id INTO sale_dept_id FROM navigation_department
    WHERE name = 'Sale';
    
    -- new staff
    IF NEW.department_id = sale_dept_id
    THEN 
		INSERT navigation_salestaff
        (employee_id)
        VALUES (
			NEW.employee_id
        );
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_sale_staff` BEFORE UPDATE ON `navigation_employeeworksat` FOR EACH ROW BEGIN

	DECLARE sale_dept_id INT;
    DECLARE e_id INT;
    DECLARE current_dept INT;
    
    SET e_id = NEW.employee_id;
    
    SELECT id INTO sale_dept_id FROM navigation_department
    WHERE name = 'Sale';
    
    -- the current record
    IF NEW.to_date = '9999-01-01'
    THEN
		-- new sale staff
		IF NEW.department_id = sale_dept_id
        THEN
			INSERT navigation_salestaff
			(employee_id)
			VALUES (
				NEW.employee_id
			);
		ELSE
        -- leave
			IF OLD.department_id = sale_dept_id
            THEN 
				DELETE FROM navigation_salestaff
                WHERE employee_id = e_id;
			END IF;
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_sale_staff` BEFORE DELETE ON `navigation_employeeworksat` FOR EACH ROW BEGIN

	DECLARE sale_dept_id INT;
    
    SELECT id INTO sale_dept_id FROM navigation_department
    WHERE name = 'Sale';
    
    -- staff leave
    IF OLD.department_id = sale_dept_id
    THEN 
		DELETE FROM navigation_salestaff
		WHERE employee_id = OLD.employee_id;
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `navigation_jobtitle`
--

DROP TABLE IF EXISTS `navigation_jobtitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_jobtitle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navigation_jobtitle_employee_id_d1ed7f3a_fk_navigatio` (`employee_id`),
  CONSTRAINT `navigation_jobtitle_employee_id_d1ed7f3a_fk_navigatio` FOREIGN KEY (`employee_id`) REFERENCES `navigation_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_jobtitle`
--

LOCK TABLES `navigation_jobtitle` WRITE;
/*!40000 ALTER TABLE `navigation_jobtitle` DISABLE KEYS */;
INSERT INTO `navigation_jobtitle` VALUES (1,'Staff','2000-01-01','2000-10-01',1),(2,'Senior Staff','2000-10-01','9999-01-01',1),(3,'Cleaner','2001-01-01','9999-01-01',2),(4,'Engineer','2003-05-06','9999-01-01',3);
/*!40000 ALTER TABLE `navigation_jobtitle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_order`
--

DROP TABLE IF EXISTS `navigation_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(100) NOT NULL,
  `quantity` int NOT NULL,
  `sale_staff_id` int NOT NULL,
  `status` varchar(10) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navigation_order_sale_staff_id_d8b8940c_fk_navigatio` (`sale_staff_id`),
  CONSTRAINT `navigation_order_sale_staff_id_d8b8940c_fk_navigatio` FOREIGN KEY (`sale_staff_id`) REFERENCES `navigation_salestaff` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_order`
--

LOCK TABLES `navigation_order` WRITE;
/*!40000 ALTER TABLE `navigation_order` DISABLE KEYS */;
INSERT INTO `navigation_order` VALUES (1,'Watch',1,1,'A',24.50);
/*!40000 ALTER TABLE `navigation_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_salary`
--

DROP TABLE IF EXISTS `navigation_salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_salary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` int NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navigation_salary_employee_id_df61c51f_fk_navigation_employee_id` (`employee_id`),
  CONSTRAINT `navigation_salary_employee_id_df61c51f_fk_navigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `navigation_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_salary`
--

LOCK TABLES `navigation_salary` WRITE;
/*!40000 ALTER TABLE `navigation_salary` DISABLE KEYS */;
INSERT INTO `navigation_salary` VALUES (1,1000,'2000-01-01','2000-10-01',1),(2,1200,'2000-10-01','2000-12-01',1),(3,1300,'2000-12-01','9999-01-01',1),(4,900,'2001-01-01','2001-02-01',2),(5,950,'2001-02-01','9999-01-01',2),(6,1200,'2003-05-06','9999-01-01',3);
/*!40000 ALTER TABLE `navigation_salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_salestaff`
--

DROP TABLE IF EXISTS `navigation_salestaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_salestaff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navigation_salestaff_employee_id_549a8801_fk_navigatio` (`employee_id`),
  CONSTRAINT `navigation_salestaff_employee_id_549a8801_fk_navigatio` FOREIGN KEY (`employee_id`) REFERENCES `navigation_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_salestaff`
--

LOCK TABLES `navigation_salestaff` WRITE;
/*!40000 ALTER TABLE `navigation_salestaff` DISABLE KEYS */;
INSERT INTO `navigation_salestaff` VALUES (1,4);
/*!40000 ALTER TABLE `navigation_salestaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_systemuser`
--

DROP TABLE IF EXISTS `navigation_systemuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_systemuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `access_level` varchar(10) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `navigation_systemuser_user_id_cd6fe0a5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_systemuser`
--

LOCK TABLES `navigation_systemuser` WRITE;
/*!40000 ALTER TABLE `navigation_systemuser` DISABLE KEYS */;
INSERT INTO `navigation_systemuser` VALUES (5,'A',12),(6,'G',13);
/*!40000 ALTER TABLE `navigation_systemuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'cs5200_employee'
--

--
-- Dumping routines for database 'cs5200_employee'
--
/*!50003 DROP PROCEDURE IF EXISTS `find_all_departments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_all_departments`()
BEGIN

SELECT * FROM navigation_department
ORDER BY id ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_all_employees` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_all_employees`()
BEGIN

DECLARE end_date DATE;
SET end_date = '9999-01-01';

SELECT e.*, s.amount AS salary, j.title, d.name AS department_name  FROM navigation_employee e
LEFT JOIN navigation_salary s ON (s.employee_id = e.id AND s.to_date = end_date)
LEFT JOIN navigation_jobtitle j ON (j.employee_id = e.id AND j.to_date = end_date)
LEFT JOIN navigation_employeeworksat w ON (w.employee_id = e.id AND w.to_date = end_date)
LEFT JOIN navigation_department d ON (d.id = w.department_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_all_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_all_orders`()
BEGIN

SELECT o.*, e.first_name, e.last_name, e.id AS employee_id FROM navigation_order o
JOIN navigation_salestaff s ON s.id = o.sale_staff_id
JOIN navigation_employee e ON s.employee_id = e.id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_all_sale_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_all_sale_staff`()
BEGIN

SELECT * FROM navigation_salestaff;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_all_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_all_users`()
BEGIN

SELECT a.username, s.access_level, a.id FROM navigation_systemuser s
JOIN auth_user a ON s.user_id = a.id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_assignment_history_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_assignment_history_by_id`(IN e_id INT)
BEGIN

SELECT e.*, d.name AS department_name FROM navigation_employeeworksat e
LEFT JOIN navigation_department d ON d.id = e.department_id
WHERE employee_id = e_id
ORDER BY to_date DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_current_assignment_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_current_assignment_by_id`(IN input_id INT)
BEGIN

SELECT * FROM navigation_employeeworksat
WHERE employee_id = input_id
ORDER BY to_date DESC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_current_salary_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_current_salary_by_id`(IN input_id INT)
BEGIN

SELECT * FROM navigation_salary s
WHERE s.employee_id = input_id
ORDER BY to_date DESC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_current_title_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_current_title_by_id`(IN input_id INT)
BEGIN

SELECT * FROM navigation_jobtitle s
WHERE s.employee_id = input_id
ORDER BY to_date DESC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_employee_all_info_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_employee_all_info_by_id`(IN input_id INT)
BEGIN

DECLARE end_date DATE;
SET end_date = '9999-01-01';

SELECT e.*, s.amount AS salary, j.title, d.name AS department_name  FROM navigation_employee e
LEFT JOIN navigation_salary s ON (s.employee_id = e.id AND s.employee_id = input_id AND s.to_date = end_date)
LEFT JOIN navigation_jobtitle j ON (j.employee_id = e.id AND j.employee_id = input_id AND j.to_date = end_date)
LEFT JOIN navigation_employeeworksat w ON (w.employee_id = e.id AND w.employee_id = e.id AND w.to_date = end_date)
LEFT JOIN navigation_department d ON (d.id = w.department_id)
WHERE e.id = input_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_employee_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_employee_by_id`(IN input_id INT)
BEGIN

SELECT * FROM navigation_employee e
WHERE e.id = input_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_employee_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_employee_by_name`(IN input_first_name VARCHAR(100), IN input_last_name VARCHAR(100))
BEGIN

SELECT * FROM navigation_employee e
WHERE e.first_name = input_first_name AND e.last_name = input_last_name;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_later_assignment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_later_assignment`(IN e_id INT, IN s_id INT)
BEGIN

SELECT * FROM navigation_employeeworksat
WHERE employee_id = e_id AND id > s_id
ORDER BY to_date ASC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_later_salary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_later_salary`(IN e_id INT, IN s_id INT)
BEGIN

SELECT * FROM navigation_salary
WHERE employee_id = e_id AND id > s_id
ORDER BY to_date ASC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_later_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_later_title`(IN e_id INT, IN s_id INT)
BEGIN

SELECT * FROM navigation_jobtitle
WHERE employee_id = e_id AND id > s_id
ORDER BY to_date ASC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_previous_assignment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_previous_assignment`(IN e_id INT, IN s_id INT)
BEGIN

SELECT * FROM navigation_employeeworksat
WHERE employee_id = e_id AND id < s_id
ORDER BY to_date DESC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_previous_salary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_previous_salary`(IN e_id INT, IN s_id INT)
BEGIN

SELECT * FROM navigation_salary
WHERE employee_id = e_id AND id < s_id
ORDER BY to_date DESC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_previous_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_previous_title`(IN e_id INT, IN s_id INT)
BEGIN

SELECT * FROM navigation_jobtitle
WHERE employee_id = e_id AND id < s_id
ORDER BY to_date DESC
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_salary_history_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_salary_history_by_id`(IN input_id INT)
BEGIN

SELECT * FROM navigation_salary s
WHERE s.employee_id = input_id
ORDER BY to_date DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_title_history_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_title_history_by_id`(IN input_id INT)
BEGIN

SELECT * FROM navigation_jobtitle j
WHERE j.employee_id = input_id
ORDER BY to_date DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_assignment_to_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_assignment_to_date`(IN e_id INT)
BEGIN

SELECT * FROM navigation_employeeworksat
WHERE employee_id = e_id AND to_date = "9999-01-01";

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_salary_to_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_salary_to_date`(IN e_id INT)
BEGIN

SELECT * FROM navigation_salary
WHERE employee_id = e_id AND to_date = "9999-01-01";

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_title_to_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_title_to_date`(IN e_id INT)
BEGIN

SELECT * FROM navigation_jobtitle
WHERE employee_id = e_id AND to_date = "9999-01-01";

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

-- Dump completed on 2020-12-10 21:49:13
