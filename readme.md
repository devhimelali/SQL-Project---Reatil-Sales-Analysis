# 🛒 Retail Sales Analysis (SQL Project)

## 📌 Project Overview

This project demonstrates how SQL can be used to explore, clean, and analyze retail sales data.

Using a fictional **retail sales database** (`sql_retail_sales_analysis`), the project walks through:

* Setting up the database and table structure
* Cleaning the data by removing null or incomplete records
* Performing exploratory data analysis (EDA)
* Answering key business questions through SQL queries

___

## 🎯 Objectives

* **Database Setup:** Create and populate a retail sales database.
* **Data Cleaning:** Detect and handle missing values.
* **Exploratory Data Analysis:** Run SQL queries to understand the dataset.
* **Business Insights:** Answer common sales-related questions, such as identifying top customers, high-value
  transactions, and sales trends.

___

## 🗂 Project Structure

### 1. **Database Setup:**

* Create sql_retail_sales_analysis database
     ```sql
     CREATE
     DATABASE sql_retail_sales_analysis;
     ```

* Create retail_sales table with fields like `transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`,
  `age`, `category`, `quantity`, `price_per_unit`, `cogs`, `total_sale`.
     ```sql
     CREATE TABLE retail_sales (
         transactions_id INT PRIMARY KEY,
         sale_date DATE,
         sale_time TIME,
         customer_id INT,
         gender VARCHAR(10),
         age INT,
         category VARCHAR(35),
         quantity INT,
         price_per_unit FLOAT,
         cogs FLOAT,
         total_sale FLOAT
     );
     ```

### 2. **Data Exploration & Cleaning:**

* **Record count:-**
     ```sql
     SELECT COUNT(*)
     FROM retail_sales;
     ```
* **Unique customer and category counts:-**
    ```sql
    -- Unique customer count
    SELECT COUNT(DISTINCT customer_id)
    FROM retail_sales;
    
    -- Unique category count
    SELECT DISTINCT category
    FROM retail_sales;
    ```

    * **Null value checks and clean-up:-**
        ```sql
        -- Null value checks
        SELECT *
        FROM retail_sales
        WHERE sale_date IS NULL
           OR sale_time IS NULL
           OR customer_id IS NULL
           OR gender IS NULL
           OR age IS NULL
           OR category IS NULL
           OR quantity IS NULL
           OR price_per_unit IS NULL
           OR cogs IS NULL;
      
        -- Null value clean-up
        DELETE
        FROM retail_sales
        WHERE sale_date IS NULL
           OR sale_time IS NULL
           OR customer_id IS NULL
           OR gender IS NULL
           OR age IS NULL
           OR category IS NULL
           OR quantity IS NULL
           OR price_per_unit IS NULL
           OR cogs IS NULL;
        ```

### 3. **Analysis Queries**

   Example queries are included in the project:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05:**
    ```sql
    SELECT *
    FROM retail_sales
    WHERE sale_date = '2022-11-05';
    ```
2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
    ```sql
    SELECT *
    FROM retail_sells
    WHERE category = 'Clothing'
      AND quantiy > 3
      AND DATE_FORMAT(sale_date, '%m-%Y') = '11-2022';
    ```
3. Write a SQL query to calculate the total sales (total_sale) for each category:
    ```sql
    SELECT category,
        SUM(total_sale) AS total_sale,
        COUNT(*) AS total_order
    FROM retail_sells
    GROUP BY category;
    ```
4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
    ```sql
    SELECT category,
       SUM(total_sale) AS total_sale,
       COUNT(*) AS total_order
    FROM retail_sells
    GROUP BY category;
    ```
5. Write a SQL query to find all transactions where the total_sale is greater than 1000:
    ```sql
    SELECT *
    FROM retail_sells
    WHERE total_sale > 1000;
    ```
6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:
    ```sql
    SELECT category,
           gender,
           COUNT(transactions_id) AS number_of_transaction
    FROM retail_sells
    GROUP BY category, gender
    ORDER BY category;
    ```
7. Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year:
    ```sql
    SELECT *
    FROM (SELECT YEAR (sale_date) AS year, 
        MONTH (sale_date) AS month, 
        AVG (total_sale) AS avg_sale, 
        RANK() OVER (
              PARTITION BY YEAR (sale_date)
              ORDER BY AVG (total_sale) DESC
              ) AS rank_in_year
        FROM retail_sells
        GROUP BY YEAR (sale_date), MONTH (sale_date)) as t1
    WHERE t1.rank_in_year = 1;
    ```
8. Write a SQL query to find the top 5 customers based on the highest total sales:
    ```sql
    SELECT
        customer_id,
        SUM(total_sale) as total_sales
    FROM retail_sells
    GROUP BY customer_id
    ORDER BY total_sales DESC
    LIMIT 5
    ```
9. Write a SQL query to find the number of unique customers who purchased items from each category:
    ```sql
    SELECT category,
           COUNT(DISTINCT customer_id) AS unique_customer
    FROM retail_sells
    GROUP BY category;
    ```
10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
    ```sql
    WITH hourly_sale
             AS
             (SELECT *,
                     CASE
                         WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
                         WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                         ELSE 'Evening'
                         END as shift
              FROM retail_sells)
    SELECT shift,
           COUNT(*) as total_orders
    FROM hourly_sale
    GROUP BY shift;
    ```

### **4. Findings**

* Customers span multiple demographics
* Some transactions exceed 1000 → premium purchases
* Seasonal sales patterns visible in monthly trends
* Top customers and best-selling categories identified
___

## 📊 Example Insights

* **High-Value Purchases:** Transactions above 1000 show premium product demand.
* **Customer Behavior:** Unique customer counts per category help identify loyal segments.
* **Sales Trends:** Monthly and shift-based analysis reveal when customers shop most.
* **Category Performance:** Clothing and Beauty stand out among popular product categories.
___
## 📁 Reports

* **Sales Summary:** Total sales, demographics, and category performance
* **Trend Analysis:** Monthly peaks and daily shift sales patterns
* **Customer Insights:** Top customers and loyalty by category
___

## 🧑‍💻 Tech Stack

* **Database:** PostgreSQL / MySQL (works with any SQL database)
* **Language:** SQL

## ✅ Conclusion

This project gives beginners hands-on experience with SQL for data analysis. By setting up a database, cleaning data, and answering business-driven questions, it provides a solid foundation for anyone starting their journey into **data analytics.**

📌 Feel free to fork this repo, practice the queries, and build on top of it!