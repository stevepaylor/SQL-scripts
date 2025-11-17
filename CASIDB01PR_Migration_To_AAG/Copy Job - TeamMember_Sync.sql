USE [msdb]
GO

/****** Object:  Job [TeamMember_Sync]    Script Date: 11/24/2017 1:57:34 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 11/24/2017 1:57:34 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'TeamMember_Sync', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Synchronizing team members on this server with the Common_Security database on the casivc07pr, which is updated with data from Lawson', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'ITappsDBA', 
		@notify_page_operator_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [TM Synch]    Script Date: 11/24/2017 1:57:35 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'TM Synch', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'INSERT INTO [COMMON_SECURITY].[dbo].[COMPANY]
           ([COMPANY_ID]
           ,[COMPANY_NM]
           ,[ACTIVE_IND])
SELECT [COMPANY_ID]
      ,[COMPANY_NM]
      ,[ACTIVE_IND]
  FROM [casivc07pr].[COMMON_SECURITY].[dbo].[COMPANY] WITH( NOLOCK)
  WHERE COMPANY_ID not in (SELECT [COMPANY_ID]
  FROM [COMMON_SECURITY] .[dbo].[COMPANY] WITH( NOLOCK))
  
INSERT INTO [COMMON_SECURITY].[dbo].[TEAM_MEMBER_STATUS_REF]
           ([TEAM_MEMBER_STATUS_CD]
           ,[TEAM_MEMBER_STATUS_NM])
SELECT [TEAM_MEMBER_STATUS_CD]
      ,[TEAM_MEMBER_STATUS_NM]
  FROM [casivc07pr].[COMMON_SECURITY].[dbo].[TEAM_MEMBER_STATUS_REF] WITH( NOLOCK)
  WHERE TEAM_MEMBER_STATUS_CD not in (SELECT [TEAM_MEMBER_STATUS_CD]
  FROM [COMMON_SECURITY] .[dbo].[TEAM_MEMBER_STATUS_REF] WITH( NOLOCK))
GO





INSERT INTO [COMMON_SECURITY].[dbo].[DEPARTMENT]
           ([DEPT_CD]
           ,[BUSINESS_UNIT_CD]
           ,[COMPANY_ID]
           ,[DEPT_NM]
           ,[ACTIVE_IND])
SELECT [DEPT_CD]
      ,[BUSINESS_UNIT_CD]
      ,[COMPANY_ID]
      ,[DEPT_NM]
      ,[ACTIVE_IND]
  FROM [casivc07pr].[COMMON_SECURITY].[dbo].[DEPARTMENT]
    WHERE DEPT_CD not in (SELECT [DEPT_CD]
  FROM [COMMON_SECURITY] .[dbo].[DEPARTMENT] WITH( NOLOCK))


INSERT INTO [COMMON_SECURITY].[dbo] .[TEAM_MEMBER]
           ([TEAM_MEMBER_NUM]
           ,[COMPANY_ID]
           ,[TEAM_MEMBER_FIRST_NM]
           ,[TEAM_MEMBER_LAST_NM]
           ,[TEAM_MEMBER_STATUS_CD]
           ,[HIRE_DT]
           ,[DEPT_CD]
           ,[BUSINESS_UNIT_CD]
           ,[BADGE_NUM])
SELECT [TEAM_MEMBER_NUM]
      ,[COMPANY_ID]
      ,[TEAM_MEMBER_FIRST_NM]
      ,[TEAM_MEMBER_LAST_NM]
      ,[TEAM_MEMBER_STATUS_CD]
      ,[HIRE_DT]
      ,[DEPT_CD]
      ,[BUSINESS_UNIT_CD]
      ,[BADGE_NUM]
  FROM [casivc07pr] .[COMMON_SECURITY]. [dbo].[TEAM_MEMBER]  WITH(NOLOCK )
  where [TEAM_MEMBER_NUM] not in
  (SELECT [TEAM_MEMBER_NUM]
  FROM [COMMON_SECURITY] .[dbo]. [TEAM_MEMBER] WITH( NOLOCK))

INSERT INTO [COMMON_SECURITY].[dbo] .[MANAGER_OF_TM]
           ([EMPLOYEE]
           ,[SUPERVISOR])
SELECT [EMPLOYEE]
      ,[SUPERVISOR]
  FROM [casivc07pr] .[COMMON_SECURITY]. [dbo].[MANAGER_OF_TM] WITH(NOLOCK )
where EMPLOYEE not in (select EMPLOYEE from [COMMON_SECURITY]. [dbo]. [MANAGER_OF_TM] WITH(NOLOCK ))


INSERT INTO [COMMON_SECURITY].[dbo] .[JOB_REF]
           ([JOB_CD]
           ,[COMPANY_ID]
           ,[JOB_TITLE_NM]
           ,[ACTIVE_IND])
SELECT [JOB_CD]
      ,[COMPANY_ID]
      ,[JOB_TITLE_NM]
      ,[ACTIVE_IND]
  FROM [casivc07pr] .[COMMON_SECURITY]. [dbo].[JOB_REF] WITH(NOLOCK )
  WHERE JOB_CD not in (SELECT [JOB_CD]
  FROM [COMMON_SECURITY] .[dbo]. [JOB_REF] WITH( NOLOCK))


INSERT INTO [COMMON_SECURITY].[dbo] .[TEAM_MEMBER_JOB_ASSOC]
           ([TEAM_MEMBER_NUM]
           ,[COMPANY_ID]
           ,[JOB_CD])
SELECT [TEAM_MEMBER_NUM]
      ,[COMPANY_ID]
      ,[JOB_CD]
  FROM [casivc07pr] .[COMMON_SECURITY]. [dbo].[TEAM_MEMBER_JOB_ASSOC] WITH(NOLOCK )
  where [TEAM_MEMBER_NUM] not in
  (SELECT [TEAM_MEMBER_NUM]
  FROM [COMMON_SECURITY] .[dbo]. [TEAM_MEMBER_JOB_ASSOC] WITH( NOLOCK))
 

UPDATE a  WITH (ROWLOCK)
SET
  a.[TEAM_MEMBER_STATUS_CD] = b. [TEAM_MEMBER_STATUS_CD]
  FROM [COMMON_SECURITY] .[dbo]. [TEAM_MEMBER] a join [casivc07pr].[COMMON_SECURITY]. [dbo].[TEAM_MEMBER] b
   ON a .TEAM_MEMBER_NUM = b.[TEAM_MEMBER_NUM]
   AND a .[TEAM_MEMBER_STATUS_CD] != b.[TEAM_MEMBER_STATUS_CD]

 UPDATE a  WITH (ROWLOCK)
        SET
            a.[TEAM_MEMBER_LAST_NM] = b.[TEAM_MEMBER_LAST_NM]
    FROM [COMMON_SECURITY] .[dbo].[TEAM_MEMBER] a join [casivc07pr].[COMMON_SECURITY]. [dbo].[TEAM_MEMBER] b
         ON a.TEAM_MEMBER_NUM = b.[TEAM_MEMBER_NUM]
       AND a.[TEAM_MEMBER_LAST_NM] != b.[TEAM_MEMBER_LAST_NM]

 UPDATE a  WITH (ROWLOCK)
        SET
            a.[DEPT_CD] = b.[DEPT_CD],
            a.[BUSINESS_UNIT_CD]=b.[BUSINESS_UNIT_CD], 
            a.[COMPANY_ID]=b.[COMPANY_ID]
    FROM [COMMON_SECURITY] .[dbo].[TEAM_MEMBER] a join [casivc07pr].[COMMON_SECURITY]. [dbo].[TEAM_MEMBER] b
         ON a.TEAM_MEMBER_NUM = b.[TEAM_MEMBER_NUM]
       AND a.[DEPT_CD] != b.[DEPT_CD]', 
		@database_name=N'COMMON_SECURITY', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Deactive Terminated Team Members]    Script Date: 11/24/2017 1:57:35 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Deactive Terminated Team Members', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'UPDATE PRINCIPALS SET ACTIVE_IND = 0 WHERE ACTIVE_IND = 1 AND TEAM_MEMBER_NUM IN (SELECT TEAM_MEMBER_NUM FROM TEAM_MEMBER WHERE TEAM_MEMBER_STATUS_CD NOT LIKE ''A%'')', 
		@database_name=N'COMMON_SECURITY', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'120 minute run', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120521, 
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

