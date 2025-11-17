USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - AAG <AAG_name> Failover From A-node Alert')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - AAG <AAG_name> Failover From A-node Alert', @delete_unused_schedule=1

USE [msdb]
GO

/****** Object:  Job [DBA - AAG <AAG_name> Failover From A-node Alert]    Script Date: 10/22/2019 4:30:03 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Viejas DB Maintenance]    Script Date: 10/22/2019 4:30:03 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Viejas DB Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Viejas DB Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - AAG <AAG_name> Failover From A-node Alert', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Runs every minute and sends alert if the A-node replica changes from primary to secondary', 
		@category_name=N'Viejas DB Maintenance', 
		@owner_login_name=N'ITappsDBA', 
		@notify_email_operator_name=N'ITappsDBA', 
		@notify_page_operator_name=N'SteveText', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Check AAG Role and Send Alert if Changed]    Script Date: 10/22/2019 4:30:03 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check AAG Role and Send Alert if Changed', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @SUBJECT_TEXT VARCHAR(200);
SET @SUBJECT_TEXT = ''Primary Replica of AAG <AAG_name> Has Failed Over on '' + @@SERVERNAME;

DECLARE @BODY_TEXT VARCHAR(200);
SET @BODY_TEXT = ''Determine if server '' + @@SERVERNAME + '' is operational.  If it is, then immediately initiate an AAG failover back to the primary node ('' + @@SERVERNAME + '') AND Immediately contact Steve Paylor at 858-354-0983 (7x24).'';

IF (SELECT
    ars.role_desc
    FROM sys.dm_hadr_availability_replica_states ars
    INNER JOIN sys.availability_groups ag
    ON ars.group_id = ag.group_id
    WHERE ag.name = ''<AAG_name>''
    AND ars.is_local = 1) = ''SECONDARY''
BEGIN

  EXEC msdb.dbo.sp_send_dbmail
  @profile_name = ''Alerts'',
  @recipients = ''8583540983@vtext.com;steve@lpaylor.com;_ITDBA@viejas.com'',
  @subject = @SUBJECT_TEXT,
  @body = @BODY_TEXT;

END', 
		@database_name=N'msdb', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Minute', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20161020, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

