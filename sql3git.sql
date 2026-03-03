-- Find the total number of orders, total sales, avg sales, max(highest) sales, min(lowest) sales. THIS IS FROM MYDATABASE 
select sales from orders

select
	customer_id,
	count(sales) [total orders],
	sum(sales) as [total sales],
	avg(sales) as [avg sales],
	max(sales) as [highest sales],
	min(sales) as [lowest sales]
from Orders
group by customer_id