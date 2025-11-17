USE [msdb]
GO

/****** Object:  Job [Refresh_slot_slip_jackpot_table]    Script Date: 10/9/2025 4:15:39 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/9/2025 4:15:39 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Refresh_slot_slip_jackpot_table', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'DWH_Alerts', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Refresh_slot_slip_jackpot_table]    Script Date: 10/9/2025 4:15:39 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Refresh_slot_slip_jackpot_table', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=1, 
		@retry_interval=2, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

DROP TABLE IF EXISTS [iQ-Gaming].[slot].[slip_jackpot] ;
GO

SELECT 
  [JKPT_ID]
, [SLPR_ID]
, [JPTY_ID]
, [TAXT_ID]
, [JKPT_JACKPOT_ID]
, [JKPT_ASSOCIATED_PLAYER_CARD]
, [JKPT_PLAYER_CARD]
, [JKPT_PLAYER_NAME]
, [JKPT_ORIGINAL_AMOUNT]
, [JKPT_MACHINE_PAID_AMOUNT]
, [JKPT_HPJP_AMOUNT]
, [JKPT_NET_AMOUNT_ROUNDED]
, [JKPT_NET_AMOUNT]
, [JKPT_TAX_AMOUNT]
, [JKPT_PAYLINE]
, [JKPT_COINS_PLAYED]
, [JKPT_WINNING_COMBINATION]
, [JKPT_BLIND_ATTEMPT]
, [JKPT_CALC_SDS_AMOUNT]
, [JKPT_PRMT_PMU_AMOUNT]
, [JKPT_PMU_AMOUNT_USED]
, [JKPT_EXPIRY_TS]
, [JKPT_SLOT_ONLINE]
, [JKPT_PROG_LEVELS]
, [JKPT_GENERATED_BY]
, [JKPT_AWARD_TYPE]
, [JKPT_AWARD_TEXT]
, [JKPT_CREATED_TS]
, [JKPT_CREATED_USER]
, [JKPT_UPDATED_TS]
, [JKPT_UPDATED_USER]
, [JKPT_IS_BONUS_JP]
, [JKPT_BONUS_AMOUNT]
, [JKPT_CANCELED_JACKPOT_TYPE]
, [JKPT_CASH_AMOUNT]
, [JKPT_CHEQUE_AMOUNT]
, [JKPT_TAX_RATE_AMOUNT]

INTO [iQ-Gaming].[slot].[slip_jackpot]

FROM [RPTDB01PR].[SDSVJPRD_REPORTING].[SLIP].[JACKPOT] ;
GO

SELECT COUNT(*)
FROM [RPTDB01PR].[SDSVJPRD_REPORTING].[SLIP].[JACKPOT] ;
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 2:05AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20240828, 
		@active_end_date=99991231, 
		@active_start_time=20500, 
		@active_end_time=235959, 
		@schedule_uid=N'51011287-770f-44d7-b2aa-1baee3ec8a48'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

