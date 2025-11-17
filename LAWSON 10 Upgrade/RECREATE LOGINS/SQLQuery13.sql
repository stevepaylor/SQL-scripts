USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\CEPGJBSVR')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\CEPGJBSVR] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\CEPGJBSVR] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CEPGJBSVR')
CREATE USER [VIEJAS\CEPGJBSVR] FOR LOGIN [VIEJAS\CEPGJBSVR] WITH DEFAULT_SCHEMA=[VIEJAS\CEPGJBSVR]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\CEPGJBSVR'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datawriter' AND type = 'R')
EXEC sp_addrolemember N'db_datawriter', N'VIEJAS\CEPGJBSVR'



ALTER AUTHORIZATION ON SCHEMA::[VIEJAS\CEPGJBSVR] TO [VIEJAS\CEPGJBSVR]

USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CEPGJBSVR')
CREATE USER [VIEJAS\CEPGJBSVR] FOR LOGIN [VIEJAS\CEPGJBSVR] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\CEPGJBSVR'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datawriter' AND type = 'R')
EXEC sp_addrolemember N'db_datawriter', N'VIEJAS\CEPGJBSVR'




ALTER LOGIN [VIEJAS\CEPGJBSVR] ENABLE

END