select sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) Totals from [Order Details] od 

select count(*) - count(o.ShippedDate) 'Not shipped' from Orders o

select count(distinct CustomerID) 'Active customers' from Orders o

