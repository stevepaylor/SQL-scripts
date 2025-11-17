USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'Payroll_ETL_Run')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [Payroll_ETL_Run] WITH PASSWORD = 0x01006B7FDC738F1D9838F2B11785B90938DBF26BE66C9B055EA6 HASHED, SID = 0x8F84BDF2BFB45B4BBF14FA5C28104048, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR
IF(@CreateError = 0)
BEGIN
DENY CONNECT SQL TO [Payroll_ETL_Run]
SET @CreateError = @@ERROR
END
IF(@CreateError = 0)
BEGIN
ALTER LOGIN [Payroll_ETL_Run] DISABLE
SET @CreateError = @@ERROR
END


DENY CONNECT SQL TO [Payroll_ETL_Run] 


USE [msdb]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Payroll_ETL_Run')
CREATE USER [Payroll_ETL_Run] FOR LOGIN [Payroll_ETL_Run] WITH DEFAULT_SCHEMA=[dbo]

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
EXEC sp_addrolemember N'SQLAgentUserRole', N'Payroll_ETL_Run'

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentReaderRole' AND type = 'R')
BEGIN
CREATE ROLE [SQLAgentReaderRole] AUTHORIZATION [dbo]
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAgentReaderRole' AND type = 'R')
EXEC sp_addrolemember N'SQLAgentReaderRole', N'Payroll_ETL_Run'

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
EXEC sp_addrolemember N'SQLAgentOperatorRole', N'Payroll_ETL_Run'



ALTER LOGIN [Payroll_ETL_Run] ENABLE

END