USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\HR_EMP')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\HR_EMP] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\HR_EMP] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'hr_emp')
CREATE USER [hr_emp] FOR LOGIN [VIEJAS\HR_EMP] WITH DEFAULT_SCHEMA=[hr_emp]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_emp' AND type = 'R')
BEGIN
CREATE ROLE [Lawson_emp] AUTHORIZATION [dbo]

ALTER AUTHORIZATION ON SCHEMA::[Lawson_emp] TO [Lawson_emp]
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_emp' AND type = 'R')
EXEC sp_addrolemember N'Lawson_emp', N'hr_emp'



ALTER AUTHORIZATION ON SCHEMA::[hr_emp] TO [hr_emp]

USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\HR_EMP')
CREATE USER [VIEJAS\HR_EMP] FOR LOGIN [VIEJAS\HR_EMP] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_emp' AND type = 'R')
BEGIN
CREATE ROLE [Lawson_emp] AUTHORIZATION [dbo]

END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_emp' AND type = 'R')
EXEC sp_addrolemember N'Lawson_emp', N'VIEJAS\HR_EMP'




ALTER LOGIN [VIEJAS\HR_EMP] ENABLE

END