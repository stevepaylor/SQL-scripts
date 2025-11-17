USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'GC_LawsonITrak')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [GC_LawsonITrak] WITH PASSWORD = 0x0100C11930A38A92F7D95D93F6BF57E7F6FFE34ABA3F112BCEC8 HASHED, SID = 0x295DB3A2A6B0CD43BA2888B5AA4E0C5B, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [GC_LawsonITrak] 


USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'GC_LawsonITrak')
CREATE USER [GC_LawsonITrak] FOR LOGIN [GC_LawsonITrak] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'GC_LawsonITrak'



ALTER LOGIN [GC_LawsonITrak] ENABLE

END