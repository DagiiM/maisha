-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: soteni
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `about_about`
--

DROP TABLE IF EXISTS `about_about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about_about` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `object_id` int unsigned NOT NULL,
  `content_type_id` int NOT NULL,
  `image_id` bigint DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) DEFAULT '0',
  `deletion_date` datetime(6) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `about_about_content_type_id_8e2db647_fk_django_content_type_id` (`content_type_id`),
  KEY `about_about_image_id_b6e7a5f1_fk_media_image_id` (`image_id`),
  CONSTRAINT `about_about_content_type_id_8e2db647_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `about_about_image_id_b6e7a5f1_fk_media_image_id` FOREIGN KEY (`image_id`) REFERENCES `media_image` (`id`),
  CONSTRAINT `about_about_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about_about`
--

LOCK TABLES `about_about` WRITE;
/*!40000 ALTER TABLE `about_about` DISABLE KEYS */;
INSERT INTO `about_about` VALUES (1,'<p>Our partners have supported many of our projects</p>',1,1,13,NULL,NULL,NULL,NULL,0,NULL,0),(3,'<p><strong>About Maisha</strong></p>\r\n\r\n<p style=\"text-align:justify\">Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving and protecting girls in the most vulnerable situations of sexual violence and abuse by providing a continuum of care and support, and building their resiliency for quality living.</p>\r\n\r\n<p style=\"text-align:justify\">&nbsp;</p>\r\n\r\n<p style=\"text-align:justify\">MGSH was initiated in 2014, with support from friends from Drammen Norway on pure voluntary basis. It started as a community-based organization and upgraded to an NGO in 2020. We run a shelter that offers a temporal home to young girls survivors of sexual violence. While at the shelter we offer survivors psychosocial support, healthcare referrals, educational support, legal referrals and family reintegration.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;Additionally, we run community-safe spaces that are information hubs for girls and young women to access information on sexual gender-based violence (SGBV), sexual reproductive health (SRHR) and get supported to access education, life skills, and livelihood opportunities.</p>\r\n\r\n<p>&nbsp;</p>',1,1,28,NULL,NULL,NULL,NULL,0,NULL,0),(5,'<p>We have several programs with the aim of providing comprehensive support to survivors of sexual violence and individuals within our communities. These programs include the safe space, safe house, community outreach and education, each playing a unique and vital role &nbsp;in our efforts to address the diverse and complex needs of the individuals we serve.&nbsp;</p>',1,1,29,47,NULL,NULL,NULL,0,NULL,0),(6,'<h3><strong>We consider these services the foundation to freedom and support for living a fulfilled life:</strong></h3>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Safety &amp; Basic Care - Shelter, food, clothing and protection.</p>\r\n	</li>\r\n	<li>\r\n	<p>Counseling &amp; Medical - Offering support for emotional healing and physical well-being.</p>\r\n	</li>\r\n	<li>\r\n	<p>Education &amp; Training - Personalized educational and vocational training programs.</p>\r\n	</li>\r\n	<li>\r\n	<p>Social Work &amp; Legal Advocacy - social work within the community and advocacy for legal justice.</p>\r\n	</li>\r\n</ul>',1,1,31,8,NULL,NULL,NULL,0,NULL,0);
/*!40000 ALTER TABLE `about_about` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `about_aboutrelationship`
--

DROP TABLE IF EXISTS `about_aboutrelationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about_aboutrelationship` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `about_id` bigint NOT NULL,
  `content_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `about_aboutrelationship_about_id_cb0b2603_fk_about_about_id` (`about_id`),
  KEY `about_aboutrelations_content_type_id_6951f918_fk_django_co` (`content_type_id`),
  CONSTRAINT `about_aboutrelations_content_type_id_6951f918_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `about_aboutrelationship_about_id_cb0b2603_fk_about_about_id` FOREIGN KEY (`about_id`) REFERENCES `about_about` (`id`),
  CONSTRAINT `about_aboutrelationship_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about_aboutrelationship`
--

LOCK TABLES `about_aboutrelationship` WRITE;
/*!40000 ALTER TABLE `about_aboutrelationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `about_aboutrelationship` ENABLE KEYS */;
UNLOCK TABLES;

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
  `id` bigint NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add about',7,'add_about'),(26,'Can change about',7,'change_about'),(27,'Can delete about',7,'delete_about'),(28,'Can view about',7,'view_about'),(29,'Can add about relationship',8,'add_aboutrelationship'),(30,'Can change about relationship',8,'change_aboutrelationship'),(31,'Can delete about relationship',8,'delete_aboutrelationship'),(32,'Can view about relationship',8,'view_aboutrelationship'),(33,'Can add image',9,'add_image'),(34,'Can change image',9,'change_image'),(35,'Can delete image',9,'delete_image'),(36,'Can view image',9,'view_image'),(37,'Can add video',10,'add_video'),(38,'Can change video',10,'change_video'),(39,'Can delete video',10,'delete_video'),(40,'Can view video',10,'view_video'),(41,'Can add document',11,'add_document'),(42,'Can change document',11,'change_document'),(43,'Can delete document',11,'delete_document'),(44,'Can view document',11,'view_document'),(45,'Can add team member',12,'add_teammember'),(46,'Can change team member',12,'change_teammember'),(47,'Can delete team member',12,'delete_teammember'),(48,'Can view team member',12,'view_teammember'),(49,'Can add partner',13,'add_partner'),(50,'Can change partner',13,'change_partner'),(51,'Can delete partner',13,'delete_partner'),(52,'Can view partner',13,'view_partner'),(53,'Can add category',14,'add_category'),(54,'Can change category',14,'change_category'),(55,'Can delete category',14,'delete_category'),(56,'Can view category',14,'view_category'),(57,'Can add tag',15,'add_tag'),(58,'Can change tag',15,'change_tag'),(59,'Can delete tag',15,'delete_tag'),(60,'Can view tag',15,'view_tag'),(61,'Can add subscription',16,'add_subscription'),(62,'Can change subscription',16,'change_subscription'),(63,'Can delete subscription',16,'delete_subscription'),(64,'Can view subscription',16,'view_subscription'),(65,'Can add blog',17,'add_blog'),(66,'Can change blog',17,'change_blog'),(67,'Can delete blog',17,'delete_blog'),(68,'Can view blog',17,'view_blog'),(69,'Can add comment',18,'add_comment'),(70,'Can change comment',18,'change_comment'),(71,'Can delete comment',18,'delete_comment'),(72,'Can view comment',18,'view_comment'),(73,'Can add trash item',19,'add_trashitem'),(74,'Can change trash item',19,'change_trashitem'),(75,'Can delete trash item',19,'delete_trashitem'),(76,'Can view trash item',19,'view_trashitem'),(77,'Can add wallet',20,'add_wallet'),(78,'Can change wallet',20,'change_wallet'),(79,'Can delete wallet',20,'delete_wallet'),(80,'Can view wallet',20,'view_wallet'),(81,'Can add payment transaction',21,'add_paymenttransaction'),(82,'Can change payment transaction',21,'change_paymenttransaction'),(83,'Can delete payment transaction',21,'delete_paymenttransaction'),(84,'Can view payment transaction',21,'view_paymenttransaction'),(85,'Can add address',22,'add_address'),(86,'Can change address',22,'change_address'),(87,'Can delete address',22,'delete_address'),(88,'Can view address',22,'view_address'),(89,'Can add Contact',23,'add_contact'),(90,'Can change Contact',23,'change_contact'),(91,'Can delete Contact',23,'delete_contact'),(92,'Can view Contact',23,'view_contact'),(93,'Can add contact information',24,'add_contactinformation'),(94,'Can change contact information',24,'change_contactinformation'),(95,'Can delete contact information',24,'delete_contactinformation'),(96,'Can view contact information',24,'view_contactinformation'),(97,'Can add quote',25,'add_quote'),(98,'Can change quote',25,'change_quote'),(99,'Can delete quote',25,'delete_quote'),(100,'Can view quote',25,'view_quote'),(101,'Can add Subscription',26,'add_subscription'),(102,'Can change Subscription',26,'change_subscription'),(103,'Can delete Subscription',26,'delete_subscription'),(104,'Can view Subscription',26,'view_subscription'),(105,'Can add organization step',27,'add_organizationstep'),(106,'Can change organization step',27,'change_organizationstep'),(107,'Can delete organization step',27,'delete_organizationstep'),(108,'Can view organization step',27,'view_organizationstep'),(109,'Can add organization',28,'add_organization'),(110,'Can change organization',28,'change_organization'),(111,'Can delete organization',28,'delete_organization'),(112,'Can view organization',28,'view_organization'),(113,'Can add program',29,'add_program'),(114,'Can change program',29,'change_program'),(115,'Can delete program',29,'delete_program'),(116,'Can view program',29,'view_program'),(117,'Can add activity',30,'add_activity'),(118,'Can change activity',30,'change_activity'),(119,'Can delete activity',30,'delete_activity'),(120,'Can view activity',30,'view_activity'),(121,'Can add service',31,'add_service'),(122,'Can change service',31,'change_service'),(123,'Can delete service',31,'delete_service'),(124,'Can view service',31,'view_service'),(125,'Can add icon',32,'add_icon'),(126,'Can change icon',32,'change_icon'),(127,'Can delete icon',32,'delete_icon'),(128,'Can view icon',32,'view_icon'),(129,'Can add trash',33,'add_trash'),(130,'Can change trash',33,'change_trash'),(131,'Can delete trash',33,'delete_trash'),(132,'Can view trash',33,'view_trash');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$e9urmccVNczmrDqjVfWlTI$WWGg2Qk1eXThGD/ZzgbhSy/SCpu7wnhMMLMt+sE3mXY=','2024-04-06 09:48:44.998243',1,'admin','Douglas','Mutethia','admin@eleso.ltd',1,1,'2024-02-25 22:44:20.255830'),(2,'pbkdf2_sha256$600000$joiG8dcgz8ZNioZYk0SleE$yv2CWp6mMupVWSG3BrpHsvpENSvkxP/AKocW+DWgLi8=','2024-04-03 19:49:04.014039',1,'randie.marsh','Randie L.','Marsh','randie.marsh@handinhandkenya.org',1,1,'2024-02-25 22:44:20.485467'),(3,'pbkdf2_sha256$600000$0bbNXVOTldxXudNAomLmNK$z0PBPBc9lzKwo/9QsKgqmvySp7Pgx1CVXV5IeuTxcfo=',NULL,0,'flo','Flo','Keah','flokeah@maishagirlssafehouse.org',1,1,'2024-02-29 16:06:08.000000'),(4,'pbkdf2_sha256$600000$kCkQupRtBOthYz2yO1T96n$jYExwDtAW4bigd5C7s9GMET7vqYwkmJyNvri6dUEFiY=',NULL,0,'YvonneNjoka','','','',0,1,'2024-04-02 07:42:09.348319'),(5,'pbkdf2_sha256$600000$AFG28PeZpwVQJQAWCsQEha$ojjVG5Q7bDeIazmySUcUu63uw6eH+Tpq5mf6RZdunYI=',NULL,0,'AbrahamLiona','','','',0,1,'2024-04-02 08:09:21.950465');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
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
  `id` bigint NOT NULL AUTO_INCREMENT,
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
-- Table structure for table `blog_blog`
--

DROP TABLE IF EXISTS `blog_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_blog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `publication_date` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `featured` tinyint(1) NOT NULL,
  `views` int unsigned NOT NULL,
  `likes` int unsigned NOT NULL,
  `author_id` int NOT NULL,
  `document_id` bigint DEFAULT NULL,
  `image_id` bigint DEFAULT NULL,
  `video_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `blog_blog_author_id_8791af69_fk_auth_user_id` (`author_id`),
  KEY `blog_blog_document_id_dbe5ba64_fk_media_document_id` (`document_id`),
  KEY `blog_blog_image_id_803ffc27_fk_media_image_id` (`image_id`),
  KEY `blog_blog_video_id_1a908835_fk_media_video_id` (`video_id`),
  CONSTRAINT `blog_blog_author_id_8791af69_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `blog_blog_document_id_dbe5ba64_fk_media_document_id` FOREIGN KEY (`document_id`) REFERENCES `media_document` (`id`),
  CONSTRAINT `blog_blog_image_id_803ffc27_fk_media_image_id` FOREIGN KEY (`image_id`) REFERENCES `media_image` (`id`),
  CONSTRAINT `blog_blog_video_id_1a908835_fk_media_video_id` FOREIGN KEY (`video_id`) REFERENCES `media_video` (`id`),
  CONSTRAINT `blog_blog_chk_1` CHECK ((`views` >= 0)),
  CONSTRAINT `blog_blog_chk_2` CHECK ((`likes` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_blog`
