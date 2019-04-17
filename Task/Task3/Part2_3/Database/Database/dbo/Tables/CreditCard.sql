CREATE TABLE [dbo].[CreditCard]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Number] INT NULL, 
    [ExpiringDate] DATE NULL, 
    [FullName] NVARCHAR(50) NULL, 
    [EmployeeID] INT NULL
)
