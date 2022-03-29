-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: onlineshop
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

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
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(60) NOT NULL,
  `housenumber` int(11) NOT NULL,
  `country` varchar(60) NOT NULL,
  `userId` int(11) NOT NULL,
  `cityId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_ibfk_1` (`userId`),
  KEY `cityId` (`cityId`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`cityId`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (3,'Bauwaren'),(1,'Elektrowaren'),(6,'Lebensmittel'),(5,'Technik'),(4,'Television');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `postcode` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Bremerhaven','27574'),(2,'Bremerhaven','27574'),(3,'Bremerhaven','27574');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_products_ibfk_1` (`productId`),
  KEY `orderId` (`orderId`),
  CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
INSERT INTO `order_products` VALUES (17,130.99,1,4,19),(18,130.99,1,4,20),(19,130.99,1,4,21),(20,130.99,1,4,22);
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `received` tinyint(1) NOT NULL DEFAULT 0,
  `trackingnumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trackingnumber` (`trackingnumber`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (5,0,'undefined'),(8,0,'tasdadse'),(9,0,'tasddadse'),(11,0,'e19f1b04-8eb8-42ad-b0e0-ca0de80565fa'),(12,0,'1f96e5bc-5e21-4dd5-b977-e49953b2ffd4'),(13,0,'8775feb6-f561-4ef0-8788-77e4af006726'),(14,0,'6ffd662f-547a-484b-b84d-6c1cd0e6135c'),(15,0,'3e0c73e6-2243-401a-9ef4-88db0903d600'),(16,0,'76bec49c-f51a-4690-aed3-2405ff7fb626'),(17,0,'d6343eaf-719d-4e66-821f-f2c70ee4aa08'),(18,0,'b291d096-4f4c-4fc4-8c4a-3684f1ad4c93'),(19,0,'e5f7c5c0-273c-4c53-97c9-4656f1e57262'),(20,0,'8ca728ff-e52d-4199-95f1-681b032aedba'),(21,0,'0ba2e8f3-475b-4645-acac-d4a188b762aa'),(22,0,'d4ec8293-7007-4274-bdd3-965a6bef36cd'),(23,0,'2e639e69-7397-40a9-aa46-12d689c2306b'),(24,0,'d265236b-78d7-4324-b35c-a0ea81d7984b'),(25,0,'23baa6d0-e5cb-4a88-a545-9512029dc774'),(26,0,'08361df5-1155-42dc-9748-2b8ab07fe068'),(27,0,'20a59258-4af8-429c-9619-cc1da7bf9c53'),(28,0,'ed78d8ea-c598-42aa-8cdf-c2d5e997b1fc'),(29,0,'607940f4-3b01-4e72-89cd-4035eea4c45a'),(30,0,'94f05435-4347-4b6d-9cef-dfbfe0f7ee53'),(31,0,'c5750318-a6c4-43d1-ba74-1f2ca1739d3a'),(32,0,'e5344302-a3ec-428a-8161-7d6c3aee1d9e'),(33,0,'e36028f1-ff70-4f1e-95af-4777d1899e5b'),(34,0,'2941ab9c-3a14-4aa3-9814-2e88d119b2c4'),(35,0,'472965da-1de5-427d-ab2b-a6a49afae530'),(36,0,'a2e69c68-00d3-44a6-8214-b1ce7061ee59'),(37,0,'eefc615e-63a2-430f-8656-36a4229e434e');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_statusId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `orders_ibfk_2` (`order_statusId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`order_statusId`) REFERENCES `order_status` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (19,34,28),(20,35,28),(21,36,28),(22,37,28);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `delivery_time` int(11) NOT NULL,
  `sellerId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_ibfk_1` (`sellerId`),
  KEY `article_ibfk_2` (`categoryId`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `sellers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'LED Leiste mit RGBW',3.56,'Mit warmweiß funktion',0,2,1,1),(2,'Nagel ',2.00,'Gut zum nageln',83,2,1,3),(3,'Glühbirne x35 10000000 Watt',1.60,'Glühbirne mit viel Watt',0,2,1,1),(4,'LG TV 500x QHD',130.99,'Richtig guter TV mit perfekter Qualität',23,3,1,4),(5,'Raspberry Pi 4, Raspberry Pi Starter Kit (4GB RAM / 32GB SD)',209.99,'Raspberry Pi 4 4GB RAM: New SOC Broadcom BCM2711, 1.5GHz Quad-Core ARM Cortex-A72 CPU. Dual band 802.11b/g/n/ac WiFi (2.4/5.0 GHz) and BT 5.0 module for fast wireless networking with less interference and better reception.\r\nHigh Capacity - 2×USB 3 0 Ports, 2 × USB 2 0 ports and 2 × Micro HDMI ports. The HEVC 4K streams can support at 60 fps and manage 2 screens in 4K.\r\n32GB Class 10 SD Card: pre-installed with Raspberry Pi OS (Raspbian), can be easily booted with Raspbian for Raspberry Pi 4. Equipped with an SD card reader that is compatible with USB-A & USB-C C, easy to connect microSD to the computer.\r\nPowerful Cooling System: Equipped with 1 mini heat sink fan and 3 copper heat sink, your Raspberry Pi 4 can provide impeccable heat dissipation and prevent system failure. Uniquely designed premium housing provides enough space for fan and gap for heat dissipation.\r\nProfessional power supply with on/off switch: 1.5M/5V 3A USB-C power supply with noise filter and on/off switch, specially designed and tested for Raspberry Pi 4 (UL Listed) low-loss power transmission, thick and durable.\r\n',8345,3,2,5),(6,'Be Quiet Straight Power 11 Power Supply, Black 1000W',179.43,'Ausgestattet mit einem nahezu unhörbaren SilentWings3 135mm Lüfter\nDas be quiet! Straight Power 11 1000W setzt neue Maßstäbe für flüsterleise Systeme, ohne auch nur geringste Kompromisse bei der Stromversorgung einzugehen\nGesteigerte Spannungsregulierung und Stabilität dank fortschrittlicher LLC, SR und DC/DC Technologie\nKomfortables vollmodulares Kabelmanagement sorgt für maximale Flexibilität und einfache Bedienung\nProduktkonzeption, Design und Qualitätskontrolle in Deutschland\n',453,4,1,5);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL,
  `content` text NOT NULL,
  `rating` int(2) NOT NULL DEFAULT 0,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `productId` (`productId`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (9,'asd','ads',3,28,5),(10,'ompatible with USB-A & USB-C C, easy to connect microSD to t','i 4 4GB RAM: New SOC Broadcom BCM2711, 1.5GHz Quad-Core ARM Cortex-A72 CPU. Dual band 802.11b/g/n/ac WiFi (2.4/5.0 GHz) and BT 5.0 module for fast wireless networking with less interference and better reception. High Capacity - 2×USB 3 0 Ports, 2 × USB 2 0 ports and 2 × Micro HDMI ports. The HEVC 4K streams can support at 60 fps and manage 2 screens in 4K. 32GB Class 10 SD Card: pre-installed with Raspberry Pi OS (Raspbian), can be easily booted with Raspbian for Raspberry Pi 4. Equipped with an SD card reader that is compatible with USB-A & USB-C C, easy to connect microSD to the computer. Powerful Cooling System: Equipped with 1 mini heat sink fan and 3 copper heat sink, your Raspberry Pi 4 can provide impeccable heat dissipation and prevent system failure. Uniquely designed premium housing provides enough space f',5,28,5);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sellers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
INSERT INTO `sellers` VALUES (1,'Rüdiger','Hersteller für Wasserleitungen'),(2,'Hans-Jürgen GmbH','Hersteller von Elektrowaren'),(3,'Peter-Schmit','Hersteller von lauten Baugeräuschen während der Arbeitszeit.');
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart_item`
--

DROP TABLE IF EXISTS `shopping_cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopping_cart_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart_item`
--

LOCK TABLES `shopping_cart_item` WRITE;
/*!40000 ALTER TABLE `shopping_cart_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping_cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userinfos`
--

DROP TABLE IF EXISTS `userinfos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userinfos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(60) NOT NULL,
  `lastname` varchar(60) NOT NULL,
  `gender` varchar(60) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userinfos_ibfk_1` (`userId`),
  CONSTRAINT `userinfos_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinfos`
--

LOCK TABLES `userinfos` WRITE;
/*!40000 ALTER TABLE `userinfos` DISABLE KEYS */;
INSERT INTO `userinfos` VALUES (7,'Janis','Meister','Herr',28);
/*!40000 ALTER TABLE `userinfos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(255) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (28,'janis','janis.meister87@','$2a$10$E2nEjP/LkKhF750iYiyEIuzrGCMYStAWwE9d8iGWwhIoof4JOC/we',0);
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

-- Dump completed on 2022-03-29 14:40:35
