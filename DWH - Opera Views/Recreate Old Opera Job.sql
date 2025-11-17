USE [msdb]
GO

/****** Object:  Job [Repl-ETL - iQ-Gaming Opera Oracle Import (hourly)]    Script Date: 12/29/2023 12:16:42 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Uncategorized (Local)]    Script Date: 12/29/2023 12:16:42 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Uncategorized (Local)' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Uncategorized (Local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Repl-ETL - iQ-Gaming Opera Oracle Import (hourly)', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Import tables from Opera Oracle to iQ-Gaming (Delta)', 
		@category_name=N'Uncategorized (Local)', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'DWH_Alerts', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Load_DELTA_OBI_RESERVATION_STAT_DAILY]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Load_DELTA_OBI_RESERVATION_STAT_DAILY', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

EXEC Opera_5_0.usp_Load_DELTA_OBI_RESERVATION_STAT_DAILY ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Load_DELTA_NAME_RESERVATION]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Load_DELTA_NAME_RESERVATION', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

EXEC Opera_5_0.usp_Load_DELTA_NAME_RESERVATION ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Load_DELTA_FINANCIAL_TRANSACTIONS]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Load_DELTA_FINANCIAL_TRANSACTIONS', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

EXEC Opera_5_0.usp_Load_DELTA_FINANCIAL_TRANSACTIONS ;
GO
', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Snapshot_Refresh_ROOM_CATEGORY_TEMPLATE]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Snapshot_Refresh_ROOM_CATEGORY_TEMPLATE', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

EXEC Opera_5_0.usp_Snapshot_Refresh_ROOM_CATEGORY_TEMPLATE ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Snapshot_Refresh_TRX_CODES]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Snapshot_Refresh_TRX_CODES', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

EXEC Opera_5_0.usp_Snapshot_Refresh_TRX_CODES ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Save NAME_RESERVATION ETL History]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Save NAME_RESERVATION ETL History', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

SET ANSI_WARNINGS OFF;
GO
INSERT INTO Opera_5_0.NAME_RESERVATION_ETL_HISTORY 

SELECT 
  MAX(CONVERT(CHAR(16),CURRENT_TIMESTAMP,121)) AS BATCH_COMPLETION
, COUNT(*) AS ROWS
, MIN(CONVERT(CHAR(10),ARRIVAL,120)) AS EARLIEST_ARRIVAL
, MAX(CONVERT(CHAR(10),ARRIVAL,120)) AS LATEST_ARRIVAL
, MIN(CONVERT(CHAR(16),ACTUAL_CHECK_OUT_DATE,121)) AS EARLIEST_CHECK_OUT
, MAX(CONVERT(CHAR(16),ACTUAL_CHECK_OUT_DATE,121)) AS LATEST_CHECK_OUT

FROM Opera_5_0.NAME_RESERVATION
GO

SET ANSI_WARNINGS ON;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Recreate_and_Load_RESERVATIONS_Table]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Recreate_and_Load_RESERVATIONS_Table', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

EXEC Opera_5_0.usp_Recreate_and_Load_RESERVATIONS_Table ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Kick Off Job ETL_Refresh_Opera_Transactions_Tables_From_DWHDB01PR]    Script Date: 12/29/2023 12:16:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Kick Off Job ETL_Refresh_Opera_Transactions_Tables_From_DWHDB01PR', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC MSBIDB01DV.msdb.dbo.sp_start_job N''DWH - ETL_Refresh_Opera_Transactions_Tables_From_DWHDB01PR'' ;  
GO  

', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every hour - between 7AM and 3AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20230519, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=30000, 
		@schedule_uid=N'65c512e9-f268-41ec-b431-e9207aff7695'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


