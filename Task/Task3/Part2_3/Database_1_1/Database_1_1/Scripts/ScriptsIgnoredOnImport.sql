
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;
GO

SET NUMERIC_ROUNDABORT OFF;
GO

IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END
GO

USE [master];
GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END
GO

PRINT N'Creating $(DatabaseName)...'
GO

CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO

USE [$(DatabaseName)];
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END
GO

IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END
GO

ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END
GO

IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';
GO

PRINT N'Creating [dbo].[Categories]...';
GO

PRINT N'Creating [dbo].[Categories].[CategoryName]...';
GO

PRINT N'Creating [dbo].[CreditCard]...';
GO

PRINT N'Creating [dbo].[CustomerCustomerDemo]...';
GO

PRINT N'Creating [dbo].[CustomerDemographics]...';
GO

PRINT N'Creating [dbo].[Customers]...';
GO

PRINT N'Creating [dbo].[Customers].[City]...';
GO

PRINT N'Creating [dbo].[Customers].[CompanyName]...';
GO

PRINT N'Creating [dbo].[Customers].[PostalCode]...';
GO

PRINT N'Creating [dbo].[Customers].[Region]...';
GO

PRINT N'Creating [dbo].[Employees]...';
GO

PRINT N'Creating [dbo].[Employees].[LastName]...';
GO

PRINT N'Creating [dbo].[Employees].[PostalCode]...';
GO

PRINT N'Creating [dbo].[EmployeeTerritories]...';
GO

PRINT N'Creating [dbo].[Order Details]...';
GO

PRINT N'Creating [dbo].[Order Details].[OrderID]...';
GO

PRINT N'Creating [dbo].[Order Details].[OrdersOrder_Details]...';
GO

PRINT N'Creating [dbo].[Order Details].[ProductID]...';
GO

PRINT N'Creating [dbo].[Order Details].[ProductsOrder_Details]...';
GO

PRINT N'Creating [dbo].[Orders]...';
GO

PRINT N'Creating [dbo].[Orders].[CustomerID]...';
GO

PRINT N'Creating [dbo].[Orders].[CustomersOrders]...';
GO

PRINT N'Creating [dbo].[Orders].[EmployeeID]...';
GO

PRINT N'Creating [dbo].[Orders].[EmployeesOrders]...';
GO

PRINT N'Creating [dbo].[Orders].[OrderDate]...';
GO

PRINT N'Creating [dbo].[Orders].[ShippedDate]...';
GO

PRINT N'Creating [dbo].[Orders].[ShippersOrders]...';
GO

PRINT N'Creating [dbo].[Orders].[ShipPostalCode]...';
GO

PRINT N'Creating [dbo].[Products]...';
GO

PRINT N'Creating [dbo].[Products].[CategoriesProducts]...';
GO

PRINT N'Creating [dbo].[Products].[CategoryID]...';
GO

PRINT N'Creating [dbo].[Products].[ProductName]...';
GO

PRINT N'Creating [dbo].[Products].[SupplierID]...';
GO

PRINT N'Creating [dbo].[Products].[SuppliersProducts]...';
GO

PRINT N'Creating [dbo].[Region]...';
GO

PRINT N'Creating [dbo].[Shippers]...';
GO

PRINT N'Creating [dbo].[Suppliers]...';
GO

PRINT N'Creating [dbo].[Suppliers].[CompanyName]...';
GO

PRINT N'Creating [dbo].[Suppliers].[PostalCode]...';
GO

PRINT N'Creating [dbo].[Territories]...';
GO

PRINT N'Creating [dbo].[DF_Order_Details_UnitPrice]...';
GO

PRINT N'Creating [dbo].[DF_Order_Details_Quantity]...';
GO

PRINT N'Creating [dbo].[DF_Order_Details_Discount]...';
GO

PRINT N'Creating [dbo].[DF_Orders_Freight]...';
GO

PRINT N'Creating [dbo].[DF_Products_UnitPrice]...';
GO

PRINT N'Creating [dbo].[DF_Products_UnitsInStock]...';
GO

PRINT N'Creating [dbo].[DF_Products_UnitsOnOrder]...';
GO

PRINT N'Creating [dbo].[DF_Products_ReorderLevel]...';
GO

PRINT N'Creating [dbo].[DF_Products_Discontinued]...';
GO

PRINT N'Creating [dbo].[FK_CustomerCustomerDemo]...';
GO

PRINT N'Creating [dbo].[FK_CustomerCustomerDemo_Customers]...';
GO

PRINT N'Creating [dbo].[FK_Employees_Employees]...';
GO

PRINT N'Creating [dbo].[FK_EmployeeTerritories_Employees]...';
GO

PRINT N'Creating [dbo].[FK_EmployeeTerritories_Territories]...';
GO

