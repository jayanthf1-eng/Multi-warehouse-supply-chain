CREATE DATABASE IF NOT EXISTS SupplyChain;
USE SupplyChain;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(100)
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    lead_time_days INT NOT NULL
);

CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_name VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    city VARCHAR(100),
    address VARCHAR(255)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE,
    unit_price DECIMAL(10,2) NOT NULL,
    safety_stock INT NOT NULL DEFAULT 10
);

CREATE TABLE customerorders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending','Allocated','Partially Fulfilled','Fulfilled','Cancelled') NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_customerorders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orderitems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_ordered INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity_fulfilled INT NOT NULL DEFAULT 0,
    CONSTRAINT uq_orderitems_order_product UNIQUE (order_id, product_id),
    CONSTRAINT chk_orderitem_quantity CHECK (quantity_ordered > 0),
    CONSTRAINT chk_orderitem_fulfilled CHECK (quantity_fulfilled >= 0 AND quantity_fulfilled <= quantity_ordered),
    CONSTRAINT chk_orderitem_price CHECK (unit_price >= 0),
    CONSTRAINT fk_orderitems_order FOREIGN KEY (order_id) REFERENCES customerorders(order_id),
    CONSTRAINT fk_orderitems_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    shipment_date DATETIME,
    carrier_name VARCHAR(100),
    tracking_number VARCHAR(100) UNIQUE,
    status ENUM('Preparing','Dispatched','In Transit','Delivered','Cancelled') NOT NULL DEFAULT 'Preparing',
    CONSTRAINT fk_shipments_order FOREIGN KEY (order_id) REFERENCES customerorders(order_id),
    CONSTRAINT fk_shipments_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE shipmentitems (
    shipment_item_id INT PRIMARY KEY AUTO_INCREMENT,
    shipment_id INT NOT NULL,
    order_item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_shipped INT NOT NULL,
    CONSTRAINT chk_shipment_quantity CHECK (quantity_shipped > 0),
    CONSTRAINT fk_shipmentitems_shipment FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id),
    CONSTRAINT fk_shipmentitems_orderitem FOREIGN KEY (order_item_id) REFERENCES orderitems(order_item_id),
    CONSTRAINT fk_shipmentitems_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE backorders (
    backorder_id INT PRIMARY KEY AUTO_INCREMENT,
    order_item_id INT NOT NULL,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    quantity_backordered INT NOT NULL,
    backorder_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) DEFAULT 'Pending',
    CONSTRAINT fk_backorders_orderitem FOREIGN KEY (order_item_id) REFERENCES orderitems(order_item_id),
    CONSTRAINT fk_backorders_product FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_backorders_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE fulfillmentlog (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    order_item_id INT,
    warehouse_id INT,
    product_id INT,
    quantity_allocated INT NOT NULL DEFAULT 0,
    event_message VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_fulfillmentlog_order FOREIGN KEY (order_id) REFERENCES customerorders(order_id),
    CONSTRAINT fk_fulfillmentlog_orderitem FOREIGN KEY (order_item_id) REFERENCES orderitems(order_item_id),
    CONSTRAINT fk_fulfillmentlog_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_fulfillmentlog_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE purchaseorders (
    purchase_order_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    order_date DATE NOT NULL,
    expected_delivery_date DATE,
    status ENUM('Draft','Placed','Partially Received','Received','Cancelled') NOT NULL DEFAULT 'Draft',
    CONSTRAINT fk_purchaseorders_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT fk_purchaseorders_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE purchaseorderitems (
    purchase_order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_ordered INT NOT NULL,
    quantity_received INT NOT NULL DEFAULT 0,
    unit_cost DECIMAL(10,2) NOT NULL,
    CONSTRAINT uq_poitems_po_product UNIQUE (purchase_order_id, product_id),
    CONSTRAINT chk_poitem_quantity CHECK (quantity_ordered > 0),
    CONSTRAINT chk_poitem_received CHECK (quantity_received >= 0 AND quantity_received <= quantity_ordered),
    CONSTRAINT chk_poitem_cost CHECK (unit_cost >= 0),
    CONSTRAINT fk_poitems_po FOREIGN KEY (purchase_order_id) REFERENCES purchaseorders(purchase_order_id),
    CONSTRAINT fk_poitems_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE supplierproducts (
    supplier_product_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT uq_supplierproducts UNIQUE (supplier_id, product_id),
    CONSTRAINT fk_supplierproducts_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT fk_supplierproducts_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE warehouseinventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    reserved_quantity INT NOT NULL DEFAULT 0,
    CONSTRAINT uq_inventory_warehouse_product UNIQUE (warehouse_id, product_id),
    CONSTRAINT fk_inventory_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE inventorytransfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    from_warehouse_id INT NOT NULL,
    to_warehouse_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    transfer_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Requested','In Transit','Completed','Cancelled') NOT NULL DEFAULT 'Requested',
    CONSTRAINT chk_transfer_quantity CHECK (quantity > 0),
    CONSTRAINT chk_transfer_warehouses CHECK (from_warehouse_id <> to_warehouse_id),
    CONSTRAINT fk_transfers_from FOREIGN KEY (from_warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_transfers_to FOREIGN KEY (to_warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_transfers_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE inventoryalerts (
    alert_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_id INT NOT NULL,
    product_id INT NOT NULL,
    current_available INT NOT NULL,
    safety_stock INT NOT NULL,
    alert_message VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Open','Resolved') NOT NULL DEFAULT 'Open',
    CONSTRAINT fk_alerts_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_alerts_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (customer_name,phone,city) VALUES
('Rahul Sharma','9876543211','Chennai'),
('Priya Kumar','9876510001','Bengaluru'),
('Arjun Reddy','9876510002','Hyderabad'),
('Sneha Patel','9876510003','Mumbai'),
('Vikram Singh','9876510004','Delhi'),
('Ananya Das','9876510005','Kolkata'),
('Kiran Rao','9876510006','Visakhapatnam'),
('Meera Nair','9876510007','Chennai'),
('Rahul Verma','9876510008','Jaipur'),
('Divya Sharma','9876510009','Pune');

INSERT INTO suppliers (supplier_name,phone,lead_time_days) VALUES
('ABC Electronics Suppliers','9876543210',5),
('TechSource India','9876500001',4),
('Digital Components Ltd','9876500002',6),
('Prime Electronics','9876500003',5),
('Global Tech Supplies','9876500004',7),
('Smart Devices Wholesale','9876500005',3),
('ElectroMart Suppliers','9876500006',8),
('NextGen Components','9876500007',5),
('Reliable IT Distributors','9876500008',4),
('Metro Electronics Supply','9876500009',6);

INSERT INTO warehouses (warehouse_name,region,city,address) VALUES
('South Regional Warehouse','South India','Chennai','Chennai, Tamil Nadu, India'),
('Central Warehouse','South India','Bengaluru','Bengaluru, Karnataka, India'),
('North Regional Warehouse','North India','Delhi','Delhi, India'),
('West Regional Warehouse','West India','Mumbai','Mumbai, Maharashtra, India'),
('East Regional Warehouse','East India','Kolkata','Kolkata, West Bengal, India'),
('Hyderabad Distribution Center','South India','Hyderabad','Hyderabad, Telangana, India'),
('Pune Storage Center','West India','Pune','Pune, Maharashtra, India'),
('Coimbatore Warehouse','South India','Coimbatore','Coimbatore, Tamil Nadu, India'),
('Jaipur Distribution Center','North India','Jaipur','Jaipur, Rajasthan, India'),
('Visakhapatnam Warehouse','South India','Visakhapatnam','Visakhapatnam, Andhra Pradesh, India');

INSERT INTO products (product_name,sku,unit_price,safety_stock) VALUES
('Wireless Mouse','WM-101',799.00,20),
('Wireless Keyboard','WK-102',1299.00,15),
('USB-C Hub','UCH-103',1899.00,10),
('Laptop Stand','LS-104',999.00,12),
('Webcam HD','WC-105',2499.00,8),
('Bluetooth Headphones','BH-106',1799.00,15),
('Mechanical Keyboard','MK-107',3499.00,10),
('USB Flash Drive 64GB','USB-108',599.00,20),
('External SSD 1TB','SSD-109',6999.00,5),
('Laptop Charger','LC-110',1499.00,10);

INSERT INTO customerorders (customer_id,order_date,status) VALUES
(1,'2026-10-01 09:00:00','Fulfilled'),
(2,'2026-10-02 10:15:00','Fulfilled'),
(3,'2026-10-03 11:30:00','Pending'),
(4,'2026-10-04 12:00:00','Allocated'),
(5,'2026-10-05 13:45:00','Partially Fulfilled'),
(6,'2026-10-06 14:20:00','Pending'),
(7,'2026-10-07 15:00:00','Cancelled'),
(8,'2026-10-08 16:10:00','Fulfilled'),
(9,'2026-10-09 17:25:00','Allocated'),
(10,'2026-10-10 18:00:00','Pending');

INSERT INTO orderitems (order_id,product_id,quantity_ordered,unit_price,quantity_fulfilled) VALUES
(1,1,2,799.00,2),
(2,2,1,1499.00,1),
(3,3,3,999.00,0),
(4,4,2,699.00,0),
(5,5,1,1599.00,1),
(6,6,2,1999.00,0),
(7,7,1,2499.00,0),
(8,8,4,499.00,4),
(9,9,1,5999.00,0),
(10,10,2,899.00,0);

INSERT INTO shipments (order_id,warehouse_id,shipment_date,carrier_name,tracking_number,status) VALUES
(1,1,'2026-10-11 09:00:00','Blue Dart','BD100001','Delivered'),
(2,2,'2026-10-11 10:00:00','DTDC','DT100002','Delivered'),
(3,3,'2026-10-12 11:00:00','Delhivery','DL100003','Preparing'),
(4,4,'2026-10-12 12:00:00','Blue Dart','BD100004','Dispatched'),
(5,5,'2026-10-13 13:00:00','DTDC','DT100005','In Transit'),
(6,6,'2026-10-13 14:00:00','Delhivery','DL100006','Preparing'),
(7,7,'2026-10-14 15:00:00','Blue Dart','BD100007','Cancelled'),
(8,8,'2026-10-14 16:00:00','DTDC','DT100008','Delivered'),
(9,9,'2026-10-15 17:00:00','Delhivery','DL100009','Dispatched'),
(10,10,'2026-10-16 18:00:00','Blue Dart','BD100010','Preparing');

INSERT INTO shipmentitems (shipment_id,order_item_id,product_id,quantity_shipped) VALUES
(1,1,1,2),
(2,2,2,1),
(3,3,3,3),
(4,4,4,2),
(5,5,5,1),
(6,6,6,2),
(7,7,7,1),
(8,8,8,4),
(9,9,9,1),
(10,10,10,2);

INSERT INTO backorders (order_item_id,product_id,warehouse_id,quantity_backordered,backorder_date,status) VALUES
(1,1,1,5,'2026-10-11 03:30:00','Pending'),
(2,2,2,3,'2026-10-11 04:30:00','Pending'),
(3,3,3,8,'2026-10-12 05:30:00','Pending'),
(4,4,4,4,'2026-10-12 06:30:00','Processing'),
(5,5,5,2,'2026-10-13 07:30:00','Pending'),
(6,6,6,6,'2026-10-13 08:30:00','Pending'),
(7,7,7,3,'2026-10-14 09:30:00','Processing'),
(8,8,8,7,'2026-10-14 10:30:00','Fulfilled'),
(9,9,9,2,'2026-10-15 11:30:00','Pending'),
(10,10,10,5,'2026-10-16 12:30:00','Pending');

INSERT INTO fulfillmentlog (order_id,order_item_id,warehouse_id,product_id,quantity_allocated,event_message,created_at) VALUES
(1,1,1,1,2,'Wireless Mouse allocated successfully','2026-10-11 09:00:00'),
(2,2,2,2,1,'Wireless Keyboard allocated successfully','2026-10-11 10:00:00'),
(3,3,3,3,0,'USB-C Hub awaiting stock allocation','2026-10-12 11:00:00'),
(4,4,4,4,0,'Laptop Stand allocation pending','2026-10-12 12:00:00'),
(5,5,5,5,1,'Webcam HD partially allocated','2026-10-13 13:00:00'),
(6,6,6,6,0,'Bluetooth Headphones awaiting stock','2026-10-13 14:00:00'),
(7,7,7,7,0,'Mechanical Keyboard allocation pending','2026-10-14 15:00:00'),
(8,8,8,8,4,'USB Flash Drive allocated successfully','2026-10-14 16:00:00'),
(9,9,9,9,0,'External SSD awaiting stock allocation','2026-10-15 17:00:00'),
(10,10,10,10,0,'Laptop Charger allocation pending','2026-10-16 18:00:00');

INSERT INTO purchaseorders (supplier_id,warehouse_id,order_date,expected_delivery_date,status) VALUES
(1,1,'2026-10-01','2026-10-06','Received'),
(2,2,'2026-10-02','2026-10-08','Received'),
(3,3,'2026-10-03','2026-10-08','Placed'),
(4,4,'2026-10-04','2026-10-11','Placed'),
(5,5,'2026-10-05','2026-10-08','Partially Received'),
(6,6,'2026-10-06','2026-10-14','Placed'),
(7,7,'2026-10-07','2026-10-12','Draft'),
(8,8,'2026-10-08','2026-10-12','Received'),
(9,9,'2026-10-09','2026-10-15','Placed'),
(10,10,'2026-10-10','2026-10-16','Draft');

INSERT INTO purchaseorderitems (purchase_order_id,product_id,quantity_ordered,quantity_received,unit_cost) VALUES
(1,1,50,50,650.00),
(2,2,40,40,1200.00),
(3,3,30,0,850.00),
(4,4,25,0,700.00),
(5,5,20,10,1500.00),
(6,6,35,0,1800.00),
(7,7,15,0,2500.00),
(8,8,60,60,400.00),
(9,9,20,0,5500.00),
(10,10,25,0,900.00);

INSERT INTO supplierproducts (supplier_id,product_id) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5),
(6,6), (7,7), (8,8), (9,9), (10,10);

INSERT INTO warehouseinventory (warehouse_id,product_id,quantity,reserved_quantity) VALUES
(1,1,100,0), (1,2,75,5), (1,3,50,3),
(2,1,80,10), (2,4,60,5), (2,5,40,2),
(3,2,90,8), (3,6,35,5),
(4,3,65,4), (4,7,45,5),
(5,4,55,3), (5,8,100,10),
(6,5,30,2), (6,9,25,3),
(7,6,70,5), (7,10,40,4),
(8,7,60,5), (8,8,85,10),
(9,9,20,2),
(10,10,50,5);

INSERT INTO inventorytransfers (from_warehouse_id,to_warehouse_id,product_id,quantity,transfer_date,status) VALUES
(1,2,1,10,'2026-10-11 09:00:00','Completed'),
(2,3,2,15,'2026-10-11 10:00:00','Completed'),
(3,4,3,8,'2026-10-12 11:00:00','In Transit'),
(4,5,4,12,'2026-10-12 12:00:00','Requested'),
(5,6,5,6,'2026-10-13 13:00:00','Completed'),
(6,7,6,20,'2026-10-13 14:00:00','In Transit'),
(7,8,7,9,'2026-10-14 15:00:00','Requested'),
(8,9,8,25,'2026-10-14 16:00:00','Completed'),
(9,10,9,5,'2026-10-15 17:00:00','Cancelled'),
(10,1,10,11,'2026-10-16 18:00:00','Requested');

INSERT INTO inventoryalerts (warehouse_id,product_id,current_available,safety_stock,alert_message,created_at,status) VALUES
(1,1,5,20,'Critical: Wireless Mouse stock is low','2026-10-11 09:00:00','Open'),
(2,2,8,15,'Low stock: Wireless Keyboard','2026-10-11 10:00:00','Open'),
(3,3,4,10,'Critical: USB-C Hub stock is low','2026-10-12 11:00:00','Open'),
(4,4,6,12,'Low stock: Laptop Stand','2026-10-12 12:00:00','Resolved'),
(5,5,3,10,'Critical: Webcam HD stock is low','2026-10-13 13:00:00','Open'),
(6,6,7,15,'Low stock: Bluetooth Headphones','2026-10-13 14:00:00','Open'),
(7,7,2,10,'Critical: Mechanical Keyboard stock is low','2026-10-14 15:00:00','Open'),
(8,8,9,20,'Low stock: USB Flash Drive stock','2026-10-14 16:00:00','Resolved'),
(9,9,5,12,'Low stock: External SSD','2026-10-15 17:00:00','Open'),
(10,10,4,10,'Critical: Laptop Charger stock is low','2026-10-16 18:00:00','Open');

DELIMITER //
CREATE TRIGGER trg_low_stock_alert
AFTER UPDATE ON warehouseinventory
FOR EACH ROW
BEGIN
    DECLARE v_safety_stock INT;
    DECLARE v_available INT;

    SELECT safety_stock INTO v_safety_stock
    FROM products WHERE product_id = NEW.product_id;

    SET v_available = NEW.quantity - NEW.reserved_quantity;

    IF v_available <= v_safety_stock THEN
        INSERT INTO inventoryalerts (warehouse_id,product_id,current_available,safety_stock,alert_message,created_at,status)
        VALUES (NEW.warehouse_id,NEW.product_id,v_available,v_safety_stock,'Low stock alert',CURRENT_TIMESTAMP,'Open');
    END IF;
END//
DELIMITER ;

CREATE VIEW vw_warehousefulfillmentmetrics AS
SELECT w.warehouse_id, w.warehouse_name, p.product_id, p.product_name,
       wi.quantity AS total_quantity,
       wi.reserved_quantity,
       (wi.quantity - wi.reserved_quantity) AS available_quantity,
       p.safety_stock,
       CASE WHEN (wi.quantity - wi.reserved_quantity) <= p.safety_stock THEN 'LOW STOCK'
            ELSE 'STOCK OK' END AS stock_status
FROM warehouses w
JOIN warehouseinventory wi ON w.warehouse_id = wi.warehouse_id
JOIN products p ON wi.product_id = p.product_id;

-- How do you display the stock status of every product in every warehouse?
SELECT * FROM vw_warehousefulfillmentmetrics;
