--=================WINDOW FUNCTION: PARTITION BY======================

--find the total sales across all orders
select sum (sales) as [total sales] from sales.Orders

--find the total sales for each product
select productID, sum (sales) as [total sales] from sales.Orders
group by productID

--Find the total sales for each product, additionally provide details such order id & order date
select OrderDate,productID, orderID, sum (sales) as [total sales] from sales.Orders
group by productID, orderID, OrderDate

select sum (sales) over() as [total_sales] from sales.Orders
select productID, sum (sales) over(partition by productID) as [total_sales] from sales.Orders --dont need productID listed in partition by unlike group by
select OrderDate,productID, orderID, sum (sales) over(partition by productID) as [total_sales] from sales.Orders
select OrderDate,productID, orderID, sum (sales) over(partition by orderID) as [total_sales] from sales.Orders

--Find the total sales across all orders, additionally provide details such order id & order date
select OrderID, OrderDate, sales, sum(sales) over() [totalsales]
from sales.Orders

--Find the total sales for each product, additionally provide details such order id & order date
select ProductID,OrderID, OrderDate, sales, sum(sales) over(partition by productID) [totalsales]
from sales.Orders

select * from sales.Orders

--Find the total sales across all orders, find the total sales for each product, additionally provide details such order id & order date
select ProductID,OrderID, OrderDate, Sales,
sum(sales) over() totalsales,
sum(sales) over(partition by productID) [totalsalesbyproducts]
from sales.Orders

--Find the total sales across all orders, find the total sales for each product, find the total sales for each combination of product and order status, additionally provide details such order id & order date
select ProductID, OrderID, OrderDate, orderstatus, Sales,
sum(sales) over() totalsales,
sum(sales) over(partition by productID) [totalsalesbyproducts],
sum(sales) over(partition by productid ,orderstatus) [totalsalesbyproductsandstatus]
from sales.Orders

--============WINDOW FUNCTION: ORDER BY=================
-- Rank each order based on their sales from highest to lowest
-- Additionally provide details such order Id, order date

select orderdate, sales,
rank() over(order by sales desc) Ranksales
from sales.Orders