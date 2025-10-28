# SQL_RETAIL-SALES-ANALYSIS---P1

📘 Project Overview
Project Title: Retail Sales Analysis
Skill Level: Beginner
Database: p1_retail_db
This project demonstrates foundational SQL techniques for data analysis and business insights within a retail environment. It focuses on creating, cleaning, and analyzing sales data to extract meaningful patterns and support business decision-making.
The project simulates a typical data analyst workflow — from database creation and data preparation to exploratory analysis (EDA) and business-oriented SQL reporting.
🎯 Objectives
Database Setup: Build and populate a relational database for retail sales transactions.
Data Cleaning: Identify and eliminate null or inconsistent records to ensure data accuracy.
Exploratory Data Analysis (EDA): Examine key metrics to understand customer demographics and sales performance.
Business Insights: Write SQL queries to answer strategic business questions and generate actionable findings.
🧩 Project Structure
1. Database Setup
The analysis begins with the creation of a dedicated database p1_retail_db and a core table retail_sales.
The table contains essential transaction-level details such as date, time, customer information, and sales metrics.
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
The cleaning process ensures reliable analysis by removing incomplete or invalid records.
Key steps include counting total records, identifying unique customers, listing available categories, and eliminating null entries.
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
3. Data Analysis & Business Queries
The following SQL queries were designed to uncover key performance insights and answer practical business questions:
Retrieve all sales made on a specific date (e.g., 2022-11-05):
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
Find all ‘Clothing’ transactions with quantity > 4 during November 2022:
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
Calculate total and count of sales by category:
SELECT category,
       SUM(total_sale) AS net_sale,
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
Find the average customer age for the ‘Beauty’ category:
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
List all transactions exceeding ₹1000 in total sale value:
SELECT * FROM retail_sales
WHERE total_sale > 1000;
Count transactions by gender and category:
SELECT category,
       gender,
       COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
Identify the highest-performing month per year based on average sales:
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
Top 5 customers by total sales volume:
SELECT customer_id,
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
Unique customer count per category:
SELECT category,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
Classify transactions by shift (Morning, Afternoon, Evening):
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
📊 Key Findings
Customer Demographics: The dataset features diverse age groups, with most purchases made in the Clothing and Beauty categories.
High-Value Transactions: Several large transactions exceeded ₹1000, indicating premium buyers.
Seasonality: Monthly averages reveal noticeable sales peaks, useful for inventory and marketing planning.
Customer Insights: Identifies both top-spending customers and the most popular categories, highlighting opportunities for loyalty programs.
📈 Generated Reports
Sales Overview: Summarizes revenue, total transactions, and product category performance.
Trend Analysis: Tracks sales growth and variations across time and shifts.
Customer Analysis: Highlights unique buyers, repeat customers, and spending behavior by demographic.
🧩 Conclusion
This project provides a complete, beginner-friendly introduction to SQL for Data Analysis.
It walks through database design, data cleaning, exploratory analysis, and insight generation.
The results illustrate how SQL can be applied to uncover actionable trends in retail operations, customer behavior, and product performance.
⚙️ How to Use
Clone the Repository:
Copy the project to your local machine using Git or download as a ZIP.
Database Setup:
Execute database_setup.sql to create and populate the retail database.
Run Queries:
Use the scripts in analysis_queries.sql to perform your analysis.
Experiment & Extend:
Modify or create new queries to explore additional insights or KPIs.
