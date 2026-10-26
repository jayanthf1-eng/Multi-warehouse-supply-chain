-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: SupplyChain
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `backorders`
--

DROP TABLE IF EXISTS `backorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backorders` (
  `backorder_id` int NOT NULL AUTO_INCREMENT,
  `order_item_id` int NOT NULL,
  `product_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `quantity_backordered` int NOT NULL,
  `backorder_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(30) DEFAULT 'Pending',
  PRIMARY KEY (`backorder_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `backorders_ibfk_1` FOREIGN KEY (`order_item_id`) REFERENCES `orderitems` (`order_item_id`),
  CONSTRAINT `backorders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `backorders_ibfk_3` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backorders`
--

LOCK TABLES `backorders` WRITE;
/*!40000 ALTER TABLE `backorders` DISABLE KEYS */;
INSERT INTO `backorders` VALUES (1,1,1,1,5,'2026-10-11 03:30:00','Pending'),(2,2,2,2,3,'2026-10-11 04:30:00','Pending'),(3,3,3,3,8,'2026-10-12 05:30:00','Pending'),(4,4,4,4,4,'2026-10-12 06:30:00','Processing'),(5,5,5,5,2,'2026-10-13 07:30:00','Pending'),(6,6,6,6,6,'2026-10-13 08:30:00','Pending'),(7,7,7,7,3,'2026-10-14 09:30:00','Processing'),(8,8,8,8,7,'2026-10-14 10:30:00','Fulfilled'),(9,9,9,9,2,'2026-10-15 11:30:00','Pending'),(10,10,10,10,5,'2026-10-16 12:30:00','Pending');
/*!40000 ALTER TABLE `backorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerorders`
--

DROP TABLE IF EXISTS `customerorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerorders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Pending','Allocated','Partially Fulfilled','Fulfilled','Cancelled') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customerorders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerorders`
--

LOCK TABLES `customerorders` WRITE;
/*!40000 ALTER TABLE `customerorders` DISABLE KEYS */;
INSERT INTO `customerorders` VALUES (1,1,'2026-10-01 09:00:00','Fulfilled'),(2,2,'2026-10-02 10:15:00','Fulfilled'),(3,3,'2026-10-03 11:30:00','Pending'),(4,4,'2026-10-04 12:00:00','Allocated'),(5,5,'2026-10-05 13:45:00','Partially Fulfilled'),(6,6,'2026-10-06 14:20:00','Pending'),(7,7,'2026-10-07 15:00:00','Cancelled'),(8,8,'2026-10-08 16:10:00','Fulfilled'),(9,9,'2026-10-09 17:25:00','Allocated'),(10,10,'2026-10-10 18:00:00','Pending');
/*!40000 ALTER TABLE `customerorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Rahul Sharma','9876543211','Chennai'),(2,'Priya Kumar','9876510001','Bengaluru'),(3,'Arjun Reddy','9876510002','Hyderabad'),(4,'Sneha Patel','9876510003','Mumbai'),(5,'Vikram Singh','9876510004','Delhi'),(6,'Ananya Das','9876510005','Kolkata'),(7,'Kiran Rao','9876510006','Visakhapatnam'),(8,'Meera Nair','9876510007','Chennai'),(9,'Rahul Verma','9876510008','Jaipur'),(10,'Divya Sharma','9876510009','Pune');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fulfillmentlog`
--

DROP TABLE IF EXISTS `fulfillmentlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fulfillmentlog` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `order_item_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity_allocated` int NOT NULL DEFAULT '0',
  `event_message` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `order_id` (`order_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `fulfillmentlog_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customerorders` (`order_id`),
  CONSTRAINT `fulfillmentlog_ibfk_2` FOREIGN KEY (`order_item_id`) REFERENCES `orderitems` (`order_item_id`),
  CONSTRAINT `fulfillmentlog_ibfk_3` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `fulfillmentlog_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fulfillmentlog`
--

LOCK TABLES `fulfillmentlog` WRITE;
/*!40000 ALTER TABLE `fulfillmentlog` DISABLE KEYS */;
INSERT INTO `fulfillmentlog` VALUES (1,1,1,1,1,2,'Wireless Mouse allocated successfully','2026-10-11 09:00:00'),(2,2,2,2,2,1,'Wireless Keyboard allocated successfully','2026-10-11 10:00:00'),(3,3,3,3,3,0,'USB-C Hub awaiting stock allocation','2026-10-12 11:00:00'),(4,4,4,4,4,0,'Laptop Stand allocation pending','2026-10-12 12:00:00'),(5,5,5,5,5,1,'Webcam HD partially allocated','2026-10-13 13:00:00'),(6,6,6,6,6,0,'Bluetooth Headphones awaiting stock','2026-10-13 14:00:00'),(7,7,7,7,7,0,'Mechanical Keyboard allocation pending','2026-10-14 15:00:00'),(8,8,8,8,8,4,'USB Flash Drive allocated successfully','2026-10-14 16:00:00'),(9,9,9,9,9,0,'External SSD awaiting stock allocation','2026-10-15 17:00:00'),(10,10,10,10,10,0,'Laptop Charger allocation pending','2026-10-16 18:00:00');
/*!40000 ALTER TABLE `fulfillmentlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventoryalerts`
--

DROP TABLE IF EXISTS `inventoryalerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventoryalerts` (
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `current_available` int NOT NULL,
  `safety_stock` int NOT NULL,
  `alert_message` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Open','Resolved') NOT NULL DEFAULT 'Open',
  PRIMARY KEY (`alert_id`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventoryalerts_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `inventoryalerts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventoryalerts`
--

LOCK TABLES `inventoryalerts` WRITE;
/*!40000 ALTER TABLE `inventoryalerts` DISABLE KEYS */;
INSERT INTO `inventoryalerts` VALUES (1,1,1,5,20,'Critical: Wireless Mouse stock is low','2026-10-11 09:00:00','Open'),(2,2,2,8,15,'Low stock: Wireless Keyboard','2026-10-11 10:00:00','Open'),(3,3,3,4,10,'Critical: USB-C Hub stock is low','2026-10-12 11:00:00','Open'),(4,4,4,6,12,'Low stock: Laptop Stand','2026-10-12 12:00:00','Resolved'),(5,5,5,3,10,'Critical: Webcam HD stock is low','2026-10-13 13:00:00','Open'),(6,6,6,7,15,'Low stock: Bluetooth Headphones','2026-10-13 14:00:00','Open'),(7,7,7,2,10,'Critical: Mechanical Keyboard stock is low','2026-10-14 15:00:00','Open'),(8,8,8,9,20,'Low stock: USB Flash Drive stock','2026-10-14 16:00:00','Resolved'),(9,9,9,5,12,'Low stock: External SSD','2026-10-15 17:00:00','Open'),(10,10,10,4,10,'Critical: Laptop Charger stock is low','2026-10-16 18:00:00','Open'),(11,1,1,15,20,'Low stock alert','2026-10-26 12:27:16','Open');
/*!40000 ALTER TABLE `inventoryalerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventorytransfers`
--

DROP TABLE IF EXISTS `inventorytransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventorytransfers` (
  `transfer_id` int NOT NULL AUTO_INCREMENT,
  `from_warehouse_id` int NOT NULL,
  `to_warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `transfer_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Requested','In Transit','Completed','Cancelled') NOT NULL DEFAULT 'Requested',
  PRIMARY KEY (`transfer_id`),
  KEY `from_warehouse_id` (`from_warehouse_id`),
  KEY `to_warehouse_id` (`to_warehouse_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventorytransfers_ibfk_1` FOREIGN KEY (`from_warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `inventorytransfers_ibfk_2` FOREIGN KEY (`to_warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `inventorytransfers_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `inventorytransfers_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `inventorytransfers_chk_2` CHECK ((`from_warehouse_id` <> `to_warehouse_id`))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventorytransfers`
--

LOCK TABLES `inventorytransfers` WRITE;
/*!40000 ALTER TABLE `inventorytransfers` DISABLE KEYS */;
INSERT INTO `inventorytransfers` VALUES (1,1,2,1,10,'2026-10-11 09:00:00','Completed'),(2,2,3,2,15,'2026-10-11 10:00:00','Completed'),(3,3,4,3,8,'2026-10-12 11:00:00','In Transit'),(4,4,5,4,12,'2026-10-12 12:00:00','Requested'),(5,5,6,5,6,'2026-10-13 13:00:00','Completed'),(6,6,7,6,20,'2026-10-13 14:00:00','In Transit'),(7,7,8,7,9,'2026-10-14 15:00:00','Requested'),(8,8,9,8,25,'2026-10-14 16:00:00','Completed'),(9,9,10,9,5,'2026-10-15 17:00:00','Cancelled'),(10,10,1,10,11,'2026-10-16 18:00:00','Requested');
/*!40000 ALTER TABLE `inventorytransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity_ordered` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity_fulfilled` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_item_id`),
  UNIQUE KEY `order_id` (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customerorders` (`order_id`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `orderitems_chk_1` CHECK ((`quantity_ordered` > 0)),
  CONSTRAINT `orderitems_chk_2` CHECK (((`quantity_fulfilled` >= 0) and (`quantity_fulfilled` <= `quantity_ordered`))),
  CONSTRAINT `orderitems_chk_3` CHECK ((`unit_price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (1,1,1,2,799.00,2),(2,2,2,1,1499.00,1),(3,3,3,3,999.00,0),(4,4,4,2,699.00,0),(5,5,5,1,1599.00,1),(6,6,6,2,1999.00,0),(7,7,7,1,2499.00,0),(8,8,8,4,499.00,4),(9,9,9,1,5999.00,0),(10,10,10,2,899.00,0);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `sku` varchar(50) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `safety_stock` int NOT NULL DEFAULT '10',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Wireless Mouse','WM-101',799.00,20),(2,'Wireless Keyboard','WK-102',1299.00,15),(3,'USB-C Hub','UCH-103',1899.00,10),(4,'Laptop Stand','LS-104',999.00,12),(5,'Webcam HD','WC-105',2499.00,8),(6,'Bluetooth Headphones','BH-106',1799.00,15),(7,'Mechanical Keyboard','MK-107',3499.00,10),(8,'USB Flash Drive 64GB','USB-108',599.00,20),(9,'External SSD 1TB','SSD-109',6999.00,5),(10,'Laptop Charger','LC-110',1499.00,10);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseorderitems`
--

DROP TABLE IF EXISTS `purchaseorderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchaseorderitems` (
  `purchase_order_item_id` int NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity_ordered` int NOT NULL,
  `quantity_received` int NOT NULL DEFAULT '0',
  `unit_cost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`purchase_order_item_id`),
  UNIQUE KEY `purchase_order_id` (`purchase_order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `purchaseorderitems_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchaseorders` (`purchase_order_id`),
  CONSTRAINT `purchaseorderitems_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `purchaseorderitems_chk_1` CHECK ((`quantity_ordered` > 0)),
  CONSTRAINT `purchaseorderitems_chk_2` CHECK (((`quantity_received` >= 0) and (`quantity_received` <= `quantity_ordered`))),
  CONSTRAINT `purchaseorderitems_chk_3` CHECK ((`unit_cost` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorderitems`
--

LOCK TABLES `purchaseorderitems` WRITE;
/*!40000 ALTER TABLE `purchaseorderitems` DISABLE KEYS */;
INSERT INTO `purchaseorderitems` VALUES (1,1,1,50,50,650.00),(2,2,2,40,40,1200.00),(3,3,3,30,0,850.00),(4,4,4,25,0,700.00),(5,5,5,20,10,1500.00),(6,6,6,35,0,1800.00),(7,7,7,15,0,2500.00),(8,8,8,60,60,400.00),(9,9,9,20,0,5500.00),(10,10,10,25,0,900.00);
/*!40000 ALTER TABLE `purchaseorderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseorders`
--

DROP TABLE IF EXISTS `purchaseorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchaseorders` (
  `purchase_order_id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `order_date` date NOT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `status` enum('Draft','Placed','Partially Received','Received','Cancelled') NOT NULL DEFAULT 'Draft',
  PRIMARY KEY (`purchase_order_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `purchaseorders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `purchaseorders_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorders`
--

LOCK TABLES `purchaseorders` WRITE;
/*!40000 ALTER TABLE `purchaseorders` DISABLE KEYS */;
INSERT INTO `purchaseorders` VALUES (1,1,1,'2026-10-01','2026-10-06','Received'),(2,2,2,'2026-10-02','2026-10-08','Received'),(3,3,3,'2026-10-03','2026-10-08','Placed'),(4,4,4,'2026-10-04','2026-10-11','Placed'),(5,5,5,'2026-10-05','2026-10-08','Partially Received'),(6,6,6,'2026-10-06','2026-10-14','Placed'),(7,7,7,'2026-10-07','2026-10-12','Draft'),(8,8,8,'2026-10-08','2026-10-12','Received'),(9,9,9,'2026-10-09','2026-10-15','Placed'),(10,10,10,'2026-10-10','2026-10-16','Draft');
/*!40000 ALTER TABLE `purchaseorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipmentitems`
--

DROP TABLE IF EXISTS `shipmentitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipmentitems` (
  `shipment_item_id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int NOT NULL,
  `order_item_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity_shipped` int NOT NULL,
  PRIMARY KEY (`shipment_item_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `shipmentitems_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`),
  CONSTRAINT `shipmentitems_ibfk_2` FOREIGN KEY (`order_item_id`) REFERENCES `orderitems` (`order_item_id`),
  CONSTRAINT `shipmentitems_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `shipmentitems_chk_1` CHECK ((`quantity_shipped` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipmentitems`
--

LOCK TABLES `shipmentitems` WRITE;
/*!40000 ALTER TABLE `shipmentitems` DISABLE KEYS */;
INSERT INTO `shipmentitems` VALUES (1,1,1,1,2),(2,2,2,2,1),(3,3,3,3,3),(4,4,4,4,2),(5,5,5,5,1),(6,6,6,6,2),(7,7,7,7,1),(8,8,8,8,4),(9,9,9,9,1),(10,10,10,10,2);
/*!40000 ALTER TABLE `shipmentitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `shipment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `shipment_date` datetime DEFAULT NULL,
  `carrier_name` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `status` enum('Preparing','Dispatched','In Transit','Delivered','Cancelled') NOT NULL DEFAULT 'Preparing',
  PRIMARY KEY (`shipment_id`),
  UNIQUE KEY `tracking_number` (`tracking_number`),
  KEY `order_id` (`order_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customerorders` (`order_id`),
  CONSTRAINT `shipments_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
INSERT INTO `shipments` VALUES (1,1,1,'2026-10-11 09:00:00','Blue Dart','BD100001','Delivered'),(2,2,2,'2026-10-11 10:00:00','DTDC','DT100002','Delivered'),(3,3,3,'2026-10-12 11:00:00','Delhivery','DL100003','Preparing'),(4,4,4,'2026-10-12 12:00:00','Blue Dart','BD100004','Dispatched'),(5,5,5,'2026-10-13 13:00:00','DTDC','DT100005','In Transit'),(6,6,6,'2026-10-13 14:00:00','Delhivery','DL100006','Preparing'),(7,7,7,'2026-10-14 15:00:00','Blue Dart','BD100007','Cancelled'),(8,8,8,'2026-10-14 16:00:00','DTDC','DT100008','Delivered'),(9,9,9,'2026-10-15 17:00:00','Delhivery','DL100009','Dispatched'),(10,10,10,'2026-10-16 18:00:00','Blue Dart','BD100010','Preparing');
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplierproducts`
--

DROP TABLE IF EXISTS `supplierproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplierproducts` (
  `supplier_product_id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`supplier_product_id`),
  UNIQUE KEY `supplier_id` (`supplier_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `supplierproducts_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `supplierproducts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplierproducts`
--

LOCK TABLES `supplierproducts` WRITE;
/*!40000 ALTER TABLE `supplierproducts` DISABLE KEYS */;
INSERT INTO `supplierproducts` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `supplierproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `lead_time_days` int NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'ABC Electronics Suppliers','9876543210',5),(2,'TechSource India','9876500001',4),(3,'Digital Components Ltd','9876500002',6),(4,'Prime Electronics','9876500003',5),(5,'Global Tech Supplies','9876500004',7),(6,'Smart Devices Wholesale','9876500005',3),(7,'ElectroMart Suppliers','9876500006',8),(8,'NextGen Components','9876500007',5),(9,'Reliable IT Distributors','9876500008',4),(10,'Metro Electronics Supply','9876500009',6);
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_warehousefulfillmentmetrics`
--

DROP TABLE IF EXISTS `vw_warehousefulfillmentmetrics`;
/*!50001 DROP VIEW IF EXISTS `vw_warehousefulfillmentmetrics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_warehousefulfillmentmetrics` AS SELECT 
 1 AS `warehouse_id`,
 1 AS `warehouse_name`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `total_quantity`,
 1 AS `reserved_quantity`,
 1 AS `available_quantity`,
 1 AS `safety_stock`,
 1 AS `stock_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `warehouseinventory`
--

DROP TABLE IF EXISTS `warehouseinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouseinventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `reserved_quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `warehouse_id` (`warehouse_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `warehouseinventory_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `warehouseinventory_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouseinventory`
--

LOCK TABLES `warehouseinventory` WRITE;
/*!40000 ALTER TABLE `warehouseinventory` DISABLE KEYS */;
INSERT INTO `warehouseinventory` VALUES (1,1,1,100,0),(2,1,2,75,5),(3,1,3,50,3),(4,2,1,80,10),(5,2,4,60,5),(6,2,5,40,2),(7,3,2,90,8),(8,3,6,35,5),(9,4,3,65,4),(10,4,7,45,5),(11,5,4,55,3),(12,5,8,100,10),(13,6,5,30,2),(14,6,9,25,3),(15,7,6,70,5),(16,7,10,40,4),(17,8,7,60,5),(18,8,8,85,10),(19,9,9,20,2),(20,10,10,50,5);
/*!40000 ALTER TABLE `warehouseinventory` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_low_stock_alert` AFTER UPDATE ON `warehouseinventory` FOR EACH ROW BEGIN
    DECLARE v_safety_stock INT;
    DECLARE v_available INT;

    SELECT safety_stock
    INTO v_safety_stock
    FROM Products
    WHERE product_id = NEW.product_id;

    SET v_available = NEW.quantity - NEW.reserved_quantity;

    IF v_available <= v_safety_stock THEN
        INSERT INTO InventoryAlerts
        (
            warehouse_id,
            product_id,
            current_available,
            safety_stock,
            alert_message,
            created_at,
            status
        )
        VALUES
        (
            NEW.warehouse_id,
            NEW.product_id,
            v_available,
            v_safety_stock,
            'Low stock alert',
            CURRENT_TIMESTAMP,
            'Open'
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouses` (
  `warehouse_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_name` varchar(100) NOT NULL,
  `region` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (1,'South Regional Warehouse','South India','Chennai','Chennai, Tamil Nadu, India'),(2,'Central Warehouse','South India','Bengaluru','Bengaluru, Karnataka, India'),(3,'North Regional Warehouse','North India','Delhi','Delhi, India'),(4,'West Regional Warehouse','West India','Mumbai','Mumbai, Maharashtra, India'),(5,'East Regional Warehouse','East India','Kolkata','Kolkata, West Bengal, India'),(6,'Hyderabad Distribution Center','South India','Hyderabad','Hyderabad, Telangana, India'),(7,'Pune Storage Center','West India','Pune','Pune, Maharashtra, India'),(8,'Coimbatore Warehouse','South India','Coimbatore','Coimbatore, Tamil Nadu, India'),(9,'Jaipur Distribution Center','North India','Jaipur','Jaipur, Rajasthan, India'),(10,'Visakhapatnam Warehouse','South India','Visakhapatnam','Visakhapatnam, Andhra Pradesh, India');
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `vw_warehousefulfillmentmetrics`
--

/*!50001 DROP VIEW IF EXISTS `vw_warehousefulfillmentmetrics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_warehousefulfillmentmetrics` AS select `w`.`warehouse_id` AS `warehouse_id`,`w`.`warehouse_name` AS `warehouse_name`,`p`.`product_id` AS `product_id`,`p`.`product_name` AS `product_name`,`wi`.`quantity` AS `total_quantity`,`wi`.`reserved_quantity` AS `reserved_quantity`,(`wi`.`quantity` - `wi`.`reserved_quantity`) AS `available_quantity`,`p`.`safety_stock` AS `safety_stock`,(case when ((`wi`.`quantity` - `wi`.`reserved_quantity`) <= `p`.`safety_stock`) then 'LOW STOCK' else 'STOCK OK' end) AS `stock_status` from ((`warehouses` `w` join `warehouseinventory` `wi` on((`w`.`warehouse_id` = `wi`.`warehouse_id`))) join `products` `p` on((`wi`.`product_id` = `p`.`product_id`))) */;
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

-- Dump completed on 2026-10-26 18:01:37
