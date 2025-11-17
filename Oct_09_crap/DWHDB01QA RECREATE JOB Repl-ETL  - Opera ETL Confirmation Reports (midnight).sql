USE [msdb]
GO

/****** Object:  Job [Repl-ETL  - Opera ETL Confirmation Reports (midnight)]    Script Date: 10/9/2025 4:16:16 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Uncategorized (Local)]    Script Date: 10/9/2025 4:16:16 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Uncategorized (Local)' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Uncategorized (Local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Repl-ETL  - Opera ETL Confirmation Reports (midnight)', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Uncategorized (Local)', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'DWH_Alerts', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Opera NAME_RESERVATION Daily Load Count -- Summed by Room Class]    Script Date: 10/9/2025 4:16:16 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Opera NAME_RESERVATION Daily Load Count -- Summed by Room Class', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=5, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

DECLARE @query_value AS VARCHAR(1000);

--DECLARE @recipients_value VARCHAR(200) = ''carl@readywillingnabel.com;spaylor@VIEJAS.com;_itdba@VIEJAS.com'' ;

DECLARE @recipients_value VARCHAR(200) = ''spaylor@VIEJAS.com'' ;

DECLARE @subject_value AS VARCHAR(200);
SET @subject_value = ''Opera NAME_RESERVATION Daily Load Count -- Summed by Room Class -- Confirmation for DWHDB01QA --- '' + CONVERT(CHAR(10),CURRENT_TIMESTAMP,120) 

SET @query_value =
''SELECT *
FROM (
   SELECT 
     CONVERT(CHAR(10),ETL_LAST_UPDATE_DATE,120) AS RESV_INSERTED_DATE
   , ROOM_CLASS
   , CASE
       WHEN INSERT_DATE = UPDATE_DATE THEN 1 ELSE 0
     END AS NEW_REC
   FROM [iQ-Gaming].Opera_5_0.NAME_RESERVATION
) as s
PIVOT
(
  SUM(NEW_REC)
    FOR ROOM_CLASS IN (PSEUDO, STAND, VCR, WHS)
)AS pvt
ORDER BY RESV_INSERTED_DATE DESC''

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = alerts,
    @recipients = ''spaylor@viejas.com'',
    @subject = @subject_value,
    @query = @query_value,
    @attach_query_result_as_file = 1;', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Opera NAME_RESERVATION Daily Load Count -- Adds and Updates]    Script Date: 10/9/2025 4:16:16 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Opera NAME_RESERVATION Daily Load Count -- Adds and Updates', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=5, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

DECLARE @subject_value as VARCHAR(200) = ''Opera NAME_RESERVATION Daily Load Count -- Adds and Updates -- Confirmation DWHDB01QA --- '' + CONVERT(CHAR(10),CURRENT_TIMESTAMP,120);

--DECLARE @recipients_value VARCHAR(200) = ''spaylor@VIEJAS.com;_itdba@VIEJAS.com'';

DECLARE @recipients_value VARCHAR(200) = ''spaylor@VIEJAS.com'';

DECLARE @query_value VARCHAR(1000) =
N''SELECT 
  CONVERT(CHAR(10),ETL_LAST_UPDATE_DATE,120) AS ''''Load Date''''
, CASE
	WHEN ETL_INSERT_DATE = ETL_LAST_UPDATE_DATE AND INSERT_DATE = UPDATE_DATE
	THEN ''''Add'''' 
	ELSE ''''Update'''' 
  END AS ''''Add or Update''''
, COUNT(*) AS ''''Record Count''''

FROM [iQ-Gaming].Opera_5_0.NAME_RESERVATION

GROUP BY
  CONVERT(CHAR(10),ETL_LAST_UPDATE_DATE,120) 
, CASE
	WHEN ETL_INSERT_DATE = ETL_LAST_UPDATE_DATE AND INSERT_DATE = UPDATE_DATE
	THEN ''''Add'''' 
	ELSE ''''Update'''' 
  END 

ORDER BY
  CONVERT(CHAR(10),ETL_LAST_UPDATE_DATE,120) DESC
, CASE
	WHEN ETL_INSERT_DATE = ETL_LAST_UPDATE_DATE AND INSERT_DATE = UPDATE_DATE
	THEN ''''Add'''' 
	ELSE ''''Update'''' 
  END ;''

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''alerts'',
    @recipients = @recipients_value,
    @subject = @subject_value,
    @query = @query_value,
    @attach_query_result_as_file = 1;', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Opera NAME_RESERVATION Daily Load Count  -- Key Dates per  Batch]    Script Date: 10/9/2025 4:16:16 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Opera NAME_RESERVATION Daily Load Count  -- Key Dates per  Batch', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=5, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

TRUNCATE TABLE [iQ-Gaming].Opera_5_0.NAME_RESERVATION_ETL_HISTORY_BATCH_COUNT
GO

INSERT INTO [iQ-Gaming].Opera_5_0.NAME_RESERVATION_ETL_HISTORY_BATCH_COUNT
SELECT 
  BATCH_COMPLETION
, ROWS

FROM [iQ-Gaming].Opera_5_0.NAME_RESERVATION_ETL_HISTORY

ORDER BY BATCH_COMPLETION DESC
GO



DECLARE @subject_value as VARCHAR(200) = ''Opera NAME_RESERVATION Daily Load Count  -- Key Dates per  Batch  -- Confirmation for DWHDB01QA ---  '' + CONVERT(CHAR(10),CURRENT_TIMESTAMP,120);


--DECLARE @recipients_value VARCHAR(200) = ''carl@readywillingnabel.com;spaylor@VIEJAS.com;_itdba@VIEJAS.com'' ;

DECLARE @recipients_value VARCHAR(200) = ''spaylor@VIEJAS.com'' ;

DECLARE @query_value VARCHAR(1000);

SET @query_value =
N''SELECT  
  t2.BATCH_COMPLETION AS ''''Batch Completion Time''''
, t2.ROWS AS ''''Total Reservations''''
, t2.ROWS - t1.ROWS AS ''''Reservations In This Batch''''
, t3.EARLIEST_ARRIVAL AS ''''Earliest Arrival''''
, t3.LATEST_ARRIVAL AS ''''Latest Arrival''''
, t3.EARLIEST_CHECK_OUT AS ''''Earliest Check Out''''
, t3.LATEST_CHECK_OUT AS ''''Latest Check Out''''

FROM [iQ-Gaming].Opera_5_0.NAME_RESERVATION_ETL_HISTORY_BATCH_COUNT  t1

INNER JOIN  [iQ-Gaming].Opera_5_0.NAME_RESERVATION_ETL_HISTORY_BATCH_COUNT  t2
ON   t1.BATCH_NO = (t2.BATCH_NO + 1)

INNER JOIN [iQ-Gaming].Opera_5_0.NAME_RESERVATION_ETL_HISTORY  t3
ON t1.BATCH_COMPLETION = t3.BATCH_COMPLETION

WHERE DATEDIFF(MONTH,t2.BATCH_COMPLETION,CURRENT_TIMESTAMP) < 3

ORDER BY t2.BATCH_COMPLETION DESC;''

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''alerts'',
    @recipients = @recipients_value,
    @subject = @subject_value,
    @query = @query_value,
    @attach_query_result_as_file = 1;', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Opera RESERVATIONS Table Reload Confirmation]    Script Date: 10/9/2025 4:16:16 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Opera RESERVATIONS Table Reload Confirmation', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=5, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [iQ-Gaming] ;
GO

DECLARE @subject_value as VARCHAR(200) = ''Opera RESERVATIONS Table Reload Confirmation for DWHDB01QA --- '' + CONVERT(CHAR(16),CURRENT_TIMESTAMP,120);

DECLARE @recipients_value VARCHAR(200) = ''spaylor@VIEJAS.com''; -- viejas_alerts@readywillingnabel.com;_itdba@viejas.com;carl@readywillingnabel.com

--DECLARE @recipients_value VARCHAR(200) = ''spaylor@VIEJAS.com'';

DECLARE @query_value VARCHAR(1000) =
N''SELECT 
  CONVERT(CHAR(16),RESV_DATE,120) AS ''''Reservation Date''''
, COUNT(*)  AS ''''Total Number of Reservations''''

FROM [iQ-Gaming].Opera_5_0.RESERVATIONS

GROUP BY
  CONVERT(CHAR(16),RESV_DATE,120)

ORDER BY
  CONVERT(CHAR(16),RESV_DATE,120) DESC;''

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''alerts'',
    @recipients = @recipients_value,
    @subject = @subject_value,
    @query = @query_value,
    @attach_query_result_as_file = 1;', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at Midnight', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20161005, 
		@active_end_date=99991231, 
		@active_start_time=100, 
		@active_end_time=235959, 
		@schedule_uid=N'a0616787-aeae-4ec1-9eee-7c8cb255aee1'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

