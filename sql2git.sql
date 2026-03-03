/* Generate a report showing the total sales for each category:
High: If the sales are higher than 50
Medium: If the sales between 20 and 50
Low: If the sales equal or lower than 20
Sort category from lowest to highest */

select
	Category,
	sum(Sales) as totalSales
from(
	select 
		orderID,
		Sales,
	case
		when Sales > 50 then 'High'
		when Sales >= 20 and Sales <= 50 then 'Medium'
		when Sales < 20 then 'Low'
	end Category
	from sales.Orders
) as temp
group by Category
order by totalSales asc

-- Retrive employee details with gender displayed as full text

SELECT 
    EmployeeID,
    FirstName + ' ' + COALESCE(LastName, '') AS [FullName],
    Gender,
    -- Cột hiển thị chữ Male/Female
    CASE 
        WHEN Gender = 'M' THEN 'Male'
        WHEN Gender = 'F' THEN 'Female'
        ELSE 'Unknown gender'
    END AS [Full text gender],
    -- Cột dùng Partition để đếm số lượng Nam/Nữ
    COUNT(Gender) OVER(PARTITION BY Gender) AS [total by gender]
FROM Sales.Employees
ORDER BY Gender

--Retrieve customers details with abbreviated country code

select
	CustomerID,
	FirstName,
	LastName,
	Country,
case when country = 'USA' then 'US'
	 when country = 'Germany' then 'DE'
else 'n/a'
end as [abbreviated country]
from sales.Customers

select distinct country
from sales.Customers

--Find the average scores of customers and treat NULLS as 0
--Additionally provide details such as customerID and lastname
select
	CustomerID,
	LastName,
	Score,
case when score is null then 0
	else score
end as [clean score],

avg(coalesce(score,0)) over() [avg with coalesce],

avg(case when score is null then 0
	else score
end) over() as avgcustomerclean,
	Avg(score) over() as [Average score]
from sales.Customers

--Count how many times each customer has made an order with sales greater than 30

select
	OrderID,
	CustomerID,
	Sales,
	case when sales > 30 then 1
	else 0
	end as [SalesFlag]
from sales.Orders
Order by customerID

--NO orderId,sales for group by
select
	CustomerID,
	count(*) [TotalOrders],

	sum(case when sales > 30 then 1
	else 0
	end) as [TotalOrders>30]
from sales.Orders
group by customerID