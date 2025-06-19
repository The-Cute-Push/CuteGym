IF OBJECT_ID('address', 'U') IS NULL
BEGIN
    CREATE TABLE [address] (
        [id_address] INT PRIMARY KEY NOT NULL,
        [street] VARCHAR(200) NOT NULL,
        [location] VARCHAR(200) NOT NULL,
        [number] INT,
        [reference] VARCHAR(200),
        [city] VARCHAR(100) NOT NULL,
        [state] VARCHAR(100) NOT NULL,
        [country] VARCHAR(100) NOT NULL
    );
END
GO

IF OBJECT_ID('phone', 'U') IS NULL
BEGIN
    CREATE TABLE [phone] (
        [id_phone] INT PRIMARY KEY NOT NULL,
        [nr_phone] VARCHAR(15) NOT NULL
    );
END
GO

IF OBJECT_ID('user_types', 'U') IS NULL
BEGIN
    CREATE TABLE [user_types] (
        [id_user_type] INT PRIMARY KEY NOT NULL,
        [name] VARCHAR(50) NOT NULL,
        [description] VARCHAR(200)
    );
END
GO

IF OBJECT_ID('users', 'U') IS NULL
BEGIN
    CREATE TABLE [users] (
        [id_user] INT PRIMARY KEY NOT NULL,
        [nm_user] VARCHAR(50) NOT NULL,
        [email] VARCHAR(100) NOT NULL,
        [password_hash] VARCHAR(200),
        [active] BIT NOT NULL,
        [dt_creation] DATETIME NOT NULL,
        [dt_birth] DATE NOT NULL,
        [specialty] VARCHAR(50),
        [phone] INT NOT NULL,
        [id_address] INT NOT NULL,
        [id_user_type] INT NOT NULL,
        CONSTRAINT FK_Users_Phone FOREIGN KEY ([phone]) REFERENCES [phone] ([id_phone]),
        CONSTRAINT FK_Users_Address FOREIGN KEY ([id_address]) REFERENCES [address] ([id_address]),
        CONSTRAINT FK_Users_UserTypes FOREIGN KEY ([id_user_type]) REFERENCES [user_types] ([id_user_type])
    );
END
GO

IF OBJECT_ID('modalities', 'U') IS NULL
BEGIN
    CREATE TABLE [modalities] (
        [id_modalities] SMALLINT PRIMARY KEY NOT NULL,
        [name] VARCHAR(50) NOT NULL,
        [description] VARCHAR(200)
    );
END
GO

IF OBJECT_ID('instructor_modalities', 'U') IS NULL
BEGIN
    CREATE TABLE [instructor_modalities] (
        [id_instructor] INT NOT NULL,
        [id_modalities] SMALLINT NOT NULL,
        PRIMARY KEY (id_instructor, id_modalities),
        CONSTRAINT FK_InstructorModalities_Users FOREIGN KEY ([id_instructor]) REFERENCES [users] ([id_user]),
        CONSTRAINT FK_InstructorModalities_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities])
    );
END
GO

IF OBJECT_ID('plans', 'U') IS NULL
BEGIN
    CREATE TABLE [plans] (
        [id_plan] TINYINT PRIMARY KEY NOT NULL,
        [name] VARCHAR(50) NOT NULL,
        [description] VARCHAR(200) NOT NULL,
        [price] NUMERIC(5,2) NOT NULL,
        [duration_mnth] TINYINT NOT NULL
    );
END
GO

IF OBJECT_ID('plan_modalities', 'U') IS NULL
BEGIN
    CREATE TABLE [plan_modalities] (
        [id_plan] TINYINT NOT NULL,
        [id_modalities] SMALLINT NOT NULL,
        PRIMARY KEY (id_plan, id_modalities),
        CONSTRAINT FK_PlanModalities_Plans FOREIGN KEY ([id_plan]) REFERENCES [plans] ([id_plan]),
        CONSTRAINT FK_PlanModalities_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities])
    );
END
GO

IF OBJECT_ID('subscriptions', 'U') IS NULL
BEGIN
    CREATE TABLE [subscriptions] (
        [id_subscriptions] INT PRIMARY KEY NOT NULL,
        [id_plan] TINYINT NOT NULL,
        [id_user] INT NOT NULL,
        [active] BIT NOT NULL,
        [dt_start] DATE NOT NULL,
        CONSTRAINT FK_Subscriptions_Plans FOREIGN KEY ([id_plan]) REFERENCES [plans] ([id_plan]),
        CONSTRAINT FK_Subscriptions_Users FOREIGN KEY ([id_user]) REFERENCES [users] ([id_user])
    );
END
GO

IF OBJECT_ID('payment_method', 'U') IS NULL
BEGIN
    CREATE TABLE [payment_method] (
        [id_method] INT PRIMARY KEY NOT NULL,
        [name_method] VARCHAR(20) NOT NULL
    );
END
GO

IF OBJECT_ID('payments', 'U') IS NULL
BEGIN
    CREATE TABLE [payments] (
        [id_payment] INT PRIMARY KEY NOT NULL,
        [id_subscriptions] INT NOT NULL,
        [dt_payment] DATE NOT NULL,
        [price] NUMERIC(5,2) NOT NULL,
        [id_method] INT NOT NULL,
        CONSTRAINT FK_Payments_Subscriptions FOREIGN KEY ([id_subscriptions]) REFERENCES [subscriptions] ([id_subscriptions]),
        CONSTRAINT FK_Payments_PaymentMethod FOREIGN KEY ([id_method]) REFERENCES [payment_method] ([id_method])
    );
END
GO

IF OBJECT_ID('classes', 'U') IS NULL
BEGIN
    CREATE TABLE [classes] (
        [id_class] INT PRIMARY KEY NOT NULL,
        [id_modalities] SMALLINT NOT NULL,
        [id_instructor] INT NOT NULL,
        [dt_hour_class] DATETIME NOT NULL,
        CONSTRAINT FK_Classes_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities]),
        CONSTRAINT FK_Classes_Users FOREIGN KEY ([id_instructor]) REFERENCES [users] ([id_user])
    );
END
GO