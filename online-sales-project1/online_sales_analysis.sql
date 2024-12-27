-- Retrieve all records from the table
SELECT * 
FROM transactions_2;

-- Analysis of Payment Methods: Determine the most used payment methods by customers (Credit Card, PayPal, Debit Card).
SELECT 
    payment_method,
    COUNT(payment_method) AS Used_Methods,
    ROUND(SUM(total_revenue), 2) AS Total_Revenue,
	CONCAT(ROUND(COUNT(payment_method) * 100.0 / SUM(COUNT(payment_method)) OVER(), 2), '%') AS Percent_Used
FROM 
    transactions_2
GROUP BY payment_method
ORDER BY used_methods DESC
;

-- Sales Trend Analysis: Observe sales trends by month, identifying peaks and drops in sales.
SELECT 
    DATE_FORMAT(`date`, '%Y-%m') AS year_month_date, 
    SUM(units_sold) AS Total_Units, 
    ROUND(SUM(total_revenue), 2) AS Total_Revenue
FROM transactions_2
GROUP BY year_month_date
ORDER BY year_month_date
;

-- Analysis of Product Categories: Determine the average unit price, total units sold, total revenue, and average revenue per unit for each product category.
SELECT 
    product_category,
    ROUND(AVG(unit_price), 2) AS Avg_Unit_Price, 
    ROUND(SUM(units_sold), 2) AS Total_Units_Sold, 
    ROUND(SUM(total_revenue), 2) AS Total_Revenue,
    ROUND((SUM(total_revenue) / SUM(units_sold)), 2) AS Avg_Revenue_Per_Unit
FROM transactions_2
GROUP BY product_category
ORDER BY Avg_Unit_Price DESC
;

-- Analysis of Price Ranges: Classify products into price ranges (Low, Medium, High) and analyze their average unit price, total units sold, total revenue, and average revenue per unit.
SELECT 
    CASE
        WHEN unit_price < 100 THEN 'Low'
        WHEN unit_price BETWEEN 100 AND 500 THEN 'Medium'
        WHEN unit_price > 500 THEN 'High'
    END AS price_range,
    ROUND(AVG(unit_price), 2) AS Avg_Unit_Price, 
    SUM(units_sold) AS Total_Units_Sold, 
    ROUND(SUM(total_revenue), 2) AS Total_Revenue,
    ROUND((SUM(total_revenue) / SUM(units_sold)), 2) AS Avg_Revenue_Per_Unit
FROM transactions_2
GROUP BY price_range
ORDER BY Avg_Unit_Price DESC
;

-- Regional Analysis: Determine the average unit price, total units sold, and total revenue for each region.
SELECT 
    Region,
    ROUND(AVG(unit_price), 2) AS Avg_Unit_Price, 
    SUM(units_sold) AS Total_Units_Sold, 
    ROUND(SUM(total_revenue), 2) AS Total_Revenue
FROM transactions_2
GROUP BY region
ORDER BY Total_Revenue DESC
;


-- View Creation: Product Category Analysis
-- This view calculates the average unit price, total units sold, total revenue, 
-- and average revenue per unit for each product category.
CREATE OR REPLACE VIEW Product_Category_Analysis AS
SELECT 
    product_category,
    ROUND(AVG(unit_price), 2) AS Avg_Unit_Price, 
    ROUND(SUM(units_sold), 2) AS Total_Units_Sold, 
    ROUND(SUM(total_revenue), 2) AS Total_Revenue,
    ROUND((SUM(total_revenue) / SUM(units_sold)), 2) AS Avg_Revenue_Per_Unit
FROM transactions_2
GROUP BY product_category
ORDER BY Avg_Unit_Price DESC
;

-- Calling the View
SELECT * FROM Product_Category_Analysis
;

-- Common Table Expression (CTE): Price Range Analysis 
-- This CTE categorizes products into price ranges (Low, Medium, High)
WITH price_range_cte AS (
SELECT 
    CASE
        WHEN unit_price < 100 THEN 'Low'
        WHEN unit_price BETWEEN 100 AND 500 THEN 'Medium'
        WHEN unit_price > 500 THEN 'High'
    END AS price_range,
    ROUND(AVG(unit_price), 2) AS Avg_Unit_Price, 
    SUM(units_sold) AS Total_Units_Sold, 
    ROUND(SUM(total_revenue), 2) AS Total_Revenue,
    ROUND((SUM(total_revenue) / SUM(units_sold)), 2) AS Avg_Revenue_Per_Unit
FROM transactions_2
GROUP BY price_range
)
-- Calling the CTE  
SELECT *
FROM price_range_cte
ORDER BY Avg_Unit_Price DESC;


-- INDEX CREATION
-- Index on payment_method
CREATE INDEX idx_payment_method ON transactions_2(payment_method);

-- Index on date
CREATE INDEX idx_date ON transactions_2(date);

-- Index on product_category
CREATE INDEX idx_product_category ON transactions_2(product_category);

-- Index on region
CREATE INDEX idx_region ON transactions_2(region);
