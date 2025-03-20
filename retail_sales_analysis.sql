

drop table if exists  retails_sales;
create table retails_sales(
				transactions_id int primary key,	
				sale_date date,	
				sale_time time,	
				customer_id int,
				gender varchar(15),	
				age int, 	
				category varchar(15),	
				quantiy int,	
				price_per_unit float,	
				cogs float,	
				total_sale float

);

select * from retails_sales
limit 10

--checking total no of rows
select count(*)
from retails_sales

--data cleaning
--checking for null values
select * from retails_sales
where transactions_id is null or	
				sale_date is null or
				sale_time is null or	
				customer_id is null or
				gender is null or
				category is null or
				quantiy is null or	
				price_per_unit is null or
				cogs is null or
				total_sale is null 
order by transactions_id

--delete null values
delete from retails_sales
where transactions_id is null or	
				sale_date is null or
				sale_time is null or	
				customer_id is null or
				gender is null or
				category is null or
				quantiy is null or	
				price_per_unit is null or
				cogs is null or
				total_sale is null 

--data exploration
--how many sales
select count(*)
from retails_sales

--how many customers
select count(distinct customer_id)
from retails_sales

--how many caterogory
select count(distinct category)
from retails_sales

--what are caterogory
select distinct category
from retails_sales


--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select *
from retails_sales

select *
from retails_sales
where sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select *
from retails_sales
where category = 'Clothing' and quantiy >= 4
and To_char(sale_date,'YYYY-MM') = '2022-11'

--3.Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as total_sales
from retails_sales
group by 1

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select category,round(avg(age),2)
from retails_sales
where category = 'Beauty'
group by 1

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select *
from retails_sales
where total_sale >1000

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender,sum(transactions_id)
from retails_sales
where total_sale >1000
group by 1

--7Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1


--8.**Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id,sum(total_sale)
from retails_sales
group by 1
order by 2 desc
limit 5

--9.Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id),category
from retails_sales
group by 2

--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
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

