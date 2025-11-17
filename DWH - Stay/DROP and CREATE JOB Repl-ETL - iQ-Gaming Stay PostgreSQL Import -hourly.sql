USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name=N'Repl-ETL - iQ-Gaming Stay PostgreSQL Import (hourly)')
EXEC msdb.dbo.sp_delete_job @job_name=N'Repl-ETL - iQ-Gaming Stay PostgreSQL Import (hourly)', @delete_unused_schedule=1
GO

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0

IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Uncategorized (Local)' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Uncategorized (Local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Repl-ETL - iQ-Gaming Stay PostgreSQL Import (hourly)', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Import tables from Opera Oracle to iQ-Gaming (Delta)', 
		@category_name=N'Uncategorized (Local)', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'DWH_Alerts', 
		@notify_page_operator_name=N'DWH_Text_Alerts', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Load_Delta_Stay_Reservations]    Script Date: 9/17/2023 12:37:56 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Load_Delta_Stay_Reservations', 
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

EXEC Opera_5_0.usp_Snapshot_Refresh_OBI_RESERVATION_STAT_DAILY ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc usp_Load_DELTA_NAME_RESERVATION]    Script Date: 9/17/2023 12:37:56 PM ******/
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
/****** Object:  Step [Run Proc usp_Load_DELTA_FINANCIAL_TRANSACTIONS]    Script Date: 9/17/2023 12:37:56 PM ******/
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
/****** Object:  Step [Run Proc usp_Snapshot_Refresh_ROOM_CATEGORY_TEMPLATE]    Script Date: 9/17/2023 12:37:56 PM ******/
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
/****** Object:  Step [Run Proc usp_Snapshot_Refresh_TRX_CODES]    Script Date: 9/17/2023 12:37:56 PM ******/
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
/****** Object:  Step [Save NAME_RESERVATION ETL History]    Script Date: 9/17/2023 12:37:56 PM ******/
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
/****** Object:  Step [Run Proc usp_Snapshot_Refresh_RESERVATIONS]    Script Date: 9/17/2023 12:37:56 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc usp_Snapshot_Refresh_RESERVATIONS', 
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

EXEC Opera_5_0.usp_Snapshot_Refresh_RESERVATIONS ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc - usp_Repl_ETL_Table_RowCount_Keys_Validation_Opera]    Script Date: 9/17/2023 12:37:56 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc - usp_Repl_ETL_Table_RowCount_Keys_Validation_Opera', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [SystemMaintDB]
GO

DECLARE @return_value int

EXEC @return_value = dbo.usp_Repl_ETL_Table_RowCount_Keys_Validation_Opera

SELECT	''Return Value'' = @return_value

GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc - usp_Repl_ETL_Table_RowCount_Keys_Validation_Get_Metrics_Opera]    Script Date: 9/17/2023 12:37:56 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc - usp_Repl_ETL_Table_RowCount_Keys_Validation_Get_Metrics_Opera', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE SystemMaintDB
GO

DECLARE @return_value int

EXEC @return_value = dbo.usp_Repl_ETL_Table_RowCount_Keys_Validation_Get_Metrics_Opera

SELECT	''Return Value'' = @return_value

GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc - usp_Repl_ETL_Table_RowCount_Keys_Validation_Opera_Report1]    Script Date: 9/17/2023 12:37:56 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc - usp_Repl_ETL_Table_RowCount_Keys_Validation_Opera_Report1', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE SystemMaintDB
GO

DECLARE @return_value int

EXEC @return_value = dbo.usp_Repl_ETL_Table_RowCount_Keys_Validation_Opera_Report1

SELECT	''Return Value'' = @return_value

GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Proc - usp_Opera_Variance_Email]    Script Date: 9/17/2023 12:37:56 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Proc - usp_Opera_Variance_Email', 
		@step_id=11, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE SystemMaintDB ;
GO

EXEC dbo.usp_Opera_Variance_Email ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every hour', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20230519, 
		@active_end_date=99991231, 
		@active_start_time=53000, 
		@active_end_time=52959, 
		@schedule_uid=N'5d5b3ece-a1b2-4efb-91d9-e730c5e40019'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


