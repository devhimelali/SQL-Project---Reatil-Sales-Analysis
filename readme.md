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
* **Business Insights:** Answer common sales-related questions, such as identifying top customers, high-value transactions, and sales trends.
___

## 🗂 Project Structure

### 1. **Database Setup:**

   * Create sql_retail_sales_analysis database
        ```sql
        CREATE
        DATABASE sql_retail_sales_analysis;
        ```

   * Create retail_sales table with fields like `transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`, `category`, `quantity`, `price_per_unit`, `cogs`, `total_sale`.
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