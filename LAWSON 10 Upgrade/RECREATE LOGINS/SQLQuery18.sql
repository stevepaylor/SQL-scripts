USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\HR_OSHA')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\HR_OSHA] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\HR_OSHA] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\hr_osha')
CREATE USER [VIEJAS\hr_osha] FOR LOGIN [VIEJAS\HR_OSHA] WITH DEFAULT_SCHEMA=[VIEJAS\hr_osha]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_OSHA' AND type = 'R')
BEGIN
CREATE ROLE [Lawson_OSHA] AUTHORIZATION [dbo]

ALTER AUTHORIZATION ON SCHEMA::[Lawson_OSHA] TO [Lawson_OSHA]
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_OSHA' AND type = 'R')
EXEC sp_addrolemember N'Lawson_OSHA', N'VIEJAS\hr_osha'



ALTER AUTHORIZATION ON SCHEMA::[VIEJAS\hr_osha] TO [VIEJAS\hr_osha]

USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\HR_OSHA')
CREATE USER [VIEJAS\HR_OSHA] FOR LOGIN [VIEJAS\HR_OSHA] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_OSHA' AND type = 'R')
BEGIN
CREATE ROLE [Lawson_OSHA] AUTHORIZATION [dbo]

END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_OSHA' AND type = 'R')
EXEC sp_addrolemember N'Lawson_OSHA', N'VIEJAS\HR_OSHA'




ALTER LOGIN [VIEJAS\HR_OSHA] ENABLE

END