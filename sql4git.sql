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
--ORDER BY always uses a frame. Default is "rows between unbounded preceding and current row"

select orderdate, sales,
rank() over(order by sales desc) Ranksales
from sales.Orders

--============WINDOW FUNCTION: WINDOW FRAME (ROWS UNBOUNDED PRECEDING)=================
select orderid, orderdate, orderstatus, sales,
sum(sales) over(partition by orderstatus order by orderdate
rows between current row and 2 following) [totalsales current, row + 2]
from sales.Orders

/* ==================== COMPACT FRAME =======================

For only PRECEDING, the CURRENT ROW can be skipped
NORMAL FORM ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
SHORT FORM ROWS 2 FOLLOWING */

select orderid, orderdate, orderstatus, sales,
sum(sales) over(partition by orderstatus order by orderdate
rows between 2 preceding and current row) [totalsales row - 2, current]
from sales.Orders

--Rank customers based on their total sales
--select coalesce(firstname, '') + ' ' + coalesce(lastname, '') [full name] from sales.Customers c
--join sales.Orders o on c.CustomerID = o.CustomerID

select * from sales.Orders

select o.customerID, coalesce(firstname, '') + ' ' + coalesce(lastname, '') [fullname], sum(sales) [TotalSales], rank() over(order by sum(sales) desc) RankCustomers
from sales.Orders o
join sales.Customers c on c.CustomerID = o.CustomerID 
group by o.customerID, coalesce(firstname, '') + ' ' + coalesce(lastname, '')

--Find the total amount of orders

select count(orderID) [TotalOrders] from sales.Orders

--Find the total amount of orders
--Additionally provide details such order Id, order date

select count(orderID) over() [TotalOrders], orderID, orderDate from sales.Orders
--group by orderID, OrderDate

--Find the total amount of orders
--Find the total number of Orders for each customers
--Additionally provide details such order Id, order date
select o.customerID,
coalesce(firstname, '') + ' ' + coalesce(lastname, '') [fullname],
count(orderID) over(partition by o.customerID) [TotalOrdersbyCustomers],
count(orderID) over() [TotalOrders], orderID, orderDate
from sales.Orders o
join sales.Customers c on c.CustomerID = o.CustomerID