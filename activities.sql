CREATE DATABASE  IF NOT EXISTS `activities` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `activities`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: activities
-- ------------------------------------------------------
-- Server version	5.5.5-10.2.7-MariaDB

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
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id_act` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  `type` varchar(140) DEFAULT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_act`),
  UNIQUE KEY `id_act_UNIQUE` (`id_act`),
  KEY `user_act_FK_idx` (`id_user`),
  CONSTRAINT `user_act_FK` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (1,'Stairs','Exercise',4,1),(2,'Walk','Exercise',4,1),(3,'Bathroom','Necessity',4,1);
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats` (
  `id_stats` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `id_act` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_stats`),
  UNIQUE KEY `id_stats_UNIQUE` (`id_stats`),
  KEY `user_stat_FK_idx` (`id_user`),
  KEY `act_stat_FK_idx` (`id_user`,`id_act`),
  CONSTRAINT `act_stat_FK` FOREIGN KEY (`id_user`, `id_act`) REFERENCES `activities` (`id_user`, `id_act`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_stat_FK` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (1,4,1,'2017-08-15 22:20:30',0),(2,4,2,'2017-08-15 22:20:30',0),(3,4,1,'2017-08-15 23:04:48',0),(4,4,1,'2017-08-15 23:04:51',0),(5,4,1,'2017-08-15 23:04:51',0),(6,4,1,'2017-08-16 10:05:17',0),(7,4,1,'2017-08-16 10:05:20',0),(8,4,1,'2017-08-16 10:14:54',0),(9,4,1,'2017-08-16 10:57:40',0),(10,4,1,'2017-08-16 10:58:07',0),(11,4,1,'2017-08-16 10:59:38',0),(12,4,1,'2017-08-16 11:03:33',0),(13,4,2,'2017-08-16 07:00:00',1),(14,4,2,'2017-08-16 07:00:00',1),(15,4,2,'2017-08-16 07:00:00',1),(16,4,2,'2017-08-16 07:00:00',1),(17,4,2,'2017-08-15 07:00:00',1),(18,4,2,'2017-08-15 07:00:00',1),(19,4,2,'2017-08-15 07:00:00',1),(20,4,2,'2017-08-15 07:00:00',1),(21,4,2,'2017-08-14 07:00:00',1),(22,4,2,'2017-08-14 07:00:00',1),(23,4,2,'2017-08-14 07:00:00',1),(24,4,2,'2017-08-14 07:00:00',1),(25,4,2,'2017-08-14 07:00:00',1),(26,4,2,'2017-08-14 07:00:00',1),(27,4,2,'2017-08-14 07:00:00',1),(28,4,2,'2017-08-14 07:00:00',1),(29,4,2,'2017-08-14 07:00:00',1),(30,4,2,'2017-08-14 07:00:00',1),(31,4,2,'2017-08-13 07:00:00',0),(32,4,2,'2017-08-13 07:00:00',0),(33,4,2,'2017-08-13 07:00:00',0),(34,4,2,'2017-08-13 07:00:00',0),(35,4,2,'2017-08-13 07:00:00',0),(36,4,2,'2017-08-13 07:00:00',0),(37,4,2,'2017-08-13 07:00:00',0),(38,4,2,'2017-08-13 07:00:00',0),(39,4,2,'2017-08-13 07:00:00',0),(40,4,2,'2017-08-13 07:00:00',0),(41,4,2,'2017-08-13 07:00:00',0),(42,4,2,'2017-08-13 07:00:00',0),(43,4,2,'2017-08-13 07:00:00',0),(44,4,2,'2017-08-13 07:00:00',0),(45,4,2,'2017-08-13 07:00:00',0),(46,4,2,'2017-08-13 07:00:00',0),(47,4,2,'2017-08-13 07:00:00',0),(48,4,2,'2017-08-13 07:00:00',0),(49,4,2,'2017-08-13 07:00:00',0),(50,4,2,'2017-08-13 07:00:00',0),(51,4,2,'2017-08-13 07:00:00',0),(52,4,2,'2017-08-13 07:00:00',0),(53,4,2,'2017-08-13 07:00:00',0),(54,4,2,'2017-08-13 07:00:00',0),(55,4,2,'2017-08-13 07:00:00',0),(56,4,2,'2017-08-13 07:00:00',0),(57,4,2,'2017-08-13 07:00:00',0),(58,4,2,'2017-08-13 07:00:00',0),(59,4,2,'2017-08-13 07:00:00',0),(60,4,2,'2017-08-13 07:00:00',0),(61,4,2,'2017-08-13 07:00:00',0),(62,4,2,'2017-08-13 07:00:00',0),(63,4,2,'2017-08-13 07:00:00',0),(64,4,2,'2017-08-13 07:00:00',0),(65,4,2,'2017-08-13 07:00:00',0),(66,4,2,'2017-08-13 07:00:00',0),(67,4,2,'2017-08-13 07:00:00',0),(68,4,2,'2017-08-13 07:00:00',0),(69,4,2,'2017-08-13 07:00:00',0);
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id_token` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `token` varchar(250) NOT NULL,
  `timestampe` datetime NOT NULL DEFAULT current_timestamp(),
  `active` varchar(140) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_token`),
  UNIQUE KEY `id_token_UNIQUE` (`id_token`),
  KEY `id_user_token_FK_idx` (`id_user`),
  CONSTRAINT `id_user_token_FK` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,4,'9ac71555-55ab-4974-a57f-b627cd4e6509','2017-08-15 15:10:55','1'),(2,4,'183eccfb-6783-4787-babc-4c82f16d4ab2','2017-08-15 15:37:52','1'),(3,4,'9914d8a6-1d6d-43f0-9e0b-7d29ef3a8125','2017-08-15 15:38:38','1'),(4,4,'cd951767-88d4-4f6a-8564-490e89503b57','2017-08-15 16:50:22','1');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(140) NOT NULL,
  `displayName` varchar(140) DEFAULT NULL,
  `passwordHash` varchar(250) NOT NULL,
  `timestamp` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `id_user_UNIQUE` (`id_user`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'jase1','That guy','$2a$08$2b4lMhxmiR6kN3BAJ/It3enK6lcoFeypJ6WTuCsBnXoc6.fslHu1.',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-17 10:48:39
