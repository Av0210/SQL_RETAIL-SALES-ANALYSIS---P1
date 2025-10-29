-- sql Retail sales Analysis p1
-- create database sql_project_p1
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
ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;


-- Data Cleaning  
SELECT * FROM retail_sales 
WHERE transactions_id is null ;

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
-- Data Exploration
-- how many sales we have?
SELECT count(*) as total_sales FROM retail_sales ;
-- how many unique customers we have?
SELECT COUNT(distinct customer_id) from retail_sales;
SELECT	distinct category from retail_sales; 

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales 
where sale_date = '2022-11-05';
-- Q.2 -- Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022
-- SELECT 
--  category,
--  SUM(quantity)
--  FROM retail_sales
--  WHERE category = 'Clothing'
--  GROUP BY 1
 
SELECT transactions_id, sale_date, quantity, total_sale
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity >= 4 ;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 --  SELECT 
--     category,
--     SUM(total_sale) as net_sale,
--     COUNT(*) as total_orders
--   FROM retail_sales
--   GROUP BY 1
 
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

-- SELECT 
-- ROUND(AVG(age),2) as avg_age
-- FROM retail_sales
--  WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

-- SELECT * FROM retail_sales 
-- WHERE total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- SELECT 
--    category,
--    gender,
--    count(*) as total_trans
--    from retail_sales
--    group by 
--        category,
--        gender 
-- ORDER BY 1 ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
-- do not have year , month columns
--  SELECT 
--      year,
--      month,
--      avg_sale
-- FROM
-- (
-- SELECT
--     YEAR (sale_date) as year,
--     MONTH (sale_date) as month,
--     AVG(total_sale) as avg_sale ,
--     RANK() OVER (
--     PARTITION BY YEAR(sale_date) 
--     ORDER BY AVG(total_sale) DESC) AS sale_rank
--     FROM retail_sales
--     GROUP BY 1, 2 
-- ) AS T1
-- WHERE sale_rank = 1


-- highest average sale per month
--    
-- SELECT 
--     YEAR(sale_date) AS year,
--     MONTH(sale_date) AS month,
--     MAX(total_sale) AS max_sale
-- FROM retail_sales
-- GROUP BY 1, 2
-- ORDER BY 1, 2;

-- Top 3 Months per Year per Category
-- SELECT 
--     year,
--     category,
--     month,
--     avg_sale,
--     sale_rank
-- FROM (
--     SELECT
--         YEAR(sale_date) AS year,
--         category,
--         MONTH(sale_date) AS month,
--         AVG(total_sale) AS avg_sale,
--         RANK() OVER (
--             PARTITION BY YEAR(sale_date), category
--             ORDER BY AVG(total_sale) DESC
--         ) AS sale_rank
--     FROM retail_sales
--     GROUP BY 1, 2, 3
-- ) AS T1
-- WHERE sale_rank <= 3
-- ORDER BY year, category, sale_rank;
 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 
--  select 
--    customer_id,
--    SUM(total_sale) as total_sales
--    From retail_sales 
--    group by 1
--    order by  2 DESC
--    limit 5 
 
 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 
 SELECT 
     category,
     COUNT(DISTINCT customer_id) AS unique_customer
	 FROM retail_sales
     GROUP BY category
	;
 
 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
-- common table expression 
-- WITH hourly_sale
-- AS
-- (
-- SELECT *,  
--    CASE
--    WHEN HOUR(sale_time) < 12 THEN 'morning'
--    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
--    ELSE 'evening'
--    END AS shift
-- FROM retail_sales 
-- )
-- SELECT 
--        shift, 
--       COUNT(*) as total_orders
--       FROM Hourly_sale
--       GROUP BY shift

-- HOUR(CURRENT_TIME()) as current hour

 -- END OF THE PROJECT -- 
 
 -- INTERMIDIATE --  
-- Sales & Revenue Insights
-- Q1. What is the overall revenue, total COGS, and total profit for the entire dataset? 
-- Q2. Which product category contributes the most to overall revenue and profit? 
-- Q3. What is the age distribution of top customers by total spending? 
-- Q4.How many repeat vs. one-time customers exist in the data? 
-- Q5. Identify the top 3 most profitable hours of the day.
-- Q6. What is the overall sales-to-cost ratio per category?
-- Q7.Which product category shows the highest month-on-month growth?
-- Q8.Identify the top 10 most profitable customers.
-- Q.9 Sales Efficiency (Quantity vs. Revenue Correlation Proxy)
-- Q.10 Profit per Category (Net Earnings)
-- Q.11 Seasonal Sales Trend (Quarterly Analysis)

