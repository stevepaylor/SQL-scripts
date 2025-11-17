----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 64 $
----------------------------------------------------------------------------------------------------

USE [msdb]
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'DBA - sp_WhoIsActive')
	EXEC msdb.dbo.sp_delete_job @job_name='DBA - sp_WhoIsActive', @delete_unused_schedule=1
GO

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0

IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - sp_WhoIsActive', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com

Collects who is active and save to DBA.dbo.WhoIsActive table. Data older than 48 hours will be deleted when 
this job runs.
', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [sp_WhoIsActive]    Script Date: 2/17/2013 8:00:50 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'sp_WhoIsActive', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'if not exists (select * from sys.sysdatabases where name = ''DBA'')
	return
go

use DBA
go

--
-- create WhoIsActive table in DBA database if not already exists
if not exists (select * from sys.sysobjects where name = ''WhoIsActive'' and type =''u'')
begin
	declare @destination_table varchar(4000) ;
	set @destination_table = ''DBA.dbo.WhoIsActive''

	declare @schema varchar(4000) ;
	exec master.dbo.sp_WhoIsActive
		@get_transaction_info = 1,
		@get_plans = 1,
		@find_block_leaders = 1,
		@RETURN_SCHEMA = 1,
		@SCHEMA = @schema output

	set @schema = replace(@schema, ''<table_name>'', @destination_table) ;
	exec (@schema)
	create index IDXWhoIsActive_collection_time on WhoIsActive (collection_time)
end

--
-- execute stored procedure
begin try
	exec master.dbo.sp_WhoIsActive 
	@get_transaction_info = 1,
	@get_plans = 1,
	@find_block_leaders = 1,
	@destination_table = ''DBA.dbo.WhoIsActive''
end try
begin catch
	print ''ignore error''
end catch
go

--
-- clean up data older than 24 hours
declare @cnt int
set @cnt = 1
while @cnt > 0
begin
	delete top (1000) WhoIsActive
	where collection_time < dateadd(hour, -24, getdate()) OPTION (RECOMPILE)
	select @cnt = @@rowcount
end
go
', 
		@database_name=N'DBA', 
		@flags=8
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'sp_WhoIsActive', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120216, 
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
