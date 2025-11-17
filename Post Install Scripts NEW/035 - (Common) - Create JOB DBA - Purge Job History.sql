-- turn off default clean job history clean up setting in SQL Agent properties\history
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @jobhistory_max_rows=-1, 
		@jobhistory_max_rows_per_job=-1
GO

USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Purge Job History')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Purge Job History', @delete_unused_schedule=1

USE [msdb]
GO

/****** Object:  Job [DBA - Purge Job History]    Script Date: 4/28/2017 4:03:48 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 4/28/2017 4:03:48 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Purge Job History', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Runs SP_PURGE_JOBHISTORY to delete job history rows more than 60 days old for all jobs', 
		@category_name=N'[Uncategorized (Local)]',
		@notify_email_operator_name=N'ITappsDBA', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run SP_PURGE_JOBHISTORY]    Script Date: 4/28/2017 4:03:48 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run SP_PURGE_JOBHISTORY', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE MSDB ;
GO

DECLARE @Date DATETIME;

-- All rows over 60 days old

SET @Date = GETDATE() - 60;

EXEC MSDB.DBO.SP_PURGE_JOBHISTORY @Oldest_date=@Date;

-- All rows over 2 days old for this job

SET @Date = GETDATE() - 2;

EXEC dbo.sp_purge_jobhistory
@job_name = N''DBA - Backup LOG (All Databases)'' ,
@oldest_date = @Date;

-- All rows over 1 days old for these jobs

SET @Date = GETDATE() - 1;

EXEC dbo.sp_purge_jobhistory
@job_name = N''DBA - Monitor AutoGrowth'' ,
@oldest_date = @Date;

EXEC dbo.sp_purge_jobhistory
@job_name = N''DBA - Record DB Connections'' ,
@oldest_date = @Date;

EXEC dbo.sp_purge_jobhistory
@job_name = N''DBA - sp_WhoIsActive'' ,
@oldest_date = @Date;

EXEC dbo.sp_purge_jobhistory
@job_name = N''DBA - Who Is Blocking'' ,
@oldest_date = @Date;


', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 10AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20170428, 
		@active_end_date=99991231, 
		@active_start_time=100000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


