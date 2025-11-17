USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'Lawson_LexID')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [Lawson_LexID] WITH PASSWORD = 0x0100B63A552A767B40F13027850B1402E6755924BB0666FAAB5E HASHED, SID = 0xDE28508C96B6A444BC9F8CAA7846EBA3, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [Lawson_LexID] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_LexID')
CREATE USER [Lawson_LexID] FOR LOGIN [Lawson_LexID] WITH DEFAULT_SCHEMA=[Lawson_LexID]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_LexID' AND type = 'R')
BEGIN
CREATE ROLE [db_LexID] AUTHORIZATION [dbo]
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_LexID' AND type = 'R')
EXEC sp_addrolemember N'db_LexID', N'Lawson_LexID'



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_LexID')
CREATE USER [Lawson_LexID] FOR LOGIN [Lawson_LexID] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_LexID' AND type = 'R')
BEGIN
CREATE ROLE [db_LexID] AUTHORIZATION [dbo]
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_LexID' AND type = 'R')
EXEC sp_addrolemember N'db_LexID', N'Lawson_LexID'


GRANT SELECT ON [lawson].[HRPICT]  TO [Lawson_LexID] 
GRANT UPDATE ON [lawson].[HRPICT]  TO [Lawson_LexID] 

ALTER LOGIN [Lawson_LexID] ENABLE

END