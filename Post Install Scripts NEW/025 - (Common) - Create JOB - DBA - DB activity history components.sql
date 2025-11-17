-- If the job already exists, drop it 
USE msdb
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Record DB Connections')
EXEC msdb.dbo.sp_delete_job @job_name = N'DBA - Record DB Connections', @delete_unused_schedule=1
GO

-- If the DBActivity_SAVED table does not exist, create it
IF NOT EXISTS (SELECT * FROM DBA.sys.objects WHERE object_id = OBJECT_ID(N'DBA..DBActivity_SAVED') AND type in (N'U'))
BEGIN
  CREATE TABLE DBA..DBActivity_SAVED(
    dbname VARCHAR(128) NOT NULL
  , loginname VARCHAR(128) NOT NULL
  , hostname VARCHAR(128) NOT NULL
  , cmd VARCHAR(128) NOT NULL
  , logintime DATETIME NOT NULL,
    CONSTRAINT PK_DBActivety_SAVED PRIMARY KEY CLUSTERED 
    (
  	dbname ASC,
  	loginname ASC,
	hostname ASC,
	cmd ASC,
	logintime ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
END
--ELSE
--BEGIN
--	TRUNCATE TABLE DBA..DBActivity_SAVED
--END
GO

-- Check if DBActivty table already exists, save contents to a work table (DBActivity_SAVED) then DROP it
IF EXISTS (SELECT * FROM DBA.sys.objects WHERE object_id = OBJECT_ID(N'DBA..DBActivity') AND type in (N'U'))
BEGIN
  INSERT INTO DBA..DBActivity_SAVED
  SELECT DISTINCT
	RTRIM(CAST(exist.dbname AS VARCHAR(128))) AS dbname
  , RTRIM(CAST(exist.loginname AS VARCHAR(128))) AS loginname
  , RTRIM(CAST(exist.hostname AS VARCHAR(128))) AS hostname
  , cmd = 
    CASE
      WHEN exist.hostname = 'initialize' THEN CAST('initialize' AS VARCHAR(128)) 
      ELSE CAST('Unknown Command' AS VARCHAR(128))
    END
  , exist.logintime
  FROM DBA..DBActivity exist
  LEFT OUTER JOIN DBA..DBActivity_SAVED saved
  ON  exist.dbname = saved.dbname
  AND exist.loginname = saved.loginname
  AND exist.hostname = saved.hostname
  --AND exist.cmd = saved.cmd
  AND exist.logintime = saved.logintime
  WHERE exist.dbname IS NOT NULL
    AND exist.dbname <> ' '
    AND exist.loginname IS NOT NULL 
    AND exist.loginname <> ' '
    AND exist.hostname IS NOT NULL 
    AND exist.hostname <> ' '
	--AND exist.cmd IS NOT NULL 
    --AND exist.cmd <> ' '
	AND saved.logintime IS NULL  -- only insert rows that don't previously exist in SAVED table in case there was an existing SAVED table 

  DROP TABLE DBA..DBActivity;
END
GO

-- Create or re-create the DBActivity table with the new schema
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE DBA..DBActivity(
  dbname VARCHAR(128) NOT NULL
, loginname VARCHAR(128) NOT NULL
, hostname VARCHAR(128) NOT NULL
, cmd VARCHAR(128) NOT NULL CONSTRAINT cmd_default DEFAULT 'Unknown Command'
, logintime DATETIME NOT NULL,
  CONSTRAINT PK_DBActivety PRIMARY KEY CLUSTERED 
  (
	dbname ASC,
	loginname ASC,
	hostname ASC,
	cmd ASC,
	logintime ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
  ) ON [PRIMARY]
GO

-- Initialize the table IF there was an old version of the table saved to DBActivity_SAVED, then reload from it
-- OTHERWISE set it to the intial values
IF EXISTS (SELECT * FROM DBA.sys.objects WHERE object_id = OBJECT_ID(N'DBA..DBActivity_SAVED') AND type in (N'U'))
AND EXISTS (SELECT * FROM DBA..DBActivity_SAVED)
BEGIN
  INSERT INTO DBA..DBActivity
  SELECT 
    saved.dbname
  , saved.loginname
  , saved.hostname
  , saved.cmd
  , MAX(saved.logintime)
  FROM DBA..DBActivity_SAVED saved
  LEFT OUTER JOIN DBA..DBActivity exist
  ON  saved.dbname = exist.dbname
  AND saved.loginname = exist.loginname
  AND saved.hostname = exist.hostname
  --AND saved.cmd = exist.cmd
  AND saved.logintime = exist.logintime
  WHERE exist.logintime IS NULL -- To prevent trying to insert duplicate rows
  GROUP BY
    saved.dbname
  , saved.loginname
  , saved.hostname
  , saved.cmd
  ORDER BY
    saved.dbname
  , saved.loginname
  , saved.hostname
  , saved.cmd;
END
ELSE
BEGIN
  INSERT INTO DBA..DBActivity
  (
    dbname
  , loginname
  , hostname
  , cmd
  , logintime
  )
  SELECT 
	cast([NAME] AS VARCHAR(128)) -- dbname
  , cast('initialize' AS VARCHAR(128)) -- loginname
  , cast('initialize' AS VARCHAR(128)) -- hostname
  , cast('initialize' AS VARCHAR(128)) -- cmd
  , CURRENT_TIMESTAMP -- logintime
    FROM sys.databases
END
GO

PRINT 'Creation or Re-creation of DBActivity table completed.'

USE DBA
GO

IF EXISTS (SELECT * FROM DBA.sys.objects WHERE object_id = OBJECT_ID(N'DBA..GetDBconnections') AND type in (N'P', N'PC'))
DROP PROCEDURE GetDBconnections;
GO

CREATE PROCEDURE GetDBconnections
AS

-- DECLARE 2 working table variables 

DECLARE @TV_DBActivity TABLE
(
  TV_dbname VARCHAR(128) NULL
 ,TV_sysdbname VARCHAR(128) NOT NULL
 ,TV_loginname VARCHAR(128) NOT NULL
 ,TV_hostname VARCHAR(128) NOT NULL
 ,TV_cmd VARCHAR(128) NOT NULL
 ,TV_logintime DATETIME NOT NULL
);

DECLARE @TV_DBActivity2 TABLE
(
  TV_dbname2 VARCHAR(128) NOT NULL
 ,TV_loginname2 VARCHAR(128) NOT NULL
 ,TV_hostname2 VARCHAR(128) NOT NULL
 ,TV_cmd2 VARCHAR(128) NOT NULL
 ,TV_logintime2 DATETIME NOT NULL
);

INSERT INTO @TV_DBActivity
(
 TV_dbname
,TV_sysdbname
,TV_loginname
,TV_hostname
,TV_cmd
,TV_logintime
)
SELECT distinct
 A.dbname
,sysdbname = CASE WHEN db_name(S.dbid) IS NULL THEN 'Unknown' ELSE db_name(S.dbid) END
--,db_name(S.dbid) as sysdbname
,S.loginame
,S.hostname
,S.cmd 
,S.login_time
FROM master..sysprocesses S
LEFT OUTER JOIN DBA..DBActivity A
ON  db_name(S.dbid) = A.dbname
AND S.loginame = A.loginname 
AND S.hostname = A.hostname
AND S.login_time = A.logintime
WHERE S.dbid IS NOT NULL
  AND S.loginame IS NOT NULL
  AND S.login_time IS NOT NULL
  AND S.hostname IS NOT NULL
  AND A.dbname IS NULL; --insures that we only select rows that don't already exist in the DBActivy table

-- insert the rows in the temptable variable into the physical table - using the TV_sysdbname as the dbname

INSERT INTO DBA..DBActivity
(
 dbname
,loginname
,hostname
,cmd
,logintime
)
SELECT 
 TV_sysdbname 
,TV_loginname 
,TV_hostname
,TV_cmd
,TV_logintime
FROM @TV_DBActivity;

--*************************************************
-- clear out all but the most recent connection for each dbname, loginname and hostname
-- to keep the table from growing too large with unneeded interim data - last login is all that is
-- needed
--*************************************************

INSERT INTO @TV_DBActivity2
(
 TV_dbname2
,TV_loginname2
,TV_hostname2
,TV_cmd2
,TV_logintime2
)
SELECT
 dbname
,loginname
,hostname
,cmd
,MAX(logintime)as logintime
FROM DBA..DBActivity
group by
 dbname
,loginname
,hostname
,cmd
order by
 dbname
,loginname
,hostname
,cmd;

--*************************************************
-- clear out the DBActivity table too reload with only most current data
--*************************************************
TRUNCATE TABLE DBA..DBActivity;

--*************************************************
-- reload the DBActivity table with most recent data only
--*************************************************
INSERT INTO DBA..DBActivity
(
 dbname
,loginname
,hostname
,cmd
,logintime
)
SELECT 
 TV_dbname2 
,TV_loginname2 
,TV_hostname2
,CASE
	WHEN TV_cmd2 IS NULL THEN 'Unknown Command'
	WHEN TV_cmd2 = ' ' THEN 'Unknown Command'
	ELSE TV_cmd2
 END
,TV_logintime2
FROM @TV_DBActivity2
WHERE TV_hostname2 IS NOT NULL
  AND TV_hostname2 <> ' ' 
  AND TV_loginname2 IS NOT NULL
  AND TV_loginname2 <> ' ' 
  AND TV_dbname2 IS NOT NULL
  AND TV_dbname2 <> ' ' ;
GO

PRINT 'Creation or replacement of GetDBconnections stored proc completed.'
GO

-- create the job
USE msdb
GO

--IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Record DB Connections')
--EXEC msdb.dbo.sp_delete_job @job_name = N'DBA - Record DB Connections', @delete_unused_schedule=1
--GO

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Record DB Connections', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]',
		@notify_email_operator_name=N'ITappsDBA', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Get and store DB connections', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec GetDBconnections;', 
		@database_name=N'DBA', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 30 seconds', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=2, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120214, 
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

PRINT 'Creation or replacement of DBA - Record DB Connections job completed.'
GO

PRINT 'Script completed.'
GO
