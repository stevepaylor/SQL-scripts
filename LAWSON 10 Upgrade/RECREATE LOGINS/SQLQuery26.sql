USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\jfreedman')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\jfreedman] FROM WINDOWS
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [VIEJAS\jfreedman] 


USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jfreedman')
CREATE USER [VIEJAS\jfreedman] FOR LOGIN [VIEJAS\jfreedman] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'VIEJAS\jfreedman'



USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jfreedman')
CREATE USER [VIEJAS\jfreedman] FOR LOGIN [VIEJAS\jfreedman] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\jfreedman'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [VIEJAS\jfreedman] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [VIEJAS\jfreedman] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [VIEJAS\jfreedman] 

------USE [dba_OLD]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jfreedman')
------CREATE USER [VIEJAS\jfreedman] FOR LOGIN [VIEJAS\jfreedman] WITH DEFAULT_SCHEMA=[VIEJAS\jfreedman]



USE [msdb]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jfreedman')
CREATE USER [VIEJAS\jfreedman] FOR LOGIN [VIEJAS\jfreedman] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentUserRole' AND type = 'R')
BEGIN
CREATE ROLE [SQLAgentUserRole] AUTHORIZATION [dbo]
GRANT EXECUTE ON [dbo].[sp_add_job]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_add_jobschedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_add_jobserver]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_add_jobstep]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_add_schedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_addtask]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_attach_schedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_check_for_owned_jobs]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_check_for_owned_jobsteps]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_delete_job]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_delete_jobschedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_delete_jobserver]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_delete_jobstep]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_delete_jobsteplog]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_delete_schedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_detach_schedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_droptask]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_enum_sqlagent_subsystems]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_get_job_alerts]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_get_jobstep_db_username]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_get_sqlagent_properties]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_category]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_job]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobactivity]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobcount]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobhistory]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobhistory_full]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobhistory_sem]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobhistory_summary]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobs_in_schedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobschedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobserver]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobstep]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_jobsteplog]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_operator]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_proxy]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_help_schedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_maintplan_subplans_by_job]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_notify_operator]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_start_job]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_stop_job]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_uniquetaskname]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_update_job]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_update_jobschedule]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_update_jobstep]  TO [SQLAgentUserRole] 
GRANT EXECUTE ON [dbo].[sp_update_schedule]  TO [SQLAgentUserRole] 
GRANT SELECT ON [dbo].[syscategories]  TO [SQLAgentUserRole] 
GRANT SELECT ON [dbo].[sysjobs_view]  TO [SQLAgentUserRole] 
GRANT SELECT ON [dbo].[sysschedules_localserver_view]  TO [SQLAgentUserRole] 
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentUserRole' AND type = 'R')
EXEC sp_addrolemember N'SQLAgentUserRole', N'VIEJAS\jfreedman'

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentReaderRole' AND type = 'R')
BEGIN
CREATE ROLE [SQLAgentReaderRole] AUTHORIZATION [dbo]
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentReaderRole' AND type = 'R')
EXEC sp_addrolemember N'SQLAgentReaderRole', N'VIEJAS\jfreedman'

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentOperatorRole' AND type = 'R')
BEGIN
CREATE ROLE [SQLAgentOperatorRole] AUTHORIZATION [dbo]
GRANT EXECUTE ON [dbo].[sp_enum_login_for_proxy]  TO [SQLAgentOperatorRole] 
GRANT EXECUTE ON [dbo].[sp_help_alert]  TO [SQLAgentOperatorRole] 
GRANT EXECUTE ON [dbo].[sp_help_notification]  TO [SQLAgentOperatorRole] 
GRANT EXECUTE ON [dbo].[sp_help_targetserver]  TO [SQLAgentOperatorRole] 
GRANT EXECUTE ON [dbo].[sp_purge_jobhistory]  TO [SQLAgentOperatorRole] 
GRANT SELECT ON [dbo].[sysalerts]  TO [SQLAgentOperatorRole] 
GRANT SELECT ON [dbo].[sysalerts_performance_counters_view]  TO [SQLAgentOperatorRole] 
GRANT SELECT ON [dbo].[sysnotifications]  TO [SQLAgentOperatorRole] 
GRANT SELECT ON [dbo].[sysoperators]  TO [SQLAgentOperatorRole] 
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentOperatorRole' AND type = 'R')
EXEC sp_addrolemember N'SQLAgentOperatorRole', N'VIEJAS\jfreedman'

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
EXEC sp_addrolemember N'db_ssisoperator', N'VIEJAS\jfreedman'



ALTER LOGIN [VIEJAS\jfreedman] ENABLE

END