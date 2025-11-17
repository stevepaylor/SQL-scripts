USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\Crystal NT')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\Crystal NT] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\Crystal NT] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Crystal NT')
CREATE USER [Crystal NT] FOR LOGIN [VIEJAS\Crystal NT] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'Crystal NT'



------USE [PR_Data_DW]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Crystal NT')
------CREATE USER [VIEJAS\Crystal NT] FOR LOGIN [VIEJAS\Crystal NT] WITH DEFAULT_SCHEMA=[dbo]



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Crystal NT')
CREATE USER [VIEJAS\Crystal NT] FOR LOGIN [VIEJAS\Crystal NT] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\Crystal NT'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\Crystal NT] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\Crystal NT] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\Crystal NT] 

ALTER LOGIN [VIEJAS\Crystal NT] ENABLE

END