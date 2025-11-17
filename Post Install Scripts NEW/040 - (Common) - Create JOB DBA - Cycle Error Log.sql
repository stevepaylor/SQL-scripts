USE [msdb]
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'DBA - Cycle Error Log')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Cycle Error Log', @delete_unused_schedule=1
GO

USE [msdb]
GO

/****** Object:  Job [DBA - Cycle Error Log]    Script Date: 8/27/2020 12:36:07 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 8/27/2020 12:36:07 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Cycle Error Log', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Cycles the current error log if it is over 5 million bytes', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Cycle Error Log]    Script Date: 8/27/2020 12:36:08 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Cycle Error Log', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/************************************************************************************************************************* 
            Cycle error log when exceeds given size
			Ron Klimaszewski
			2015-09-30
			https://ronthepolymath.wordpress.com/

			Modified by Steve Paylor
			2016-04-27

			Changed temp table to table variable

**************************************************************************************************************************/

SET NOCOUNT ON

DECLARE @limit FLOAT
, @mailto NVARCHAR(150)
, @mailsubject NVARCHAR(100)
, @mailquery NVARCHAR(100)
, @v VARCHAR(15);

SELECT @v = CAST(SERVERPROPERTY(''productversion'') AS VARCHAR);

IF OBJECT_ID(''TEMPDB..##logs'') IS NOT NULL DROP TABLE ##logs;
CREATE TABLE ##logs 
( 
  Lognum INT
, Logdate DATETIME
, [Size (BYTES)] FLOAT
);

--Set the limit to 5MB

SET @limit = 5000000

SET @mailto = ''spaylor@viejas.com'';

SET @mailsubject = ''SQL Farm Warning: Error logs cycled on '' + @@SERVERNAME ;

SET @mailquery = ''SELECT * FROM ##logs ORDER BY Lognum'';

INSERT ##logs EXEC master..xp_enumerrorlogs;

SELECT * FROM ##logs ;

IF (SELECT [Size (BYTES)] FROM ##logs WHERE Lognum = 0) > @limit
BEGIN
	EXEC master..sp_cycle_errorlog

 	EXEC msdb..sp_send_dbmail @profile_name =''Alerts'', @recipients= @mailto, @subject = @mailsubject, @query = @mailquery
END ;

DROP TABLE ##logs ;
', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 3:30PM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20160427, 
		@active_end_date=99991231, 
		@active_start_time=153000, 
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

