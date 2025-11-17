USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\SWright')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\SWright] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\SWright] 


USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SWright')
CREATE USER [VIEJAS\SWright] FOR LOGIN [VIEJAS\SWright] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\SWright'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\SWright] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\SWright] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\SWright] 

ALTER LOGIN [VIEJAS\SWright] ENABLE

END