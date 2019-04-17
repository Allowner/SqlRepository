select o.OrderID, o.ShippedDate, o.ShipVia from dbo.Orders o
where o.ShipVia >= 2 and o.ShippedDate >= '1998-05-06'

select o.OrderID, 
CASE
    WHEN o.ShippedDate IS NULL THEN 'Not shipped'
END 
from dbo.Orders o 
where o.ShippedDate IS NULL

select o.OrderID 'Order Number',  
CASE
    WHEN o.ShippedDate IS NULL THEN 'Not shipped'
	ELSE CONVERT(VARCHAR(23), o.ShippedDate, 121) 
END AS 'Shipped Date' 
from dbo.Orders o 
where o.ShippedDate > '1998-05-06' or o.ShippedDate IS NULL

