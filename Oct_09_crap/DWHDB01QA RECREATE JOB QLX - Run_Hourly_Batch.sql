USE [msdb]
GO

/****** Object:  Job [QLX - Run_Hourly_Batch]    Script Date: 10/9/2025 4:13:07 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/9/2025 4:13:07 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'QLX - Run_Hourly_Batch', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Run the hourly batch jobs defined in the iQ-Scheduling database', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'DWH_Alerts', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Clear Hourly Flags]    Script Date: 10/9/2025 4:13:07 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Clear Hourly Flags', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [dbo].[sp_Clear_Flags_H]', 
		@database_name=N'iQ-Scheduling', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Hourly Batch]    Script Date: 10/9/2025 4:13:07 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Hourly Batch', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @MessageID int,
          @errmsg nvarchar(2048),
                     @ErrorSeverity INT,
                  @ErrorState INT, 
                  @ErrorID INT;

set @MessageID = (select top 1 sjh.sql_message_id
                                   from msdb.dbo.sysjobs sj
                                  inner join msdb.dbo.sysjobhistory sjh
                             on sj.job_id = sjh.job_id
                                     left outer join msdb.dbo.sysjobsteps sjs 
                            on sjh.job_id = sjs.job_id 
                 and sjh.step_id = sjs.step_id  
                                where sj.[name] = ''QLX - Run_Hourly_Batch'' 
                 and sjs.step_name = ''Clear Hourly Flags'' 
                                order by msdb.dbo.agent_datetime(sjh.run_date, sjh.run_time) desc)

if @MessageID in (0, 70002)

   exec [dbo].[sp_Run_Hourly_Batch]

else 
begin
       

    begin try
        ;THROW 70001, ''Not All Prior Day processes Completed.  Check Execution Log.  '', 1
    end try
    begin catch
          select @errmsg = ERROR_MESSAGE(),
                 @ErrorSeverity = ERROR_SEVERITY(),
                 @ErrorState = ERROR_STATE(),
                 @ErrorID = ERROR_NUMBER() ;

        raiserror(@ErrorID,@ErrorSeverity,@ErrorState,@errmsg )

        ;throw
    end catch
end', 
		@database_name=N'iQ-Scheduling', 
		@flags=8
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Hourly_Batch', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20220208, 
		@active_end_date=99991231, 
		@active_start_time=110000, 
		@active_end_time=50100, 
		@schedule_uid=N'f94702f7-f4db-4f9e-97ec-5eb6e0b7740b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

