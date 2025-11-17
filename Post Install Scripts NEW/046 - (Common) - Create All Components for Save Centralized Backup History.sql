USE [master]
GO

/****** Object:  LinkedServer [DBAMDB01PR]    Script Date: 1/23/2023 10:22:01 AM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'DBAMDB01PR', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'DBAMDB01PR',@useself=N'False',@locallogin=NULL,@rmtuser=N'DBAdmin',@rmtpassword='$QLisg00d4U!!!'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


--================================================================================
-- Create the temp table used to process the backup history and send it to the 
-- centralized backup history table on DBAMDB01pr
--=================================================================================
USE DBA
GO

IF NOT EXISTS (Select TABLE_NAME From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = 'Backup_History_delta_inserts')
BEGIN
  CREATE TABLE DBA.[dbo].[Backup_History_delta_inserts](
	[InstanceName] [varchar](100) NOT NULL,
	[backup_set_id] [int] NOT NULL,
	[database_name] [varchar](100) NULL,
	[backup_start_DTTM] [datetime] NULL,
	[backup_finish_DTTM] [datetime] NULL,
	[backup_type] [varchar](4) NULL,
	[backup_size] [numeric](20, 0) NULL,
	[backupset_name] [varchar](200) NULL,
  CONSTRAINT [PK_Backup_History] PRIMARY KEY CLUSTERED 
  (
	[InstanceName] ASC,
	[backup_set_id] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
  ) ON [PRIMARY]
END
GO

--================================================================================
-- Create the table to save the MAX backup_start_date for this instnace in the 
-- centralized backup history table DBAMDB01pr. This saved date is used to insure
-- that only new records are processed and thereby reduce the processing over the
-- linked server to DBAMDB01pr.
--================================================================================
USE DBA
GO

IF NOT EXISTS (Select TABLE_NAME From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = 'Backup_History_MAX_backup_start_DTTM')
BEGIN
  CREATE TABLE DBA.[dbo].[Backup_History_MAX_backup_start_DTTM]
  (
  [MAX_backup_start_DTTM] [datetime] NULL
  ) ON [PRIMARY]
END
GO
--================================================================================
-- As this is the initial creation of the table, default the date to 2022-01-01 so 
-- that on the first run all of the backup history available in the msdb database
-- is loaded from its earliest date.
--================================================================================
USE DBA
GO

IF (SELECT MAX(MAX_backup_start_DTTM) FROM DBA.dbo.Backup_History_MAX_backup_start_DTTM) IS NULL
BEGIN 

  TRUNCATE TABLE DBA.dbo.Backup_History_MAX_backup_start_DTTM

  INSERT INTO DBA.dbo.Backup_History_MAX_backup_start_DTTM
  SELECT '2022-01-01' AS MAX_backup_start_DTTM

END
GO

IF (SELECT MAX(MAX_backup_start_DTTM) FROM DBA.dbo.Backup_History_MAX_backup_start_DTTM) < '2022-01-01'
BEGIN 

  TRUNCATE TABLE DBA.dbo.Backup_History_MAX_backup_start_DTTM

  INSERT INTO DBA.dbo.Backup_History_MAX_backup_start_DTTM
  SELECT '2022-01-01' AS MAX_backup_start_DTTM

END
GO

--================================================================================
-- Drop and create the stored proc
--================================================================================
USE DBA
GO  

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'sp_SaveBackupHistoryToDBAMDB01pr' AND ROUTINE_TYPE = 'PROCEDURE')
	DROP PROCEDURE dbo.sp_SaveBackupHistoryToDBAMDB01pr
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.sp_SaveBackupHistoryToDBAMDB01pr
AS
BEGIN
	SET NOCOUNT ON ;
  --=============================================================================
  -- Author:		Steve Paylor
  -- Create date: 2022-12-08
  -- Description:	
  -- Insert new backup history records into the Backup_History
  -- table in the Backup_Tracking DV on DBAMDB01PR
  --==============================================================================
    -------------------------------------------------------------------------------------------------------------------
  -- 1) Using the working table containing only new rows, insert them to the target table on DBAMDB01PR
  -------------------------------------------------------------------------------------------------------------------
  INSERT INTO DBA.dbo.Backup_History_delta_inserts
  SELECT 
    CAST(@@SERVERNAME AS VARCHAR(100)) AS InstanceName
  , backup_set_id
  , database_name
  , backup_start_date AS backup_start_DTTM
  , backup_finish_date as backup_finish_DTTM

  , CASE type 
      WHEN 'D' THEN 'Full' 
      WHEN 'L' THEN 'Log' 
      WHEN 'I' THEN 'Diff'
    END AS backup_type
  
  , backup_size
  , name AS backupset_name

  FROM msdb.dbo.backupset

  WHERE backup_start_date > (SELECT MAX(MAX_backup_start_DTTM) FROM DBA.dbo.Backup_History_MAX_backup_start_DTTM)

  ORDER BY
  backup_start_date ASC ;
  -------------------------------------------------------------------------------------------------------------------
  -- 2) Save the max backup_start_date loaded to drive future processing
  -------------------------------------------------------------------------------------------------------------------
  TRUNCATE TABLE DBA.dbo.Backup_History_MAX_backup_start_DTTM ;

  INSERT INTO DBA.dbo.Backup_History_MAX_backup_start_DTTM
  SELECT MAX(backup_start_DTTM) 
  FROM DBA.dbo.Backup_History_delta_inserts

  --------------------------------------------------------------------------------------------------------------------
  -- 3) Insert new backup history records into the Backup_History table in the Backup_Tracking DB on DBAMDB01PR
  --
  --    Using the working table containing only new rows, insert them to the target table on DBAMDB01PR
  -------------------------------------------------------------------------------------------------------------------
  INSERT INTO DBAMDB01PR.Backup_Tracking.dbo.Backup_History_Centralized
  (
    InstanceName
  , backup_set_id
  , database_name
  , backup_start_DTTM
  , backup_finish_DTTM
  , backup_type
  , backup_size
  , backupset_name
  , Loaded_DTTM
  )
  SELECT
   source.InstanceName
  ,source.backup_set_id
  ,source.database_name
  ,source.backup_start_DTTM
  ,source.backup_finish_DTTM
  ,source.backup_type
  ,source.backup_size
  ,source.backupset_name
  ,CURRENT_TIMESTAMP -- Loaded_DTTM

  FROM DBA.dbo.Backup_History_delta_inserts source 
  
  WHERE (SELECT MAX(backup_set_id) 
        FROM DBAMDB01PR.Backup_Tracking.dbo.Backup_History_Centralized
        WHERE InstanceName = @@SERVERNAME) IS NULL
     OR source.backup_set_id > (
        SELECT MAX(backup_set_id) 
        FROM DBAMDB01PR.Backup_Tracking.dbo.Backup_History_Centralized
        WHERE InstanceName = @@SERVERNAME) ;

-------------------------------------------------------------------------------------------------------------
-- Clear out the working table 
-------------------------------------------------------------------------------------------------------------
  TRUNCATE TABLE DBA.dbo.Backup_History_delta_inserts ;
END
GO

--================================================================================
-- Delete and create the Job
--================================================================================
USE [msdb]
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'DBA - Save_Backup_History_To_DBAMDB01pr')
	EXEC msdb.dbo.sp_delete_job @job_name='DBA - Save_Backup_History_To_DBAMDB01pr', @delete_unused_schedule=1
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
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Save_Backup_History_To_DBAMDB01pr', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run the Stored Proc', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @RC int
EXECUTE @RC = DBA.dbo.sp_SaveBackupHistoryToDBAMDB01pr 
GO', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 12:05AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20221209, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=235959, 
		@schedule_uid=N'a651876c-abb7-411c-9117-d7f8c750f5f0'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

  --------------------------------------------------------------------------------------------------------------------
  -- 5) Run the job
  -------------------------------------------------------------------------------------------------------------------
USE MSDB  
GO  
  
EXEC dbo.sp_start_job N'DBA - Save_Backup_History_To_DBAMDB01pr'  
GO