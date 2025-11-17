USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Update Stats')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Update Stats', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Index_Maint_Integrity_Checks')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Index_Maint_Integrity_Checks', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Index_Maint_Integrity_Checks - Stop Job at 4AM')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Index_Maint_Integrity_Checks - Stop Job at 4AM', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Index_Maint_Integrity_Checks - Stop Job at 9AM')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Index_Maint_Integrity_Checks - Stop Job at 9AM', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Integrity Check (All Databases)')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Integrity Check (All Databases)', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Integrity Check (All Databases)')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Integrity Check (All Databases)', @delete_unused_schedule=1
GO

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 6/20/2023 9:52:31 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Update Stats', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update Stats]    Script Date: 6/20/2023 9:52:31 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update Stats', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET NOCOUNT ON
 
DECLARE @dbName sysname, @rc int, @sql nvarchar(4000)
 
SELECT name
INTO #db
FROM sys.databases
WHERE 
                [name] <> ''model'' AND
                [name] <> ''tempdb'' AND
				[name] <> ''CMKTDB_ARCHIVE'' AND
				[name] <> ''CMKTDB_ARCHIVE_OLD'' AND
                name NOT LIKE ''%ReportServer%'' AND
                DATABASEPROPERTYEX([name], ''IsInStandBy'') = 0 AND
                DATABASEPROPERTYEX([name], ''Status'') = ''ONLINE'' AND
                DATABASEPROPERTYEX([name], ''Updateability'') = ''READ_WRITE'' AND
                source_database_id IS NULL
 
SET @rc = @@ROWCOUNT
 
SELECT @dbName = MIN(name)
FROM #db
 
WHILE @rc <> 0
BEGIN
	EXEC isp_UPDATE_STATISTICS @dbName

	SELECT TOP 1 @dbName = name
	FROM #db
	WHERE name > @dbName
	ORDER BY name

	SET @rc = @@ROWCOUNT

	SELECT @dbName 
END

DROP TABLE #db
', 
		@database_name=N'DBA', 
		@flags=8
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 2AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20071009, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'd6ca88c9-99b5-44bc-8a12-25caa6a29af6'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

