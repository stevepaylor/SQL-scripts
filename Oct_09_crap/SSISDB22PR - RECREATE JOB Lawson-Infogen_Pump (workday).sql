USE [msdb]
GO

/****** Object:  Job [Lawson-Infogen_Pump (workday)]    Script Date: 10/10/2025 4:28:18 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/10/2025 4:28:18 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Lawson-Infogen_Pump (workday)', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Execute package: Infogen_Pump', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [SSIS: Infogen_Pump]    Script Date: 10/10/2025 4:28:18 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'SSIS: Infogen_Pump', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\"\Lawson\Infogen_Pump_wd\"" /SERVER SSISDB22PR /CONNECTION DBA;"\"Data Source=INFODB01PR;Initial Catalog=DBA;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;Application Name=SSIS-Infogen_Pump-{8C1F2BF2-E823-4ACD-B272-5E4D115BE0A5}AGINDB01PR.DBA;\"" /CONNECTION "\"Fin_Data_WH\"";"\"Data Source=DWHDB01PR;Initial Catalog=Fin_Data_WH;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;Application Name=SSIS-Infogen_Pump-{259CB037-FBB6-475F-959C-123A2DD9A5DF}LWSNVC04PR.Fin_Data_WH;\"" /CONNECTION "\"IT_Cfg\"";"\"Data Source=INFODB01PR;Initial Catalog=it_cfg;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;Application Name=SSIS-Infogen_Pump-{DF74CC3C-F1C6-4DE3-BBFF-1B5D87ACE7D3}GEN02.it_cfg;\"" /CONNECTION "\"IT_Trn\"";"\"Data Source=INFODB01PR;Initial Catalog=it_trn;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;Application Name=SSIS-Infogen_Pump-{8A389BC1-EFBF-426F-801B-E252FEDFC2EC}GEN01.it_trn;\"" /CHECKPOINTING OFF /REPORTING E', 
		@database_name=N'master', 
		@flags=40
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Infogen_Pump Once a day at 5.30 AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20180520, 
		@active_end_date=99991231, 
		@active_start_time=53000, 
		@active_end_time=235959, 
		@schedule_uid=N'ea7f1dce-70c5-42a8-9c95-566c4e5d5346'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

