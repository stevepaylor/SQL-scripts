USE [msdb]
GO

/****** Object:  Job [iQ_Scheduling_sp_CMP_Update_IQC_Player_002A0D24_1E65_4EC4_A079_6315E303B1BC]    Script Date: 1/3/2023 4:24:34 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 1/3/2023 4:24:34 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'iQ_Scheduling_sp_CMP_Update_IQC_Player_002A0D24_1E65_4EC4_A079_6315E303B1BC', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=3, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'VIEJAS\gMSA018$', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Parallel_Execution_Command_1]    Script Date: 1/3/2023 4:24:34 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Parallel_Execution_Command_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @SQL NVARCHAR(4000), @Message VARCHAR(8000) = ''Completed Successfully'', @IsError TINYINT = 0, @Start_Dt DATETIME = GetDate();
BEGIN TRY
    SET @SQL = ''Exec [iQ-Gaming].[VCR].[sp_CMP_Update_IQC_Player] '';
    EXEC sp_executesql @SQL;
 
    if ''Job_Dependencies'' = ''Job_Flows''
        update [iQ-Scheduling].[dbo].[Job_Flows]
           set Completed = 1, 
               LastCompleted = GetDate() 
         where FlowID in (select FlowID 
                            from [iQ-Scheduling].[dbo].[v_Job_Flows] 
					       where FlowGroupingID = 70) 
           and [Enabled] = 1 
    if ''Job_Dependencies'' = ''Job_Dependencies''
        update [iQ-Scheduling].[dbo].[Job_Dependencies]
           set Completed = 1 
         where DependencyID in (select DependencyID 
                                  from [iQ-Scheduling].[dbo].[v_Job_Dependencies] 
					             where DependencyGroupingID = 70) 
           and [Enabled] = 1 
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
        SELECT @IsError = 1, @Message = 
               ''Error Number: "'' + CAST(ERROR_NUMBER() AS VARCHAR) + ''"'' + CHAR(10)
               + ''In Line #'' + CAST(ERROR_LINE() AS VARCHAR) + CHAR(10)
               + ''Message: "'' + ERROR_MESSAGE() + ''"'';
    if ''Job_Dependencies'' = ''Job_Flows''
        update [iQ-Scheduling].[dbo].[Job_Flows]
           set IsError = 1, 
               LastCompleted = GetDate() 
         where FlowID in (select FlowID 
                            from [iQ-Scheduling].[dbo].[v_Job_Flows] 
					       where FlowGroupingID = 70) 
           and [Enabled] = 1 
    if ''Job_Dependencies'' = ''Job_Dependencies''
        update [iQ-Scheduling].[dbo].[Job_Dependencies]
           set IsError = 1 
         where DependencyID in (select DependencyID 
                                  from [iQ-Scheduling].[dbo].[v_Job_Dependencies] 
					             where DependencyGroupingID = 70) 
           and [Enabled] = 1 
END CATCH 
IF ''M'' = ''I'' 
BEGIN  
    IF OBJECT_ID(''[iQ-Scheduling].[dbo].[Execution_Log_IntraDay]'') is Not Null
    BEGIN
        INSERT INTO [iQ-Scheduling].[dbo].[Execution_Log_IntraDay](ProcedureName, ProcessID, Start_Dt, IsError, Message, SQLQuery)
        SELECT ''sp_CMP_Update_IQC_Player'', 70, @Start_Dt, @IsError, @Message, @SQL
    END 
END 
ELSE 
BEGIN  
    IF OBJECT_ID(''[iQ-Scheduling].[dbo].[Execution_Log]'') is Not Null
    BEGIN
        INSERT INTO [iQ-Scheduling].[dbo].[Execution_Log](ProcedureName, ProcessID, Start_Dt, IsError, Message, SQLQuery)
        SELECT ''sp_CMP_Update_IQC_Player'', 70, @Start_Dt, @IsError, @Message, @SQL
    END 
END 
', 
		@database_name=N'iQ-Gaming', 
		@flags=0
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


