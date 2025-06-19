IF OBJECT_ID('address', 'U') IS NULL
CREATE TABLE [address] (
  [id_address] INT PRIMARY KEY IDENTITY(1,1) CHECK ([id_address] > 0),
  [street] VARCHAR(200) NOT NULL,
  [location] VARCHAR(200) NOT NULL,
  [number] INT CHECK ([number] >= 0),
  [reference] VARCHAR(200),
  [city] VARCHAR(100) NOT NULL,
  [state] VARCHAR(100) NOT NULL,
  [country] VARCHAR(100) NOT NULL
);

IF OBJECT_ID('phone', 'U') IS NULL
CREATE TABLE [phone] (
  [id_phone] INT PRIMARY KEY IDENTITY(1,1) CHECK ([id_phone] > 0),
  [nr_phone] VARCHAR(15) NOT NULL
);

IF OBJECT_ID('user_types', 'U') IS NULL
CREATE TABLE [user_types] (
  [id_user_type] TINYINT PRIMARY KEY IDENTITY(1,1) CHECK ([id_user_type] > 0),
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200)
);

IF OBJECT_ID('users', 'U') IS NULL
CREATE TABLE [users] (
  [id_user] INT PRIMARY KEY IDENTITY(1,1) CHECK ([id_user] > 0),
  [nm_user] VARCHAR(50) NOT NULL,
  [email] VARCHAR(100) NOT NULL,
  [password_hash] VARCHAR(200),
  [active] BIT NOT NULL,
  [dt_creation] DATETIME NOT NULL,
  [dt_birth] DATE NOT NULL,
  [specialty] VARCHAR(50),
  [phone] INT NOT NULL CHECK ([phone] > 0),
  [id_address] INT NOT NULL CHECK ([id_address] > 0),
  [id_user_type] TINYINT NOT NULL CHECK ([id_user_type] > 0),
  CONSTRAINT FK_Users_Phone FOREIGN KEY ([phone]) REFERENCES [phone] ([id_phone]),
  CONSTRAINT FK_Users_Address FOREIGN KEY ([id_address]) REFERENCES [address] ([id_address]),
  CONSTRAINT FK_Users_UserTypes FOREIGN KEY ([id_user_type]) REFERENCES [user_types] ([id_user_type])
);

IF OBJECT_ID('modalities', 'U') IS NULL
CREATE TABLE [modalities] (
  [id_modalities] TINYINT PRIMARY KEY IDENTITY(1,1) CHECK ([id_modalities] > 0),
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200)
);

IF OBJECT_ID('instructor_modalities', 'U') IS NULL
CREATE TABLE [instructor_modalities] (
  [id_instructor] INT NOT NULL CHECK ([id_instructor] > 0),
  [id_modalities] TINYINT NOT NULL CHECK ([id_modalities] > 0),
  PRIMARY KEY (id_instructor, id_modalities),
  CONSTRAINT FK_InstructorModalities_Users FOREIGN KEY ([id_instructor]) REFERENCES [users] ([id_user]),
  CONSTRAINT FK_InstructorModalities_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities])
);

IF OBJECT_ID('plans', 'U') IS NULL
CREATE TABLE [plans] (
  [id_plan] TINYINT PRIMARY KEY IDENTITY(1,1) CHECK ([id_plan] > 0),
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200) NOT NULL,
  [price] NUMERIC(5,2) NOT NULL CHECK ([price] >= 0),
  [duration_mnth] TINYINT NOT NULL CHECK ([duration_mnth] > 0)
);

IF OBJECT_ID('plan_modalities', 'U') IS NULL
CREATE TABLE [plan_modalities] (
  [id_plan] TINYINT NOT NULL CHECK ([id_plan] > 0),
  [id_modalities] TINYINT NOT NULL CHECK ([id_modalities] > 0),
  CONSTRAINT FK_PlanModalities_Plans FOREIGN KEY ([id_plan]) REFERENCES [plans] ([id_plan]),
  CONSTRAINT FK_PlanModalities_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities])
);

IF OBJECT_ID('subscriptions', 'U') IS NULL
CREATE TABLE [subscriptions] (
  [id_subscriptions] INT PRIMARY KEY IDENTITY(1,1) CHECK ([id_subscriptions] > 0),
  [id_plan] TINYINT NOT NULL CHECK ([id_plan] > 0),
  [id_user] INT NOT NULL CHECK ([id_user] > 0),
  [active] BIT NOT NULL,
  [dt_start] DATE NOT NULL,
  CONSTRAINT FK_Subscriptions_Plans FOREIGN KEY ([id_plan]) REFERENCES [plans] ([id_plan]),
  CONSTRAINT FK_Subscriptions_Users FOREIGN KEY ([id_user]) REFERENCES [users] ([id_user])
);

IF OBJECT_ID('payment_method', 'U') IS NULL
CREATE TABLE [payment_method] (
  [id_method] TINYINT PRIMARY KEY IDENTITY(1,1) CHECK ([id_method] > 0),
  [name_method] VARCHAR(20) NOT NULL
);

IF OBJECT_ID('payments', 'U') IS NULL
CREATE TABLE [payments] (
  [id_payment] INT PRIMARY KEY IDENTITY(1,1) CHECK ([id_payment] > 0),
  [id_subscriptions] INT NOT NULL CHECK ([id_subscriptions] > 0),
  [dt_payment] DATE NOT NULL,
  [price] NUMERIC(5,2) NOT NULL CHECK ([price] >= 0),
  [id_method] TINYINT NOT NULL CHECK ([id_method] > 0),
  CONSTRAINT FK_Payments_Subscriptions FOREIGN KEY ([id_subscriptions]) REFERENCES [subscriptions] ([id_subscriptions]),
  CONSTRAINT FK_Payments_PaymentMethod FOREIGN KEY ([id_method]) REFERENCES [payment_method] ([id_method])
);

IF OBJECT_ID('classes', 'U') IS NULL
CREATE TABLE [classes] (
  [id_class] INT PRIMARY KEY IDENTITY(1,1) CHECK ([id_class] > 0),
  [id_modalities] TINYINT NOT NULL CHECK ([id_modalities] > 0),
  [id_instructor] INT NOT NULL CHECK ([id_instructor] > 0),
  [dt_hour_class] DATETIME NOT NULL,
  CONSTRAINT FK_Classes_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities]),
  CONSTRAINT FK_Classes_Instructor FOREIGN KEY ([id_instructor]) REFERENCES [users] ([id_user])
);
