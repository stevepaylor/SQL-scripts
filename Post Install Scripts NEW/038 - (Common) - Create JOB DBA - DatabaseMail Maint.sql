USE [msdb]
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'DBA - DatabaseMail Maint')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - DatabaseMail Maint', @delete_unused_schedule=1
GO

USE [DBA]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM DBA.sys.objects WHERE object_id = OBJECT_ID(N'DBA.dbo.sysmail_log_ARCHIVE') AND type in (N'U'))
BEGIN
  DROP TABLE DBA.dbo.sysmail_log_ARCHIVE;
END
GO

CREATE TABLE [dbo].[sysmail_log_ARCHIVE](
	[log_id] [int] NOT NULL,
	[event_type] [int] NOT NULL,
	[log_date] [datetime] NOT NULL,
	[description] [nvarchar](max) NULL,
	[process_id] [int] NULL,
	[mailitem_id] [int] NULL,
	[account_id] [int] NULL,
	[last_mod_date] [datetime] NOT NULL,
	[last_mod_user] [sysname] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBA.sys.objects WHERE object_id = OBJECT_ID(N'DBA.dbo.sysmail_mailitems_ARCHIVE') AND type in (N'U'))
BEGIN
  DROP TABLE DBA.dbo.sysmail_mailitems_ARCHIVE;
END
GO

CREATE TABLE [dbo].[sysmail_mailitems_ARCHIVE](
	[mailitem_id] [int] NOT NULL,
	[profile_id] [int] NOT NULL,
	[recipients] [varchar](max) NULL,
	[copy_recipients] [varchar](max) NULL,
	[blind_copy_recipients] [varchar](max) NULL,
	[subject] [nvarchar](255) NULL,
	[from_address] [varchar](max) NULL,
	[reply_to] [varchar](max) NULL,
	[body] [nvarchar](max) NULL,
	[body_format] [varchar](20) NULL,
	[importance] [varchar](6) NULL,
	[sensitivity] [varchar](12) NULL,
	[file_attachments] [nvarchar](max) NULL,
	[attachment_encoding] [varchar](20) NULL,
	[query] [nvarchar](max) NULL,
	[execute_query_database] [sysname] NULL,
	[attach_query_result_as_file] [bit] NULL,
	[query_result_header] [bit] NULL,
	[query_result_width] [int] NULL,
	[query_result_separator] [char](1) NULL,
	[exclude_query_output] [bit] NULL,
	[append_query_error] [bit] NULL,
	[send_request_date] [datetime] NOT NULL,
	[send_request_user] [sysname] NOT NULL,
	[sent_account_id] [int] NULL,
	[sent_status] [tinyint] NULL,
	[sent_date] [datetime] NULL,
	[last_mod_date] [datetime] NOT NULL,
	[last_mod_user] [sysname] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


USE [msdb]
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
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - DatabaseMail Maint', 
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
/****** Object:  Step [Archive sysmail_log before purge]    Script Date: 1/6/2019 12:48:58 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Archive sysmail_log before purge', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'INSERT INTO DBA.dbo.sysmail_log_ARCHIVE
SELECT *
FROM MSDB.dbo.sysmail_log
WHERE log_date < DATEADD(DAY,-1,CURRENT_TIMESTAMP)
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Purge sysmail_log]    Script Date: 1/6/2019 12:48:58 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Purge sysmail_log', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @DeleteBeforeDate DateTime 
SELECT @DeleteBeforeDate = DATEADD(d,-1, GETDATE())
EXEC sysmail_delete_log_sp @logged_before = @DeleteBeforeDate', 
		@database_name=N'msdb', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Archive sysmail_mailitems  before purge]    Script Date: 1/6/2019 12:48:58 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Archive sysmail_mailitems  before purge', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'INSERT INTO DBA.dbo.sysmail_mailitems_ARCHIVE
SELECT *
FROM MSDB.dbo.sysmail_mailitems
WHERE send_request_date < DATEADD(DAY,-1,CURRENT_TIMESTAMP)
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Purge sysmail_mailitems]    Script Date: 1/6/2019 12:48:58 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Purge sysmail_mailitems', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL',
		@command=N'DECLARE @DeleteBeforeDate DateTime ; 

SELECT @DeleteBeforeDate = DATEADD(d,-1, GETDATE()) ;
 
EXEC sysmail_delete_mailitems_sp @sent_before = @DeleteBeforeDate', 
		@database_name=N'msdb', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 7AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190106, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
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


