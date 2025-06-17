CREATE TABLE [address] (
  [id_address] MEDIUMINT PRIMARY KEY NOT NULL,
  [street] VARCHAR(200) NOT NULL,
  [location] VARCHAR(200) NOT NULL,
  [number] MEDIUMINT,
  [reference] VARCHAR(200),
  [city] VARCHAR(100) NOT NULL,
  [state] VARCHAR(100) NOT NULL,
  [country] VARCHAR(100) NOT NULL
)
GO

CREATE TABLE [phone] (
  [id_phone] MEDIUMINT PRIMARY KEY NOT NULL,
  [nr_phone] VARCHAR(15) NOT NULL
)
GO

CREATE TABLE [users] (
  [id_user] INT PRIMARY KEY NOT NULL,
  [nm_user] VARCHAR(50) NOT NULL,
  [email] VARCHAR(100) NOT NULL,
  [password_hash] VARCHAR(200),
  [active] bool NOT NULL,
  [dt_creation] DATETIME NOT NULL,
  [dt_birth] date NOT NULL,
  [specialty] varchar(50),
  [phone] mediumint NOT NULL,
  [id_address] mediumint NOT NULL,
  [id_user_type] INT NOT NULL
)
GO

CREATE TABLE [user_types] (
  [id_user_type] INT PRIMARY KEY NOT NULL,
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200)
)
GO

CREATE TABLE [instructor_modalities] (
  [id_instructor] INT NOT NULL,
  [id_modalities] SMALLINT NOT NULL,
  [Primary] Key(id_instructor,id_modalities)
)
GO

CREATE TABLE [modalities] (
  [id_modalities] SMALLINT PRIMARY KEY NOT NULL,
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200)
)
GO

CREATE TABLE [plan_modalities] (
  [id_plan] INT NOT NULL,
  [id_modalities] INT NOT NULL
)
GO

CREATE TABLE [plans] (
  [id_plan] TINYINT PRIMARY KEY NOT NULL,
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(200) NOT NULL,
  [price] NUMERIC(5,2) NOT NULL,
  [duration_mnth] TINYINT NOT NULL
)
GO

CREATE TABLE [subscriptions] (
  [id_subscriptions] INT PRIMARY KEY NOT NULL,
  [id_plan] TINYINT NOT NULL,
  [id_user] INT NOT NULL,
  [active] bool NOT NULL,
  [dt_start] date NOT NULL
)
GO

CREATE TABLE [payments] (
  [id_payment] int PRIMARY KEY NOT NULL,
  [id_subscriptions] int NOT NULL,
  [dt_payment] date NOT NULL,
  [price] numeric(5,2) NOT NULL,
  [id_method] int NOT NULL
)
GO

CREATE TABLE [payment_method] (
  [id_method] int PRIMARY KEY NOT NULL,
  [name_method] varchar(20) NOT NULL
)
GO

CREATE TABLE [classes] (
  [id_class] INT PRIMARY KEY NOT NULL,
  [id_modalities] SMALLINT NOT NULL,
  [id_instructor] INT NOT NULL,
  [dt_hour_class] DATETIME NOT NULL
)
GO

ALTER TABLE [users] ADD FOREIGN KEY ([phone]) REFERENCES [phone] ([id_phone])
GO

ALTER TABLE [users] ADD FOREIGN KEY ([id_address]) REFERENCES [address] ([id_address])
GO

ALTER TABLE [users] ADD FOREIGN KEY ([id_user_type]) REFERENCES [user_types] ([id_user_type])
GO

ALTER TABLE [instructor_modalities] ADD FOREIGN KEY ([id_instructor]) REFERENCES [users] ([id_user_type])
GO

ALTER TABLE [instructor_modalities] ADD FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities])
GO

CREATE TABLE [plans_plan_modalities] (
  [plans_id_plan] TINYINT,
  [plan_modalities_id_plan] INT,
  PRIMARY KEY ([plans_id_plan], [plan_modalities_id_plan])
);
GO

ALTER TABLE [plans_plan_modalities] ADD FOREIGN KEY ([plans_id_plan]) REFERENCES [plans] ([id_plan]);
GO

ALTER TABLE [plans_plan_modalities] ADD FOREIGN KEY ([plan_modalities_id_plan]) REFERENCES [plan_modalities] ([id_plan]);
GO


CREATE TABLE [modalities_plan_modalities] (
  [modalities_id_modalities] SMALLINT,
  [plan_modalities_id_modalities] INT,
  PRIMARY KEY ([modalities_id_modalities], [plan_modalities_id_modalities])
);
GO

ALTER TABLE [modalities_plan_modalities] ADD FOREIGN KEY ([modalities_id_modalities]) REFERENCES [modalities] ([id_modalities]);
GO

ALTER TABLE [modalities_plan_modalities] ADD FOREIGN KEY ([plan_modalities_id_modalities]) REFERENCES [plan_modalities] ([id_modalities]);
GO


ALTER TABLE [plans] ADD FOREIGN KEY ([id_plan]) REFERENCES [subscriptions] ([id_plan])
GO

ALTER TABLE [subscriptions] ADD FOREIGN KEY ([id_user]) REFERENCES [users] ([id_user])
GO

ALTER TABLE [subscriptions] ADD FOREIGN KEY ([id_subscriptions]) REFERENCES [payments] ([id_subscriptions])
GO

ALTER TABLE [payment_method] ADD FOREIGN KEY ([id_method]) REFERENCES [payments] ([id_method])
GO

ALTER TABLE [modalities] ADD FOREIGN KEY ([id_modalities]) REFERENCES [classes] ([id_modalities])
GO

ALTER TABLE [classes] ADD FOREIGN KEY ([id_instructor]) REFERENCES [instructor_modalities] ([id_instructor])
GO
