-- Walmart Sales Analysis Project

CREATE DATABASE walmartDB;
USE walmartDB;

-- fixing date format
UPDATE walmart
SET transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y %H:%i');

ALTER TABLE walmart
MODIFY transaction_date DATETIME;

-- base view with calculated sales
CREATE OR REPLACE VIEW base_sales AS
SELECT 
    transaction_id,
    product_name,
    category,
    quantity_sold,
    unit_price,
    quantity_sold * unit_price AS sales,
    transaction_date,
    store_location,
    promotion_applied,
    holiday_indicator,
    weather_conditions
FROM walmart;

-- monthly sales trend
CREATE OR REPLACE VIEW monthly_sales AS
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    ROUND(SUM(quantity_sold * unit_price), 2) AS total_sales
FROM walmart
GROUP BY month
ORDER BY month;

-- category performance
CREATE OR REPLACE VIEW sales_by_category AS
SELECT 
    category,
    ROUND(SUM(quantity_sold * unit_price), 2) AS total_sales
FROM walmart
GROUP BY category;

-- store-wise sales
CREATE OR REPLACE VIEW sales_by_store AS
SELECT 
    store_location,
    ROUND(SUM(quantity_sold * unit_price), 2) AS total_sales
FROM walmart
GROUP BY store_location;

-- promotion impact
CREATE OR REPLACE VIEW promotion_impact AS
SELECT 
    promotion_applied,
    ROUND(SUM(quantity_sold * unit_price), 2) AS total_sales
FROM walmart
GROUP BY promotion_applied;

-- holiday impact
CREATE OR REPLACE VIEW holiday_impact AS
SELECT 
    holiday_indicator,
    ROUND(SUM(quantity_sold * unit_price), 2) AS total_sales
FROM walmart
GROUP BY holiday_indicator;

-- quick checks
SELECT * FROM base_sales LIMIT 5;
SELECT * FROM monthly_sales;