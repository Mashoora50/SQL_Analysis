create database portfolio_sql_prjct;
show databases;
use portfolio_sql_prjct;
select * from retail_sales;
show columns from retail_sales;

#DATA PREPROCESSIG
#CHANGED COLUMN NAME
alter table retail_sales rename column `ï»¿transactions_id` to `transactions_id`;
show columns from retail_sales;
#CHECKED TOTAL COUNT OF TABLE
select count(*) from retail_sales;

select distinct gender from retail_sales;
#CHECKED FOR NULL VALUES
select * from retail_sales where transactions_id is null;
select * from retail_sales where sale_date is null;

#DELETE ROWS WHERE FOUND NULL VALUES
delete from retail_sales where quantiy is null;

#CHECKED UNIQUE CUTOMERS
select count(distinct customer_id) as cust_id from retail_sales;

select count(distinct category)as un_cat from retail_sales;
select distinct category from retail_sales;

#1.SQL query to retrive all columns for sales made on'2022-11-2025'?
select * from retail_sales where sale_date='2022-11-05';

alter table retail_sales modify column sale_date Date;
 alter table retail_sales rename column `quantiy` to `quantity`;
 
 #2.SQL query to retrive all transaction of ctegory 'clothing and sale date'2002-11'
 select * from retail_sales
where category='Clothing'
And
date_format(sale_date,'%Y-%m')='2022-11'
And
 quantity>=4;
 
  #3.SQL query to calculate totalsale for each  category?
 select Category,sum(total_sale) as totals_sales,
 count(*) as tot_orders
 from retail_sales
 group by Category;
 
 
  #4.SQL query to find average of cutomer who purchased in category 'beauty'?
 select round(avg(age),2) from retail_sales 
 where category="Beauty";
 
 
#5.SQL query tofind all trasnsaction where total sale is greater 1000?
 select * from retail_sales
 where total_sale>=1000;
 
 #6.SQL query to find tottal orders in each category where total sale is greater than 1000?
 select category,count(*) as total_transactions
 from retail_sales
 where total_sale>1000
 group by category;
 
 #7.SQL query to find all transaction id made by each each gender and category?
 select category,gender,
 count(*) as total_transactions
 from retail_sales
 group by category,gender
 order by category;
 
 
 #8.SQL query o find average sale of each month and best selling month of each year?
 select * from
 (
 select
 extract(year from sale_date)as YEAR,
 extract(month from sale_date)as Month,
 round(avg(total_sale),2)as Avg_Sale,
 rank()over(partition by extract(year from sale_date) order by avg(total_sale)desc) as rankbymonth
 from retail_sales
 group by 1, 2)as t1
 where rankbymonth=1;
 
#9.SQL query to find total sales done by each gender in each category?
SELECT gender,category,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY gender, category
ORDER BY 2,3 DESC;

#10.SQL qury to find top 3 customers by sale?
select customer_id,sum(total_sale)as tot_sale,
dense_rank()over(order by sum(total_sale)desc)as ranked
from retail_sales
group by customer_id
limit 3;

#11.SQL query to find unique customer from eacg category?
select category,count(distinct customer_id) as uniqu_customer
from retail_sales
group by category;




#12.SQl query to create shift and number of orders done in each shift?
with hourly_purchase as(
select*,
case
when extract(hour from sale_time)<12 then "morning"
when extract(hour from sale_time) between 12 and 17 then "afternoon"
else "evening"
end as shift
from retail_sales)
select shift,
count(*) as total_orders
from hourly_purchase
group by shift;





