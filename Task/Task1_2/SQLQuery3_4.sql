select distinct OrderID from [Order Details] od
where od.Quantity between 3 and 10

select c.CustomerID, c.Country from Customers c 
where LEFT(c.Country, 1) between 'b' and 'g' 
order by Country

select c.CustomerID, c.Country from Customers c 
where LEFT(c.Country, 1) >= 'b' and LEFT(c.Country, 1) <= 'g' 
order by Country

select p.ProductName from Products p 
where p.ProductName LIKE '%cho_olad%' 