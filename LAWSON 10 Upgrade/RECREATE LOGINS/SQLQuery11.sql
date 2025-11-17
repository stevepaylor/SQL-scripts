USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'adp_user')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [adp_user] WITH PASSWORD = 0x0100597D0F76A6E7E655C460A023CF7B186943DCD72796E73842 HASHED, SID = 0x40B2009A0759B048854E865C2B7E4C64, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [adp_user] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'adp_user')
CREATE USER [adp_user] FOR LOGIN [adp_user] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'adp_user'




USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'adp_user')
CREATE USER [adp_user] FOR LOGIN [adp_user] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'adp_user'




ALTER LOGIN [adp_user] ENABLE

END