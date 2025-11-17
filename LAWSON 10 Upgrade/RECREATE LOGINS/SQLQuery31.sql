USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\adpuser')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\adpuser] FROM WINDOWS
SET @CreateError = @@ERROR

IF(@CreateError = 0)
BEGIN
exec master.dbo.sp_addsrvrolemember @loginame='VIEJAS\adpuser', @rolename='sysadmin'
END

GRANT CONNECT SQL TO [VIEJAS\adpuser] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\adpuser')
CREATE USER [VIEJAS\adpuser] FOR LOGIN [VIEJAS\adpuser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'VIEJAS\adpuser'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\adpuser'



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\adpuser')
CREATE USER [VIEJAS\adpuser] FOR LOGIN [VIEJAS\adpuser] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\adpuser'



ALTER LOGIN [VIEJAS\adpuser] ENABLE

END