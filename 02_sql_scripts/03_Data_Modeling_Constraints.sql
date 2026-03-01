/*    
   SCRIPT: 03_Data_Modeling_Constraints.sql
   AUTHOR: Aaron Olmedo
   DESCRIPTION: 
   This script alters the existing tables to add FOREIGN KEY constraints.
   It transforms isolated tables into a relational Star Schema, ensuring 
   referential integrity.
*/

-- 1. Link Orders to Customers
-- (An order cannot exist without a valid customer)
ALTER TABLE olist_orders_dataset
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (customer_id) REFERENCES olist_customers_dataset(customer_id);
GO

-- 2. Link Order Items to Orders
-- (Items must belong to a valid order)
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT FK_Items_Orders
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
GO

-- 3. Link Order Items to Products
-- (You can't sell a product that isn't in the catalog)
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT FK_Items_Products
FOREIGN KEY (product_id) REFERENCES olist_products_dataset(product_id);
GO

-- 4. Link Order Items to Sellers
-- (Items must be sold by a registered seller)
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT FK_Items_Sellers
FOREIGN KEY (seller_id) REFERENCES olist_sellers_dataset(seller_id);
GO

-- 5. Link Reviews to Orders
-- (A review must be attached to a real order)
ALTER TABLE olist_order_reviews_dataset
ADD CONSTRAINT FK_Reviews_Orders
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
GO

-- 6. Link Payments to Orders
ALTER TABLE olist_order_payments_dataset
ADD CONSTRAINT FK_Payments_Orders
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
GO


/* ============================================================================
   SCRIPT: Fix and Link Category Translation to Products
============================================================================ */

-- Step 1: Make the column NOT NULL (A requirement for Primary Keys)
ALTER TABLE product_category_name_translation
ALTER COLUMN product_category_name NVARCHAR(100) NOT NULL;
GO

-- Step 2: Now we can safely make it the Primary Key
ALTER TABLE product_category_name_translation
ADD CONSTRAINT PK_Category_Translation PRIMARY KEY (product_category_name);
GO

-- Step 3: Link the Products table to the Translation table
ALTER TABLE olist_products_dataset
ADD CONSTRAINT FK_Products_Translation
FOREIGN KEY (product_category_name) REFERENCES product_category_name_translation(product_category_name);
GO