-- Q1. What is the overall revenue, total COGS, and total profit for the entire dataset? 
SELECT 
    ROUND(SUM(total_sale), 2) AS total_revenue,
    ROUND(SUM(cogs), 2) AS total_cogs,
    ROUND(SUM(total_sale - cogs), 2) AS total_profit,
    ROUND(SUM(total_sale - cogs) / SUM(total_sale) * 100, 2) AS profit_margin_pct
FROM retail_sales;

SELECT *FROM retail_sales;

-- Q2. Which product category contributes the most to overall revenue and profit? 
SELECT 
    category,
    ROUND(SUM(total_sale), 2) AS total_revenue,
    ROUND(SUM(total_sale - cogs), 2) AS total_profit,
    ROUND(SUM(total_sale - cogs)/SUM(total_sale)*100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;
-- Q3. What is the age distribution of top customers by total spending? 
SELECT 
    CASE
        WHEN age < 25 THEN 'Youth (<25)'
        WHEN age BETWEEN 25 AND 40 THEN 'Adult (25–40)'
        WHEN age BETWEEN 41 AND 60 THEN 'Middle-age (41–60)'
        ELSE 'Senior (60+)'
    END AS age_group,
    ROUND(SUM(total_sale), 2) AS total_spent,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(total_sale), 2) AS avg_spent_per_order
FROM retail_sales
GROUP BY age_group
ORDER BY total_spent DESC;

-- Q4.How many repeat vs. one-time customers exist in the data? 
-- 
SELECT 
    CASE 
        WHEN c.total_visits = 1 THEN 'First-time Customer'
        ELSE 'Returning Customer'
    END AS customer_type,
    COUNT(*) AS num_customers
FROM (
    SELECT 
        customer_id,
        COUNT(DISTINCT sale_date) AS total_visits
    FROM retail_sales
    GROUP BY customer_id
) AS c
GROUP BY 
    CASE 
        WHEN c.total_visits = 1 THEN 'First-time Customer'
        ELSE 'Returning Customer'
    END;

-- To check first time user

SELECT COUNT(*) AS first_time_customers
FROM (
  SELECT customer_id
  FROM retail_sales
  GROUP BY customer_id
  HAVING COUNT(DISTINCT sale_date) = 1
) t;

-- Q5. Identify the top 3 most profitable hours of the day. 
SELECT 
    EXTRACT(HOUR FROM sale_time) AS hour,
    ROUND(SUM(total_sale - cogs), 2) AS profit
FROM retail_sales
GROUP BY EXTRACT(HOUR FROM sale_time)
ORDER BY profit DESC
LIMIT 3;

-- Q6. What is the overall sales-to-cost ratio per category?
-- Equation: Sales-to-Cost Ratio = SUM(total_sale) / SUM(cogs)
SELECT 
    category,
    ROUND(SUM(total_sale)/SUM(cogs), 2) AS sales_to_cost_ratio
FROM retail_sales
GROUP BY category
ORDER BY sales_to_cost_ratio DESC;
-- Q7.Which product category shows the highest month-on-month growth?
WITH monthly_sales AS (
    SELECT 
        category,
        DATE_FORMAT(sale_date, '%Y-%m') AS month,
        SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY category, DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT 
    category,
    month,
    total_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (PARTITION BY category ORDER BY month))
        / NULLIF(LAG(total_sales) OVER (PARTITION BY category ORDER BY month), 0) * 100,
        2
    ) AS growth_pct
FROM monthly_sales
ORDER BY category, month;


-- Q8.Identify the top 10 most profitable customers.
SELECT 
    customer_id,
    ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM retail_sales
GROUP BY customer_id
ORDER BY total_profit DESC
LIMIT 10;

-- Q.9 Sales Efficiency (Quantity vs. Revenue Correlation Proxy)
-- Equation: Revenue per Quantity = SUM(total_sale) / SUM(quantity)
SELECT 
    category,
    ROUND(SUM(total_sale) / SUM(quantity), 2) AS revenue_per_unit
FROM retail_sales
GROUP BY category
ORDER BY revenue_per_unit DESC;

-- Q.10 Profit per Category (Net Earnings)
-- Equation: Net Profit = SUM(total_sale - cogs)
SELECT 
    category,
    ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;

-- Q.11 Seasonal Sales Trend (Quarterly Analysis)
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(QUARTER FROM sale_date) AS quarter,
    ROUND(SUM(total_sale), 2) AS quarterly_sales
FROM retail_sales
GROUP BY year, quarter
ORDER BY year, quarter;