PRINT N'Creating [dbo].[FK_Order_Details_Orders]...';
GO

PRINT N'Creating [dbo].[FK_Order_Details_Products]...';
GO

PRINT N'Creating [dbo].[FK_Orders_Customers]...';
GO

PRINT N'Creating [dbo].[FK_Orders_Employees]...';
GO

PRINT N'Creating [dbo].[FK_Orders_Shippers]...';
GO

PRINT N'Creating [dbo].[FK_Products_Categories]...';
GO

PRINT N'Creating [dbo].[FK_Products_Suppliers]...';
GO

PRINT N'Creating [dbo].[FK_Territories_Region]...';
GO

PRINT N'Creating [dbo].[CK_Birthdate]...';
GO

PRINT N'Creating [dbo].[CK_Discount]...';
GO

PRINT N'Creating [dbo].[CK_Quantity]...';
GO

PRINT N'Creating [dbo].[CK_UnitPrice]...';
GO

PRINT N'Creating [dbo].[CK_Products_UnitPrice]...';
GO

PRINT N'Creating [dbo].[CK_ReorderLevel]...';
GO

PRINT N'Creating [dbo].[CK_UnitsInStock]...';
GO

PRINT N'Creating [dbo].[CK_UnitsOnOrder]...';
GO

PRINT N'Creating [dbo].[Alphabetical list of products]...';
GO

PRINT N'Creating [dbo].[Current Product List]...';
GO

PRINT N'Creating [dbo].[Customer and Suppliers by City]...';
GO

PRINT N'Creating [dbo].[Invoices]...';
GO

PRINT N'Creating [dbo].[Order Details Extended]...';
GO

PRINT N'Creating [dbo].[Order Subtotals]...';
GO

PRINT N'Creating [dbo].[Orders Qry]...';
GO

PRINT N'Creating [dbo].[Product Sales for 1997]...';
GO

PRINT N'Creating [dbo].[Products Above Average Price]...';
GO

PRINT N'Creating [dbo].[Products by Category]...';
GO

PRINT N'Creating [dbo].[Quarterly Orders]...';
GO

PRINT N'Creating [dbo].[Sales by Category]...';
GO

PRINT N'Creating [dbo].[Sales Totals by Amount]...';
GO

PRINT N'Creating [dbo].[Summary of Sales by Quarter]...';
GO

PRINT N'Creating [dbo].[Summary of Sales by Year]...';
GO

PRINT N'Creating [dbo].[Category Sales for 1997]...';
GO

PRINT N'Creating [dbo].[CustOrderHist]...';
GO

PRINT N'Creating [dbo].[CustOrdersDetail]...';
GO

PRINT N'Creating [dbo].[CustOrdersOrders]...';
GO

PRINT N'Creating [dbo].[Employee Sales by Country]...';
GO

PRINT N'Creating [dbo].[Sales by Year]...';
GO

PRINT N'Creating [dbo].[SalesByCategory]...';
GO

PRINT N'Creating [dbo].[Ten Most Expensive Products]...';
GO

-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    --The following statement was imported into the database project as a schema object and named dbo.__RefactorLog.
--CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)

    --The following statement was imported into the database project as a schema object and named SqlTableBase.dbo.__RefactorLog.microsoft_database_tools_support.
--EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'

END
GO

IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'af0c7936-6237-45d6-81d5-e4afe569d2b3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('af0c7936-6237-45d6-81d5-e4afe569d2b3')
GO

PRINT N'Update complete.';
GO

/*
Deployment script for Northwind

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/


GO

DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END



GO

:setvar DatabaseName "Northwind"
:setvar DefaultFilePrefix "Northwind"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"


GO

--Syntax Error: Incorrect syntax near :.
--:setvar DatabaseName "Northwind"
--:setvar DefaultFilePrefix "Northwind"
--:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
--:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
--

GO

:on error exit

GO

--Syntax Error: Incorrect syntax near :.
--:on error exit

GO

/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"

GO

--Syntax Error: Incorrect syntax near :.
--/*
--Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
--To re-enable the script after enabling SQLCMD mode, execute the following:
--SET NOEXEC OFF; 
--*/
--:setvar __IsSqlCmdEnabled "True"

GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END



GO

--Syntax Error: Incorrect syntax near TEMPORAL_HISTORY_RETENTION.
--IF EXISTS (SELECT 1
--           FROM   [master].[dbo].[sysdatabases]
--           WHERE  [name] = N'$(DatabaseName)')
--    BEGIN
--        ALTER DATABASE [$(DatabaseName)]
--            SET TEMPORAL_HISTORY_RETENTION ON 
--            WITH ROLLBACK IMMEDIATE;
--    END
--
--



GO
