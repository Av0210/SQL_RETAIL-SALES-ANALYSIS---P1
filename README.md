#   PROJECT -1
# RETAIL-SALES-ANALYSIS
## **Project Overview**

.. **Project Title**: Retail Sales Analysis
.. **Skill Level**: Beginner 
.. **Database**: `sql_project_p1`

This project demonstrates foundational SQL techniques for data analysis and business insights within a retail environment. It focuses on creating, cleaning, and analyzing sales data to extract meaningful patterns and support business decision-making.
The project simulates a typical data analyst workflow — from database creation and data preparation to exploratory analysis (EDA) and business-oriented SQL reporting

### Objectives

1. **Database Setup**: Build and populate a relational database for retail sales transactions.
2. **Data Cleaning**: Identify and eliminate null or inconsistent records to ensure data accuracy.
3. **Exploratory Data Analysis (EDA)**: Examine key metrics to understand customer demographics and sales performance.
4. **Business Insights**: Write SQL queries to answer strategic business questions and generate actionable findings.

## Project Structure

### 1. Database Setup
The analysis begins with the creation of a dedicated database `sql_project_p1` and a core table `retail_sales`.

```SQL
create database sql_project_p1
USE sql_project_p1 ;

-- create table reatil_sales
create table retail_sales(
    transactions_id	 INT PRIMARY KEY,
	sale_date	DATE,
    sale_time	TIME,
	customer_id	INT,
    gender VARCHAR(15),
    age	        INT,
    category	VARCHAR(20),
	quantity	    INT,
    price_per_unit	 FLOAT,
    cogs	         FLOAT,
    total_sale       FLOAT
);
```

### 2. Data Exploration & Cleaning
The cleaning process ensures reliable analysis by removing incomplete or invalid records.
Key steps include counting total records, identifying unique customers, listing available categories, and eliminating null entries.

```SQL
-- Data Cleaning  
SELECT * FROM retail_sales 
WHERE 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

DELETE FROM reatil_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Data Exploration
-- how many sales we have?
SELECT count(*) as total_sales FROM retail_sales ;

-- how many unique customers we have?

SELECT COUNT(distinct customer_id) from retail_sales;
SELECT	distinct category from retail_sales;
```
### 3. Data Analysis & Business Queries

The following SQL queries were designed to uncover key performance insights and answer practical business questions:

**Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05**
```sql
SELECT * FROM retail_sales 
where sale_date = '2022-11-05';
```
**Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022**
```sql
SELECT 
 category,
 SUM(quantity)
 FROM retail_sales
 WHERE category = 'Clothing'
 GROUP BY 1

SELECT transactions_id, sale_date, quantity, total_sale
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity >= 4 ;
```
**Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.**
```sql
 SELECT 
     category,
     SUM(total_sale) as net_sale,
     COUNT(*) as total_orders
     FROM retail_sales
     GROUP BY 1
```
**Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
SELECT 
ROUND(AVG(age),2) as avg_age
FROM retail_sales
 WHERE category = 'Beauty'
```
**Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.**
```sql
SELECT * FROM retail_sales 
WHERE total_sale > 1000
```
**Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**
```sql
SELECT 
   category,
   gender,
   count(*) as total_trans
   from retail_sales
   group by 
       category,
       gender 
ORDER BY 1 ;
```
**Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**
```sql
SELECT 
     year,
     month,
     avg_sale
FROM
(
SELECT
    YEAR (sale_date) as year,
    MONTH (sale_date) as month,
    AVG(total_sale) as avg_sale ,
    RANK() OVER (
    PARTITION BY YEAR(sale_date) 
    ORDER BY AVG(total_sale) DESC) AS sale_rank
    FROM retail_sales
    GROUP BY 1, 2 
) AS T1
WHERE sale_rank = 1
```
**highest average sale per month**
 ```sql
SELECT 
   YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    MAX(total_sale) AS max_sale
    FROM retail_sales
    GROUP BY 1, 2
    ORDER BY 1, 2;
```
**Top 3 Months per Year per Category**
```sql
 SELECT 
     year,
     category,
     month,
     avg_sale,
     sale_rank
     FROM (
     SELECT
        YEAR(sale_date) AS year,
        category,
        MONTH(sale_date) AS month,
         AVG(total_sale) AS avg_sale,
         RANK() OVER (
            PARTITION BY YEAR(sale_date), category
            ORDER BY AVG(total_sale) DESC
           ) AS sale_rank
           FROM retail_sales
           GROUP BY 1, 2, 3
           ) AS T1
   WHERE sale_rank <= 3
   ORDER BY year, category, sale_rank;
```  
**Q.8 Write a SQL query to find the top 5 customers based on the highest total sales**
```sql
 select 
   customer_id,
   SUM(total_sale) as total_sales
   From retail_sales 
   group by 1
   order by  2 DESC
   limit 5
```
**Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.**
```sql
SELECT 
     category,
     COUNT(DISTINCT customer_id) AS unique_customer
	 FROM retail_sales
     GROUP BY category
```
**Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**

-- common table expression 
```sql
WITH hourly_sale
AS
(
SELECT *,  
   CASE
   WHEN HOUR(sale_time) < 12 THEN 'morning'
   WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
   ELSE 'evening'
   END AS shift
FROM retail_sales 
)
SELECT 
       shift, 
      COUNT(*) as total_orders
      FROM Hourly_sale
      GROUP BY shift
```
 **Key Findings**
 
1. **Customer Demographics**: The dataset features diverse age groups, with most purchases made in the Clothing and Beauty categories.
2. **High-Value Transactions**: Several large transactions exceeded ₹1000, indicating premium buyers.
3. **Seasonality**: Monthly averages reveal noticeable sales peaks, useful for inventory and marketing planning.
4. **Customer Insights**: Identifies both top-spending customers and the most popular categories, highlighting opportunities for loyalty programs.

**Generated Reports**

1. **Sales Overview**: Summarizes revenue, total transactions, and product category performance.
2. **Trend Analysis**: Tracks sales growth and variations across time and shifts.
3. **Customer Analysis**: Highlights unique buyers, repeat customers, and spending behavior by demographic.

**Conclusion**

This project provides a complete, beginner-friendly introduction to SQL for Data Analysis.
It walks through database design, data cleaning, exploratory analysis, and insight generation.
The results illustrate how SQL can be applied to uncover actionable trends in retail operations, customer behavior, and product performance.

**How to Use**

1. **Clone the Repository**:
Copy the project to your local machine using Git or download as a ZIP.
2. **Database Setup**:
Execute database_setup.sql to create and populate the retail database.
3. **Run Queries**:
Use the scripts in analysis_queries.sql to perform your analysis.
4. **Experiment & Extend**:
Modify or create new queries to explore additional insights or KPIs.
