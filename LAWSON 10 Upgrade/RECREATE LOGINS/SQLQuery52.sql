USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\APham')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\APham] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\APham] 


USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\APham')
CREATE USER [VIEJAS\APham] FOR LOGIN [VIEJAS\APham] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\APham'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\APham] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\APham] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\APham] 

ALTER LOGIN [VIEJAS\APham] ENABLE

END