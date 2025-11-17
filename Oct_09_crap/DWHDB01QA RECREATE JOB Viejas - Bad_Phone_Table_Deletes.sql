USE [msdb]
GO

/****** Object:  Job [Viejas - Bad_Phone_Table_Deletes]    Script Date: 10/9/2025 4:18:32 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Casino Marketplace]]    Script Date: 10/9/2025 4:18:32 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Casino Marketplace]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Casino Marketplace]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Viejas - Bad_Phone_Table_Deletes', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Casino Marketplace]', 
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [deletes using logic provide by Marketing (Nate W.)]    Script Date: 10/9/2025 4:18:32 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'deletes using logic provide by Marketing (Nate W.)', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'---------------------------------------------------------------------
--
-- Created on 10/18/2022
-- Author spaylor
-- 
-- This job deletes invalid Phone records from CMP based on logic probide by Nate W.
-- in Marketing.
------------------------------------------------------------------------------------
-- Using logic provided by Nate in Marketing,  write records that will be deleted
-- to an history table named tPlayerPhone_Cleanup_Deletes to be used for 
-- recovering data if necessary
-------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--
-- Updated on 11/08/2022
--
-- Add ModinfiedBy Team Member information to the table that saves rows that are being deleted
--**************************************************************************************

-- Save a copy of the deleted rows with timestamp appended

INSERT INTO Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes

SELECT 
  tpp.PlayerId
, tpp.ContactTypeId
, tpp.PhoneNumber
, tpp.Extension
, tpp.IsCall
, tpp.IsSendTextMessage
, tpp.IsInactive
, tpp.CreatedDtm
, tpp.CreatedBy
, tpp.ModifiedDtm
, tpp.ModifiedBy
, tpp.DataRowVersion

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


FROM CMP13.dbo.tPlayerPhone tpp
LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
       ON tpp.playerid = vpv.playerid

LEFT JOIN CMPAPI.dbo.v_TM cre 
on tpp.CreatedBy = cre.EmpId

LEFT JOIN CMPAPI.dbo.v_TM mod 
on tpp.ModifiedBy = mod.EmpId

WHERE tpp.ContactTypeId IN (3,8,10)
  AND vpv.acct NOT LIKE ''9999%'' 
  AND vpv.firstname NOT LIKE ''%Viejas%'' 
  AND vpv.lastname NOT LIKE ''%giftcard%''
  AND LEN(CAST(tpp.PhoneNumber AS CHAR)) < 10 
  OR tpp.PhoneNumber LIKE ''%a-z%'' 
  OR tpp.PhoneNumber = ''6194455400''
  OR (CAST(PhoneNumber AS VARCHAR(10)) = REPLICATE(LEFT(CAST(PhoneNumber AS VARCHAR(10)),1),LEN(CAST(PhoneNumber AS VARCHAR(10)))))

-- Using the same criteria of the above query, delete from the tPlayerPhone table

DELETE tpp
FROM CMP13.dbo.tPlayerPhone tpp
LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
       ON tpp.playerid = vpv.playerid

WHERE tpp.ContactTypeId IN (3,8,10)
  AND vpv.acct NOT LIKE ''9999%'' 
  AND vpv.firstname NOT LIKE ''%Viejas%'' 
  AND vpv.lastname NOT LIKE ''%giftcard%''
  AND LEN(CAST(tpp.PhoneNumber AS CHAR)) < 10 
  OR tpp.PhoneNumber LIKE ''%a-z%'' 
  OR tpp.PhoneNumber = ''6194455400''
  OR (CAST(PhoneNumber AS VARCHAR(10)) = REPLICATE(LEFT(CAST(PhoneNumber AS VARCHAR(10)),1),LEN(CAST(PhoneNumber AS VARCHAR(10)))))', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQLAgent_Jobs_Output\Viejas - Bad_Phone_Table_Deletes_Log.txt', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'First Tueday of the month At 2AM', 
		@enabled=1, 
		@freq_type=32, 
		@freq_interval=3, 
		@freq_subday_type=1, 
		@freq_subday_interval=1, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=1, 
		@active_start_date=20221206, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'4a1c3318-3ce9-4c2a-a205-4ab3debc8fa2'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

