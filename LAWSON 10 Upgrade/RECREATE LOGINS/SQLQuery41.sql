USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\VImmanni')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\VImmanni] FROM WINDOWS
SET @CreateError = @@ERROR

IF(@CreateError = 0)
BEGIN
exec master.dbo.sp_addsrvrolemember @loginame='VIEJAS\VImmanni', @rolename='sysadmin'
END

GRANT CONNECT SQL TO [VIEJAS\VImmanni] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VImmanni')
CREATE USER [VIEJAS\VImmanni] FOR LOGIN [VIEJAS\VImmanni] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\VImmanni'

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ss_application' AND type = 'R')
BEGIN
CREATE ROLE [ss_application] AUTHORIZATION [dbo]
GRANT DELETE ON [dbo].[BOA_Tran_Control]  TO [ss_application] 
GRANT INSERT ON [dbo].[BOA_Tran_Control]  TO [ss_application] 
GRANT SELECT ON [dbo].[BOA_Tran_Control]  TO [ss_application] 
GRANT UPDATE ON [dbo].[BOA_Tran_Control]  TO [ss_application] 
GRANT SELECT ON [dbo].[EDI_Control]  TO [ss_application] 
GRANT UPDATE ON [dbo].[EDI_Control]  TO [ss_application] 
GRANT SELECT ON [dbo].[EDI_Vendor_Control]  TO [ss_application] 
GRANT DELETE ON [dbo].[EventLogger]  TO [ss_application] 
GRANT INSERT ON [dbo].[EventLogger]  TO [ss_application] 
GRANT REFERENCES ON [dbo].[EventLogger]  TO [ss_application] 
GRANT SELECT ON [dbo].[EventLogger]  TO [ss_application] 
GRANT UPDATE ON [dbo].[EventLogger]  TO [ss_application] 
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ss_application' AND type = 'R')
EXEC sp_addrolemember N'ss_application', N'VIEJAS\VImmanni'



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VImmanni')
CREATE USER [VIEJAS\VImmanni] FOR LOGIN [VIEJAS\VImmanni] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ss_application' AND type = 'R')
BEGIN
CREATE ROLE [ss_application] AUTHORIZATION [dbo]
GRANT EXECUTE ON [dbo].[usp_EDIPOExtract]  TO [ss_application] 
GRANT EXECUTE ON [dbo].[usp_EDI_GetGSControl]  TO [ss_application] 
GRANT EXECUTE ON [dbo].[usp_EDI_GetISAControl]  TO [ss_application] 
GRANT EXECUTE ON [dbo].[usp_EDI_GetVendorData]  TO [ss_application] 
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ss_application' AND type = 'R')
EXEC sp_addrolemember N'ss_application', N'VIEJAS\VImmanni'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\VImmanni'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\VImmanni] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\VImmanni] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\VImmanni] 

ALTER LOGIN [VIEJAS\VImmanni] ENABLE

END