select c.CompanyName, c.Country from dbo.Customers c 
where c.CustomerID IN (
select c.CustomerID from dbo.Customers c 
where c.Country = 'USA' OR c.Country = 'Canada') 
order by c.CompanyName, c.Country

select c.CompanyName, c.Country from dbo.Customers c 
where c.CustomerID NOT IN (
select c.CustomerID from dbo.Customers c 
where c.Country = 'USA' OR c.Country = 'Canada') 
order by c.CompanyName

select distinct c.Country from dbo.Customers c 
order by c.Country desc