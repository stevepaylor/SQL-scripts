USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\FIN_HR')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\FIN_HR] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\FIN_HR] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\fin_hr')
CREATE USER [VIEJAS\fin_hr] FOR LOGIN [VIEJAS\FIN_HR] WITH DEFAULT_SCHEMA=[VIEJAS\fin_hr]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_FIN_HR' AND type = 'R')
BEGIN
CREATE ROLE [Lawson_FIN_HR] AUTHORIZATION [dbo]

ALTER AUTHORIZATION ON SCHEMA::[Lawson_FIN_HR] TO [Lawson_FIN_HR]
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_FIN_HR' AND type = 'R')
EXEC sp_addrolemember N'Lawson_FIN_HR', N'VIEJAS\fin_hr'



ALTER AUTHORIZATION ON SCHEMA::[VIEJAS\fin_hr] TO [VIEJAS\fin_hr]

USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\FIN_HR')
CREATE USER [VIEJAS\FIN_HR] FOR LOGIN [VIEJAS\FIN_HR] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_FIN_HR' AND type = 'R')
BEGIN
CREATE ROLE [Lawson_FIN_HR] AUTHORIZATION [dbo]

END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_FIN_HR' AND type = 'R')
EXEC sp_addrolemember N'Lawson_FIN_HR', N'VIEJAS\FIN_HR'




ALTER LOGIN [VIEJAS\FIN_HR] ENABLE

END