/* PROJECT: OLIST SUPPLY CHAIN & E-COMMERCE ANALYTICS
   SCRIPT: 02_Data_Ingestion_Bulk_Insert.sql
   AUTHOR: Aaron Olmedo 
   DESCRIPTION: 
   This script loads the raw CSV data into the previously created SQL tables 
   using the BULK INSERT command.
   
   IMPORTANT: 
   - Update the 'FROM' file path to match your local machine directory.
   - CODEPAGE = '65001' is used to correctly import UTF-8 characters (Portuguese accents).
   - FORMAT = 'CSV' handles text qualifiers (double quotes) in the dataset.
*/

USE olist_supply_chain;
GO

--1. LOAD DIMENSION TABLES
	--Load Customers Table
BULK INSERT olist_customers_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_customers_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');

	--Load Geolocation Table
BULK INSERT olist_geolocation_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_geolocation_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');

	--Load Sellers Table
BULK INSERT olist_sellers_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_sellers_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');

	--Load Products Table
BULK INSERT olist_products_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_products_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');

	--Load Product Category Name Translation Table
BULK INSERT product_category_name_translation
FROM 'C:\Datos_Olist_Supply_Chain\product_category_name_translation.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');

--2. LOAD FACT TABLES
	--Load Orders Table
BULK INSERT olist_orders_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_orders_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');

--3. LOAD TRANSACTIONAL DETAIL TABLES
	--Load Order Items Table
BULK INSERT olist_order_items_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_order_items_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');

	--Load Order Payments Table
BULK INSERT olist_order_payments_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_order_payments_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');


--*** NOTE: BULK INSERT fails here due to line breaks (Enter) in user comments. 
--*** SOLUTION: Load this specific CSV using the SSMS GUI (Tasks -> Import Flat File).

	--Load Order Reviews Table
BULK INSERT olist_order_reviews_dataset
FROM 'C:\Datos_Olist_Supply_Chain\olist_order_reviews_dataset.csv'
WITH (FORMAT = 'CSV',FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '0X0a',CODEPAGE = '65001');



--   FIX: Drop the empty original table and rename the successfully loaded one.
DROP TABLE olist_order_reviews_dataset;
GO
-- Rename your newly created table to match the official project name
-- sp_rename is a built-in SQL Server procedure to rename objects
EXEC sp_rename 'olist_order_review_dataset', 'olist_order_reviews_dataset';
GO