USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\frxuser')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\frxuser] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\frxuser] 


USE [Fin_Data_WH]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'VIEJAS\frxuser'




USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'VIEJAS\frxuser'




------USE [PR_Data_DW]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
------CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
------EXEC sp_addrolemember N'db_owner', N'VIEJAS\frxuser'




USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_FRX' AND type = 'R')
BEGIN
CREATE ROLE [Lawson_FRX] AUTHORIZATION [dbo]

END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_FRX' AND type = 'R')
EXEC sp_addrolemember N'Lawson_FRX', N'VIEJAS\frxuser'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_ddladmin' AND type = 'R')
EXEC sp_addrolemember N'db_ddladmin', N'VIEJAS\frxuser'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\frxuser'


GRANT SELECT ON [lawson].[APVENADDR]  TO [VIEJAS\frxuser] 
GRANT SELECT ON [lawson].[APVENMAST]  TO [VIEJAS\frxuser] 


ALTER LOGIN [VIEJAS\frxuser] ENABLE

END