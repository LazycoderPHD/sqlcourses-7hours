--Find the sales price for each order by dividing sales by quantity

select * from sales.orders

select
	orderid,
	sales,
	quantity,
	
	sales / nullif(quantity, 0) as [sales price]
	
from sales.orders
order by sales,