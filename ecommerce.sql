-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `username` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `qty` int NOT NULL,
  PRIMARY KEY (`username`,`sku`),
  KEY `sku_cart_fk` (`sku`),
  CONSTRAINT `sku_cart_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`SKU`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `username_cart_fk` FOREIGN KEY (`username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `cart_AFTER_INSERT` AFTER INSERT ON `cart` FOR EACH ROW BEGIN
update users set cart=cart+1 where email=new.username;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `cart_AFTER_DELETE` AFTER DELETE ON `cart` FOR EACH ROW BEGIN
update users set cart=0 where email=old.username;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` varchar(255) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `image` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('1001','Human','https://ecommercecloneproductimages.s3.amazonaws.com/images/appliances.jpeg'),('1002','Appliances','https://ecommercecloneproductimages.s3.amazonaws.com/images/appliances.jpeg'),('1003','Books','https://ecommercecloneproductimages.s3.amazonaws.com/images/books.jpeg'),('1004','Electronics','https://ecommercecloneproductimages.s3.amazonaws.com/images/electronics.jpeg'),('1005','Essentials','https://ecommercecloneproductimages.s3.amazonaws.com/images/essentials.jpeg'),('1006','Fashion','https://ecommercecloneproductimages.s3.amazonaws.com/images/fashion.jpeg'),('1007','Mobiles','https://ecommercecloneproductimages.s3.amazonaws.com/images/mobiles.jpeg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `featured`
--

DROP TABLE IF EXISTS `featured`;
/*!50001 DROP VIEW IF EXISTS `featured`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `featured` AS SELECT 
 1 AS `SKU`,
 1 AS `Title`,
 1 AS `Description`,
 1 AS `Images`,
 1 AS `Reg_price`,
 1 AS `Promo_price`,
 1 AS `Inventory`,
 1 AS `seller_id`,
 1 AS `category`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `keywords`
--

DROP TABLE IF EXISTS `keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `keywords` (
  `keyword` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  PRIMARY KEY (`keyword`,`sku`),
  KEY `fk_sku_keyword` (`sku`),
  CONSTRAINT `fk_sku_keyword` FOREIGN KEY (`sku`) REFERENCES `products` (`SKU`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keywords`
--

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
INSERT INTO `keywords` VALUES ('denver','ajdj13ha'),('deodrant','ajdj13ha');
/*!40000 ALTER TABLE `keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_No` varchar(255) NOT NULL,
  `Shipping_Address` text,
  `Username` varchar(255) DEFAULT NULL,
  `Status` int DEFAULT '0',
  `Date` datetime DEFAULT NULL,
  PRIMARY KEY (`Order_No`),
  KEY `fk_username` (`Username`),
  KEY `order_no_index` (`Order_No`),
  CONSTRAINT `fk_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('1412d0c9-15f7-42cb-9d81-8f59bd4ee739','Aashaina Homes,Ghaziabas','dg325@snu.edu.in',2,'2022-11-28 08:37:01'),('505089a7-4343-41a9-b44c-5fddc7cfd055','Aashaina Homes,Ghaziabas','dg325@snu.edu.in',0,'2022-11-27 11:36:14'),('6b51867e-9ae0-4f74-80fa-529147218651','Aashaina Homes,Ghaziabas','dg325@snu.edu.in',3,'2022-11-25 18:10:44'),('928e65a2-f8dc-4c3c-84a2-aba215edafef','Aashaina Homes,Ghaziabas','dg325@snu.edu.in',0,'2022-11-27 11:22:56'),('9b02a56d-f4e4-4955-8220-ad55e0f7f07d','Aashaina Homes,Ghaziabas','dg325@snu.edu.in',0,'2022-11-27 11:02:31'),('d3398f54-9a4d-4b8f-8ee3-9ae23c0b28e3','Aashaina Homes,Ghaziabas','dg325@snu.edu.in',3,'2022-11-25 05:11:20'),('dd143521-9b6c-4405-bf7a-17eaf72a37b5','Aashaina Homes,Ghaziabas','dg325@snu.edu.in',2,'2022-11-25 12:14:57');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `SKU` varchar(255) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Description` text NOT NULL,
  `Images` text NOT NULL,
  `Reg_price` int NOT NULL,
  `Promo_price` int NOT NULL,
  `Inventory` int unsigned NOT NULL,
  `seller_id` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`SKU`),
  KEY `seller_fk` (`seller_id`),
  KEY `title_index` (`Title`),
  KEY `category_fk_idx` (`category`),
  CONSTRAINT `category_fk` FOREIGN KEY (`category`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `seller_fk` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('ajdj13ha','Denver deo','this is a green deodrant with bluetooth','[\"https://ecommercecloneproductimages.s3.amazonaws.com/images/ajdj13ha_1.png\"]',200,0,8,'tusharmishra16@gmail.com','1004');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_in_order`
--

DROP TABLE IF EXISTS `products_in_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_in_order` (
  `Order_No` varchar(255) NOT NULL,
  `SKU` varchar(255) NOT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Order_No`,`SKU`),
  KEY `fk_sku` (`SKU`),
  CONSTRAINT `fk_order_no` FOREIGN KEY (`Order_No`) REFERENCES `orders` (`Order_No`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sku` FOREIGN KEY (`SKU`) REFERENCES `products` (`SKU`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_in_order`
--

LOCK TABLES `products_in_order` WRITE;
/*!40000 ALTER TABLE `products_in_order` DISABLE KEYS */;
INSERT INTO `products_in_order` VALUES ('1412d0c9-15f7-42cb-9d81-8f59bd4ee739','ajdj13ha',1),('505089a7-4343-41a9-b44c-5fddc7cfd055','ajdj13ha',1),('6b51867e-9ae0-4f74-80fa-529147218651','ajdj13ha',1),('928e65a2-f8dc-4c3c-84a2-aba215edafef','ajdj13ha',1),('9b02a56d-f4e4-4955-8220-ad55e0f7f07d','ajdj13ha',1),('d3398f54-9a4d-4b8f-8ee3-9ae23c0b28e3','ajdj13ha',2),('dd143521-9b6c-4405-bf7a-17eaf72a37b5','ajdj13ha',1);
/*!40000 ALTER TABLE `products_in_order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `products_in_order_AFTER_INSERT` AFTER INSERT ON `products_in_order` FOR EACH ROW BEGIN
update products set inventory=inventory-new.quantity where sku=new.sku;
delete from cart where sku=new.sku and username in (select username from orders where order_no=new.order_no);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `rating` double(2,1) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`rating`,`sku`,`username`),
  KEY `sku_review_fk` (`sku`),
  KEY `username_review_fk` (`username`),
  CONSTRAINT `sku_review_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`SKU`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `username_review_fk` FOREIGN KEY (`username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (2.0,'ajdj13ha','tusharmishra16@gmail.com'),(4.0,'ajdj13ha','tusharmishra16@gmail.com');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `seller_id` varchar(255) NOT NULL,
  `seller_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES ('tusharmishra16@gmail.com','Tushar Mishra');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Username` varchar(255) NOT NULL,
  `Email` varchar(150) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `cart` int DEFAULT '0',
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('dg325@snu.edu.in','dg325@snu.edu.in','Devanshi Goel',0),('ss878@snu.edu.in ','ss878@snu.edu.in ','Sarthak Singhania',NULL),('tusharmishra16@gmail.com','tusharmishra16@gmail.com','Tushar Mishra',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `users_BEFORE_INSERT` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
if length(new.Email)>0 then set new.Username=new.Email;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `featured`
--

/*!50001 DROP VIEW IF EXISTS `featured`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `featured` AS select `products`.`SKU` AS `SKU`,`products`.`Title` AS `Title`,`products`.`Description` AS `Description`,`products`.`Images` AS `Images`,`products`.`Reg_price` AS `Reg_price`,`products`.`Promo_price` AS `Promo_price`,`products`.`Inventory` AS `Inventory`,`products`.`seller_id` AS `seller_id`,`products`.`category` AS `category` from `products` where `products`.`SKU` in (select `products_in_order`.`SKU` from `products_in_order` group by `products_in_order`.`SKU` order by count(`products_in_order`.`SKU`) desc) limit 1 */;
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

-- Dump completed on 2022-11-28 14:13:57
