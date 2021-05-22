IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20200924223731_Initial')
BEGIN
    CREATE TABLE [Department] (
        [ID] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        CONSTRAINT [PK_Department] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20200924223731_Initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200924223731_Initial', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20200930010955_OtherEntities')
BEGIN
    CREATE TABLE [Seller] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [Email] nvarchar(max) NULL,
        [BirthDate] datetime2 NOT NULL,
        [BaseSalary] float NOT NULL,
        [DepartmentID] int NULL,
        CONSTRAINT [PK_Seller] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Seller_Department_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [Department] ([ID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20200930010955_OtherEntities')
BEGIN
    CREATE TABLE [SalesRecord] (
        [Id] int NOT NULL IDENTITY,
        [Date] datetime2 NOT NULL,
        [Amount] float NOT NULL,
        [Status] int NOT NULL,
        [SellerId] int NULL,
        CONSTRAINT [PK_SalesRecord] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SalesRecord_Seller_SellerId] FOREIGN KEY ([SellerId]) REFERENCES [Seller] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20200930010955_OtherEntities')
BEGIN
    CREATE INDEX [IX_SalesRecord_SellerId] ON [SalesRecord] ([SellerId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20200930010955_OtherEntities')
BEGIN
    CREATE INDEX [IX_Seller_DepartmentID] ON [Seller] ([DepartmentID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20200930010955_OtherEntities')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200930010955_OtherEntities', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201015010741_DepartmentForeingKey')
BEGIN
    ALTER TABLE [Seller] DROP CONSTRAINT [FK_Seller_Department_DepartmentID];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201015010741_DepartmentForeingKey')
BEGIN
    EXEC sp_rename N'[Seller].[DepartmentID]', N'DepartmentId', N'COLUMN';
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201015010741_DepartmentForeingKey')
BEGIN
    EXEC sp_rename N'[Seller].[IX_Seller_DepartmentID]', N'IX_Seller_DepartmentId', N'INDEX';
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201015010741_DepartmentForeingKey')
BEGIN
    DROP INDEX [IX_Seller_DepartmentId] ON [Seller];
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Seller]') AND [c].[name] = N'DepartmentId');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Seller] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Seller] ALTER COLUMN [DepartmentId] int NOT NULL;
    CREATE INDEX [IX_Seller_DepartmentId] ON [Seller] ([DepartmentId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201015010741_DepartmentForeingKey')
BEGIN
    ALTER TABLE [Seller] ADD CONSTRAINT [FK_Seller_Department_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Department] ([ID]) ON DELETE CASCADE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201015010741_DepartmentForeingKey')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20201015010741_DepartmentForeingKey', N'2.1.14-servicing-32113');
END;

GO

