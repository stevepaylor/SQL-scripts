USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on  S-Drive or T-Drvie Less Than 10% Free')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on  S-Drive or T-Drvie Less Than 10% Free', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Critical Drive Free Space')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Critical Drive Free Space', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on F-Drvie Less Than 10% Free')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on F-Drvie Less Than 10% Free', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on L-Drvie Less Than 10% Free')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on L-Drvie Less Than 10% Free', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on T-Drvie Less Than 10% Free')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on T-Drvie Less Than 10% Free', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on L-Drive or T-Drvie Less Than 10% Free')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on L-Drive or T-Drvie Less Than 10% Free', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Critical Drive Less Than 10% Free')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Critical Drive Less Than 10% Free', @delete_unused_schedule=1
GO


IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space - NEW')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space - NEW', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space v2')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space V2', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space v2 (PROD)')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space V2 (PROD)', @delete_unused_schedule=1
GO


IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space v2 (Non-PROD)')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space V2 (Non-PROD)', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Alert on Low Disk Space v2')
EXEC msdb.dbo.sp_delete_job @job_name=N'Alert on Low Disk Space V2', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space v3')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space V3', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space v3 (PROD)')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space V3 (PROD)', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Alert on Low Disk Space v3 (Non-PROD)')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Alert on Low Disk Space V3 (Non-PROD)', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - Alert on Low Disk Space v3 (Non-PROD)]    Script Date: 10/6/2025 3:09:23 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Viejas DB Maintenance]    Script Date: 10/6/2025 3:09:23 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Viejas DB Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Viejas DB Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Alert on Low Disk Space v3 (Non-PROD)', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'This job will send a text message and Email when any drive on the server is 10% or less free.  It will send out just an Email when any drive is 20% or less free.                                                                                                                                                                              10/6/2025 - spaylor - added code to restrict alerts to disk less than 50GB free regardless of PCT free.', 
		@category_name=N'Viejas DB Maintenance', 
		@owner_login_name=N'DBAdmin', 
		@notify_page_operator_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Check Space and Send Alerts]    Script Date: 10/6/2025 3:09:23 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check Space and Send Alerts', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--------------------------------------------------------------------------------------------------------------
-- Step 1 - If the DBA.dbo.Disk_Space_Alerts_Control does not exist, create it.  The logic below will do the 
-- initial load
--------------------------------------------------------------------------------------------------------------

USE DBA ;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''dbo.Disk_Space_Alerts_Control'') AND type in (N''U''))

