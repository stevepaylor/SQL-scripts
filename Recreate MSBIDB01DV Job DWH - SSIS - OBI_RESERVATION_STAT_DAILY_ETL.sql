USE [msdb]
GO

/****** Object:  Job [DWH - SSIS - OBI_RESERVATION_STAT_DAILY_ETL]    Script Date: 4/8/2022 10:04:40 AM ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'7ab83533-63bb-4f52-b2d6-87796183443a', @delete_unused_schedule=1
GO

/****** Object:  Job [DWH - SSIS - OBI_RESERVATION_STAT_DAILY_ETL]    Script Date: 4/8/2022 10:04:40 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 4/8/2022 10:04:40 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DWH - SSIS - OBI_RESERVATION_STAT_DAILY_ETL', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'ITappsDBA', 
		@notify_page_operator_name=N'SteveText', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run SSIS Package OBI_RESERVATION_STAT_DAILY_ETL]    Script Date: 4/8/2022 10:04:40 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run SSIS Package OBI_RESERVATION_STAT_DAILY_ETL', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\"\Opera\OBI_RESERVATION_STAT_DAILY\"" /SERVER MSBIDB01DV /DECRYPT viejas123 /X86  /CHECKPOINTING OFF /REPORTING E', 
		@database_name=N'master', 
		@flags=40
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Save Load Confirmation Data to History Table]    Script Date: 4/8/2022 10:04:40 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Save Load Confirmation Data to History Table', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=5, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET ANSI_WARNINGS OFF;
GO
INSERT INTO [OperaData_Temp].[dbo].[NAME_RESERVATION_ETL_HISTORY] 

SELECT 
  MAX(CONVERT(CHAR(16),CURRENT_TIMESTAMP,121)) AS BATCH_COMPLETION
, COUNT(*) AS ROWS
, MIN(CONVERT(CHAR(10),ARRIVAL,120)) AS EARLIEST_ARRIVAL
, MAX(CONVERT(CHAR(10),ARRIVAL,120)) AS LATEST_ARRIVAL
, MIN(CONVERT(CHAR(16),ACTUAL_CHECK_OUT_DATE,121)) AS EARLIEST_CHECK_OUT
, MAX(CONVERT(CHAR(16),ACTUAL_CHECK_OUT_DATE,121)) AS LATEST_CHECK_OUT

FROM [OperaData_Temp].[dbo].[NAME_RESERVATION]
GO

SET ANSI_WARNINGS ON;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'7:00 and every 2 hours afterwards Each Day', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20180215, 
		@active_end_date=99991231, 
		@active_start_time=90000, 
		@active_end_time=55959, 
		@schedule_uid=N'01ebd00b-30bf-45b6-bbf9-a1a5fcc1242e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 7AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20180215, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=235959, 
		@schedule_uid=N'42be43d1-dce1-46e9-9c78-36a42a04e661'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Hour on the 15', 
		@enabled=0, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20180215, 
		@active_end_date=99991231, 
		@active_start_time=1500, 
		@active_end_time=235959, 
		@schedule_uid=N'e246477e-38d4-43cd-a119-19db7b3407c9'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


