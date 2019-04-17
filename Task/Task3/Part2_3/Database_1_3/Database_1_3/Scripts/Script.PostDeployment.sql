:setvar CustomersTable Customers 
:setvar SuppliersTable Suppliers 
:setvar ProductsTable Products 

go
MERGE INTO [$(CustomersTable)] C 
USING (
VALUES ('AAAAA','Gourmet Lanchonetes','André Fonseca','Sales Associate',
'Av. Brasil, 442','Campinas','SP','04876-786','Brazil','(11) 555-9482',NULL, NULL),
('BBBBB','Great Lakes Food Market','Howard Snyder',
'Marketing Manager','2732 Baker Blvd.','Eugene','OR','97403','USA','(503) 555-7555',NULL, NULL),
('CCCCC','GROSELLA-Restaurante','Manuel Pereira',
'Owner','5ª Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela','(2) 283-2951','(2) 283-3397', NULL),
('DDDDD','Hanari Carnes','Mario Pontes','Accounting Manager',
'Rua do Paço, 67','Rio de Janeiro','RJ','05454-876','Brazil','(21) 555-0091','(21) 555-8765', NULL),
('EEEEE','HILARION-Abastos','Carlos Hernández','Sales Representative',
'Carrera 22 con Ave. Carlos Soublette #8-35','San Cristóbal','Táchira','5022','Venezuela','(5) 555-1340','(5) 555-1948', NULL)) 
AS Source (CustomerID, CompanyName, ContactName, ContactTitle, [Address], 
City, Region, PostalCode, Country, Phone, Fax, CreationDate)  
ON C.CustomerID = Source.CustomerID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (CustomerID, CompanyName, ContactName, ContactTitle, [Address], 
City, Region, PostalCode, Country, Phone, Fax, CreationDate) 
VALUES (Source.CustomerID, Source.CompanyName, Source.ContactName, Source.ContactTitle, Source.[Address], 
Source.City, Source.Region, Source.PostalCode, Source.Country, Source.Phone, Source.Fax, Source.CreationDate);

go
set identity_insert [$(SuppliersTable)] on

go
MERGE INTO [$(SuppliersTable)] S 
USING (
VALUES (25,'Ma Maison','Jean-Guy Lauzon','Marketing Manager','2960 Rue St. Laurent','Montréal','Québec','H1J 1C3','Canada','(514) 555-9022',NULL,NULL),
(26,'Pasta Buttini s.r.l.','Giovanni Giudici','Order Administrator','Via dei Gelsomini, 153','Salerno',NULL,'84100','Italy','(089) 6547665','(089) 6547667',NULL),
(27,'Escargots Nouveaux','Marie Delamare','Sales Manager','22, rue H. Voiron','Montceau',NULL,'71300','France','85.57.00.07',NULL,NULL),
(28,'Gai pâturage','Eliane Noz','Sales Representative','Bat. B 3, rue des Alpes','Annecy',NULL,'74000','France','38.76.98.06','38.76.98.58',NULL),
(29,'Forêts d''érables','Chantal Goulet','Accounting Manager','148 rue Chasseur','Ste-Hyacinthe','Québec','J2S 7S8','Canada','(514) 555-2955','(514) 555-2921',NULL)) 
AS Source (SupplierID, CompanyName, ContactName, ContactTitle, [Address], City,
Region, PostalCode, Country, Phone, Fax, HomePage)  
ON S.SupplierID = Source.SupplierID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (SupplierID, CompanyName, ContactName, ContactTitle, [Address], City,
Region, PostalCode, Country, Phone, Fax, HomePage) 
VALUES (Source.SupplierID, Source.CompanyName, Source.ContactName, Source.ContactTitle, Source.[Address], Source.City,
Source.Region, Source.PostalCode, Source.Country, Source.Phone, Source.Fax, Source.HomePage);

go
set identity_insert [$(SuppliersTable)] off

go
set identity_insert [$(ProductsTable)] on
go
ALTER TABLE [$(ProductsTable)] NOCHECK CONSTRAINT ALL

go
MERGE INTO [$(ProductsTable)] P 
USING ( 
VALUES (73,'Röd Kaviar',17,8,'24 - 150 g jars',15,101,0,5,0),
(74,'Longlife Tofu',4,7,'5 kg pkg.',10,4,20,5,0),
(75,'Rhönbräu Klosterbier',12,1,'24 - 0.5 l bottles',7.75,125,0,25,0),
(76,'Lakkalikööri',23,1,'500 ml',18,57,0,20,0),
(77,'Original Frankfurter grüne Soße',12,2,'12 boxes',13,32,0,15,0)) 
AS Source (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit,
UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)  
ON P.ProductID = Source.ProductID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit,
UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued) 
VALUES (Source.ProductID, Source.ProductName, Source.SupplierID, Source.CategoryID, Source.QuantityPerUnit,
Source.UnitPrice, Source.UnitsInStock, Source.UnitsOnOrder, Source.ReorderLevel, Source.Discontinued);

go
set identity_insert [$(ProductsTable)] off
go
ALTER TABLE [$(ProductsTable)] CHECK CONSTRAINT ALL
