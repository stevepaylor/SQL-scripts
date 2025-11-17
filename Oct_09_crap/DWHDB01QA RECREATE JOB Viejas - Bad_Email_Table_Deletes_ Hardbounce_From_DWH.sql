USE [msdb]
GO

/****** Object:  Job [Viejas - Bad_Email_Table_Deletes_ Hardbounce_From_DWH]    Script Date: 10/9/2025 4:17:49 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/9/2025 4:17:49 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Viejas - Bad_Email_Table_Deletes_ Hardbounce_From_DWH', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Get before counts]    Script Date: 10/9/2025 4:17:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Get before counts', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET NOCOUNT ON;

SELECT ''Counts Before Processing HardBounces'';

SELECT ''Live table in CMP13 prod: '', COUNT(*) AS ''RowCount''
FROM CMPDBLIS01QA.CMP13.dbo.tPlayerEmail;


SELECT ''Current Row Count Selected for Deletion: '', COUNT(*) AS ''RowCount''
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes_NEW;

SELECT ''Deletes archive table: '', COUNT(*) AS ''RowCount''
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes;

SELECT ''Players With Multiple Deleted Bad Email Addresses'';

SELECT 
  PlayerId
, COUNT(*) AS CountMultipleDeletes
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes

GROUP BY
  PlayerId

HAVING COUNT(*) > 1;', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Archive and Delete Hardbounces]    Script Date: 10/9/2025 4:17:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Archive and Delete Hardbounces', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--**************************************************************************************
--
-- Created on 10/17/2022
-- Author spaylor
----------------------------------------------------------------------------------------
-- Save a copy of the deleted rows with the hardbounce data appended

-- Join the tPlayerEmail and DBM Email_HardBounce (on DWHDB02pr) tables
-- and write those records to an history table named tPlayerEmail_HardBounce_Deletes
----------------------------------------------------------------------------------------
--
-- Updated on 11/02/2022
-- By spaylor
--
-- Add CreatedBy and ModinfiedBy Team Member information to the table that saves rows that are being deleted
----------------------------------------------------------------------------------------
--
-- Updated on 07/11/2025
-- By spaylor
--
-- Moved Viejas_Custom_Processes DB to DWH after the CMP upgrade and modified SQL to delete from tPlayerEmail on Linked server to the new CMP13 database. 
-- 
--**********************************************************************************************************

-----------------------------------------------------------------------------------------------------------------------------------
-- Create a temp table of the tPlayerEmail rows that have an entry in the DWH hardbounce table and has not already been cleaned out
-----------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes_NEW
GO

SELECT DISTINCT
  tpe.PlayerId
, tpe.ContactTypeId
, tpe.EmailAddress
, tpe.IsEmailSend
, tpe.IsInactive
, tpe.CreatedDtm
, tpe.CreatedBy
, tpe.ModifiedDtm
, tpe.ModifiedBy
, tpe.DataRowVersion

, cre.TEAM_MEMBER_NUM AS cre_TM_Number
, cre.TEAM_MEMBER_FIRST_NM AS cre_TM_FirstName
, cre.TEAM_MEMBER_LAST_NM AS cre_TM_LastName    
, cre.DEPT_NM AS cre_TM_DeptNo
, cre.Position AS cre_TM_Position
, cre.JOB_TITLE_NM AS cre_TM_JobTitle

, mod.TEAM_MEMBER_NUM AS mod_TM_Number
, mod.TEAM_MEMBER_FIRST_NM AS mod_TM_FirstName
, mod.TEAM_MEMBER_LAST_NM AS mod_TM_LastName    
, mod.DEPT_NM AS mod_TM_DeptNo
, mod.Position AS mod_TM_Position
, mod.JOB_TITLE_NM AS mod_TM_JobTitle

, CURRENT_TIMESTAMP AS DeletedFromCMP13_TS

, dwh.email_bounce_dttm
, dwh.recipient_domain_nm
, dwh.reason_txt

INTO Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes_NEW

FROM CMPDBLIS01QA.CMP13.dbo.tPlayerEmail tpe
JOIN DWHDB02PR.DBM.dbo.Email_HardBounce dwh  -- Limits rows to only those found in the HardBounce table
ON tpe.PlayerId = dwh.Playerid

LEFT JOIN CMPDBLIS01PR.CMPAPI.dbo.v_TM cre 
on tpe.CreatedBy = cre.EmpId

LEFT JOIN CMPDBLIS01PR.CMPAPI.dbo.v_TM mod 
on tpe.ModifiedBy = mod.EmpId

LEFT OUTER JOIN Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes del
ON  tpe.PlayerId = del.PlayerId
AND tpe.ContactTypeId = del.ContactTypeId
AND tpe.[EmailAddress] = del.[EmailAddress]

WHERE del.PlayerId is NULL -- Ensure the record hasn''t already been written to the archive table
GO

-----------------------------------------------------------------------------------------------------------------------------------
-- Load the rows from the temp table just created into the hardbounce pre-delete archive table to keep a copy of the deleted row
-- and the corresponding information from the DWH hardbounce table to provide for recovery of rows if it becomes necessary
-----------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes
SELECT *
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes_NEW
GO

-----------------------------------------------------------------------------
-- Delete the rows that were saved above from the tPlayerEmail table
------------------------------------------------------------------------------
-- Dump the rows to be deleted beforehand
-------------------------------------------------------------------------------
SELECT distinct 
  tpe.PlayerId 
, del.PlayerId
, tpe.[ContactTypeId]
, del.[ContactTypeId]
, tpe.[EmailAddress]
, tpe.[EmailAddress]
, del.[DeletedFromCMP13_TS]
, tpe.ModifiedDtm
, del.[email_bounce_dttm]
, del.[reason_txt]

FROM CMPDBLIS01QA.CMP13.dbo.tPlayerEmail tpe
JOIN Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes_NEW del
ON tpe.PlayerId = del.Playerid
AND tpe.[ContactTypeId] = del.[ContactTypeId]
AND tpe.[EmailAddress] = del.[EmailAddress]

------------------------------------------------------------------------------
-- delete the rows
-------------------------------------------------------------------------------
DELETE tpe
FROM CMPDBLIS01QA.CMP13.dbo.tPlayerEmail tpe
JOIN Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes_NEW del
ON tpe.PlayerId = del.Playerid
AND tpe.[ContactTypeId] = del.[ContactTypeId]
AND tpe.[EmailAddress] = del.[EmailAddress]

------------------------------------------------------------------------------
-- list rows that were just deleted from the archive table
-------------------------------------------------------------------------------
SELECT distinct 
  del.PlayerId as deleted_PlayerId
, tpe.PlayerId as CMP13_PlayerId
, del.[ContactTypeId] as deleted_ContactTypeId
, tpe.[ContactTypeId] as CMP13_ContactTypeId
, del.[EmailAddress] as deleted_EmailAddress
, tpe.[EmailAddress] as CMP13_EmailAddress
, del.[DeletedFromCMP13_TS] as deleted_DeletedFromCMP13_TS
, tpe.ModifiedDtm as CMP13_ModifiedDtm
, del.[email_bounce_dttm] as deleted_email_bounce_dttm
, del.[reason_txt] as deleted_reason_txt

FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes del
LEFT OUTER JOIN CMPDBLIS01QA.CMP13.dbo.tPlayerEmail tpe
ON tpe.PlayerId = del.Playerid
AND tpe.[ContactTypeId] = del.[ContactTypeId]
AND tpe.[EmailAddress] = del.[EmailAddress]

WHERE del.[DeletedFromCMP13_TS] >= (SELECT MAX([DeletedFromCMP13_TS]) FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes)

ORDER BY del.[DeletedFromCMP13_TS] DESC', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Get after counts]    Script Date: 10/9/2025 4:17:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Get after counts', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET NOCOUNT ON;

SELECT ''Counts After Processing HardBounces and other deletes'';

SELECT ''Live table in CMP13 prod: '', COUNT(*) AS ''RowCount''
FROM CMPDBLIS01QA.CMP13.dbo.tPlayerEmail;

---------------------------------------------------------------------------

SELECT ''Counts After Processing HardBounces and other deletes'';

SELECT ''Hardbounce deletes archive table: '', COUNT(*) AS ''RowCount''
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes

---------------------------------------------------------------------------

SELECT ''Players With Multiple Deleted Email Addresses Due to Hardbounce'';

SELECT 
  PlayerId
, COUNT(*) AS CountMultipleDeletes
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes
GROUP BY
  PlayerId
HAVING COUNT(*) > 1;', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [List number of rows inserted in each batch]    Script Date: 10/9/2025 4:17:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'List number of rows inserted in each batch', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET NOCOUNT ON;

SELECT 
''Count of Deletes Per Batch -- Hardbounce Deletes''

SELECT 
  DeletedFromCMP13_TS
, COUNT(*) as Rows_Deleted
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes
GROUP BY
  DeletedFromCMP13_TS
ORDER BY
  DeletedFromCMP13_TS desc', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Hourly', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20231011, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=235959, 
		@schedule_uid=N'5e64b6c2-d9ff-4308-bdc5-b5e3bf612122'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

