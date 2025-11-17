USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Test Database Mail and ITAppsDBA Operator')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Test Database Mail and ITAppsDBA Operator', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Test Job Notifications to StevePager Operator')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Test Job Notifications to StevePager Operator', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Test Job Notifications to SteveText Operator')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Test Job Notifications to SteveText Operator', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Test DB Mail - Operators - Notifications')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Test DB Mail - Operators - Notifications', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - Test DB Mail - Operators - Notifications]    Script Date: 11/16/2023 1:18:50 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 11/16/2023 1:18:50 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Test DB Mail - Operators - Notifications', 
		@enabled=0, 
		@notify_level_eventlog=3, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'ITappsDBA', 
		@notify_page_operator_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create Report of Last 10 User Commands - just something to display in the report]    Script Date: 11/16/2023 1:18:50 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Report of Last 10 User Commands - just something to display in the report', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE DBA
GO

IF OBJECT_ID(''DatabaseMailTest'', ''U'') IS NOT NULL 
DROP TABLE DatabaseMailTest;

SELECT TOP 10
  CAST([dbname] as nchar(30)) as [DATABASE]
, CAST([loginname] as nchar(30)) as [LOGIN]
, CAST([hostname] as nchar(24)) as [HOST]
, CONVERT(char(30),logintime,100) as [TIME OF LOGIN]
, CAST([cmd] as nvarchar(128)) as [COMMAND]

INTO DBA.dbo.DatabaseMailTest

FROM DBA.dbo.DBActivity

WHERE hostname NOT IN (''DBAMDB01UT'',''IDERAP01PR'',''IDERAP02PR'',''IDERAP03PR'')
  AND loginname NOT IN (''NT AUTHORITY\SYSTEM'',''NT SERVICE\SQLSERVERAGENT'',''NT SERVICE\MSSQLSERVER'',''initialize'',''VIEJAS\hsimpson'',''VIEJAS\sqlservice1'')
  AND dbname NOT IN (''DBA'',''master'',''msdb'',''tempdb'',''model'')
  AND cmd NOT IN (''DBCC'',''BACKUP'',''RAISERROR'')
  AND [cmd] NOT IN (
 ''AWAITING COMMAND''
,''BACKUP DATABASE''
,''BACKUP LOG''
,''DBCC''    
,''DBCC ALLOC CHECK''
,''DBCC TABLE CHECK''
,''initialize''
,''RESTORE HEADERON''
,''SET COMMAND''    
,''SET OPTION OFF'' 
,''SET OPTION ON''  
,''SET TEXTSIZE''   
,''Unknown Command''
,''UKNOWN TOKEN''
,''USE DATABASE''
) 
ORDER BY
  logintime DESC;

DECLARE @TABLENAME_INPUT nvarchar(500) = ''DatabaseMailTest'' ;
DECLARE @TBL_STYLE_INPUT nvarchar(1024) = ''style="font:8pt" class="AltListBorder" cellpadding="2" cellspacing="1"'' ;
DECLARE @HDR_STYLE_INPUT nvarchar(1024) = ''class="RowHeader"'' ;
DECLARE @OUTPUT nvarchar(MAX) ;

EXEC DBA.[dbo].[spCustomTable2HTML]       
          @TABLENAME = @TABLENAME_INPUT  
        , @TBL_STYLE = @TBL_STYLE_INPUT
        , @HDR_STYLE = @HDR_STYLE_INPUT
        , @OUTPUT = @OUTPUT OUTPUT

DECLARE @subject_value as VARCHAR(300) = ''TEST ALERT - 10 Most Recent Database Connections Report for '' + CONVERT(VARCHAR(10),DATEADD(D,-1,CURRENT_TIMESTAMP),101) + ''  --  '' + @@SERVERNAME;
DECLARE @Rrecipients_value VARCHAR(300) = ''spaylor@viejas.com'';

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''Alerts'',
    @recipients = @Rrecipients_value,
    @subject = @subject_value,
    @body = @OUTPUT,
    @body_format = ''HTML'',
    @query_no_truncate = 1,
    @attach_query_result_as_file = 0;

DROP TABLE DatabaseMailTest;', 
		@database_name=N'master', 
		@flags=12
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


