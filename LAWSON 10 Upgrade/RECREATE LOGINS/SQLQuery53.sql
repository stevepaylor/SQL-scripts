USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\TCanicosa')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\TCanicosa] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\TCanicosa] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TCanicosa')
CREATE USER [VIEJAS\TCanicosa] FOR LOGIN [VIEJAS\TCanicosa] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\TCanicosa'



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TCanicosa')
CREATE USER [VIEJAS\TCanicosa] FOR LOGIN [VIEJAS\TCanicosa] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\TCanicosa'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\TCanicosa] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\TCanicosa] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\TCanicosa] 

ALTER LOGIN [VIEJAS\TCanicosa] ENABLE

END