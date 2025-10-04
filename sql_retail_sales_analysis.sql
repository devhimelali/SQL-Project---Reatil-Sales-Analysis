/*
 * Project Name: Retial Sells Analysis
 */

-- Delete The retial_sells database if the database already exists
DROP DATABASE IF EXISTS sql_retail_sales_analysis;

-- Create the database named sql_retail_sales_analysis
CREATE DATABASE sql_retail_sales_analysis;

-- Use the database
USE sql_retail_sales_analysis;

-- Create Table
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date       DATE,
    sale_time       TIME,
    customer_id     INT,
    gender          VARCHAR(15),
    age             INT,
    category        VARCHAR(15),
    quantiy         INT,
    price_per_unit  FLOAT,
    cogs            FLOAT,
    total_sale      INT
)

-- Retrieve all columns
SELECT *
FROM retail_sales
LIMIT 10;

-- Number of records we have?
SELECT COUNT(*)
FROM retail_sales;

-- Explore the null data
SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Data cleaning
DELETE
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

/*
 * Data Exploration
 */
-- 1. How many unique customer we have?
SELECT COUNT(DISTINCT customer_id) AS total_unique_customer
FROM retail_sales;

-- how many unique category we have?
SELECT COUNT(DISTINCT category) AS number_of_category
FROM retail_sales;

-- Retrieve All unique categories names
SELECT DISTINCT category
FROM retail_sales;

/*
 * Data Analysis & Business key Problem & Answers
 */

-- Q.1-> Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT *
FROM retail_sales
where sale_date = '2022-11-05';

-- Q.2 -> Write a SQL query to retrieve all transactions where category is 'Clothing' and the quantity sold is more than 3 in month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy > 3
  AND DATE_FORMAT(sale_date, '%m-%Y') = '11-2022';

-- Q.3 -> Write a SQL query to calculate the total sales (total_sale) and total_order for each category
SELECT category,
       SUM(total_sale) AS total_sale,
       COUNT(*)        AS total_order
FROM retail_sales
GROUP BY category;

-- Q.4 -> Write a SQL query to find the average age of the customers who purchased items from the 'Beauty' category.
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 -> Write a sql query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 -> Write a SQL query to find the total number if transactions (transactions_id) made by each gender in each category
SELECT category,
       gender,
       COUNT(transactions_id) AS number_of_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Q.7 -> Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year.
SELECT *
FROM (SELECT YEAR(sale_date)  AS year,
             MONTH(sale_date) AS month,
             AVG(total_sale)  AS avg_sale,
             RANK() OVER (
                 PARTITION BY YEAR(sale_date)
                 ORDER BY AVG(total_sale) DESC
                 )            AS rank_in_year
      FROM retail_sales
      GROUP BY YEAR(sale_date), MONTH(sale_date)) as t1
WHERE t1.rank_in_year = 1;

-- Q.8 -> Write a SQL query to find the top  5 customers based on the highest total sales.
SELECT customer_id,
       SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 -> Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
       COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales
GROUP BY category;

-- Q.10 -> Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon between 12 & 17. evening > 17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT
    shift,
    COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift