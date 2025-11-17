USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'DashboardUser')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [DashboardUser] WITH PASSWORD = 0x01007C278BFEE164FE7855711D1976D251B80209FDE0926A7305 HASHED, SID = 0x40DE42585DE29847BE8FEAE45D7EE535, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = ON, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [DashboardUser] 


USE [Fin_Data_WH]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'DashboardUser'



USE [Gen]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'DashboardUser'



USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'DashboardUser'



USE [Logan]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'DashboardUser'



------USE [PR_Data_DW]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
------CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
------EXEC sp_addrolemember N'db_datareader', N'DashboardUser'



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'DashboardUser'



ALTER LOGIN [DashboardUser] ENABLE

END