USE [msdb]
GO

/****** Object:  Job [Viejas - Bad_Email_Table_Deletes_ Hardbounce_From_DWH]    Script Date: 7/12/2025 10:09:26 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Casino Marketplace]]    Script Date: 7/12/2025 10:09:26 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Casino Marketplace]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Casino Marketplace]'
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
		@description=N'Steps 1 and 4 can be removed and step 2 must be removed when this goes into production pointing at the live tPlayerEmail table.', 
		@category_name=N'[Casino Marketplace]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Get before counts]    Script Date: 7/12/2025 10:09:26 AM ******/
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
FROM CMP13.dbo.tPlayerEmail;

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
		@output_file_name=N'E:\SQLAgent_Jobs_Output\Bad_Email_Table_Deletes_ Hardbounce_From_DWH_Log.txt', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Archive and Delete Hardbounces]    Script Date: 7/12/2025 10:09:26 AM ******/
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
--**********************************************************************************************************

INSERT INTO Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes
SELECT 
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

FROM CMP13.dbo.tPlayerEmail tpe
JOIN DWHDB02PR.DBM.dbo.Email_HardBounce dwh  -- Limits rows to only those found in the HardBounce table
ON tpe.PlayerId = dwh.Playerid

LEFT JOIN CMPAPI.dbo.v_TM cre 
on tpe.CreatedBy = cre.EmpId

LEFT JOIN CMPAPI.dbo.v_TM mod 
on tpe.ModifiedBy = mod.EmpId

WHERE dwh.email_bounce_dttm > tpe.ModifiedDtm -- Limits rows to only those that bounced after they were last modified (updated)

-----------------------------------------------------------------------------
-- Delete the rows that were saved above from the tPlayerEmail table
------------------------------------------------------------------------------

DELETE tpe
FROM CMP13.dbo.tPlayerEmail tpe
JOIN DWHDB02PR.DBM.dbo.Email_HardBounce dwh  -- Limits rows to only those found in the HardBounce table
ON tpe.PlayerId = dwh.Playerid

WHERE dwh.email_bounce_dttm > tpe.ModifiedDtm -- Limits rows to only those that bounced after they were last modified (updated)', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQLAgent_Jobs_Output\Bad_Email_Table_Deletes_ Hardbounce_From_DWH_Log.txt', 
		@flags=6
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Get after counts]    Script Date: 7/12/2025 10:09:26 AM ******/
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
		@output_file_name=N'E:\SQLAgent_Jobs_Output\Bad_Email_Table_Deletes_ Hardbounce_From_DWH_Log.txt', 
		@flags=6
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [List number of rows inserted in each batch]    Script Date: 7/12/2025 10:09:26 AM ******/
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
, COUNT(*)
FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes
GROUP BY
  DeletedFromCMP13_TS
ORDER BY
  DeletedFromCMP13_TS DESC', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQLAgent_Jobs_Output\Bad_Email_Table_Deletes_ Hardbounce_From_DWH_Log.txt', 
		@flags=6
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


