USE [msdb]
GO

/****** Object:  Job [DBA - DBCC UPDATEUSAGE]    Script Date: 7/11/2016 3:12:56 PM ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - DBCC UPDATEUSAGE')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - DBCC UPDATEUSAGE', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - DBCC UPDATEUSAGE]    Script Date: 7/11/2016 3:12:56 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 7/11/2016 3:12:56 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - DBCC UPDATEUSAGE', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Runs DBCC UPDATEUSAGE against all databases to fix incorrect monitoring information happening in SQL DM', 
		@category_name=N'Database Maintenance',
		@notify_email_operator_name=N'ITappsDBA', 
		@owner_login_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DBCC UPDATEUSAGE]    Script Date: 7/11/2016 3:12:57 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBCC UPDATEUSAGE', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--DECLARE @DB VARCHAR(64);
--SET @DB = ''CMP13''

--IF CONVERT(VARCHAR(64),DATABASEPROPERTYEX(@DB, ''Updateability'')) = ''READ_WRITE''
--BEGIN 
--	PRINT @DB;
--	PRINT CONVERT(VARCHAR(64),DATABASEPROPERTYEX(@DB, ''Updateability''));
--END
--ELSE
--BEGIN
--	PRINT ''NOT READ_WRITE''
--END

--DBCC UPDATEUSAGE
--exec sp_MSforeachDB ''DBCC CHECKDB (?) WITH ALL_ERRORMSGS, EXTENDED_LOGICAL_CHECKS, DATA_PURITY''

declare @servername varchar(50), --variable to hold the servername
    @DBNAME varchar(100), --variable to hold the database name
    @command varchar(1000) --variable to hold the sql command

-- set variables
select @servername=@@servername

-- declare the cursor
declare dbccuu cursor for
select name from master.dbo.sysdatabases
    where  (status & 32 <> 32 and status & 128 <> 128 and status & 512 <> 512 and status & 1024 <> 1024 and status & 4096 <> 4096 and status & 2048 <> 2048)  and (name not in (''Northwind'', ''Pubs''))

-- open the cursor
open dbccuu

-- fetch the first record into the cursor
fetch dbccuu into @DBNAME

-- while the fetch was successful
while @@fetch_status=0

begin
	IF CONVERT(VARCHAR(64),DATABASEPROPERTYEX(@DBNAME, ''Updateability'')) = ''READ_WRITE''
	BEGIN
		-- print the header for each database
		print ''''
		print ''***************************''
		print ''DBCC UPDATEUSAGE Report For ''+@DBNAME
		print ''***************************''
		print ''''

		-- set the command to execute
		set @command=''dbcc updateusage([''+@DBNAME+''])''

		-- execute the command

		exec(@command)
	END
	ELSE
	BEGIN
		PRINT '' '';
		PRINT ''++++++++++++++++++++++++'';
		PRINT ''Skipping database: '' + @DBNAME + '' which is not in READ_WRITE mode.'';
		PRINT ''++++++++++++++++++++++++'';
	END

    -- fetch the next record into the cursor
    fetch dbccuu into @DBNAME
end

-- close the cursor
close dbccuu

-- deallocate the cursor
deallocate dbccuu

-- tell user when the script was last run
select ''This script was executed on '' + cast(getdate() as varchar(50))', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DAILY at 8AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20160624, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
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

