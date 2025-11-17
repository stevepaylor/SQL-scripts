USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'infogendba')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [infogendba] WITH PASSWORD = 0x01005D3236501F398691524A214999CB6B6DB99713180CCEB99F HASHED, SID = 0xD4CE66F4A63319469336F97E0A90BD16, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [infogendba] 


USE [Fin_Data_WH]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendba')
CREATE USER [infogendba] FOR LOGIN [infogendba] WITH DEFAULT_SCHEMA=[infogendba]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'infogendba'



ALTER AUTHORIZATION ON SCHEMA::[infogendba] TO [infogendba]

------USE [PR_Data_DW]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendba')
------CREATE USER [infogendba] FOR LOGIN [infogendba] WITH DEFAULT_SCHEMA=[infogendba]

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
------EXEC sp_addrolemember N'db_owner', N'infogendba'



------ALTER AUTHORIZATION ON SCHEMA::[infogendba] TO [infogendba]

ALTER LOGIN [infogendba] ENABLE

END