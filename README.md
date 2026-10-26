### &#x20;Multi-Warehouse Supply Chain \& Inventory Fulfillment Engine



&#x20;  A MySQL database project for managing warehouse inventory, suppliers, customers, purchase orders, customer orders, shipments, and inventory fulfillment across multiple warehouses.



##### &#x20;Project Objectives



\- Manage products and inventory across multiple warehouses.

\- Maintain supplier, customer, and warehouse information.

\- Track purchase orders and customer orders.

\- Monitor available stock and reserved inventory.

\- Record shipment and inventory transfer details.

\- Generate low-stock alerts when inventory reaches the safety-stock threshold.

\- Track backorders and order fulfillment activities.



##### &#x20;Technologies



\- MySQL 8.0+

\- MySQL Command Line Client

\- SQL



##### &#x20;Database Structure



###### &#x20; Database name: `SupplyChain`



###### &#x20;  Tables and their purposes:



1\. `Warehouses` — Warehouse information and locations.

2\. `Products` — Product details and safety-stock thresholds.

3\. `Suppliers` — Supplier information.

4\. `Customers` — Customer information.

5\. `WarehouseInventory` — Product quantities and reserved stock at each warehouse.

6\. `SupplierProducts` — Relationships between suppliers and products.

7\. `PurchaseOrders` — Purchase order details and statuses.

8\. `PurchaseOrderItems` — Products and quantities associated with purchase orders.

9\. `CustomerOrders` — Customer order details and statuses.

10\. `OrderItems` — Products, quantities, and prices associated with customer orders.

11\. `Shipments` — Shipment details, carriers, tracking numbers, and statuses.

12\. `ShipmentItems` — Products and quantities included in shipments.

13\. `InventoryAlerts` — Low-stock alerts and their statuses.

14\. `InventoryTransfers` — Inventory transfers between warehouses.

15\. `FulfillmentLog` — Order fulfillment activity records.

16\. `Backorders` — Products and quantities awaiting fulfillment.



##### &#x20; Relationships



\- One warehouse can store multiple inventory records.

\- One product can be stored in multiple warehouses.

\- Suppliers and products are associated through `SupplierProducts`.

\- One customer can place multiple customer orders.

\- One customer order can contain multiple order items.

\- Purchase orders can contain multiple purchase order items.

\- Warehouses can be associated with multiple shipments.

\- Shipments can contain multiple shipment items.

\- Inventory transfers connect source and destination warehouses.

\- Products and warehouses can be associated with inventory alerts and backorders.



##### &#x20; MySQL Topics Demonstrated



\- Database and table creation

\- Primary keys and foreign keys

\- Relational database design

\- Data insertion and retrieval

\- Filtering, sorting, and aggregate queries

\- Joins and inventory reporting

\- Views

\- Stored procedures

\- Triggers

\- Inventory monitoring

\- Supply chain and order management



##### &#x20;  Views



`vw\_WarehouseFulfillmentMetrics` — Displays warehouse and product inventory information, including total quantity, reserved quantity, available quantity, safety-stock threshold, and stock status.



##### &#x20;  Stored Procedure



`sp\_AllocateAndFulfillOrder` — Accepts a customer order ID and retrieves the related order and order-item details for fulfillment processing.



Note: The current procedure retrieves order information. Complete inventory allocation and fulfillment logic can be implemented as a future enhancement.



##### &#x20;   Triggers



`trg\_low\_stock\_alert` — Executes after an update to `WarehouseInventory`. It calculates available stock and inserts an alert into `InventoryAlerts` when available stock is at or below the product's safety-stock threshold.



##### &#x20;   Inventory Monitoring



The project monitors stock availability using the following calculation:



Available Quantity = Total Quantity - Reserved Quantity



When the available quantity reaches or falls below the safety-stock threshold, the trigger creates a low-stock alert.



##### &#x20;   How to Run



1\. Start MySQL Server and open MySQL Command Line Client.

2\. Select the `SupplyChain` database or create it if necessary.

3\. Execute the SQL statements that create the project tables.

4\. Insert the sample data into the tables.

5\. Create the view, stored procedure, and trigger.

6\. Execute the SQL queries to inspect inventory, orders, shipments, and alerts.

7\. Verify the database objects and test the low-stock trigger.



Note: Execute the SQL statements in the correct order so that tables are created before dependent database objects and data are added.



##### &#x20;   Project Status



\- 16 database tables created and verified.

\- Sample data inserted.

\- Warehouse fulfillment metrics view created and verified.

\- Stored procedure created and verified.

\- Low-stock trigger created and tested.

\- Database objects checked using MySQL Command Line Client.



##### &#x20;  Future Enhancements



\- Implement complete inventory allocation and order fulfillment.

\- Automatically update stock when orders are fulfilled.

\- Add transaction handling and exception management.

\- Develop advanced warehouse and inventory reports.

\- Create a dashboard for warehouse performance monitoring



