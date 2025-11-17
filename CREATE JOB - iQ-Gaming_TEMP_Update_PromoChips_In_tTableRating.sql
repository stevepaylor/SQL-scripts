USE [msdb]
GO

/****** Object:  Job [iQ-Gaming_TEMP_Update_PromoChips_In_tTableRating]    Script Date: 12/12/2024 12:55:28 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 12/12/2024 12:55:28 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'iQ-Gaming_TEMP_Update_PromoChips_In_tTableRating', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Update Script]    Script Date: 12/12/2024 12:55:29 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Update Script', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DROP TABLE IF EXISTS [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips] ;
GO

SELECT 
  [TranID]
, [PromoChips]

INTO [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips]

FROM [CMKTDB13DPR].[CMP13].[dbo].[tTableRating]

WHERE [ModifiedDtm] >= ''2024-10-22''

SELECT COUNT(*)
FROM [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips]

MERGE INTO [iQ-Gaming].[CMP_13-1].[tTableRating] AS Target
USING [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips] AS Source  
ON (Target.[TranId] = Source.[TranId])

WHEN MATCHED 
THEN UPDATE SET 
Target.[PromoChips] = Source.[PromoChips];
GO

SELECT 
  [PlayerId]
, [GamingDt]
, [TranID]
, [ModifiedDtm]
, [PromoChips]

FROM [iQ-Gaming].[CMP_13-1].[tTableRating]

WHERE [PromoChips] <> 0

ORDER BY
  [PlayerId]
, [GamingDt]
, [TranID]
, [ModifiedDtm]', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 30 Minutes', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20241028, 
		@active_end_date=99991231, 
		@active_start_time=800, 
		@active_end_time=235959, 
		@schedule_uid=N'6c517570-0b0a-46b1-97a5-bff732b14059'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


