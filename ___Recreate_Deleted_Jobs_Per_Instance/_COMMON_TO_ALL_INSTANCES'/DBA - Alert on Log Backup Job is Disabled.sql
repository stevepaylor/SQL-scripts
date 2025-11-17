USE [msdb]
GO

/****** Object:  Job [DBA - Alert on Log Backup Job is Disabled]    Script Date: 1/12/2023 9:53:39 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 1/12/2023 9:53:39 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Alert on Log Backup Job is Disabled', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Runs every 15 minutes and send email to steve paylor''s email accounts (Viejas and personal) and sends a text message to his cell phone', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Alert on Log Backup Job is Disabled]    Script Date: 1/12/2023 9:53:39 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Alert on Log Backup Job is Disabled', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @JobName VARCHAR(50);
SET @JobName = (SELECT [name] FROM msdb.dbo.sysjobs WHERE [name] LIKE ''DBA - Backup LOG%'' AND enabled = 0);

IF @JobName IS NOT NULL
BEGIN

   -- Prepare and send Alerts

   DECLARE @SBJCT VARCHAR(64);
   SET @SBJCT = @@SERVERNAME + '' Lob Backup Job is DISABLED.'';

   DECLARE @BODY_TEXT AS VARCHAR(64);
   SET @BODY_TEXT =  @@SERVERNAME + '' - '' + @jobName + '' is DISABLED.'';
   
   -- send out pager alert

   EXEC msdb.dbo.sp_send_dbmail
     @profile_name = ''Alerts''
   --, @recipients = ''8583540983@vtext.com;spaylor@viejas.com;steve@lpaylor.com''
   , @recipients = ''spaylor@viejas.com;steve@lpaylor.com''
   , @subject = @SBJCT
   , @body = @BODY_TEXT;
   
END
GO
', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Hour', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20180306, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=235959, 
		@schedule_uid=N'8c2d90ed-7e56-45be-bec2-a6ff9fcad5d8'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


