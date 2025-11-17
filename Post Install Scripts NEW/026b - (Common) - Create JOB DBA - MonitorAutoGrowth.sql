----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 64 $
----------------------------------------------------------------------------------------------------

Use [msdb]
Go

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Monitor AutoGrowth')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Monitor AutoGrowth', @delete_unused_schedule=1

Declare @ReturnCode	 Int
Declare @ReturnCount Int
Declare	@JobOwner    Varchar(50)

Set @ReturnCode = 0
Set @ReturnCount = 0

-- Add job category --
If Not Exists (Select [name] From msdb.dbo.syscategories Where [name]=N'Database Maintenance' And category_class=1)
Begin
	Exec @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
	If(@ReturnCode <> 0) 
	Begin
		Set @ReturnCount = @ReturnCount + 1
		RaisError('ERROR: Error executing sp_add_category.', -1, -1)		
	End
End

-- Get job owner --

Set @JobOwner = 'DBAdmin'

------If Exists (Select [name] From sys.server_principals Where [name] = 'sa')
------Begin
------	Set @JobOwner = 'sa'
------End
----------Else If Exists (Select [name] From sys.server_principals Where [name] = 'ITappsDBA')
----------Begin
----------	Set @JobOwner = 'ITappsDBA'
----------End
------Else If Exists (Select [name] From sys.server_principals Where [name] = 'DBAadmin')
------Begin
------	Set @JobOwner = 'DBAdmin'
------End
------Else
------Begin
------	RaisError('ERROR: Neither the SA or DBAdmin logins exist.', -1, -1) With NoWait
------End

-- Syntax for the command for step 1 --
Declare @Step1Command Varchar(1000)
Set @Step1Command = 'Exec isp_MonitorAutoGrowth @timethreshold = 1, @frequencythreshold = 10, @monitortempdb = 0'

-- Add job if it doesn't already exist --
If Not Exists (Select [name] From msdb..sysjobs where [name] = 'DBA - Monitor AutoGrowth')
Begin
	Declare @jobId BINARY(16)
	Exec @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Monitor AutoGrowth', 
			@enabled=1, 
			@notify_level_eventlog=2, 
			@notify_level_email=2, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description=N'Monitors data and log file autogrowth.', 
			@category_name=N'Database Maintenance', 
			@owner_login_name=@JobOwner,
			@notify_email_operator_name=N'ITappsDBA', 
			@job_id = @jobId OUTPUT
	If (@ReturnCode <> 0) 
	Begin
		Set @ReturnCount = @ReturnCount + 1
		RaisError('ERROR: Error executing sp_add_job.', -1, -1)		
	End

	Exec @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check AutoGrowth And Write To Application Log', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, 
			@subsystem=N'TSQL', 
			@command= @Step1Command, 
			@database_name=N'DBA', 
			@flags=12
	If (@ReturnCode <> 0) 
	Begin
		Set @ReturnCount = @ReturnCount + 1
		RaisError('ERROR: Error executing sp_add_jobstep for Step 1.', -1, -1)		
	End

	Exec @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	If (@ReturnCode <> 0) 
	Begin
		Set @ReturnCount = @ReturnCount + 1
		RaisError('ERROR: Error executing sp_update_job.', -1, -1)			
	End

	Exec @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Export Backup History Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120323, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
	If (@ReturnCode <> 0) 
	Begin
		Set @ReturnCount = @ReturnCount + 1
		RaisError('ERROR: Error executing sp_add_jobschedule.', -1, -1)		
	End

	Exec @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	If (@ReturnCode <> 0) 
	Begin
		Set @ReturnCount = @ReturnCount + 1
		RaisError('ERROR: Error executing sp_add_jobserver.', -1, -1)		
	End

	If @ReturnCount = 0
	Begin
		RaisError('SUCCESS: Successfully created job DBA - Monitor AutoGrowth.', -1, -1)			
	End
	Else
	Begin
		RaisError('ERROR: Error creating job DBA - Monitor AutoGrowth.', -1, -1)		
	End
End
Else
Begin
	-- Update Step1 command to match current version for existing jobs --
	Exec @ReturnCount = msdb.dbo.sp_update_jobstep 
	@job_name = N'DBA - Monitor AutoGrowth',
	@step_name = 'Check AutoGrowth And Write To Application Log',
	@step_id = 1,
	@command = @Step1Command;
	
	If (@ReturnCode <> 0) 
	Begin
		Set @ReturnCount = @ReturnCount + 1
		RaisError('ERROR: Error executing sp_update_jobstep for Step 1.', -1, -1)		
	End
	Else
	Begin
		RaisError('SUCCESS: Successfully executed sp_update_jobstep for Step 1.', -1, -1)	
	End
End
