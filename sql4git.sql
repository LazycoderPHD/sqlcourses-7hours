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


