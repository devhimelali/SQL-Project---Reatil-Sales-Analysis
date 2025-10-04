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
6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:
7. Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year:
8. Write a SQL query to find the top 5 customers based on the highest total sales:
9. Write a SQL query to find the number of unique customers who purchased items from each category:
10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):