USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\DMehta')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\DMehta] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\DMehta] 


USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\dmehta')
CREATE USER [VIEJAS\dmehta] FOR LOGIN [VIEJAS\DMehta] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\dmehta'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\dmehta] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\dmehta] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\dmehta] 

ALTER LOGIN [VIEJAS\DMehta] ENABLE

END