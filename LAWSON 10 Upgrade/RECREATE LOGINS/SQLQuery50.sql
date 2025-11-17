USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\Akelleher')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\Akelleher] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\Akelleher] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Akelleher')
CREATE USER [VIEJAS\Akelleher] FOR LOGIN [VIEJAS\Akelleher] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'VIEJAS\Akelleher'



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Akelleher')
CREATE USER [VIEJAS\Akelleher] FOR LOGIN [VIEJAS\Akelleher] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\Akelleher'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\Akelleher] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\Akelleher] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\Akelleher] 

USE [msdb]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Akelleher')
CREATE USER [VIEJAS\Akelleher] FOR LOGIN [VIEJAS\Akelleher] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_ssisoperator' AND type = 'R')
BEGIN
CREATE ROLE [db_ssisoperator] AUTHORIZATION [dbo]
GRANT EXECUTE ON [dbo].[sp_add_dtspackage]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_drop_dtspackage]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_dump_dtslog_all]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_dump_dtspackagelog]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_dump_dtssteplog]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_dump_dtstasklog]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_enum_dtspackagelog]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_enum_dtspackages]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_enum_dtssteplog]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_enum_dtstasklog]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_get_dtspackage]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_get_dtsversion]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_log_dtspackage_begin]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_log_dtspackage_end]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_log_dtsstep_begin]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_log_dtsstep_end]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_log_dtstask]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_make_dtspackagename]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_reassign_dtspackageowner]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_ssis_checkexists]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_ssis_deletepackage]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_ssis_getfolder]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_ssis_getpackage]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_ssis_listfolders]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_ssis_listpackages]  TO [db_ssisoperator] 
GRANT EXECUTE ON [dbo].[sp_ssis_putpackage]  TO [db_ssisoperator] 
GRANT INSERT ON [dbo].[sysssislog]  TO [db_ssisoperator] 
GRANT SELECT ON [dbo].[sysssislog]  TO [db_ssisoperator] 
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_ssisoperator' AND type = 'R')
EXEC sp_addrolemember N'db_ssisoperator', N'VIEJAS\Akelleher'



ALTER LOGIN [VIEJAS\Akelleher] ENABLE

END