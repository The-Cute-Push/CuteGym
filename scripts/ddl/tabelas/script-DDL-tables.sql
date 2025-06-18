CREATE TABLE IF NOT EXISTS [address] (
  [id_address] INT PRIMARY KEY NOT NULL, -- Alterado todos os 'mediumint' para 'INT'
  [street] VARCHAR(200) NOT NULL,
  [location] VARCHAR(200) NOT NULL,
  [number] INT,
  [reference] VARCHAR(200),
  [city] VARCHAR(100) NOT NULL,
  [state] VARCHAR(100) NOT NULL,
  [country] VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS [phone] (
  [id_phone] INT PRIMARY KEY NOT NULL,
  [nr_phone] VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS [user_types] (
  [id_user_type] INT PRIMARY KEY NOT NULL,
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS [users] (
  [id_user] INT PRIMARY KEY NOT NULL,
  [nm_user] VARCHAR(50) NOT NULL,
  [email] VARCHAR(100) NOT NULL,
  [password_hash] VARCHAR(200),
  [active] BIT NOT NULL, -- Alterado de 'bool' para 'BIT'
  [dt_creation] DATETIME NOT NULL,
  [dt_birth] DATE NOT NULL,
  [specialty] VARCHAR(50),
  [phone] INT NOT NULL,
  [id_address] INT NOT NULL,
  [id_user_type] INT NOT NULL,
  CONSTRAINT FK_Users_Phone FOREIGN KEY ([phone]) REFERENCES [phone] ([id_phone]), -- Alterado as FK para dentro do CREATE TABLE
  CONSTRAINT FK_Users_Address FOREIGN KEY ([id_address]) REFERENCES [address] ([id_address]),
  CONSTRAINT FK_Users_UserTypes FOREIGN KEY ([id_user_type]) REFERENCES [user_types] ([id_user_type])
);

CREATE TABLE IF NOT EXISTS [modalities] (
  [id_modalities] SMALLINT PRIMARY KEY NOT NULL,
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS [instructor_modalities] (
  [id_instructor] INT NOT NULL,
  [id_modalities] SMALLINT NOT NULL,
  PRIMARY KEY (id_instructor, id_modalities),
  CONSTRAINT FK_InstructorModalities_Users FOREIGN KEY ([id_instructor]) REFERENCES [users] ([id_user]),
  CONSTRAINT FK_InstructorModalities_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities])
);

CREATE TABLE IF NOT EXISTS [plans] (
  [id_plan] TINYINT PRIMARY KEY NOT NULL,
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200) NOT NULL,
  [price] NUMERIC(5,2) NOT NULL,
  [duration_mnth] TINYINT NOT NULL
);

CREATE TABLE IF NOT EXISTS [plan_modalities] (
  [id_plan] INT NOT NULL,
  [id_modalities] INT NOT NULL,
  CONSTRAINT FK_PlanModalities_Plans FOREIGN KEY ([id_plan]) REFERENCES [plans] ([id_plan]),
  CONSTRAINT FK_PlanModalities_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities])
);

CREATE TABLE IF NOT EXISTS [subscriptions] (
  [id_subscriptions] INT PRIMARY KEY NOT NULL,
  [id_plan] TINYINT NOT NULL,
  [id_user] INT NOT NULL,
  [active] BIT NOT NULL, -- Alterado de 'bool' para 'BIT'
  [dt_start] DATE NOT NULL,
  CONSTRAINT FK_Subscriptions_Plans FOREIGN KEY ([id_plan]) REFERENCES [plans] ([id_plan]),
  CONSTRAINT FK_Subscriptions_Users FOREIGN KEY ([id_user]) REFERENCES [users] ([id_user])
);

CREATE TABLE IF NOT EXISTS [payment_method] (
  [id_method] INT PRIMARY KEY NOT NULL,
  [name_method] VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS [payments] (
  [id_payment] INT PRIMARY KEY NOT NULL,
  [id_subscriptions] INT NOT NULL,
  [dt_payment] DATE NOT NULL,
  [price] NUMERIC(5,2) NOT NULL,
  [id_method] INT NOT NULL,
  CONSTRAINT FK_Payments_Subscriptions FOREIGN KEY ([id_subscriptions]) REFERENCES [subscriptions] ([id_subscriptions]),
  CONSTRAINT FK_Payments_PaymentMethod FOREIGN KEY ([id_method]) REFERENCES [payment_method] ([id_method])
);

CREATE TABLE IF NOT EXISTS [classes] (
  [id_class] INT PRIMARY KEY NOT NULL,
  [id_modalities] SMALLINT NOT NULL,
  [id_instructor] INT NOT NULL,
  [dt_hour_class] DATETIME NOT NULL,
  CONSTRAINT FK_Classes_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities]),
  CONSTRAINT FK_Classes_InstructorModalities FOREIGN KEY ([id_instructor]) REFERENCES [instructor_modalities] ([id_instructor])
);