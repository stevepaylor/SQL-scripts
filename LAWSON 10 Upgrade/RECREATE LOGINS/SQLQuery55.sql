USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\llofstrom')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\llofstrom] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\llofstrom] 


USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\llofstrom')
CREATE USER [VIEJAS\llofstrom] FOR LOGIN [VIEJAS\llofstrom] WITH DEFAULT_SCHEMA=[VIEJAS\llofstrom]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\llofstrom'


DENY ALTER ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\llofstrom] 
DENY DELETE ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\llofstrom] 
DENY INSERT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\llofstrom] 
DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\llofstrom] 
DENY TAKE OWNERSHIP ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\llofstrom] 
DENY UPDATE ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\llofstrom] 
DENY ALTER ON [lawson].[PAYMASTR]  TO [VIEJAS\llofstrom] 
DENY DELETE ON [lawson].[PAYMASTR]  TO [VIEJAS\llofstrom] 
DENY INSERT ON [lawson].[PAYMASTR]  TO [VIEJAS\llofstrom] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\llofstrom] 
DENY TAKE OWNERSHIP ON [lawson].[PAYMASTR]  TO [VIEJAS\llofstrom] 
DENY UPDATE ON [lawson].[PAYMASTR]  TO [VIEJAS\llofstrom] 
DENY ALTER ON [lawson].[PAYSUMGRP]  TO [VIEJAS\llofstrom] 
DENY DELETE ON [lawson].[PAYSUMGRP]  TO [VIEJAS\llofstrom] 
DENY INSERT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\llofstrom] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\llofstrom] 
DENY TAKE OWNERSHIP ON [lawson].[PAYSUMGRP]  TO [VIEJAS\llofstrom] 
DENY UPDATE ON [lawson].[PAYSUMGRP]  TO [VIEJAS\llofstrom] 

ALTER LOGIN [VIEJAS\llofstrom] ENABLE

END