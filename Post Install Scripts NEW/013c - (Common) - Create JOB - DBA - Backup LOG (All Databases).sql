USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Backup LOG (All Databases)')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Backup LOG (All Databases)', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - Backup LOG (All Databases)]    Script Date: 12/6/2023 2:55:58 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 12/6/2023 2:55:58 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Backup LOG (All Databases)', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'ITappsTeam', 
		@notify_page_operator_name=N'SteveText', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DBA - Backup LOG (All Databases)]    Script Date: 12/6/2023 2:55:58 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBA - Backup LOG (All Databases)', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=3, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = ''ALL_DATABASES''
, @Directory = N''\\DBAMBK01PR\SQLBackup02''
, @BackupType = ''LOG''
--, @CleanupTime = 360
, @BackupSoftware = NULL
, @Compress  = ''Y''
, @CopyOnly = ''N''
, @Verify = ''N''
, @CheckSum = ''Y''
, @BufferCount = 512
, @MaxTransferSize = 262144
, @BlockSize = 8192
, @LogToTable = ''Y''
, @DirectoryStructure = NULL
, @AvailabilityGroupDirectoryStructure=NULL
, @FileName = ''{ServerName}_{InstanceName}_{DatabaseName}_{BackupType}_{Year}{Month}-{Day}_{Hour}.{Minute}.{Second}.{FileExtension}''
, @AvailabilityGroupFileName  = ''${AvailabilityGroupName}_{DatabaseName}_{BackupType}_{Year}-{Month}-{Day}_{Hour}.{Minute}.{Second}.{FileExtension}''', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Incremental Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=15, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140717, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=459
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

