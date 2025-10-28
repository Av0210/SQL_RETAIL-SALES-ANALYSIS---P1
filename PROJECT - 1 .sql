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
SELECT 
   category,
   gender,
   count(*) as total_trans
   from retail_sales
   group by 
       category,
       gender 
ORDER BY 1 ;

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
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    MAX(total_sale) AS max_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, 2;

-- Top 3 Months per Year per Category
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

-- HOUR(CURRENT_TIME()) as current hour

 -- END OF THE PROJECT -- 



