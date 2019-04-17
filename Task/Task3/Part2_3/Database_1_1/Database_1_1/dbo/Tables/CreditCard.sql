CREATE TABLE [dbo].[CreditCard] (
    [Id]           INT           NOT NULL,
    [Number]       INT           NULL,
    [ExpiringDate] DATE          NULL,
    [FullName]     NVARCHAR (50) NULL,
    [EmployeeID]   INT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);