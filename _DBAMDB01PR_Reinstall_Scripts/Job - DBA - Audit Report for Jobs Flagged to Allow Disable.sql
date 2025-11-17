USE [msdb]
GO

/****** Object:  Job [DBA - Audit Report for Jobs Flagged to Allow Disable]    Script Date: 5/16/2024 3:41:40 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 5/16/2024 3:41:40 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Audit Report for Jobs Flagged to Allow Disable', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'This job runs every 30 minutes at 7 minutes after the hour / half-hour.  It queries the centralized disabled job table and generates a report of any jobs that are found disabled that are not flagged as being allowed to be disabled and send the report via Email to the _itdba maling list.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create and Email Audit Report for Non-DBA Jobs]    Script Date: 5/16/2024 3:41:40 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create and Email Audit Report for Non-DBA Jobs', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=1, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [DBA]
GO

IF OBJECT_ID(''Invalid_Disabled_Jobs_Alert'', ''U'') IS NOT NULL 
DROP TABLE dbo.Invalid_Disabled_Jobs_Alert ;

SELECT 
  [InstanceName] + '' '' as Instance
, [JobName] + '' '' as Job
, CONVERT(CHAR(10),[LastChangedDTM],120) + ''  '' as ''Last Changed On   ''
, CONVERT(CHAR(10),[LastCheckedDTM],120) + ''  '' as ''Last Checked On   ''
, CASE [AllowDisabled] WHEN ''Y'' THEN ''Yes'' ELSE ''No'' END as '' Disable is Allowed ?   ''
, CONVERT(CHAR(10),[AllowDisabledSetDTM],120) + ''  '' as ''Date Set to Allow   ''
, [AllowDisabledSetBy] + ''  '' as ''Set to Allowed By   ''
, CASE [Enabled] WHEN 0 THEN ''Yes'' ELSE ''No'' END + ''  '' as ''Job is Currently Disabled ?''
, NULLIF(DisabledNotes, '' '') as ''Notes''

INTO dbo.Invalid_Disabled_Jobs_Alert

FROM [Job_Tracking].[dbo].[Disabled_Job_Tracking_Centralized]

WHERE [AllowDisabled] <> ''N'' 
  AND [JobName] NOT LIKE ''DBA - %'' ;

IF (SELECT COUNT(*) FROM dbo.Invalid_Disabled_Jobs_Alert) > 0

BEGIN

	DECLARE @TABLENAME_INPUT nvarchar(500) = ''Invalid_Disabled_Jobs_Alert'' ;
	DECLARE @TBL_STYLE_INPUT nvarchar(1024) = ''style="font:8pt" class="AltListBorder" cellpadding="2" cellspacing="1"'' ;
	DECLARE @HDR_STYLE_INPUT nvarchar(1024) = ''class="RowHeader"'' ;
	DECLARE @OUTPUT nvarchar(MAX) ;

	EXEC DBA.[dbo].[spCustomTable2HTML]       
      @TABLENAME = @TABLENAME_INPUT  
    , @TBL_STYLE = @TBL_STYLE_INPUT
    , @HDR_STYLE = @HDR_STYLE_INPUT
    , @OUTPUT = @OUTPUT OUTPUT

	DECLARE @subject_value as VARCHAR(300) = ''Audit Report - Non-DBA Jobs Allowed To Be Disabled -- As Of '' + CONVERT(CHAR(10),CURRENT_TIMESTAMP,120) 
	DECLARE @Rrecipients_value VARCHAR(300) = ''_itdba@viejas.com'';

	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''Alerts'',
    @recipients = @Rrecipients_value,
    @subject = @subject_value,
    @body = @OUTPUT,
    @body_format = ''HTML'',
    @query_no_truncate = 1,
    @attach_query_result_as_file = 0 ;

	DROP TABLE Invalid_Disabled_Jobs_Alert ;
END
ELSE
BEGIN
	SELECT ''No erroneously disabled jobs where found.'' ;
END', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create and Email Audit Report for DBA Jobs]    Script Date: 5/16/2024 3:41:40 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create and Email Audit Report for DBA Jobs', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=1, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [DBA]
GO

IF OBJECT_ID(''Invalid_Disabled_Jobs_Alert'', ''U'') IS NOT NULL 
DROP TABLE dbo.Invalid_Disabled_Jobs_Alert ;

SELECT 
  [InstanceName] + '' '' as Instance
, [JobName] + '' '' as Job
, CONVERT(CHAR(10),[LastChangedDTM],120) + ''  '' as ''Last Changed On   ''
, CONVERT(CHAR(10),[LastCheckedDTM],120) + ''  '' as ''Last Checked On   ''
, CASE [AllowDisabled] WHEN ''Y'' THEN ''Yes'' ELSE ''No'' END as '' Disable is Allowed ?   ''
, CONVERT(CHAR(10),[AllowDisabledSetDTM],120) + ''  '' as ''Date Set to Allow   ''
, [AllowDisabledSetBy] + ''  '' as ''Set to Allowed By   ''
, CASE [Enabled] WHEN 0 THEN ''Yes'' ELSE ''No'' END + ''  '' as ''Job is Currently Disabled ?''
, NULLIF(DisabledNotes, '' '') as ''Notes''

INTO dbo.Invalid_Disabled_Jobs_Alert

FROM [Job_Tracking].[dbo].[Disabled_Job_Tracking_Centralized]

WHERE [AllowDisabled] <> ''N'' 
  AND [JobName] LIKE ''DBA - %'' ;

IF (SELECT COUNT(*) FROM dbo.Invalid_Disabled_Jobs_Alert) > 0

BEGIN

	DECLARE @TABLENAME_INPUT nvarchar(500) = ''Invalid_Disabled_Jobs_Alert'' ;
	DECLARE @TBL_STYLE_INPUT nvarchar(1024) = ''style="font:8pt" class="AltListBorder" cellpadding="2" cellspacing="1"'' ;
	DECLARE @HDR_STYLE_INPUT nvarchar(1024) = ''class="RowHeader"'' ;
	DECLARE @OUTPUT nvarchar(MAX) ;

	EXEC DBA.[dbo].[spCustomTable2HTML]       
      @TABLENAME = @TABLENAME_INPUT  
    , @TBL_STYLE = @TBL_STYLE_INPUT
    , @HDR_STYLE = @HDR_STYLE_INPUT
    , @OUTPUT = @OUTPUT OUTPUT

	DECLARE @subject_value as VARCHAR(300) = ''Audit Report - DBA Maint / Housekeeping Jobs Allowed To Be Disabled -- As Of '' + CONVERT(CHAR(10),CURRENT_TIMESTAMP,120) 
	DECLARE @Rrecipients_value VARCHAR(300) = ''_itdba@viejas.com'';

	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''Alerts'',
    @recipients = @Rrecipients_value,
    @subject = @subject_value,
    @body = @OUTPUT,
    @body_format = ''HTML'',
    @query_no_truncate = 1,
    @attach_query_result_as_file = 0 ;

	DROP TABLE Invalid_Disabled_Jobs_Alert ;
END
ELSE
BEGIN
	SELECT ''No erroneously disabled jobs where found.'' ;
END', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 11AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20240212, 
		@active_end_date=99991231, 
		@active_start_time=110000, 
		@active_end_time=235959, 
		@schedule_uid=N'038739fa-2a24-420d-9226-124b031e06b0'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

