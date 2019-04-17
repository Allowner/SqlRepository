select distinct e.FirstName + ' ' + LastName Employees from Employees e 
inner join EmployeeTerritories et on et.EmployeeID = e.EmployeeID 
inner join Territories t on t.TerritoryID = et.TerritoryID 
inner join Region r on r.RegionID = t.RegionID 
where r.RegionDescription = 'Western' 

select c.CompanyName, count(o.OrderID) Orders from Customers c 
left join Orders o on o.CustomerID = c.CustomerID 
group by c.CompanyName 
order by count(o.OrderID)

