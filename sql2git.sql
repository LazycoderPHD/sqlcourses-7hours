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