# Retail Sales Analysis (Project 1)

Project Title: Retail Sales Analysis
Skill Level: Beginner
Database: p1_retail_db

Overview
--------
This repository contains a beginner-friendly SQL project that demonstrates foundational techniques for analyzing retail sales data. The project walks through database creation, data preparation and cleaning, exploratory data analysis (EDA), and the generation of business-focused insights using SQL.

Objectives
----------
- Database Setup: Create and populate a relational database for retail transactions.
- Data Cleaning: Identify and remove null or inconsistent records to ensure data quality.
- Exploratory Data Analysis: Compute key metrics to understand customer demographics and sales performance.
- Business Insights: Produce SQL reports that answer strategic business questions and support decision-making.

Project Structure
-----------------
1. Database Setup
   - Create a dedicated database (p1_retail_db) and a core table (retail_sales) to store transaction-level data.
   - Example table schema:

   CREATE DATABASE p1_retail_db;

   CREATE TABLE retail_sales
   (
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

2. Data Exploration & Cleaning
   - Inspect the dataset for completeness and consistency before analysis.
   - Example queries:

   SELECT COUNT(*) FROM retail_sales;
   SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
   SELECT DISTINCT category FROM retail_sales;

   -- Identify rows with NULL values in key fields
   SELECT * FROM retail_sales
   WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
         gender IS NULL OR age IS NULL OR category IS NULL OR 
         quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

   -- Remove incomplete records (use with caution; consider backing up first)
   DELETE FROM retail_sales
   WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
         gender IS NULL OR age IS NULL OR category IS NULL OR 
         quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

3. Data Analysis & Business Queries
   - A set of representative SQL queries to answer common business questions.

   -- Retrieve all sales on a specific date (e.g., 2022-11-05)
   SELECT * FROM retail_sales
   WHERE sale_date = '2022-11-05';

   -- Find 'Clothing' transactions with quantity >= 4 in November 2022
   SELECT *
   FROM retail_sales
   WHERE category = 'Clothing'
     AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
     AND quantity >= 4;

   -- Total revenue and order count by category
   SELECT category,
          SUM(total_sale) AS net_sale,
          COUNT(*) AS total_orders
   FROM retail_sales
   GROUP BY category;

   -- Average customer age for the 'Beauty' category
   SELECT ROUND(AVG(age), 2) AS avg_age
   FROM retail_sales
   WHERE category = 'Beauty';

   -- Transactions exceeding ₹1000
   SELECT * FROM retail_sales
   WHERE total_sale > 1000;

   -- Transaction counts by gender and category
   SELECT category,
          gender,
          COUNT(*) AS total_transactions
   FROM retail_sales
   GROUP BY category, gender
   ORDER BY category;

   -- Highest-performing month per year based on average sales
   SELECT year, month, avg_sale
   FROM (
       SELECT EXTRACT(YEAR FROM sale_date) AS year,
              EXTRACT(MONTH FROM sale_date) AS month,
              AVG(total_sale) AS avg_sale,
              RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)
                          ORDER BY AVG(total_sale) DESC) AS rank
       FROM retail_sales
       GROUP BY 1, 2
   ) AS ranked_sales
   WHERE rank = 1;

   -- Top 5 customers by total sales
   SELECT customer_id,
          SUM(total_sale) AS total_sales
   FROM retail_sales
   GROUP BY customer_id
   ORDER BY total_sales DESC
   LIMIT 5;

   -- Unique customer count per category
   SELECT category,
          COUNT(DISTINCT customer_id) AS unique_customers
   FROM retail_sales
   GROUP BY category;

   -- Classify transactions by shift (Morning, Afternoon, Evening)
   WITH hourly_sales AS (
       SELECT *,
              CASE
                  WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
                  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                  ELSE 'Evening'
              END AS shift
       FROM retail_sales
   )
   SELECT shift,
          COUNT(*) AS total_orders
   FROM hourly_sales
   GROUP BY shift;

Key Findings
------------
- Customer Demographics: The dataset includes diverse age groups, with a concentration of purchases in the Clothing and Beauty categories.
- High-Value Transactions: Multiple transactions exceed ₹1000, indicating the presence of premium buyers.
- Seasonality: Average sales by month show patterns that can inform inventory and marketing planning.
- Customer Insights: Identification of top-spending customers and popular categories suggests opportunities for targeted loyalty programs and promotions.

Generated Reports
-----------------
- Sales Overview: Revenue summary, transaction counts, and category performance.
- Trend Analysis: Time-series and shift-based sales trends.
- Customer Analysis: Unique and repeat customer metrics, and demographic-driven insights.

How to Use
----------
1. Clone the repository:
   git clone https://github.com/Av0210/SQL_RETAIL-SALES-ANALYSIS---P1.git

2. Database setup:
   - Run the provided database_setup.sql to create the p1_retail_db and populate the retail_sales table.

3. Run analysis:
   - Execute queries in analysis_queries.sql or run the sample queries in your SQL client to reproduce the analysis.

4. Extend the project:
   - Add new queries, KPIs, or visualizations. Consider exporting results to CSV for use in BI tools.

Notes
-----
- Back up your data before running DELETE operations.
- Adjust SQL dialect functions (e.g., TO_CHAR, EXTRACT) to match your RDBMS (PostgreSQL, MySQL, etc).

---

This README has been formatted to provide a clear, professional overview of the Retail Sales Analysis project and guidance for reproducing and extending the work.