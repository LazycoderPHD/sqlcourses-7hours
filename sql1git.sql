--Find the sales price for each order by dividing sales by quantity

select * from sales.orders

select
	orderid,
	sales,
	quantity,
	
	sales / nullif(quantity, 0) as [sales price]
	
from sales.orders
order by sales,

--Identify the customers who have no scores

select
	Firstname + ' ' + coalesce(Lastname, '') as [FullName],
	score
from sales.Customers
where score is null

--list all details for customers who have not placed any orders

select
	c.*,
	o.OrderID
	--c.CustomerID,
	--c.Firstname + ' ' + coalesce(c.Lastname, '') as [Customer's FullName]
from sales.Customers as c
left join sales.Orders as o
on c.CustomerID = o.CustomerID
where o.customerID is null

select
	*
from sales.Orders