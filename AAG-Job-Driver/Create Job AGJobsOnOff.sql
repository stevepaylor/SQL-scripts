USE [msdb]
GO

/****** Object:  Job [AGJobsOnOff]    Script Date: 8/18/2015 9:11:10 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 8/18/2015 9:11:10 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AGJobsOnOff', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'CorpDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run USP_AGJobsOnOff  Proc]    Script Date: 8/18/2015 9:11:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run USP_AGJobsOnOff  Proc', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC USP_AGJobsOnOff', 
		@database_name=N'DriverJobDB', 
		@flags=8
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Clean up Log Table]    Script Date: 8/18/2015 9:11:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Clean up Log Table', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DELETE FROM [DriverJobDB].[dbo].[AGJobsOnOffJobActionLog]
WHERE (DATEDIFF(YEAR,TimeStamp,CURRENT_TIMESTAMP) > 1) -- DELETE EVERYTHING OVER 1 YEAR OLD

	OR (Message LIKE ''AGJobsOnOff Job%''
		and DATEDIFF(MONTH,TimeStamp,CURRENT_TIMESTAMP) > 2) -- DELETE START\STOP MESSAGE OVER 2 MONTH OLD

	OR (Message LIKE ''AGJobsOnOff Job%''
		and DATEDIFF(DAY,TimeStamp,CURRENT_TIMESTAMP) > 1
		and DATEPART(MINUTE,TimeStamp) <> ''00'') -- DELETE START\STOP MESSAGE OVER 1 DAY OLD AND NOT AT THE TOP OF THE HOUR

	OR (Message = ''AGJobsOnOff Job completed.''
		and DATEDIFF(DAY,TimeStamp,CURRENT_TIMESTAMP) > 2) -- DELETE ALL COMPLETED MESSAGE OVER 2 DAYS OLD
GO', 
		@database_name=N'DriverJobDB', 
		@flags=8
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Minute', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140915, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'2800e6bb-72a8-4810-9b6f-01e1fa994b42'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

