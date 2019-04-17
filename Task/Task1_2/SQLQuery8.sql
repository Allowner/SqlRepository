select s.CompanyName from Suppliers s 
where SupplierID in 
(select SupplierID from Products p where p.UnitsInStock = 0)

select e.FirstName + ' ' + e.LastName Employee from Employees e 
where EmployeeID in 
(select o.EmployeeID from Orders o 
group by o.EmployeeID
having count(o.OrderID) > 150) 

select c.CompanyName from Customers c 
where exists 
(select o.CustomerID, count(o.OrderID) from Orders o 
where o.CustomerID = c.CustomerID 
group by o.CustomerID
having count(o.OrderID) = 0) 