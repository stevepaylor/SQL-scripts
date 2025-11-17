USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'Prophix_RO')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [Prophix_RO] WITH PASSWORD = 0x0100EFCBE441A3910F199848F5D7C966C7DD75AC23CF5E8D8307 HASHED, SID = 0x004B7930415A424D9C5D43609473D174, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [Prophix_RO] 


USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Prophix_RO')
CREATE USER [Prophix_RO] FOR LOGIN [Prophix_RO] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'Prophix_RO'



ALTER LOGIN [Prophix_RO] ENABLE

END