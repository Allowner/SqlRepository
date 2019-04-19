GO 
IF EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'Region')
BEGIN
	EXEC sp_rename 'dbo.Region', 'Regions';
END;

GO 
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE [name] = 'CreationDate')
BEGIN
    ALTER TABLE [dbo].[Customers] 
	ADD [CreationDate] DATE NULL;
END;