--

LOCK TABLES `blog_blog` WRITE;
/*!40000 ALTER TABLE `blog_blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_blog_categories`
--

DROP TABLE IF EXISTS `blog_blog_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_blog_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blog_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_blog_categories_blog_id_category_id_07ca2d5b_uniq` (`blog_id`,`category_id`),
  KEY `blog_blog_categories_category_id_1fb5860b_fk_blog_category_id` (`category_id`),
  CONSTRAINT `blog_blog_categories_blog_id_41b7a08b_fk_blog_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`id`),
  CONSTRAINT `blog_blog_categories_category_id_1fb5860b_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_blog_categories`
--

LOCK TABLES `blog_blog_categories` WRITE;
/*!40000 ALTER TABLE `blog_blog_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_blog_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_blog_tags`
--

DROP TABLE IF EXISTS `blog_blog_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_blog_tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blog_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_blog_tags_blog_id_tag_id_211c6be5_uniq` (`blog_id`,`tag_id`),
  KEY `blog_blog_tags_tag_id_36a3abc6_fk_blog_tag_id` (`tag_id`),
  CONSTRAINT `blog_blog_tags_blog_id_e4cd5f6a_fk_blog_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`id`),
  CONSTRAINT `blog_blog_tags_tag_id_36a3abc6_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_blog_tags`
--

LOCK TABLES `blog_blog_tags` WRITE;
/*!40000 ALTER TABLE `blog_blog_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_blog_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_subscription`
--

DROP TABLE IF EXISTS `blog_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_subscription` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_subscription_user_id_1bd81a22_fk_auth_user_id` (`user_id`),
  CONSTRAINT `blog_subscription_user_id_1bd81a22_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_subscription`
--

LOCK TABLES `blog_subscription` WRITE;
/*!40000 ALTER TABLE `blog_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_subscription_subscribed_categories`
--

DROP TABLE IF EXISTS `blog_subscription_subscribed_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_subscription_subscribed_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_subscription_subscr_subscription_id_category_914a473e_uniq` (`subscription_id`,`category_id`),
  KEY `blog_subscription_su_category_id_86d0d662_fk_blog_cate` (`category_id`),
  CONSTRAINT `blog_subscription_su_category_id_86d0d662_fk_blog_cate` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`),
  CONSTRAINT `blog_subscription_su_subscription_id_de87dea8_fk_blog_subs` FOREIGN KEY (`subscription_id`) REFERENCES `blog_subscription` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_subscription_subscribed_categories`
--

LOCK TABLES `blog_subscription_subscribed_categories` WRITE;
/*!40000 ALTER TABLE `blog_subscription_subscribed_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_subscription_subscribed_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_subscription_subscribed_tags`
--

DROP TABLE IF EXISTS `blog_subscription_subscribed_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_subscription_subscribed_tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_subscription_subscr_subscription_id_tag_id_a4a0a355_uniq` (`subscription_id`,`tag_id`),
  KEY `blog_subscription_subscribed_tags_tag_id_c4f1ee40_fk_blog_tag_id` (`tag_id`),
  CONSTRAINT `blog_subscription_su_subscription_id_76ab1db1_fk_blog_subs` FOREIGN KEY (`subscription_id`) REFERENCES `blog_subscription` (`id`),
  CONSTRAINT `blog_subscription_subscribed_tags_tag_id_c4f1ee40_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_subscription_subscribed_tags`
--

LOCK TABLES `blog_subscription_subscribed_tags` WRITE;
/*!40000 ALTER TABLE `blog_subscription_subscribed_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_subscription_subscribed_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag`
--

DROP TABLE IF EXISTS `blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag`
--

LOCK TABLES `blog_tag` WRITE;
/*!40000 ALTER TABLE `blog_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_comment`
--

DROP TABLE IF EXISTS `comments_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `content` longtext NOT NULL,
  `object_id` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `content_type_id` int NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_comment_author_id_334ce9e2_fk_auth_user_id` (`author_id`),
  KEY `comments_comment_content_type_id_72fd5dbe_fk_django_co` (`content_type_id`),
  CONSTRAINT `comments_comment_author_id_334ce9e2_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `comments_comment_content_type_id_72fd5dbe_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `comments_comment_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_comment`
--

LOCK TABLES `comments_comment` WRITE;
/*!40000 ALTER TABLE `comments_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_address`
--

DROP TABLE IF EXISTS `contact_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_address`
--

LOCK TABLES `contact_address` WRITE;
/*!40000 ALTER TABLE `contact_address` DISABLE KEYS */;
INSERT INTO `contact_address` VALUES (1,0,'Nairobi','Nairobi','Nairobi','01000','2024-04-03 15:22:23.090093',NULL,NULL,0,'2024-04-03 15:22:23.217842'),(2,0,'Nairobi','Nairobi','Kenya','00100','2024-04-03 15:22:23.090093',NULL,NULL,0,'2024-04-03 15:22:23.217842'),(3,0,'USA','USA','USA','01000','2024-04-03 15:22:23.090093',NULL,NULL,0,'2024-04-03 15:22:23.217842');
/*!40000 ALTER TABLE `contact_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_contact`
--

DROP TABLE IF EXISTS `contact_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `message` longtext NOT NULL,
  `subscribed` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_contact`
--

LOCK TABLES `contact_contact` WRITE;
/*!40000 ALTER TABLE `contact_contact` DISABLE KEYS */;
INSERT INTO `contact_contact` VALUES (1,0,'Douglas Mutethia','douglasmutethia2017@gmail.com','Hello',1,'2024-04-03 15:22:23.253580',NULL,NULL,0,'2024-04-03 15:22:23.332042');
/*!40000 ALTER TABLE `contact_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_contactinformation`
--

DROP TABLE IF EXISTS `contact_contactinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_contactinformation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(254) NOT NULL,
  `website` varchar(200) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_contactinformation`
--

LOCK TABLES `contact_contactinformation` WRITE;
/*!40000 ALTER TABLE `contact_contactinformation` DISABLE KEYS */;
INSERT INTO `contact_contactinformation` VALUES (1,0,'(254)718428754','info@maishagirlssafehouse.org','https://maishagirlssafehouse.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(2,0,'(254)718428754','info@maishagirlssafehouse.org','https://www.maishagirlssafehouse.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(3,0,'0726304569','flo@maishagirlssafehouse.org','https://www.maishagirlssafehouse.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(4,0,'(254)718428754','randie.marsh@handinhandkenya.org','https://www.handinhandkenya.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(5,0,'0796648560','admin@maishagirlssafehouse.org','http://untf.unwomen.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(6,0,'0796648560','admin@maishagirlssafehouse.org','http://ke.ambafrance.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(7,0,'0796648563','doriceneicy@gmail.com','http://freedomfund.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(8,0,'0796648561','nasiodorice97@gmail.com','https://ke.ambafrance.org/','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975'),(9,0,'0743166899','shikonjoka@gmail.com','http://www.maishagirlssafehouse.org','2024-04-03 15:22:23.356968',NULL,NULL,0,'2024-04-03 15:22:23.484975');
/*!40000 ALTER TABLE `contact_contactinformation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_organization`
--

DROP TABLE IF EXISTS `contact_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_organization` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `mission` longtext NOT NULL,
  `vision` longtext NOT NULL,
  `values` longtext NOT NULL,
  `address_id` bigint NOT NULL,
  `contact_info_id` bigint NOT NULL,
  `logo_id` bigint DEFAULT NULL,
  `video_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_id` (`address_id`),
  UNIQUE KEY `contact_info_id` (`contact_info_id`),
  UNIQUE KEY `logo_id` (`logo_id`),
  KEY `contact_organization_video_id_6034a92f_fk_media_video_id` (`video_id`),
  CONSTRAINT `contact_organization_address_id_b6ea98ba_fk_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `contact_address` (`id`),
  CONSTRAINT `contact_organization_contact_info_id_91e79623_fk_contact_c` FOREIGN KEY (`contact_info_id`) REFERENCES `contact_contactinformation` (`id`),
  CONSTRAINT `contact_organization_logo_id_dceace85_fk_media_image_id` FOREIGN KEY (`logo_id`) REFERENCES `media_image` (`id`),
  CONSTRAINT `contact_organization_video_id_6034a92f_fk_media_video_id` FOREIGN KEY (`video_id`) REFERENCES `media_video` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_organization`
--

LOCK TABLES `contact_organization` WRITE;
/*!40000 ALTER TABLE `contact_organization` DISABLE KEYS */;
INSERT INTO `contact_organization` VALUES (2,0,'Maisha Girls Safe House','Maisha Girls Safe House fills a gap that is experienced by survivors of sexual violence. The Safe House offers young women opportunities for case management and community integration. Additionally, Maisha creates links to institutions assisting in rehabilitation, long term housing, treatment, education, and independence.','The projects mission is to reach out, receive and protect girls in the most vulnerable situations of sexual violence and abuses.','To end sexual violence against girls and young women.','...',2,2,3,NULL,'2024-04-03 15:22:23.527990',NULL,NULL,0,'2024-04-03 15:22:23.645546');
/*!40000 ALTER TABLE `contact_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_organizationstep`
--

DROP TABLE IF EXISTS `contact_organizationstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_organizationstep` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `next_step_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `next_step_id` (`next_step_id`),
  CONSTRAINT `contact_organization_next_step_id_47c6090e_fk_contact_o` FOREIGN KEY (`next_step_id`) REFERENCES `contact_organizationstep` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_organizationstep`
--

LOCK TABLES `contact_organizationstep` WRITE;
/*!40000 ALTER TABLE `contact_organizationstep` DISABLE KEYS */;
INSERT INTO `contact_organizationstep` VALUES (1,0,'Companies','Generous companies and their employees further support high-impact projects with donations and grants, helping local communities thrive.',1,'2024-04-03 15:22:23.671110',NULL,NULL,0,'2024-04-03 15:22:23.740503'),(2,0,'NGOs','Nonprofits around the world apply and join Maisha to access more funding, to build new skills, and to make important connections.',3,'2024-04-03 15:22:23.671110',NULL,NULL,0,'2024-04-03 15:22:23.740503'),(3,0,'Individual Donors','People like you give to your favorite projects; you feel great when you get updates about how your money is put to work by trusted organizations.',4,'2024-04-03 15:22:23.671110',NULL,NULL,0,'2024-04-03 15:22:23.740503'),(4,0,'Impact','Nonprofits have the funding they need to listen to feedback and try out new ways to work; communities all over the globe get more awesome!',2,'2024-04-03 15:22:23.671110',NULL,NULL,0,'2024-04-03 15:22:23.740503');
/*!40000 ALTER TABLE `contact_organizationstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_quote`
--

DROP TABLE IF EXISTS `contact_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_quote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `text` longtext NOT NULL,
  `context` longtext,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_quote`
--

LOCK TABLES `contact_quote` WRITE;
/*!40000 ALTER TABLE `contact_quote` DISABLE KEYS */;
INSERT INTO `contact_quote` VALUES (1,0,'Every girl deserves a safe and happy childhood.','Preventing girl child abuse is our mission.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(2,0,'Together, we can make a difference in the lives of young girls.','Advocating for donations to champion the campaign.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(3,0,'Protecting our girls is protecting our future.','Join us in the fight against girl child abuse.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(4,0,'Empower girls with knowledge, love, and safety.','Donate today to support our cause.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(5,0,'Girls deserve to grow up free from fear and abuse.','Your donation can change a girl\'s life.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(6,0,'Educate, empower, protect - that\'s our pledge to girls.','Help us fulfill our mission with your support.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(7,0,'Don\'t be silent; be a voice for the voiceless.','Donate to end girl child abuse.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(8,0,'Girls can achieve great things when they\'re safe and free.','Join our campaign to ensure their safety.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(9,0,'Let\'s create a world where no girl has to suffer in silence.','Donate to support our cause today.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(10,0,'A small donation can make a big difference in a girl\'s life.','Join us in preventing girl child abuse.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(11,0,'Girls are our hope for a brighter future. Let\'s protect them.','Your support can prevent girl child abuse.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(12,0,'No girl should ever live in fear. Stand with us in this fight.','Donate to make a difference.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(13,0,'Safety and happiness are every girl\'s birthright.','Join us to ensure they receive it.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(14,0,'Empower girls, and you empower the world.','Your donation can be a catalyst for change.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(15,0,'Every girl is a star in the making. Let\'s protect their shine.','Support our mission with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(16,0,'Love and kindness can break the cycle of abuse.','Advocate for a safer world for girls.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(17,0,'A girl\'s smile is a powerful force. Help us protect it.','Donate to keep girls safe.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(18,0,'Every girl is a precious gem. Let\'s keep them safe.','Champion the cause with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(19,0,'No child should ever experience the darkness of abuse.','Your support can bring light into their lives.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(20,0,'Girls are strong, but they deserve a life free from abuse.','Advocate for their safety with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(21,0,'Together, we can break the chains of girl child abuse.','Your contribution matters.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(22,0,'Girls are the future leaders of our world. Let\'s nurture them.','Support the cause with your generosity.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(23,0,'A world without girl child abuse is a world we can build together.','Donate to make this vision a reality.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(24,0,'Preventing girl child abuse is everyone\'s responsibility.','Join the campaign by donating today.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(25,0,'Kindness is a gift we can give to all girls. Let\'s give it generously.','Support our mission with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(26,0,'Girls have dreams. Let\'s make sure their dreams come true.','Advocate for their well-being with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(27,0,'Every girl is worth protecting. Let\'s stand up for them.','Your support can make a difference.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(28,0,'Love, protect, and empower the girls of our world.','Donate to be their guardian angel.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(29,0,'A girl\'s potential knows no bounds. Let\'s unlock it.','Join our campaign and donate today.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(30,0,'Girls are the heartbeat of our future. Protect that rhythm.','Donate to end girl child abuse.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(31,0,'A safe world for girls is a safe world for us all.','Your support matters.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(32,0,'Girls are the seeds of change. Water them with love and protection.','Champion the campaign with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(33,0,'Break the silence. End girl child abuse.','Join us in this mission.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(34,0,'Girls are the architects of our world\'s future. Let\'s build together.','Advocate for their safety with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(35,0,'A world without girl child abuse is a world filled with hope.','Donate to make hope a reality.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(36,0,'Girls are like stars; they deserve to shine bright.','Support their dreams with your generosity.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(37,0,'Love knows no bounds; let\'s love and protect our girls.','Your donation can make a difference.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(38,0,'Empower girls today, and they will lead us to a brighter tomorrow.','Advocate for their well-being.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(39,0,'End girl child abuse, and start a journey toward a safer world.','Donate to support the journey.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(40,1,'Girls are the artists of tomorrow\'s masterpiece. Protect their canvas.','Champion their dreams with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(41,0,'Preventing girl child abuse is building a world of possibilities.','Join us in creating possibilities with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(42,0,'No girl should ever feel the pain of abuse. Let\'s erase that pain.','Support our mission with your generosity.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(43,0,'A world where girls are safe is a world of smiles and dreams.','Donate to make those smiles and dreams come true.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(44,0,'Together, we can be the change the world needs for its girls.','Advocate for a safer world with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(45,0,'Girls are the melodies of our lives. Let\'s keep the music playing.','Your support can be their symphony.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(46,0,'A world without girl child abuse is a world without fear.','Donate to dispel the darkness of fear.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(47,0,'Girls have the power to shape the world. Let\'s give them the tools.','Champion their potential with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(48,0,'Preventing girl child abuse is our shared responsibility.','Join the campaign by donating today.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(49,0,'Kindness is a currency we can use to invest in our girls\' future.','Support our mission with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(50,0,'A girl\'s dreams should never be limited by fear. Let\'s break the chains.','Advocate for their well-being with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(51,0,'Every girl deserves a chance to thrive. Let\'s provide that chance.','Your support can change lives.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(52,0,'Girls are the architects of change; let\'s build a better world together.','Donate to be part of this construction.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(53,0,'The safety of girls is the strength of the world.','Champion the cause with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(54,0,'No child should ever endure the torment of abuse.','Your support can bring relief.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(55,0,'Girls are strong, but they deserve a life free from fear.','Advocate for their safety with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(56,0,'Every girl\'s life is a story of potential. Let\'s write a bright one.','Join our campaign and donate today.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(57,0,'Love, protect, and empower the girls of our world.','Your donation can be a guiding light.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(58,0,'A girl\'s potential knows no bounds. Let\'s unlock it.','Be the key with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(59,0,'Girls are like flowers; they deserve to bloom in safety.','Advocate for their well-being with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(60,0,'Girls are the foundation of a peaceful world. Protect their future.','Donate to end girl child abuse.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(61,0,'A world without girl child abuse is a world filled with dreams.','Your support makes dreams come true.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(62,0,'Empower girls to be the change-makers of tomorrow.','Champion their potential with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(63,0,'Every girl\'s life is a masterpiece waiting to be painted with love.','Advocate for their well-being with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(64,0,'Girls are the stars of hope in our world. Let\'s keep them shining.','Donate to light up their futures.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(65,0,'A safer world for girls is a safer world for everyone.','Your support is a building block for a safer world.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(66,0,'No girl should endure the pain of abuse. Let\'s break the cycle.','Advocate for their safety with a donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(67,0,'Every girl is a beacon of hope. Let\'s guide them to a bright future.','Support our mission with your generosity.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220'),(68,0,'Girls are the architects of tomorrow\'s masterpiece. Protect their canvas.','Champion their dreams with your donation.','2024-04-03 15:22:23.759229',NULL,NULL,0,'2024-04-03 15:22:23.807220');
/*!40000 ALTER TABLE `contact_quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_subscription`
--

DROP TABLE IF EXISTS `contact_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_subscription` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `newsletter_name` varchar(100) NOT NULL,
  `contact_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_subscription_contact_id_c59dbea5_fk_contact_contact_id` (`contact_id`),
  CONSTRAINT `contact_subscription_contact_id_c59dbea5_fk_contact_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contact_contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_subscription`
--

LOCK TABLES `contact_subscription` WRITE;
/*!40000 ALTER TABLE `contact_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_subscription` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-02-25 23:04:19.451406','1','ContactInformation object (1)',1,'[{\"added\": {}}]',24,2),(2,'2024-02-25 23:04:41.996888','1','Address object (1)',1,'[{\"added\": {}}]',22,2),(3,'2024-02-25 23:05:17.108949','1','Organization object (1)',1,'[{\"added\": {}}]',28,2),(4,'2024-02-25 23:21:20.928878','1','Image 1 - ',1,'[{\"added\": {}}]',9,2),(5,'2024-02-25 23:21:47.564430','1','Organization object (1)',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',28,2),(6,'2024-02-25 23:22:19.829998','1','Organization object (1)',2,'[]',28,2),(7,'2024-02-25 23:23:44.860958','1','Image 1 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,2),(8,'2024-02-25 23:48:42.276095','1','<p>Our partners have supported many of our projects</p>',1,'[{\"added\": {}}]',7,2),(9,'2024-02-26 04:18:19.434900','2','Image 2 - ',1,'[{\"added\": {}}]',9,2),(10,'2024-02-26 04:18:44.677660','2','Image 2 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,2),(11,'2024-02-26 04:20:40.899690','1','Image 1 - ',3,'',9,2),(12,'2024-02-26 04:30:40.962016','2','ContactInformation object (2)',1,'[{\"added\": {}}]',24,2),(13,'2024-02-26 04:31:06.897251','3','Image 3 - ',1,'[{\"added\": {}}]',9,2),(14,'2024-02-26 04:31:28.560431','2','Address object (2)',1,'[{\"added\": {}}]',22,2),(15,'2024-02-26 04:31:30.766988','2','Organization object (2)',1,'[{\"added\": {}}]',28,2),(16,'2024-02-29 16:06:08.809749','3','flo',1,'[{\"added\": {}}]',4,1),(17,'2024-02-29 16:08:22.035867','3','ContactInformation object (3)',1,'[{\"added\": {}}]',24,1),(18,'2024-02-29 16:08:37.061390','1','member: ',1,'[{\"added\": {}}]',12,1),(19,'2024-02-29 16:08:40.623747','1','member: ',2,'[]',12,1),(20,'2024-02-29 16:09:11.848354','4','Image 4 - ',1,'[{\"added\": {}}]',9,1),(21,'2024-02-29 16:09:15.610513','1','member: ',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',12,1),(22,'2024-02-29 20:02:50.270610','5','Image 5 - ',1,'[{\"added\": {}}]',9,1),(23,'2024-02-29 20:04:22.587419','1','member: ',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',12,1),(24,'2024-02-29 20:06:02.899003','6','Image 6 - ',1,'[{\"added\": {}}]',9,1),(25,'2024-02-29 20:06:09.931322','1','member: ',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',12,1),(26,'2024-02-29 20:18:22.061198','5','Image 5 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(27,'2024-02-29 20:18:31.182960','2','Image 2 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(28,'2024-02-29 20:18:38.870487','6','Image 6 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(29,'2024-02-29 20:36:37.488764','6','Image 6 - Program Director',2,'[{\"changed\": {\"fields\": [\"Caption\"]}}]',9,1),(30,'2024-02-29 20:38:10.624969','3','flo',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\"]}}]',4,1),(31,'2024-02-29 20:38:51.774124','3','flo',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(32,'2024-02-29 21:23:58.226838','7','Image 7 - ',1,'[{\"added\": {}}]',9,1),(33,'2024-03-07 16:13:32.925852','1','Companies',1,'[{\"added\": {}}]',27,1),(34,'2024-03-07 16:13:46.766987','1','Companies',2,'[{\"changed\": {\"fields\": [\"Next step\"]}}]',27,1),(35,'2024-03-07 16:16:09.907594','1','Companies',2,'[]',27,1),(36,'2024-03-07 16:16:43.792917','2','NGOs',1,'[{\"added\": {}}]',27,1),(37,'2024-03-07 16:17:30.801930','2','NGOs',2,'[{\"changed\": {\"fields\": [\"Next step\"]}}]',27,1),(38,'2024-03-07 16:21:31.877516','1','Companies',2,'[]',27,1),(39,'2024-03-07 16:22:06.393013','3','Individual Donors',1,'[{\"added\": {}}]',27,1),(40,'2024-03-07 16:22:23.559568','4','Impact',1,'[{\"added\": {}}]',27,1),(41,'2024-03-07 16:22:34.704288','3','Individual Donors',2,'[{\"changed\": {\"fields\": [\"Next step\"]}}]',27,1),(42,'2024-03-07 16:22:44.603879','2','NGOs',2,'[{\"changed\": {\"fields\": [\"Next step\"]}}]',27,1),(43,'2024-03-07 16:23:03.830582','4','Impact',2,'[{\"changed\": {\"fields\": [\"Next step\"]}}]',27,1),(44,'2024-03-07 16:23:14.922757','2','NGOs',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',27,1),(45,'2024-03-07 16:28:57.592879','1','<p>Our partners have supported many of our projects</p>',2,'[]',7,1),(46,'2024-03-07 16:31:17.608505','2','<p>We have several programs.</p>',1,'[{\"added\": {}}]',7,1),(47,'2024-03-07 16:33:26.616713','1','Safe Space',1,'[{\"added\": {}}]',29,1),(48,'2024-03-07 16:34:24.400408','1','Safe Space',2,'[]',29,1),(49,'2024-03-07 16:47:37.408206','8','Image 8 - Community Outreach',1,'[{\"added\": {}}]',9,1),(50,'2024-03-07 16:50:49.343391','1','community Outreach',1,'[{\"added\": {}}]',30,1),(51,'2024-03-07 16:59:03.630730','9','Image 9 - partner logo',1,'[{\"added\": {}}]',9,1),(52,'2024-03-07 16:59:42.476545','3','Address object (3)',1,'[{\"added\": {}}]',22,1),(53,'2024-03-07 17:00:27.640332','4','ContactInformation object (4)',1,'[{\"added\": {}}]',24,1),(54,'2024-03-07 17:00:57.521827','1','Partner: Hand in Hand Kenya',1,'[{\"added\": {}}]',13,1),(55,'2024-03-07 17:06:35.275556','10','Image 10 - d',1,'[{\"added\": {}}]',9,1),(56,'2024-03-07 17:07:23.960312','2','member: Douglas',1,'[{\"added\": {}}]',12,1),(57,'2024-03-08 20:28:32.522633','6','Image 6 - Program Director',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(58,'2024-03-08 20:35:49.163949','7','Image 7 - Beautiful scars',2,'[{\"changed\": {\"fields\": [\"Caption\"]}}]',9,1),(59,'2024-03-08 20:49:48.526471','15','Image 15 - Beautiful scars',1,'[{\"added\": {}}]',9,1),(60,'2024-03-08 20:50:39.574309','16','Image 16 - Brilliant Girls',1,'[{\"added\": {}}]',9,1),(61,'2024-03-08 20:50:53.397974','8','Image 8 - Community Outreach',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(62,'2024-03-08 20:50:59.753794','7','Image 7 - Beautiful scars',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(63,'2024-03-17 07:00:18.841852','4','Impact',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',27,1),(64,'2024-03-17 07:01:20.156711','2','NGOs',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',27,1),(65,'2024-03-17 07:02:09.998122','1','Companies',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',27,1),(66,'2024-03-17 07:02:58.401839','3','Individual Donors',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',27,1),(67,'2024-03-18 15:49:22.037389','1','Partner: Hand in Hand Kenya',2,'[]',13,1),(68,'2024-03-18 16:35:03.152868','3','<p>fugfufyu</p>',1,'[{\"added\": {}}]',7,1),(69,'2024-03-18 16:36:06.068173','3','<p>fugfufyu</p>',2,'[{\"changed\": {\"fields\": [\"Is verified\"]}}]',7,1),(70,'2024-03-18 16:36:51.218132','3','<p>About Maisha</p>',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(71,'2024-03-26 11:31:42.094026','17','Image 17 - Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',1,'[{\"added\": {}}]',9,1),(72,'2024-03-26 11:42:06.935067','4','ContactInformation object (4)',2,'[]',24,1),(73,'2024-03-26 11:44:19.930996','2','Address object (2)',2,'[{\"changed\": {\"fields\": [\"State\", \"Postal code\"]}}]',22,1),(74,'2024-03-26 11:50:13.422254','1','Safe Space',2,'[{\"changed\": {\"fields\": [\"Description\", \"End date\"]}}]',29,1),(75,'2024-03-26 11:50:42.306836','1','Safe Space',2,'[]',29,1),(76,'2024-03-26 11:51:33.661465','1','Safe Space',2,'[{\"changed\": {\"fields\": [\"End date\"]}}]',29,1),(77,'2024-03-26 11:51:55.349247','1','Safe Space',2,'[{\"changed\": {\"fields\": [\"End date\"]}}]',29,1),(78,'2024-03-26 11:55:58.851443','8','Image 8 - Community Outreach',2,'[{\"changed\": {\"fields\": [\"Image File\"]}}]',9,1),(79,'2024-03-26 11:56:48.834657','18','Image 18 - ',1,'[{\"added\": {}}]',9,1),(80,'2024-03-26 11:57:27.027391','18','Image 18 - ',2,'[{\"changed\": {\"fields\": [\"Image File\"]}}]',9,1),(81,'2024-03-26 11:59:15.463164','1','Urban farming',2,'[{\"changed\": {\"fields\": [\"Title\", \"Description\"]}}]',30,1),(82,'2024-03-26 11:59:36.094569','1','Urban farming',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',30,1),(83,'2024-03-26 12:03:33.635299','19','Image 19 - ',1,'[{\"added\": {}}]',9,1),(84,'2024-03-26 12:03:43.031521','2','Homework club',1,'[{\"added\": {}}]',30,1),(85,'2024-03-26 12:06:01.259765','1','Urban farming',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',30,1),(86,'2024-03-26 12:28:19.733236','2','Organization object (2)',2,'[{\"changed\": {\"fields\": [\"Vision\", \"Values\"]}}]',28,1),(87,'2024-03-26 12:35:21.142295','20','Image 20 - ',1,'[{\"added\": {}}]',9,1),(88,'2024-03-26 12:37:33.977688','1','Partner: Hand in Hand Kenya',2,'[]',13,1),(89,'2024-03-26 12:38:21.375436','2','Partner: United Nations Trust Fund',1,'[{\"added\": {}}]',13,1),(90,'2024-03-26 12:39:30.705567','2','Partner: United Nations Trust Fund',3,'',13,1),(91,'2024-03-26 12:40:47.237222','20','Image 20 - ',3,'',9,1),(92,'2024-03-26 13:20:41.587177','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving and protecting girls in the m',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(93,'2024-03-26 13:22:16.490623','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reach',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(94,'2024-03-26 13:23:36.293406','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving and protecting girls in the m',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(95,'2024-03-26 13:24:27.295184','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving and protecti',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(96,'2024-03-26 13:25:42.697084','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving and protecti',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(97,'2024-03-26 13:38:42.533082','2','Homework club',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',30,1),(98,'2024-03-26 19:46:37.865779','3','<p><strong><span style=\"background-color:#e74c3c\">About Maisha</span></strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works t',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(99,'2024-03-26 19:48:06.416697','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving and protecting girls in the m',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(100,'2024-03-26 19:49:15.711380','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p>Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving and protecting girls in the m',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(101,'2024-03-26 19:57:12.494518','2','Homework club',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',30,1),(102,'2024-03-26 19:59:26.007127','2','Homework club',2,'[]',30,1),(103,'2024-03-26 19:59:52.552145','19','Image 19 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(104,'2024-03-26 20:01:07.839466','19','Image 19 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(105,'2024-03-27 06:47:49.951058','68','Girls are the architects of tomorrow\'s masterpiece. Protect their canvas.',2,'[]',25,1),(106,'2024-03-27 08:31:58.789625','3','h',1,'[{\"added\": {}}]',30,1),(107,'2024-03-27 08:32:04.356651','3','h',2,'[{\"changed\": {\"fields\": [\"Soft deleted\"]}}]',30,1),(108,'2024-03-27 21:20:54.589933','23','Image 23 - ',1,'[{\"added\": {}}]',9,1),(109,'2024-03-27 21:23:40.539353','23','Image 23 - ',3,'',9,1),(110,'2024-03-27 21:24:07.810722','24','Image 24 - ',1,'[{\"added\": {}}]',9,1),(111,'2024-03-27 21:24:07.982521','25','Image 25 - ',1,'[{\"added\": {}}]',9,1),(112,'2024-03-27 21:25:21.874963','1','Temporary Shelter',1,'[{\"added\": {}}]',31,1),(113,'2024-03-28 05:34:21.075553','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p style=\"text-align:justify\">Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving an',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(114,'2024-03-28 05:39:46.737374','7','Image 7 - Beautiful scars',3,'',9,1),(115,'2024-03-28 05:45:10.106391','2','Homework club',2,'[]',30,1),(116,'2024-03-28 05:45:14.411706','1','Urban farming',2,'[]',30,1),(117,'2024-03-28 06:39:58.273698','4','<h4>We consider these services the foundation to freedom and support for living a fulfilled life:</h4>',1,'[{\"added\": {}}]',7,1),(118,'2024-03-28 06:46:20.750499','4','<h4>We consider these services the foundation to freedom and support for living a fulfilled life:</h4>',2,'[]',7,1),(119,'2024-03-28 06:46:33.562046','4','<h4>We consider these services the foundation to freedom and support for living a fulfilled life:</h4>',2,'[{\"changed\": {\"fields\": [\"Is verified\"]}}]',7,1),(120,'2024-03-28 06:47:54.937851','4','<p>We consider these services the foundation to freedom and support for living a fulfilled life:</p>',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(121,'2024-03-28 06:48:45.528317','4','<p>We consider these services the foundation to freedom and support for living a fulfilled life:</p>',2,'[]',7,1),(122,'2024-03-28 07:10:31.139887','4','<p>We consider these services the foundation to freedom and support for living a fulfilled life:</p>',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',7,1),(123,'2024-03-28 07:35:58.101945','2','<p>We have several programs.</p>',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',7,1),(124,'2024-03-28 07:41:55.009044','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p style=\"text-align:justify\">Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving an',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',7,1),(125,'2024-03-28 07:41:55.495429','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p style=\"text-align:justify\">Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving an',2,'[]',7,1),(126,'2024-03-28 08:48:25.565071','15','Image 15 - Beautiful scars',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(127,'2024-03-28 08:53:09.039377','26','Image 26 - Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',1,'[{\"added\": {}}]',9,1),(128,'2024-03-28 09:06:34.987237','29','Image 29 - Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',1,'[{\"added\": {}}]',9,1),(129,'2024-03-28 09:08:59.227088','15','Image 15 - Beautiful scars',2,'[]',9,1),(130,'2024-03-28 09:09:05.926103','16','Image 16 - Brilliant Girls',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(131,'2024-03-28 09:10:15.654588','26','Image 26 - Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(132,'2024-03-28 09:10:52.409479','16','Image 16 - Brilliant Girls',3,'',9,1),(133,'2024-03-28 09:15:14.084586','30','Image 30 - ',1,'[{\"added\": {}}]',9,1),(134,'2024-03-28 09:18:45.726012','5','ContactInformation object (5)',1,'[{\"added\": {}}]',24,1),(135,'2024-03-28 09:18:48.041586','3','Partner: United Nations Trust Fund',1,'[{\"added\": {}}]',13,1),(136,'2024-03-28 09:21:07.420998','31','Image 31 - ',1,'[{\"added\": {}}]',9,1),(137,'2024-03-28 09:21:11.659322','3','Partner: United Nations Trust Fund',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',13,1),(138,'2024-03-28 09:22:30.601434','3','Partner: United Nations Trust Fund',2,'[]',13,1),(139,'2024-03-28 09:23:43.698264','32','Image 32 - ',1,'[{\"added\": {}}]',9,1),(140,'2024-03-28 09:25:17.698102','6','ContactInformation object (6)',1,'[{\"added\": {}}]',24,1),(141,'2024-03-28 09:25:19.866254','4','Partner: French Embassy',1,'[{\"added\": {}}]',13,1),(142,'2024-03-28 09:27:21.108933','33','Image 33 - ',1,'[{\"added\": {}}]',9,1),(143,'2024-03-28 09:28:51.775373','7','ContactInformation object (7)',1,'[{\"added\": {}}]',24,1),(144,'2024-03-28 09:28:53.442053','5','Partner: freedom fund',1,'[{\"added\": {}}]',13,1),(145,'2024-03-28 09:29:21.323235','5','Partner: freedom fund',2,'[]',13,1),(146,'2024-03-28 09:29:26.622967','4','Partner: French Embassy',2,'[]',13,1),(147,'2024-03-28 09:36:10.505267','4','Partner: French Embassy',2,'[]',13,1),(148,'2024-03-28 09:36:47.143403','4','Partner: French Embassy',2,'[]',13,1),(149,'2024-03-28 09:36:54.743702','5','Partner: freedom fund',2,'[]',13,1),(150,'2024-03-28 11:10:03.330417','4','Partner: French Embassy',3,'',13,1),(151,'2024-03-28 11:10:55.640668','8','ContactInformation object (8)',1,'[{\"added\": {}}]',24,1),(152,'2024-03-28 11:11:02.630407','6','Partner: French Embassy',1,'[{\"added\": {}}]',13,1),(153,'2024-03-28 11:20:13.353164','34','Image 34 - ',1,'[{\"added\": {}}]',9,1),(154,'2024-03-28 11:22:59.578835','1','Temporary Shelter',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',31,1),(155,'2024-03-28 11:24:29.683223','35','Image 35 - ',1,'[{\"added\": {}}]',9,1),(156,'2024-03-28 11:24:32.299273','1','Temporary Shelter',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',31,1),(157,'2024-03-28 11:24:51.648670','34','Image 34 - ',3,'',9,1),(158,'2024-03-28 11:25:10.856234','35','Image 35 - ',2,'[]',9,1),(159,'2024-03-28 11:25:13.025975','35','Image 35 - ',2,'[]',9,1),(160,'2024-03-28 11:28:28.055471','35','Image 35 - ',2,'[]',9,1),(161,'2024-03-28 11:28:56.951236','1','Temporary Shelter',2,'[]',31,1),(162,'2024-03-28 11:42:54.412950','36','Image 36 - ',1,'[{\"added\": {}}]',9,1),(163,'2024-03-28 11:42:56.615029','2','Psycho-social support',1,'[{\"added\": {}}]',31,1),(164,'2024-03-28 11:44:23.704344','2','Psycho-social support',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',31,1),(165,'2024-03-28 12:07:58.385542','37','Image 37 - ',1,'[{\"added\": {}}]',9,1),(166,'2024-03-28 12:08:01.190846','3','Educational support & opportunities',1,'[{\"added\": {}}]',31,1),(167,'2024-03-28 12:08:56.197514','3','Educational support & opportunities',2,'[]',31,1),(168,'2024-03-28 13:20:56.552237','3','Educational support & opportunities',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',31,1),(169,'2024-03-28 13:43:19.761555','38','Image 38 - ',1,'[{\"added\": {}}]',9,1),(170,'2024-03-28 13:43:45.818486','4','Health care referrals',1,'[{\"added\": {}}]',31,1),(171,'2024-03-28 14:07:20.925536','2','Psycho-social support',2,'[]',31,1),(172,'2024-03-28 14:07:58.429928','39','Image 39 - ',1,'[{\"added\": {}}]',9,1),(173,'2024-03-28 14:08:00.565409','3','Educational support & opportunities',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',31,1),(174,'2024-03-28 14:50:45.054661','40','Image 40 - ',1,'[{\"added\": {}}]',9,1),(175,'2024-03-28 14:50:48.236773','5','Family Reintegration',1,'[{\"added\": {}}]',31,1),(176,'2024-03-28 15:45:05.691086','1','Temporary Shelter',2,'[]',31,1),(177,'2024-03-31 20:58:51.325992','8','ContactInformation object (8)',2,'[{\"changed\": {\"fields\": [\"Website\"]}}]',24,1),(178,'2024-04-02 06:23:23.797770','5','Family Reintegration',2,'[]',31,1),(179,'2024-04-02 06:26:39.471607','5','Family Reintegration',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',31,1),(180,'2024-04-02 06:35:03.270112','4','<ul>\r\n	<li style=\"text-align: justify;\">We consider these services the foundation to freedom and support for living a fulfilled life:</li>\r\n	<li style=\"text-align: justify;\">Safety &amp; Basic Care - ',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(181,'2024-04-02 06:36:19.206869','4','<p style=\"text-align:justify\">&nbsp;</p>\r\n\r\n<p style=\"text-align:justify\"><strong><span style=\"font-size:48px\">We consider these services the foundation to freedom and support for living a fulfilled l',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(182,'2024-04-02 06:45:22.819867','4','<p style=\"text-align:justify\">&nbsp;</p>\r\n\r\n<p style=\"text-align:justify\"><strong><span style=\"font-size:48px\">We consider these services the foundation to freedom and support for living a fulfilled l',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(183,'2024-04-02 06:45:33.516034','4','<p style=\"text-align:justify\">&nbsp;</p>\r\n\r\n<p style=\"text-align:justify\"><strong><span style=\"font-size:48px\">We consider these services the foundation to freedom and support for living a fulfilled l',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(184,'2024-04-02 06:45:59.248593','4','<p style=\"text-align:justify\">&nbsp;</p>\r\n\r\n<p style=\"text-align:justify\"><strong><span style=\"font-size:48px\">We consider these services the foundation to freedom and support for living a fulfilled l',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(185,'2024-04-02 07:18:17.319226','2','member: Douglas',3,'',12,1),(186,'2024-04-02 07:22:11.455381','41','Image 41 - ',1,'[{\"added\": {}}]',9,1),(187,'2024-04-02 07:22:27.128922','1','member: Flo',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',12,1),(188,'2024-04-02 07:23:16.479986','1','member: Flo',2,'[]',12,1),(189,'2024-04-02 07:23:16.582348','1','member: Flo',2,'[]',12,1),(190,'2024-04-02 07:26:50.187842','42','Image 42 - ',1,'[{\"added\": {}}]',9,1),(191,'2024-04-02 07:26:53.908362','1','member: Flo',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',12,1),(192,'2024-04-02 07:35:54.957617','1','member: Flo',2,'[]',12,1),(193,'2024-04-02 07:42:09.569359','4','YvonneNjoka',1,'[{\"added\": {}}]',4,1),(194,'2024-04-02 07:49:55.227964','43','Image 43 - ',1,'[{\"added\": {}}]',9,1),(195,'2024-04-02 07:50:02.183446','44','Image 44 - ',1,'[{\"added\": {}}]',9,1),(196,'2024-04-02 07:52:07.457074','9','ContactInformation object (9)',1,'[{\"added\": {}}]',24,1),(197,'2024-04-02 07:59:26.994279','3','member: ',1,'[{\"added\": {}}]',12,1),(198,'2024-04-02 08:00:30.614516','3','member: ',3,'',12,1),(199,'2024-04-02 08:09:22.180127','5','AbrahamLiona',1,'[{\"added\": {}}]',4,1),(200,'2024-04-02 08:16:16.070974','46','Image 46 - ',1,'[{\"added\": {}}]',9,1),(201,'2024-04-03 09:45:55.428484','47','Image 47 - ',1,'[{\"added\": {}}]',9,1),(202,'2024-04-03 09:45:59.705382','2','<p>We have several programs with the aim of providing comprehensive support to survivors of sexual violence and individuals within our communities. These programs include the safe space, safe house, c',2,'[{\"changed\": {\"fields\": [\"content\", \"Image\"]}}]',7,1),(203,'2024-04-03 09:48:46.088672','2','<p style=\"text-align:justify\">We have several programs with the aim of providing comprehensive support to survivors of sexual violence and individuals within our communities. These programs include th',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(204,'2024-04-03 09:52:59.289202','2','<p>We have several programs with the aim of providing comprehensive support</p>\r\n\r\n<p>to survivors of sexual violence and individuals within our communities. These</p>\r\n\r\n<p>programs include the safe ',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(205,'2024-04-03 09:53:36.497425','2','<p>We have several programs with the aim of providing comprehensive support to survivors of sexual violence and individuals within our communities. These programs include the safe space, safe house, c',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(206,'2024-04-03 11:08:54.177693','2','Safe House',1,'[{\"added\": {}}]',29,1),(207,'2024-04-03 11:25:52.073927','2','Safe House',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',29,1),(208,'2024-04-03 11:27:21.811643','2','Safe House',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',29,1),(209,'2024-04-03 11:48:16.654787','1','Safe Space',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',29,1),(210,'2024-04-03 11:51:20.021600','2','Safe House',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',29,1),(211,'2024-04-03 11:55:50.605930','2','Safe House',2,'[]',29,1),(212,'2024-04-03 12:20:34.382849','3','Education',1,'[{\"added\": {}}]',29,1),(213,'2024-04-03 12:31:58.186976','4','Community Outreach',1,'[{\"added\": {}}]',29,1),(214,'2024-04-04 04:36:33.372254','3','<p><strong>About Maisha</strong></p>\r\n\r\n<p style=\"text-align:justify\">Maisha Girls Safe House Maisha (MGSH) is a Non &ndash; Governmental Organization, that works towards reaching out to, receiving an',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',7,1),(215,'2024-04-04 04:37:47.271371','2','<p>We have several programs with the aim of providing comprehensive support to survivors of sexual violence and individuals within our communities. These programs include the safe space, safe house, c',3,'',7,1),(216,'2024-04-04 04:41:16.970456','4','<h3 style=\"text-align:justify\">We consider these services the foundation to freedom and support for living a fulfilled life:</h3>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Safety &amp; Basic Care - Shelter, food, clothing ',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',7,1),(217,'2024-04-04 04:41:48.317252','5','<p>We have several programs with the aim of providing comprehensive support to survivors of sexual violence and individuals within our communities. These programs include the safe space, safe house, c',1,'[{\"added\": {}}]',7,1),(218,'2024-04-04 04:42:11.172713','4','<h3 style=\"text-align:justify\">We consider these services the foundation to freedom and support for living a fulfilled life:</h3>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Safety &amp; Basic Care - Shelter, food, clothing ',3,'',7,1),(219,'2024-04-04 04:42:54.739601','6','<h3><strong>We consider these services the foundation to freedom and support for living a fulfilled life:</strong></h3>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Safety &amp; Basic Care - Shelter, food, clothing and protec',1,'[{\"added\": {}}]',7,1),(220,'2024-04-04 04:43:05.263509','6','<h3><strong>We consider these services the foundation to freedom and support for living a fulfilled life:</strong></h3>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Safety &amp; Basic Care - Shelter, food, clothing and protec',2,'[{\"changed\": {\"fields\": [\"Is verified\"]}}]',7,1),(221,'2024-04-04 04:44:58.944133','6','<h3><strong>We consider these services the foundation to freedom and support for living a fulfilled life:</strong></h3>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Safety &amp; Basic Care - Shelter, food, clothing and protec',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',7,1),(222,'2024-04-04 04:45:12.418481','5','<p>We have several programs with the aim of providing comprehensive support to survivors of sexual violence and individuals within our communities. These programs include the safe space, safe house, c',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',7,1),(223,'2024-04-04 06:08:38.393497','48','Image 48 - ',1,'[{\"added\": {}}]',9,1),(224,'2024-04-06 08:06:17.925477','48','Image 48 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(225,'2024-04-06 08:31:54.567469','48','Image 48 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(226,'2024-04-06 18:45:47.673239','48','Image 48 - ',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1),(227,'2024-04-06 18:59:42.129841','17','Image 17 - Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',2,'[{\"changed\": {\"fields\": [\"Featured\"]}}]',9,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'about','about'),(8,'about','aboutrelationship'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(17,'blog','blog'),(14,'blog','category'),(16,'blog','subscription'),(15,'blog','tag'),(18,'comments','comment'),(22,'contact','address'),(23,'contact','contact'),(24,'contact','contactinformation'),(28,'contact','organization'),(27,'contact','organizationstep'),(25,'contact','quote'),(26,'contact','subscription'),(5,'contenttypes','contenttype'),(11,'media','document'),(32,'media','icon'),(9,'media','image'),(10,'media','video'),(21,'mpesa','paymenttransaction'),(20,'mpesa','wallet'),(13,'partnership','partner'),(12,'partnership','teammember'),(30,'programs','activity'),(29,'programs','program'),(31,'programs','service'),(6,'sessions','session'),(33,'trash','trash'),(19,'trash','trashitem');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
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
INSERT INTO `django_session` VALUES ('2dgjjqimpmsteag268q203xc979ts0ec','.eJxVjEEOwiAQAP_C2RBYoIBH730DWViQqqFJaU_GvxuSHvQ6M5k3C3jsNRw9b2EhdmWSXX5ZxPTMbQh6YLuvPK1t35bIR8JP2_m8Un7dzvZvULHXsZ2k0cZHEBoSKbJFEticfClO-CKEcUpRAU8kYlQpTwikLSAm5Qg0-3wB1Kg39g:1rpag9:u77MUR4-H1jx2b99NIVPPLNI_XGmnH9_t9vBULOGZPw','2024-04-10 21:19:25.687303'),('3a79rsd011sby17y2f84xuvqkopl8m4b','.eJxVjMEOwiAQRP-FsyFlCwgevfsNZFlYqRpISnsy_rtt0oNmbvPezFsEXJcS1p7nMCVxESBOv11Eeua6g_TAem-SWl3mKcpdkQft8tZSfl0P9--gYC_bmpmtUSMon8Yh5azZaW-ATQTHHgaNChQAgXWeskJGu2XUZNyZkiLx-QLbJjfP:1rs6bY:awvONfBznnvjvXgco0r-hnx7rTjHHkpfpsRfX0Ue5Lg','2024-04-17 19:49:04.016849'),('4v0pmrg7uwwb4jbf9be1q69odfnt7zx9','.eJxVjMEOwiAQRP-FsyFlCwgevfsNZFlYqRpISnsy_rtt0oNmbvPezFsEXJcS1p7nMCVxESBOv11Eeua6g_TAem-SWl3mKcpdkQft8tZSfl0P9--gYC_bmpmtUSMon8Yh5azZaW-ATQTHHgaNChQAgXWeskJGu2XUZNyZkiLx-QLbJjfP:1reNyY:m-Vc9PWeYuthf_xmudi2bcOcm8Tl5F_OvUaFIPyvNZI','2024-03-10 23:32:06.371620'),('51sc13fotp2gzhyu4aw7bfzlqj5o5vjm','.eJxVjEEOwiAQAP_C2RBYoIBH730DWViQqqFJaU_GvxuSHvQ6M5k3C3jsNRw9b2EhdmWSXX5ZxPTMbQh6YLuvPK1t35bIR8JP2_m8Un7dzvZvULHXsZ2k0cZHEBoSKbJFEticfClO-CKEcUpRAU8kYlQpTwikLSAm5Qg0-3wB1Kg39g:1rhETf:47Am2WIwEsXUp6vTjZgWTLyM8vcaMbTqnySmahPrCRU','2024-03-18 19:59:59.309517'),('7fl5rh4lt2ejugxip6y28nsfioninret','.eJxVjEEOwiAQAP_C2RBYoIBH730DWViQqqFJaU_GvxuSHvQ6M5k3C3jsNRw9b2EhdmWSXX5ZxPTMbQh6YLuvPK1t35bIR8JP2_m8Un7dzvZvULHXsZ2k0cZHEBoSKbJFEticfClO-CKEcUpRAU8kYlQpTwikLSAm5Qg0-3wB1Kg39g:1reqoA:9D2X0MQG2iVkZ6yNhF-yH9lsByIxyLNs7inpvm0njE0','2024-03-12 06:19:18.420666'),('7vz0ske13mzvxcyawznosat8zxv0iepo','.eJxVjEEOwiAQAP_C2RBYoIBH730DWViQqqFJaU_GvxuSHvQ6M5k3C3jsNRw9b2EhdmWSXX5ZxPTMbQh6YLuvPK1t35bIR8JP2_m8Un7dzvZvULHXsZ2k0cZHEBoSKbJFEticfClO-CKEcUpRAU8kYlQpTwikLSAm5Qg0-3wB1Kg39g:1rp4rR:Q-2OOGop9gaDjOGpk0zdqKsxLG_Cf-PNYrFZQAT2ufU','2024-04-09 11:20:57.485387'),('hyjfhktc2s88dxssm9myhwodzwpsecfy','.eJxVjEEOwiAQAP_C2RBYoIBH730DWViQqqFJaU_GvxuSHvQ6M5k3C3jsNRw9b2EhdmWSXX5ZxPTMbQh6YLuvPK1t35bIR8JP2_m8Un7dzvZvULHXsZ2k0cZHEBoSKbJFEticfClO-CKEcUpRAU8kYlQpTwikLSAm5Qg0-3wB1Kg39g:1rt2fF:eXfuBtixLppVYC_zZs47dHKdG8Np5uhpSig0dk9iQZU','2024-04-20 09:48:45.010341'),('j2kqzqhe4m0lefuhndq2ck2ha6dp1u3b','.eJxVjEEOwiAQAP_C2RBYoIBH730DWViQqqFJaU_GvxuSHvQ6M5k3C3jsNRw9b2EhdmWSXX5ZxPTMbQh6YLuvPK1t35bIR8JP2_m8Un7dzvZvULHXsZ2k0cZHEBoSKbJFEticfClO-CKEcUpRAU8kYlQpTwikLSAm5Qg0-3wB1Kg39g:1rp8Yj:8jfs11XQab8PQT08cpiRQcTxFcehoUK8wIC3cYiy3IQ','2024-04-09 15:17:53.982251'),('lzfipa2yms4ueuu1v3ovrxc3bk02helx','.eJxVjMEOwiAQRP-FsyFlCwgevfsNZFlYqRpISnsy_rtt0oNmbvPezFsEXJcS1p7nMCVxESBOv11Eeua6g_TAem-SWl3mKcpdkQft8tZSfl0P9--gYC_bmpmtUSMon8Yh5azZaW-ATQTHHgaNChQAgXWeskJGu2XUZNyZkiLx-QLbJjfP:1reOHD:aUZIEi3BI2I8EmZ9GRhoS7aRsrKQ8VB_nkVjw1tAJb0','2024-03-10 23:51:23.028371'),('zlxta0nj2ct1ro0nwfb1kajsgfnsvwjv','.eJxVjEEOwiAQAP_C2RBYoIBH730DWViQqqFJaU_GvxuSHvQ6M5k3C3jsNRw9b2EhdmWSXX5ZxPTMbQh6YLuvPK1t35bIR8JP2_m8Un7dzvZvULHXsZ2k0cZHEBoSKbJFEticfClO-CKEcUpRAU8kYlQpTwikLSAm5Qg0-3wB1Kg39g:1rsIVf:uSG1EX-FGaQ_R8_d7bkgsfRJijbqHgWsn11PK4x2jW8','2024-04-18 08:31:47.841920');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_document`
--

DROP TABLE IF EXISTS `media_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) DEFAULT NULL,
  `object_id` int unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_orphan` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `media_document_content_type_id_59691458_fk_django_co` (`content_type_id`),
  CONSTRAINT `media_document_content_type_id_59691458_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `media_document_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_document`
--

LOCK TABLES `media_document` WRITE;
/*!40000 ALTER TABLE `media_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_icon`
--

DROP TABLE IF EXISTS `media_icon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_icon` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `object_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_orphan` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `media_icon_content_type_id_3e966730_fk_django_content_type_id` (`content_type_id`),
  CONSTRAINT `media_icon_content_type_id_3e966730_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `media_icon_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_icon`
--

LOCK TABLES `media_icon` WRITE;
/*!40000 ALTER TABLE `media_icon` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_icon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_image`
--

DROP TABLE IF EXISTS `media_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) DEFAULT NULL,
  `object_id` int unsigned NOT NULL,
  `caption` varchar(255) NOT NULL,
  `featured` tinyint(1) NOT NULL,
  `content_type_id` int NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `resize_mode` varchar(10) NOT NULL,
  `versions` json DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_orphan` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `media_image_content_type_id_9ea96aba_fk_django_content_type_id` (`content_type_id`),
  CONSTRAINT `media_image_content_type_id_9ea96aba_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `media_image_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_image`
--

LOCK TABLES `media_image` WRITE;
/*!40000 ALTER TABLE `media_image` DISABLE KEYS */;
INSERT INTO `media_image` VALUES (2,'uploads/images/Screenshot_2024-01-30_062208.png',1,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/79d2f498-e2e9-4080-9517-189aedaa3439.png\", \"medium\": \"/media/uploads/images/versions/medium/a227e44c-6381-453d-b32b-7bb1468f4348.png\", \"social\": \"/media/uploads/images/versions/social/52633905-41c0-4d7b-b291-9d3dcbea3343.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/9348e042-3ec2-4208-98a1-67f1e67b0900.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(3,'uploads/images/Screenshot_2024-02-03_160640.png',1,'',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/e5a5ad7d-c87e-435e-a3fe-484648421c8c.png\", \"medium\": \"/media/uploads/images/versions/medium/8688b8ee-3829-455f-9c4d-863db48a0d4e.png\", \"social\": \"/media/uploads/images/versions/social/d9cd9a6e-0903-44a0-a735-e5f3f714f288.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/fe849a4b-2353-4055-803a-aa7cc67f007b.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(4,'uploads/images/ceo.webp',1,'',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/cc73906a-bc5f-41d8-ac67-7e55bb770e5a.png\", \"medium\": \"/media/uploads/images/versions/medium/fcffe47d-f734-48fe-b953-84367eecdadd.png\", \"social\": \"/media/uploads/images/versions/social/9702277a-3c9d-40e5-9660-ede47881366f.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/a9b12461-c4c6-4a9b-832f-699ac7f4a73d.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(5,'uploads/images/ceo_cfGm8eN.webp',1,'',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/a0f18f4e-1291-4e90-a8d4-4d7432d9098a.png\", \"medium\": \"/media/uploads/images/versions/medium/bcd77827-08b0-49a6-a092-02afdaa6a472.png\", \"social\": \"/media/uploads/images/versions/social/0a676332-4b7e-4063-9238-901adfa7dd2d.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/09be6471-d52e-4700-8b5f-c154c840de65.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(6,'uploads/images/ceo_dNG7VUW.webp',9,'Program Director',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/0e63bd63-3a7b-4793-9bf0-2d3d61f66a07.png\", \"medium\": \"/media/uploads/images/versions/medium/3e63fb6c-794e-4249-b5f8-98941a82ce5b.png\", \"social\": \"/media/uploads/images/versions/social/b3a3daa8-64db-4286-9c5b-a958c27b2216.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/20fb67a4-0e66-4892-97c5-1e988793d6a0.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(8,'uploads/images/Picture111.png',1,'Community Outreach',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/b007fac4-6edc-4c23-813a-fa75ad322183.png\", \"medium\": \"/media/uploads/images/versions/medium/fcdbffba-470c-469a-89c9-6aa00d54aba8.png\", \"social\": \"/media/uploads/images/versions/social/4c0c9aae-6837-4a52-8f10-163feb0015cf.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/339d3fa8-4b3f-4e56-bb1d-4e094294be7a.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(9,'uploads/images/hand-in-hand.jpg',1,'partner logo',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/0d95fe6d-b86e-4c5a-90f7-2d0b7e6555ac.png\", \"medium\": \"/media/uploads/images/versions/medium/808ac1f6-1f2a-4b6e-af54-67714e00a527.png\", \"social\": \"/media/uploads/images/versions/social/883e63b1-02c1-4061-9cb8-576984207b9a.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/64798600-8d9b-40e5-9e2d-859399b9c5e8.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(10,'uploads/images/profile.png',1,'d',0,17,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/50668941-e48f-45b3-997d-817d67cad540.png\", \"medium\": \"/media/uploads/images/versions/medium/4c4b5e13-4077-4b65-b0b8-f15e61867a05.png\", \"social\": \"/media/uploads/images/versions/social/e25f60ef-52e1-4e3d-b745-54a4d5f059e8.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/86c5eaae-1262-4106-b945-dbb51d7012f7.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(15,'uploads/images/6_FKFJIep.jpg',1,'Beautiful scars',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/6a754f7c-1476-48dc-be4b-68391355e823.png\", \"medium\": \"/media/uploads/images/versions/medium/3769027f-1db5-438b-8a44-23b0df3f06ff.png\", \"social\": \"/media/uploads/images/versions/social/c6d91c7b-91f4-4ac8-aea7-2768fedb879e.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/2c251493-8500-4671-a4a2-14c0e85f7cb3.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(16,'uploads/images/5_HyeIPIK.jpg',1,'Brilliant Girls',0,30,1,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/5e17b703-000f-4619-bd82-fd43fd47a84f.png\", \"medium\": \"/media/uploads/images/versions/medium/277e6f37-ed25-4f01-a41d-3bc33888bf70.png\", \"social\": \"/media/uploads/images/versions/social/c915a366-d64d-4e6e-a757-54f8a63e455b.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/c8f21d2c-3d71-493c-811b-0b73390adc98.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(17,'uploads/images/website_pic.png',2,'Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/5e52713e-86f8-4325-95a2-29af8672b790.png\", \"medium\": \"/media/uploads/images/versions/medium/a79de231-6e92-41d3-8f5d-1c64c53bfe84.png\", \"social\": \"/media/uploads/images/versions/social/1046d86b-9c17-4646-b3f3-1da08955e452.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/845a9037-e0a1-457a-9d01-9bd0d518a5bf.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-06 18:59:42.127031',0),(18,'uploads/images/Picture111_xhBq5Po.png',2,'',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/4c61ec15-c839-4d3a-9720-4aee0f234186.png\", \"medium\": \"/media/uploads/images/versions/medium/57f911ea-d4c1-4033-8738-6271ab808d9f.png\", \"social\": \"/media/uploads/images/versions/social/318ebece-9dfd-488c-8734-1026fd79d410.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/1130ad15-e814-461b-8990-c1336ac37740.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(19,'uploads/images/Picture134.png',4,'',0,30,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/f8dba8ad-a85e-412a-b439-899536ede799.png\", \"medium\": \"/media/uploads/images/versions/medium/679e0e11-9ea5-4392-b6f6-eaf5d46a5446.png\", \"social\": \"/media/uploads/images/versions/social/b6c24794-fa64-445b-af61-6bff3009e55c.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/470b827e-3b72-4211-b04a-1b6886b4808e.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(23,'uploads/images/chrome.exe',1,'',0,31,1,'BICUBIC','{}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(24,'uploads/images/ceo_YcdzENr.webp',1,'',0,31,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/37d62a2e-c7b3-4876-b3f7-aee0758d4e22.png\", \"medium\": \"/media/uploads/images/versions/medium/1ae675bd-051f-4bb3-b549-0f42f2e1dd6f.png\", \"social\": \"/media/uploads/images/versions/social/4c024b8f-fd3e-42e6-8c1e-b05c5ca07ff8.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/b6208c62-9761-43aa-b1ab-91eac9a68e4b.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(25,'uploads/images/ceo_x81ZiGK.webp',1,'',0,31,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/11a69ef5-3e18-47e8-8c98-01db725a824d.png\", \"medium\": \"/media/uploads/images/versions/medium/261ad9e5-7937-45a4-8881-6511986cc00a.png\", \"social\": \"/media/uploads/images/versions/social/49c02c2f-c528-4448-b100-cb5d60ea2133.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/47b39860-b1ce-438c-b1b7-f9d4a82f56fb.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(26,'uploads/images/home_page.jpg',7,'Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/1237fb51-9bdc-4ff5-b2f0-d687a8385172.png\", \"medium\": \"/media/uploads/images/versions/medium/854348ee-22b6-4388-882c-891de7c3e5c2.png\", \"social\": \"/media/uploads/images/versions/social/9b6401df-a8cb-4fa5-a65c-2a1360e329c7.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/44a86f52-fe15-4d65-940d-00d8856032b6.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(29,'uploads/images/home_page_eIUrBim.jpg',8,'Reach out, Receive and Protect girls in the most vulnerable situations of sexual abuses.',1,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/cb8085e2-e988-4aaf-84d8-9c94314b7dab.png\", \"medium\": \"/media/uploads/images/versions/medium/b08e7685-043b-4ed4-9455-691a08953d64.png\", \"social\": \"/media/uploads/images/versions/social/5ac93325-1481-40ed-b98e-ed975c9fac7b.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/64845f29-67ec-4254-bdea-2b700d892b99.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(30,'uploads/images/un_logo.png',9,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/925ceee3-c1ce-414c-9c9b-f1253f26d1b8.png\", \"medium\": \"/media/uploads/images/versions/medium/b6d78c35-49b5-49d5-9051-53bafc620857.png\", \"social\": \"/media/uploads/images/versions/social/6e43abbb-5527-490b-b0df-48a30e54cd95.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/403621f8-197a-44ab-942d-06851c95560d.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(31,'uploads/images/Picture1fgn-removebg-preview.png',7,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/21ae86df-8d71-4668-9ad6-03d137caa20a.png\", \"medium\": \"/media/uploads/images/versions/medium/d46c54b0-47b0-441c-b1a4-15a8075c2294.png\", \"social\": \"/media/uploads/images/versions/social/9fe04631-7a63-47e3-acf3-b9726e3d26b8.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/ca0d7275-c03c-4c2f-8e17-21648be04865.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(32,'',9,'',0,10,0,'BICUBIC',NULL,'2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(33,'uploads/images/Picture1iu.png',9,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/9fd9b100-18f6-452b-81a1-66e761f1357d.png\", \"medium\": \"/media/uploads/images/versions/medium/8d07f7a1-d2e6-448a-9b50-e2fa1e3d5cce.png\", \"social\": \"/media/uploads/images/versions/social/768457b5-b4d3-4aca-a6c7-0bd48acde1d8.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/1091108d-6be4-42e7-bc0b-b11918b92ed7.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(34,'uploads/images/icon2-removebg-preview.png',5,'',0,31,1,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/18d50677-e9c2-45cb-9472-7520adf275bd.png\", \"medium\": \"/media/uploads/images/versions/medium/4f2d8f75-5523-4768-acc1-fef051074eeb.png\", \"social\": \"/media/uploads/images/versions/social/77663fd4-7808-4c24-a8d7-1621424337f9.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/1b0c9ae7-15f8-4586-9315-7eabdcab9e44.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(35,'uploads/images/icon2.png',8,'',0,31,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/394bdf49-d5c6-40ff-9687-37ebb9f6dd2f.png\", \"medium\": \"/media/uploads/images/versions/medium/9419e3b9-1f7e-4663-bebf-4a73463fac75.png\", \"social\": \"/media/uploads/images/versions/social/3f136f5a-7bc8-48ad-956f-e5e720477577.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/12d3b362-3a1d-48c1-8258-aaeaec566b6b.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(36,'uploads/images/Screenshot_193.png',4,'',0,31,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/7153612a-2325-4339-9b13-ec84b2fafbd0.png\", \"medium\": \"/media/uploads/images/versions/medium/5aab8486-e1ec-4df5-a81a-2c1a1fb62d13.png\", \"social\": \"/media/uploads/images/versions/social/437fe019-bedb-4c06-8d2d-69826e091a83.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/f4b24baa-7357-4366-ab40-97c38ce6aed6.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(37,'',4,'',0,31,0,'BICUBIC',NULL,'2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(38,'uploads/images/icon7.png',3,'',0,31,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/a76edb81-c097-4256-909e-b47ea654ac1f.png\", \"medium\": \"/media/uploads/images/versions/medium/2f944e77-af59-4472-8da5-3a55f9f4eabe.png\", \"social\": \"/media/uploads/images/versions/social/51c17b36-4784-4391-b663-96bc306fab7c.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/ff9f814b-456d-4c89-b6fa-5ed579866cee.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(39,'uploads/images/icon_3.png',9,'',0,31,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/de741edb-eeb5-4775-a5b6-711da8cac981.png\", \"medium\": \"/media/uploads/images/versions/medium/399b6810-5dfa-44bc-a829-afe43619194d.png\", \"social\": \"/media/uploads/images/versions/social/b00ca596-18ff-462d-b3c7-7fbb99a2d7f1.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/33bd194e-41b1-4d52-a599-e46eb6b83c33.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(40,'uploads/images/icon6.png',2,'',0,31,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/c7711cde-8acd-4902-8b7b-9f356525cfef.png\", \"medium\": \"/media/uploads/images/versions/medium/e8205073-f28b-4ae0-b43d-bc2d5dffd6a7.png\", \"social\": \"/media/uploads/images/versions/social/0022c122-c466-40e5-b370-56fd607d91df.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/d99e17ac-6e78-4eef-aa79-521c70df0143.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(41,'uploads/images/_DSC0874.JPG',7,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/0cef9860-fc59-42cc-ab92-61d81a4d219b.png\", \"medium\": \"/media/uploads/images/versions/medium/82b07a16-f662-4f36-b20f-754b1b52e02b.png\", \"social\": \"/media/uploads/images/versions/social/65dd7b93-ae5f-4662-90f8-7c45ec93671f.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/d46c9364-3d7b-47d1-b002-215cce91b524.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(42,'uploads/images/_DSC0873.JPG',9,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/b4c83abb-feb4-48f6-b538-7f03ffe5ccd1.png\", \"medium\": \"/media/uploads/images/versions/medium/fdb1f046-f2b7-445b-81ed-d3a45fab2c98.png\", \"social\": \"/media/uploads/images/versions/social/ecc34960-dca1-4115-ae6e-77736bc96716.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/90d25a87-062c-47f0-8d43-f8a169cb9a33.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(43,'uploads/images/IMG_2259.JPG',2,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/120f3482-45d7-4189-93ca-04e81c35f8c0.png\", \"medium\": \"/media/uploads/images/versions/medium/0aff0439-66b9-4bf7-82a3-2ec5840f47fa.png\", \"social\": \"/media/uploads/images/versions/social/bf212056-ecb4-4983-9aa4-9cca88cc7492.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/a48c443d-e9a2-4fa8-a575-50c8d7bd3fab.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(44,'uploads/images/IMG_2259_u1ox5PJ.JPG',2,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/8a7d1da1-a338-45f6-bd20-cac60a48cd64.png\", \"medium\": \"/media/uploads/images/versions/medium/1d026288-c1f3-4a7b-9cef-61dae53c02d7.png\", \"social\": \"/media/uploads/images/versions/social/eb95c2a5-1c48-4bb9-a631-11e71530e7ca.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/bef8a702-ae7c-40d4-a262-b7bed449d81e.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(46,'uploads/images/IMG_2268_M1OUzZi.JPG',3,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/30f61a75-6309-45b1-8ba2-8b70c45cca0e.png\", \"medium\": \"/media/uploads/images/versions/medium/c6d94f06-bdb1-4f39-ac9a-fa44b86d0e61.png\", \"social\": \"/media/uploads/images/versions/social/ca6032e4-ad15-470d-b702-fc58758bbf68.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/1aa7d72b-7fd7-4f11-a4f0-17db8441c09e.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(47,'uploads/images/saam5.jpg',8,'',0,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/e45dc2fc-fcc8-41c9-9a4b-e55cc9fd6b46.png\", \"medium\": \"/media/uploads/images/versions/medium/e90a1599-2135-45e7-8c3d-5c05fc239712.png\", \"social\": \"/media/uploads/images/versions/social/0d7962ab-8675-41e5-9539-5c66fab5e2dd.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/408dbcc3-035f-4390-b243-9b5b54c5d41b.png\"}','2024-04-03 15:22:24.240910',NULL,NULL,0,'2024-04-03 15:22:24.479974',0),(48,'uploads/images/poster_idea6.jpg',5,'',1,10,0,'BICUBIC','{\"large\": \"/media/uploads/images/versions/large/9e9d312f-2997-40c5-ba62-99d13071c2ba.png\", \"medium\": \"/media/uploads/images/versions/medium/58a550ac-0957-40c6-af17-68ce2c3dcf98.png\", \"social\": \"/media/uploads/images/versions/social/3a92a5f6-69ab-4ce7-8207-9ff64d0d3fc8.png\", \"thumbnail\": \"/media/uploads/images/versions/thumbnail/98daebf4-07e4-4c1c-bd64-f0e597ea7f27.png\"}','2024-04-04 06:08:36.138892',NULL,NULL,0,'2024-04-06 18:45:47.667172',0);
/*!40000 ALTER TABLE `media_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_video`
--

DROP TABLE IF EXISTS `media_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_video` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) DEFAULT NULL,
  `object_id` int unsigned NOT NULL,
  `description` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `poster_id` bigint DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_orphan` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `media_video_content_type_id_d28275d4_fk_django_content_type_id` (`content_type_id`),
  KEY `media_video_poster_id_21b93a96_fk_media_image_id` (`poster_id`),
  CONSTRAINT `media_video_content_type_id_d28275d4_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `media_video_poster_id_21b93a96_fk_media_image_id` FOREIGN KEY (`poster_id`) REFERENCES `media_image` (`id`),
  CONSTRAINT `media_video_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_video`
--

LOCK TABLES `media_video` WRITE;
/*!40000 ALTER TABLE `media_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mpesa_paymenttransaction`
--

DROP TABLE IF EXISTS `mpesa_paymenttransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mpesa_paymenttransaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(30) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `is_finished` tinyint(1) NOT NULL,
  `is_successful` tinyint(1) NOT NULL,
  `trans_id` varchar(30) NOT NULL,
  `order_id` varchar(200) NOT NULL,
  `checkout_request_id` varchar(100) NOT NULL,
  `date_modified` datetime(6) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `object_id` int unsigned NOT NULL,
  `content_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mpesa_paymenttransac_content_type_id_9147c435_fk_django_co` (`content_type_id`),
  CONSTRAINT `mpesa_paymenttransac_content_type_id_9147c435_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `mpesa_paymenttransaction_chk_1` CHECK ((`object_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mpesa_paymenttransaction`
--

LOCK TABLES `mpesa_paymenttransaction` WRITE;
/*!40000 ALTER TABLE `mpesa_paymenttransaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `mpesa_paymenttransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mpesa_wallet`
--

DROP TABLE IF EXISTS `mpesa_wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mpesa_wallet` (
  `uuid` char(32) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `phone_number` varchar(30) NOT NULL,
  `available_balance` decimal(6,2) NOT NULL,
  `actual_balance` decimal(6,2) NOT NULL,
  `date_modified` datetime(6) DEFAULT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mpesa_wallet`
--

LOCK TABLES `mpesa_wallet` WRITE;
/*!40000 ALTER TABLE `mpesa_wallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `mpesa_wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partnership_partner`
--

DROP TABLE IF EXISTS `partnership_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partnership_partner` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `contact_person` varchar(100) NOT NULL,
  `partnership_date` date NOT NULL,
  `address_id` bigint DEFAULT NULL,
  `contact_info_id` bigint NOT NULL,
  `logo_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_info_id` (`contact_info_id`),
  UNIQUE KEY `address_id` (`address_id`),
  UNIQUE KEY `logo_id` (`logo_id`),
  CONSTRAINT `partnership_partner_address_id_00c4d95f_fk_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `contact_address` (`id`),
  CONSTRAINT `partnership_partner_contact_info_id_3fb3eb76_fk_contact_c` FOREIGN KEY (`contact_info_id`) REFERENCES `contact_contactinformation` (`id`),
  CONSTRAINT `partnership_partner_logo_id_5f6226cb_fk_media_image_id` FOREIGN KEY (`logo_id`) REFERENCES `media_image` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partnership_partner`
--

LOCK TABLES `partnership_partner` WRITE;
/*!40000 ALTER TABLE `partnership_partner` DISABLE KEYS */;
INSERT INTO `partnership_partner` VALUES (1,1,'Hand in Hand Kenya','Randie Marsh','2024-03-07',3,4,9,'2024-04-03 15:22:24.760986','2024-04-03 19:50:35.370149',NULL,0,'2024-04-03 19:50:35.370291'),(3,0,'United Nations Trust Fund','Mary','2024-03-28',NULL,5,31,'2024-04-03 15:22:24.760986',NULL,NULL,0,'2024-04-03 15:22:24.873981'),(4,1,'French Embassy','Victoria','2024-03-28',NULL,6,32,'2024-04-03 15:22:24.760986',NULL,NULL,0,'2024-04-03 15:22:24.873981'),(5,0,'freedom fund','Ruth','2024-03-28',NULL,7,33,'2024-04-03 15:22:24.760986',NULL,NULL,0,'2024-04-03 15:22:24.873981'),(6,0,'French Embassy','Victoria','2024-03-28',NULL,8,NULL,'2024-04-03 15:22:24.760986',NULL,NULL,0,'2024-04-03 15:22:24.873981');
/*!40000 ALTER TABLE `partnership_partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partnership_teammember`
--

DROP TABLE IF EXISTS `partnership_teammember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partnership_teammember` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `role` varchar(100) NOT NULL,
  `bio` varchar(100) NOT NULL,
  `contact_info_id` bigint DEFAULT NULL,
  `image_id` bigint DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_date` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_info_id` (`contact_info_id`),
  UNIQUE KEY `image_id` (`image_id`),
  KEY `partnership_teammember_user_id_2e2221c3_fk_auth_user_id` (`user_id`),
  CONSTRAINT `partnership_teammemb_contact_info_id_1d512258_fk_contact_c` FOREIGN KEY (`contact_info_id`) REFERENCES `contact_contactinformation` (`id`),
  CONSTRAINT `partnership_teammember_image_id_688b9876_fk_media_image_id` FOREIGN KEY (`image_id`) REFERENCES `media_image` (`id`),
  CONSTRAINT `partnership_teammember_user_id_2e2221c3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partnership_teammember`
--

LOCK TABLES `partnership_teammember` WRITE;
/*!40000 ALTER TABLE `partnership_teammember` DISABLE KEYS */;
INSERT INTO `partnership_teammember` VALUES (1,0,'Program Manager','passion',3,42,3,'2024-04-03 15:22:24.911570',NULL,NULL,0,'2024-04-03 15:22:25.048057'),(2,1,'Admin','admin Maisha',2,10,1,'2024-04-03 15:22:24.911570',NULL,NULL,0,'2024-04-03 15:22:25.048057'),(3,1,'Project coordinator/ Director social work','Project coordinator',9,44,4,'2024-04-03 15:22:24.911570',NULL,NULL,0,'2024-04-03 15:22:25.048057');
/*!40000 ALTER TABLE `partnership_teammember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs_activity`
--

DROP TABLE IF EXISTS `programs_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programs_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `image_id` bigint NOT NULL,
  `program_id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) DEFAULT '0',
  `deletion_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `programs_activity_image_id_e96a0bd4_fk_media_image_id` (`image_id`),
  KEY `programs_activity_program_id_64ba5711_fk_programs_program_id` (`program_id`),
  CONSTRAINT `programs_activity_image_id_e96a0bd4_fk_media_image_id` FOREIGN KEY (`image_id`) REFERENCES `media_image` (`id`),
  CONSTRAINT `programs_activity_program_id_64ba5711_fk_programs_program_id` FOREIGN KEY (`program_id`) REFERENCES `programs_program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_activity`
--

LOCK TABLES `programs_activity` WRITE;
/*!40000 ALTER TABLE `programs_activity` DISABLE KEYS */;
INSERT INTO `programs_activity` VALUES (1,0,'Urban farming','Through APHRC, we begun the implementation of the Healthy Foods Africa in March 2022. Our focus was on an urban farming project that saw us set up a demo farm next to our community safe space in Viwandani, Lunga lunga.  We began planting kales, spinach, tomatoes, Dania, cabbages, bulb onions, beetroot, garlic, eggplant, coriander, cowpeas and spring onions that were majorly supplied to our safe house and some were sold to community members at subsidized prices. Through the project, 15 safe sisters and 98 families have been reached with information on how to utilize the little space in their homes to plant clean quality food.\r\nThe Maisha Safe sisters were involved in the project from planting to harvesting.',18,1,NULL,NULL,NULL,0,NULL),(2,0,'Homework club','Our homework club initiative was started to help school going children access the safe space after school to do their homework, do revision and share ideas.\r\n\r\nFor most of the students in Viwandani informal settlements, their homes are single rooms thus there is little room to study and they have no electricity which makes it hard for them to finish up homework after school.  \r\n\r\nThe club has been helpful in giving them a safe space to improve their school performance. The safe sisters have been instrumental in ensuring the children are well settled and guided for the two hours that they are in the space.',19,1,NULL,NULL,NULL,0,NULL),(3,1,'h','h',15,1,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `programs_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs_program`
--

DROP TABLE IF EXISTS `programs_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programs_program` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `impact_overview` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) DEFAULT '0',
  `deletion_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_program`
--

LOCK TABLES `programs_program` WRITE;
/*!40000 ALTER TABLE `programs_program` DISABLE KEYS */;
INSERT INTO `programs_program` VALUES (1,0,'Safe Space','The Maisha safe space in Viwandani, Lunga lunga has been an oasis of hope for the community. Young women, girls and boys visit the space to seek refuge and empowerment, engaging in educational sessions and activities centered around vital topics such as sexual and reproductive health and rights, sexual and gender based violence, urban farming, and life skills development.','2024-03-07','2025-03-20','few',NULL,NULL,NULL,0,NULL),(2,0,'Safe House','Our safe haven fills the gap that is largely observed in the referral pathway for survivors of sexual violence. Offering  young girls survivors with increased opportunities for case management and community integration, our shelter is a vital resource in their journey towards healing, recovery and empowerment. Survivors receive holistic support tailored to their individual needs. From counseling and healthcare services to temporary shelter and immediate personal needs, we prioritize their well-being and safety above all else.','2024-03-04','2030-03-20','Maisha girls safe house creates and help direct linkages with relevant institutions that assist in rehabilitation, long term shelter, treatment, education and temporally rescue placement.',NULL,NULL,NULL,0,NULL),(3,0,'Education','Obtaining scholarship funds from Drammen High School in Norway, the Drammen Scholarship offers a chance to academically gifted yet underprivileged students in the Viwandani area to pursue a four-year high school education. This scholarship alleviates the financial strain of covering tuition fees, thus enabling parents to address other essential needs within their households.','2024-03-04','2030-03-20','few',NULL,NULL,NULL,0,NULL),(4,0,'Community Outreach','Our community outreach program focuses on promoting sexual and reproductive health and rights (SRHR), addressing gender-based violence (SGBV), and combatting sexual violence through a multifaceted approach. Through various platforms such as girls\' forums, empowerment sessions, multisectoral meetings, and door-to-door outreach, we strive to engage with community members at every level.','2024-03-04','2030-03-20','few',NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `programs_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs_service`
--

DROP TABLE IF EXISTS `programs_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programs_service` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `image_id` bigint DEFAULT NULL,
  `icon_id` bigint DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `deletion_scheduled` tinyint(1) DEFAULT '0',
  `deletion_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `programs_service_icon_id_c7181d9e_fk_media_icon_id` (`icon_id`),
  KEY `programs_service_image_id_5343b28c_fk_media_image_id` (`image_id`),
  CONSTRAINT `programs_service_icon_id_c7181d9e_fk_media_icon_id` FOREIGN KEY (`icon_id`) REFERENCES `media_icon` (`id`),
  CONSTRAINT `programs_service_image_id_5343b28c_fk_media_image_id` FOREIGN KEY (`image_id`) REFERENCES `media_image` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_service`
--

LOCK TABLES `programs_service` WRITE;
/*!40000 ALTER TABLE `programs_service` DISABLE KEYS */;
INSERT INTO `programs_service` VALUES (1,0,'Temporary Shelter','We provide a safe haven and basic needs for survivors of sexual violence.',35,NULL,NULL,NULL,NULL,0,NULL),(2,0,'Psycho-social support','Counseling and psychotherapy sessions for survivors of sexual violence.',36,NULL,NULL,NULL,NULL,0,NULL),(3,0,'Educational support & opportunities','Mainly reintegrate survivors back into school and offer scholastic opportunities.',39,NULL,NULL,NULL,NULL,0,NULL),(4,0,'Health care referrals','Linkages and accessibility of healthcare services.',38,NULL,NULL,NULL,NULL,0,NULL),(5,0,'Family Reintegration','We provide assistance to survivors in reintegrating back into their families and communities.',40,NULL,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `programs_service` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-08  6:45:22