BEGIN
	SET QUOTED_IDENTIFIER ON ;
	
	CREATE TABLE dbo.Disk_Space_Alerts_Control(
	DriveLetter char(1) NOT NULL,
	Prod_or_QA char(1) NOT NULL,
	ActiveAlert_DTTM datetime NULL,
	CONSTRAINT PK_Disk_Space_Alerts_Control PRIMARY KEY CLUSTERED 
	(
		DriveLetter ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] ;

END
GO

-- ***********************************************************************************************************
-- If the job fails because the SERVICE BROKER is not enabled.  Then this will need to be run on the instance
-- only once to turn it on.  But, first all processes using the msdb have to be killed.
-- ***********************************************************************************************************
-- USE master ;
-- GO
--ALTER DATABASE msdb SET ENABLE_BROKER ;
--GO

USE msdb ; 
GO

DECLARE @xp_cmdshell_enabled_initially INT ;

SET @xp_cmdshell_enabled_initially = 
(SELECT CONVERT(INT, ISNULL(value, value_in_use)) AS config_value
FROM  sys.configurations
WHERE  name = ''xp_cmdshell'') ;

PRINT ''xp_cmdshell found ENABLED initially before running job? '' + 
CASE @xp_cmdshell_enabled_initially 
	WHEN 1 THEN ''YES''
	ELSE ''NO''
END ;

---------------------------------------------------------------------------------------------
-- Enable xp_cmdshell 
---------------------------------------------------------------------------------------------
EXEC sp_configure ''show advanced options'', 1 ;
RECONFIGURE ;
EXEC sp_configure ''xp_cmdshell'', 1 ;
RECONFIGURE ;

---------------------------------------------------------------------------------------------
-- load temp table with drive stats
---------------------------------------------------------------------------------------------
IF object_id(''tempdb..#drive_stats'',''U'') IS NOT NULL
DROP TABLE #drive_stats ;

DECLARE @svrName VARCHAR(255) ;
DECLARE @sql VARCHAR(1000) ;
DECLARE @output TABLE (line VARCHAR(255)) ;

--by default it will take the current server name, we can the SET the server name as well

SET @svrName = @@SERVERNAME ;
IF CHARINDEX (''\'', @svrName) > 0
	SET @svrName = SUBSTRING(@svrName, 1, CHARINDEX(''\'',@svrName)-1) ;

SET @sql =  
  ''powershell.exe -c "Get-WmiObject -ComputerName '' 
+ QUOTENAME(@svrName,'''''''') 
+ '' -Class Win32_Volume -Filter ''''DriveType = 3'''' | SELECT name,capacity,freespace | foreach{$_.name+''''|''''+$_.capacity/1048576+''''%''''+$_.freespace/1048576+''''*''''}"'' ;

--INSERTing disk name, total space and free space value in to temporary table

INSERT @output
EXEC xp_cmdshell @sql ;

--script to retrieve the values in MB FROM PS Script output

SELECT 
  RTRIM(LTRIM(SUBSTRING(line,1,CHARINDEX(''|'',line) -1))) AS Drive_Name
, ROUND(CAST(RTRIM(LTRIM(SUBSTRING(line,CHARINDEX(''|'',line)+1,(CHARINDEX(''%'',line) -1)-CHARINDEX(''|'',line)) )) AS FLOAT),0) AS ''Capacity_MB''
, ROUND(CAST(RTRIM(LTRIM(SUBSTRING(line,CHARINDEX(''%'',line)+1,(CHARINDEX(''*'',line) -1)-CHARINDEX(''%'',line)) )) AS FLOAT),0) AS ''FreeSpace_MB''
, CAST(((ROUND(CAST(RTRIM(LTRIM(SUBSTRING(line,CHARINDEX(''%'',line)+1,(CHARINDEX(''*'',line) -1)-CHARINDEX(''%'',line)) )) AS FLOAT),0)))*100/(ROUND(CAST(RTRIM(LTRIM(SUBSTRING(line,CHARINDEX(''|'',line)+1,(CHARINDEX(''%'',line) -1)-CHARINDEX(''|'',line)) )) AS FLOAT),0)) AS INT) AS ''Pct_Free''
      
INTO #drive_stats

FROM @output
WHERE line LIKE ''[A-Z][:]%''
ORDER BY Drive_Name ;

--SELECT *
--FROM #drive_stats ;

-----------------------------------------------------------------------------------------------
-- Disable xp_cmdshell - if xp_cmdshell was enabled before the job ran, then we have to assume
-- that an application or other process requires it to be on and not turn it off.  Only turn it
-- off if was off beforehand. 
---------------------------------------------------------------------------------------------
IF @xp_cmdshell_enabled_initially = 0
BEGIN
	EXEC master.dbo.sp_configure ''show advanced options'', 1
	RECONFIGURE WITH OVERRIDE
	
	EXEC master.dbo.sp_configure ''xp_cmdshell'', 0
	RECONFIGURE WITH OVERRIDE
	
	EXEC master.dbo.sp_configure ''show advanced options'', 0
	RECONFIGURE WITH OVERRIDE
END
GO
-----------------------------------------------------------------------------------------------------------------------
-- Maintenance step...
-- Insure there is a row in the Disk_Space_Alerts_Control table for every disk on the server.  If missing, insert it.
-- This handles new drives being added to the server. 
-----------------------------------------------------------------------------------------------------------------------
DECLARE @P_OR_Q CHAR(1) ;

SET @P_OR_Q = (
SELECT 
CASE SUBSTRING(@@SERVERNAME,LEN(@@SERVERNAME) -1, 2) 
  WHEN ''QA'' THEN ''Q'' ELSE ''P''
END) ;

INSERT INTO DBA.dbo.Disk_Space_Alerts_Control
SELECT 
   SUBSTRING(Drive_Name,1,1)  as DriveLetter -- DriveLetter
 , CASE 
	  WHEN (SELECT MAX(Prod_or_QA) FROM DBA.dbo.Disk_Space_Alerts_Control) IS NULL THEN  @P_OR_Q -- Ignore if there is already a value otherwise set to P or Q
	  ELSE (SELECT MAX(Prod_or_QA) FROM DBA.dbo.Disk_Space_Alerts_Control) -- set to existing value from other rows
	END
	as Prod_or_QA -- should be same for every row -- Prod_or_QA
 , NULL as ActiveAlert_DTTM
FROM #drive_stats
WHERE SUBSTRING(Drive_Name,1,1) NOT IN (SELECT DriveLetter FROM DBA.dbo.Disk_Space_Alerts_Control) ;
 
GO

---------------------------------------------------------------------------------------------
-- load control table into in table var
---------------------------------------------------------------------------------------------

DECLARE @TV_Disk_Space_Alerts_Control TABLE
(
  TV_Drive CHAR(1) 
, TV_Prod_or_QA CHAR(1)
, TV_ActiveAlert_DTTM DATETIME
) ;

INSERT INTO @TV_Disk_Space_Alerts_Control
SELECT
  SUBSTRING(DriveLetter,1,1) --TV_Drive
, Prod_or_QA -- TV_Prod_or_QA -- Value should be the same for all rows
, ActiveAlert_DTTM -- TV_ActiveAlert_DTTM

FROM DBA.dbo.Disk_Space_Alerts_Control ;

-----------------------------------------------------------------------------------------------
-- Process the temp table and send alert for each disk below the threshold
---------------------------------------------------------------------------------------------

DECLARE @TV_Drive_Stats TABLE
(
  TV_Number INT IDENTITY(1,1) --Auto incrementing Identity column
, TV_DriveLetter CHAR(1)
, TV_Capacity_MB INT
, TV_FreeSpace_MB INT
, TV_Pct_Free CHAR(2)
, TV_Recommended_Space_to_Add_GB INT
) ;

INSERT INTO @TV_Drive_Stats 
SELECT
 SUBSTRING(Drive_Name,1,1) -- TV_DriveLetter
,Capacity_MB -- TV_Capacity_MB
,FreeSpace_MB -- TV_FreeSpace_MB
,Pct_Free -- TV_Pct_Free

,CASE 
   WHEN Capacity_MB >= 1000000 THEN 100
   WHEN (Capacity_MB < 1000000 and Capacity_MB > 200000) THEN 50
   WHEN (Capacity_MB <= 200000 and Capacity_MB > 100000) THEN 20 
   ELSE (Capacity_MB / 1000)
 END 
 AS Recommended_Space_to_Add_GB

FROM #drive_stats ;

--Create and initialize the looper variable variables
DECLARE @N INT = 1 ; -- to remember the position in the outer loop 
DECLARE @Count INT ; -- to remember the number of rows in the table var used in the outer loop

-- Create vars that will be used to build the mail message for each disk
DECLARE @msg_SubjectLine VARCHAR(500) ;
DECLARE @msg_Body VARCHAR(2000) ;
DECLARE @msg_DriveLetter CHAR(1) ;
DECLARE @msg_Pct_Free VARCHAR(2) ;
DECLARE @msg_GB_Free VARCHAR(4) ;
DECLARE @msg_Recommended_Space_to_Add_GB VARCHAR(3) ;

--Determine the number of rows in the Table
SET @Count= (SELECT COUNT(*) FROM  @TV_Drive_Stats) ;

--Loop through until all row processing is done
WHILE @N <= @Count
BEGIN
    SET @msg_DriveLetter = (SELECT TV_DriveLetter FROM @TV_Drive_Stats WHERE TV_Number = @N) ;
	SET @msg_Pct_Free = (SELECT CAST(TV_Pct_Free AS VARCHAR(2)) FROM @TV_Drive_Stats WHERE TV_Number = @N) ;
	SET @msg_GB_Free = (SELECT CAST(TV_FreeSpace_MB / 1000 AS VARCHAR(4)) FROM @TV_Drive_Stats WHERE TV_Number = @N) ;
	SET @msg_Recommended_Space_to_Add_GB = (SELECT CAST(TV_Recommended_Space_to_Add_GB AS VARCHAR(3)) FROM @TV_Drive_Stats WHERE TV_Number = @N) ;

	----------------------------------------------------------------------------------------------------------------
	-- Send text alert for space under 10% free and server is PROD and is the first alert for the given condition
	-- Also adds SE''s and support@viejas.com to create a ticket
	----------------------------------------------------------------------------------------------------------------
	IF (SELECT TV_Pct_Free FROM @TV_Drive_Stats WHERE TV_Number = @N) <= 10 -- DISK SPACE UNDER 10% CONDITION
	AND (SELECT MAX(TV_Prod_or_QA) FROM @TV_Disk_Space_Alerts_Control) <> ''P'' -- IS NOT PROD CONDITION
	AND (SELECT TV_FreeSpace_MB FROM @TV_Drive_Stats WHERE TV_Number = @N) < 50000 -- DISK SPACE UNDER 50GB

	BEGIN

		-- If above conditions are met, then add a check that it is the first time the condition occurred (That is, check if the ActiveAlert_DTTM has
		-- not yet been set) then send the Email including _IT_SE and SUPPORT (to create a ticket)

		--IF (SELECT TV_ActiveAlert_DTTM FROM @TV_Disk_Space_Alerts_Control WHERE TV_Drive = @msg_DriveLetter) IS NULL  -- FIRST ONLY ALERT CONDITION

		--BEGIN
		
		--	SET @msg_SubjectLine = ''!!! URGENT !!! -- '' + @@SERVERNAME + '' '' + @msg_DriveLetter +''-Drive Is Critically Full - Freespace is '' + @msg_Pct_Free + ''% - '' +
		--	@msg_GB_Free + ''GB FREE'';

		--	SET @msg_Body = ''!!! URGENT !!! -- Please add '' 
		--	                + @msg_Recommended_Space_to_Add_GB 
		--					+ ''GB to the ''
		--					+ @msg_DriveLetter 
		--					+ ''-Drive on ''
		--					+ @@SERVERNAME ;

		--	EXEC msdb.dbo.sp_send_dbmail
		--	 @profile_name = ''Alerts''
		--	, @recipients = ''_itdba@viejas.com;8583540983@vtext.com;steve@lpaylor.com;_IT_SE@viejas.com;support@viejas.com''
		--	--, @recipients = ''spaylor@viejas.com''
		--	, @subject = @msg_SubjectLine
		--	, @body = @msg_Body ;

		--END

		-- Regardless whether or not it was the first alert and the Email was sent, update the ActiveAlert_DTTM -- this will have the affect of recording the
		-- last time the condition happened each time it happens
	
		UPDATE DBA.dbo.Disk_Space_Alerts_Control
		SET ActiveAlert_DTTM = GETDATE()
		WHERE DriveLetter =  @msg_DriveLetter ;

	END
	ELSE -- IF any of the conditions were not met for an alert to be sent, then reset the ActiveAlert_DTTM to NULL
	BEGIN 

		UPDATE DBA.dbo.Disk_Space_Alerts_Control
		SET ActiveAlert_DTTM = NULL
		WHERE DriveLetter =  @msg_DriveLetter ;	

	
	END

	-- Send Email alert for space under 10% free - to Apps team olnly and regardless of if the above alert was triggered

	IF (SELECT TV_Pct_Free FROM @TV_Drive_Stats WHERE TV_Number = @N) < 10
	AND (SELECT TV_FreeSpace_MB FROM @TV_Drive_Stats WHERE TV_Number = @N) < 50000 -- DISK SPACE UNDER 50GB

	BEGIN
		SET @msg_SubjectLine = @@SERVERNAME + '' (QA) '' + @msg_DriveLetter +''-Drive Is Under 10% Free -- Freespace is '' + @msg_Pct_Free + ''% - '' + @msg_GB_Free + ''GB FREE'';

		EXEC msdb.dbo.sp_send_dbmail
		  @profile_name = ''Alerts''
		--, @recipients = ''spaylor@viejas.com;''
		--, @recipients = ''_itdba@viejas.com;_IT_SE@viejas.com''
		, @recipients = ''_itdba@viejas.com;Steve@lpaylor.com;_IT_SE@viejas.com;support@viejas.com''
		, @subject = @msg_SubjectLine
		, @body = @msg_SubjectLine ;

	END
	SET @N = @N + 1 ; 
END
GO

', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 30 minutes', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20230111, 
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


