-- =======================================================
-- Sales Data Analysis Project
-- Author: Freddy Higa
-- Description: SQL analysis of sales dataset 
-- including revenue, customer behavior, and profitability
-- =======================================================

-- Total sales
SELECT SUM(sales_amount) AS total_revenue
FROM sales;

-- Total number of transactions
SELECT COUNT(*) AS total_transactions
FROM sales;

-- Average sales amount per transaction
SELECT AVG(sales_amount) AS avg_sale
FROM sales;

-- Sales by region
SELECT region, SUM(sales_amount) AS revenue
FROM sales
GROUP BY region
ORDER BY revenue DESC;

-- Region with highest revenue
SELECT region
FROM sales
GROUP BY region
ORDER BY SUM(sales_amount) DESC
FETCH FIRST 1 ROW ONLY;

-- Sales rep ranking with rank number
SELECT sales_rep,
       SUM(sales_amount) AS revenue,
       RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS rank
FROM sales
GROUP BY sales_rep;

-- Best-selling categories
SELECT product_category, SUM(sales_amount) AS revenue
FROM sales
GROUP BY product_category
ORDER BY revenue DESC;

-- New vs returning customers
SELECT customer_type, SUM(sales_amount) AS revenue
FROM sales
GROUP BY customer_type;

-- Payment method
SELECT payment_method, COUNT(*) AS transactions
FROM sales
GROUP BY payment_method
ORDER BY transactions DESC;

-- Sales channel
SELECT sales_channel, SUM(sales_amount) AS revenue
FROM sales
GROUP BY sales_channel;

-- Strongest region + category
SELECT region, product_category, SUM(sales_amount) AS revenue
FROM sales
GROUP BY region, product_category
ORDER BY revenue DESC;

-- Profitability analysis by product
SELECT product_id, 
    SUM(quantity_sold * unit_price) AS revenue,
    SUM(quantity_sold * unit_cost) AS cost,
    SUM((unit_price - unit_cost) * quantity_sold) AS profit
FROM sales
GROUP BY product_id
ORDER BY profit DESC;

-- Monthly sales trend
SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month,
    SUM(sales_amount) AS revenue
FROM sales
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY TO_DATE(month, 'YYYY-MM');
