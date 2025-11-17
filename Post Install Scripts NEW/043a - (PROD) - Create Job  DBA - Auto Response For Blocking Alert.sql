USE [DBA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('BlockingAlertProcessing') IS NOT NULL
DROP TABLE dbo.BlockingAlertProcessing
GO

CREATE TABLE dbo.BlockingAlertProcessing(
	AlertSeqNum int IDENTITY(1,1) NOT NULL,
	AlertTS datetime NOT NULL,
	AlertProcessed tinyint NOT NULL CONSTRAINT DF_BlockingAlertProcessing_AlertProcessed  DEFAULT ((0))
) ON [PRIMARY]

GO

IF OBJECT_ID('usp_list_blocking') IS NOT NULL
DROP PROCEDURE usp_list_blocking
GO

CREATE proc [dbo].[usp_list_blocking]
as
set nocount on
if (select count(*)
	from master..sysprocesses where spid in 
		(select rq.blocking_session_id
			from sys.dm_exec_requests rq
			join sys.dm_exec_sessions ss on (ss.session_id = rq.session_id)
			join sys.dm_exec_requests blck on (blck.blocking_session_id = rq.session_id))) != 0
begin
	print ''
	print 'At least two consecutive conditions of 10 or more processes'
	print 'being blocked have occurred.  The DBA has been paged.  If alters'
	print 'continue, please contact the DBA by phone - (858) 354-0983 and'
	print 'then act on the process with a 0 in the second column in the'
	print ' "*** SESSIONS THAT ARE DOING THE BLOCKING" section at the bottom'
	print ' of this Email message.'
	print ''
	print '*** 0 indicates source blocker'

	select blocked as blocked_by, cast(hostname as varchar(15)) as source_server, 
	cast(loginame as varchar(15)) as source_login
	from master..sysprocesses where  spid in 
	(select rq.blocking_session_id
	from sys.dm_exec_requests rq
	join sys.dm_exec_sessions ss on (ss.session_id = rq.session_id)
	join sys.dm_exec_requests blck on (blck.blocking_session_id = rq.session_id)
	)

	print ''
	print ''
	print ''
	print '*************************************'
	print '*** EVERYTHING BELOW ARE FYI ONLY ***'
	print '*************************************'
	print ''
	print '*** sessions that are being blocked'
	print ''
	select rq.session_id, cast(rq.blocking_session_id as varchar(15)) as blocking_id,
		cast(ss.login_name as varchar(15)) as login_name, ss.program_name, rq.command
	from sys.dm_exec_requests rq
	join sys.dm_exec_sessions ss on (ss.session_id = rq.session_id)
	where rq.blocking_session_id != 0
	order by rq.session_id desc

	print ''
	print ''
	print '*** SESSIONS THAT ARE DOING THE BLOCKING'
	print '*** SESSIONS THAT ARE DOING THE BLOCKING'
	print '*** SESSIONS THAT ARE DOING THE BLOCKING'
	print ''
	select rq.session_id, cast(rq.blocking_session_id as varchar(15)) as blocking_id,
		cast(ss.login_name as varchar(15)) as login_name, ss.program_name, rq.command
	from sys.dm_exec_requests rq
	join sys.dm_exec_sessions ss on (ss.session_id = rq.session_id)
	join sys.dm_exec_requests blck on (blck.blocking_session_id = rq.session_id)
	order by rq.session_id desc
end
else
begin
	print 'Please ignore. Process automatically cleared itself.'
end


GO


USE [msdb]
GO

DECLARE @jobId BINARY(16)

SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'DBA - Auto Response For Blocking Alert (PROD)')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId, @delete_unused_schedule=1
END
GO

USE [msdb]
GO

/****** Object:  Job [DBA - Auto Response For Blocking Alert (PROD)]    Script Date: 6/12/2019 2:45:55 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Viejas DB Maintenance]    Script Date: 6/12/2019 2:45:55 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Viejas DB Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Viejas DB Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Auto Response For Blocking Alert (PROD)', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'in response to ''ProcessesBlocked'' Alert', 
		@category_name=N'Viejas DB Maintenance', 
		@owner_login_name=N'ITappsDBA', 
		@notify_email_operator_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [list blocking]    Script Date: 6/12/2019 2:45:55 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'list blocking', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- flush/free cache
-- performance reasons
--
DBCC FREEPROCCACHE
GO
DBCC FREESESSIONCACHE
GO
DBCC FREESYSTEMCACHE(''ALL'')
GO
DBCC DROPCLEANBUFFERS 
GO

-- 2016-12-05 Steve Paylor 
-- Add a table and logic to only send alerts when two or more consecutive blocking alerts have been raised.

-- Insert a time stamp for the alert in the BlockingAlertProcessing table

INSERT INTO DBA.dbo.BlockingAlertProcessing
(AlertTS)VALUES (CURRENT_TIMESTAMP)
GO

-- set all rows not marked as processed and more than 9 minutes old to indicate alert has been processed
UPDATE DBA.dbo.BlockingAlertProcessing
SET AlertProcessed = 1
WHERE AlertTS < DATEADD(MINUTE,-9,CURRENT_TIMESTAMP)
GO

-- wait 3 seconds before mail

WAITFOR DELAY ''00:00:03''
GO

-- If there are more than 1 blocking alert unprocessed, mark all alerts as processed and 
-- send the alerts

IF (SELECT COUNT(*) FROM DBA.dbo.BlockingAlertProcessing WHERE AlertProcessed = 0) > 1
BEGIN

   -- set all rows to indicate alert has been processed
   UPDATE DBA.dbo.BlockingAlertProcessing
   SET AlertProcessed = 1;

   -- Prepare and send Alerts

   DECLARE @BODY_TEXT AS VARCHAR(64);
   SET @BODY_TEXT = ''10 or more sesssions are currently blocked on '' + @@SERVERNAME 
   
   -- send out pager alert

   EXEC msdb.dbo.sp_send_dbmail
     @profile_name = ''Alerts''
   , @recipients = ''8583540983@vtext.com''
   , @subject = ''!* BLOCKING ALERT *!''
   , @body = @BODY_TEXT;
   
   -- send out email alert with details

   DECLARE @SBJCT VARCHAR(64);
   SET @SBJCT = ''Blocked Process: '' + @@SERVERNAME


   EXEC msdb.dbo.sp_send_dbmail 
     @profile_name = ''Alerts''
   --, @recipients =''spaylor@viejas.com''
   , @recipients =''_ItOperations@viejas.com;_itdba@viejas.com''
   , @subject = @SBJCT
   , @append_query_error = 1
   ,  @query_result_no_padding = 1
   , @query = ''exec DBA.dbo.usp_list_blocking''

END
GO
', 
		@database_name=N'DBA', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

