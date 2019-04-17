select e.EmployeeID, c.CustomerID from Customers c, Employees e 
where c.City = e.City 
group by e.EmployeeID, c.CustomerID 
having count(e.EmployeeID) > 0 and count(c.CustomerID) > 0 

select c.City, c.CustomerID from Customers c 
group by c.City, c.CustomerID 

select a.FirstName Empl, b.FirstName Boss from Employees a
left join Employees b on a.ReportsTo = b.EmployeeID 
