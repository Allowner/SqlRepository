GO 
IF EXISTS(SELECT 1 FROM sys.tables WHERE [name] = N'[dbo.Region]')
BEGIN
	EXEC sp_rename 'dbo.Region', 'Regions';
END;

GO 
IF EXISTS(SELECT 1 FROM sys.columns WHERE [name] = N'[CreationDate]')
BEGIN
    ALTER TABLE [dbo].[Customers] 
	ADD [CreationDate] DATE NULL;
END;
