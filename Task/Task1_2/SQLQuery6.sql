select count(o.OrderID) Total, year(o.OrderDate) 'Year' from Orders o 
group by year(o.OrderDate) 

select count(o.OrderID) Total from Orders o 

select n.FullName Seller, count(o.OrderID) Amount from Orders o, 
(select e.FirstName + ' ' + e.LastName FullName, e.EmployeeID from dbo.Employees e) as n 
where n.EmployeeID = o.EmployeeID 
group by o.EmployeeID, n.FullName 
order by Amount desc

select o.EmployeeID Seller, o.CustomerID Customer, count(o.OrderID) 'Orders amount' from Orders o 
where year(o.OrderDate) = 1998
group by o.CustomerID, o.EmployeeID 
