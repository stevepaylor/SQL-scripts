USE [msdb]
GO

/****** Object:  Job [_DWH - REPL_MERGE_iQC_tPlayer_ClubState_to_REPL_Table]    Script Date: 10/9/2025 4:00:42 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/9/2025 4:00:42 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'_DWH - REPL_MERGE_iQC_tPlayer_ClubState_to_REPL_Table', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'DWH_Alerts', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run MERGE_iQC_tPlayer_ClubState_to_REPL_Table Stored Proc]    Script Date: 10/9/2025 4:00:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run MERGE_iQC_tPlayer_ClubState_to_REPL_Table Stored Proc', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming]
GO

DECLARE @RC int

EXECUTE @RC = REPL.sp_iQC_tPlayer_ClubState_Delta_Load
GO', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQL_AGENT_JOB_OUTPUT\DWH - REPL_MERGE_iQC_tPlayer_ClubState_to_REPL_Table_OUTPUT_LOG', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Query to Show Changes]    Script Date: 10/9/2025 4:00:42 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Query to Show Changes', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming]
GO

SELECT 
  COUNT(*) AS ''Row Count''
, AddedToRepl_TS
, ModifiedInRepl_TS

FROM [iQ-Gaming].REPL.iQC_tPlayer_ClubState_Repl

GROUP BY 
  AddedToRepl_TS
, ModifiedInRepl_TS

ORDER BY 
  AddedToRepl_TS
, ModifiedInRepl_TS', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQL_AGENT_JOB_OUTPUT\REPL_MERGE_iQC_tPlayer_ClubState_to_REPL_Table_OUTPUT_LOG', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 10 minutes', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20220727, 
		@active_end_date=99991231, 
		@active_start_time=400, 
		@active_end_time=300, 
		@schedule_uid=N'8827e545-b779-4687-b229-f449a3221752'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

