USE [msdb]
GO

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Clear Ad Hoc Query Plan Cache')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Clear Ad Hoc Query Plan Cache', @delete_unused_schedule=1

/****** Object:  Job [DBA - Clear Ad Hoc Query Plan Cache]    Script Date: 6/22/2016 3:36:34 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 6/22/2016 3:36:34 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Clear Ad Hoc Query Plan Cache', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'/*============================================================================
  File:     sp_SQLskills_CheckPlanCache

  Summary:  This procedure looks at cache and totals the single-use plans
			to report the percentage of memory consumed (and therefore wasted)
			from single-use plans.
			
  Date:     April 2010

  Version:	2008.
------------------------------------------------------------------------------
  Written by Kimberly L. Tripp, SQLskills.com

  For more scripts and sample code, ch', 
		@category_name=N'Database Maintenance',
		@notify_email_operator_name=N'ITappsDBA',
		@owner_login_name=N'DBAdmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Clear Ad Hoc Plan Cache]    Script Date: 6/22/2016 3:36:35 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Clear Ad Hoc Plan Cache', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE MASTER
GO
 
EXEC sp_configure ''show advanced option'', ''1'';

RECONFIGURE
GO 

if OBJECTPROPERTY(OBJECT_ID(''sp_SQLskills_CheckPlanCache''), ''IsProcedure'') = 1
	DROP PROCEDURE sp_SQLskills_CheckPlanCache
go

CREATE PROCEDURE sp_SQLskills_CheckPlanCache
	(@Percent	decimal(6,3) OUTPUT,
	 @WastedMB	decimal(19,3) OUTPUT)
AS
SET NOCOUNT ON

DECLARE @ConfiguredMemory	decimal(19,3)
	, @PhysicalMemory		decimal(19,3)
	, @MemoryInUse			decimal(19,3)
	, @SingleUsePlanCount	bigint

CREATE TABLE #ConfigurationOptions
(
	[name]				nvarchar(35)
	, [minimum]			int
	, [maximum]			int
	, [config_value]	int				-- in bytes
	, [run_value]		int				-- in bytes
);
INSERT #ConfigurationOptions EXEC (''sp_configure ''''max server memory'''''');

SELECT @ConfiguredMemory = run_value/1024/1024 
FROM #ConfigurationOptions 
WHERE name = ''max server memory (MB)''

SELECT @PhysicalMemory = total_physical_memory_kb/1024 
FROM sys.dm_os_sys_memory

SELECT @MemoryInUse = physical_memory_in_use_kb/1024 
FROM sys.dm_os_process_memory

SELECT @WastedMB = sum(cast((CASE WHEN usecounts = 1 AND objtype IN (''Adhoc'', ''Prepared'') 
								THEN size_in_bytes ELSE 0 END) AS DECIMAL(12,2)))/1024/1024 
	, @SingleUsePlanCount = sum(CASE WHEN usecounts = 1 AND objtype IN (''Adhoc'', ''Prepared'') 
								THEN 1 ELSE 0 END)
	, @Percent = @WastedMB/@MemoryInUse * 100
FROM sys.dm_exec_cached_plans

SELECT	[TotalPhysicalMemory (MB)] = @PhysicalMemory
	, [TotalConfiguredMemory (MB)] = @ConfiguredMemory
	, [MaxMemoryAvailableToSQLServer (%)] = @ConfiguredMemory/@PhysicalMemory * 100
	, [MemoryInUseBySQLServer (MB)] = @MemoryInUse
	, [TotalSingleUsePlanCache (MB)] = @WastedMB
	, TotalNumberOfSingleUsePlans = @SingleUsePlanCount
	, [PercentOfConfiguredCacheWastedForSingleUsePlans (%)] = @Percent
GO

EXEC sys.sp_MS_marksystemobject ''sp_SQLskills_CheckPlanCache''
go

-----------------------------------------------------------------
-- Logic (in a job?) to decide whether or not to clear - using sproc...
-----------------------------------------------------------------

DECLARE @Percent		decimal(6, 3)
		, @WastedMB		decimal(19,3)
		, @StrMB		nvarchar(20)
		, @StrPercent	nvarchar(20)
EXEC sp_SQLskills_CheckPlanCache @Percent output, @WastedMB output

SELECT @StrMB = CONVERT(nvarchar(20), @WastedMB)
		, @StrPercent = CONVERT(nvarchar(20), @Percent)

IF @Percent > 10 OR @WastedMB > 10
	BEGIN
		DBCC FREESYSTEMCACHE(''SQL Plans'') 
		RAISERROR (''%s MB (%s percent) was allocated to single-use plan cache. Single-use plans have been cleared.'', 10, 1, @StrMB, @StrPercent)
	END
ELSE
	BEGIN
		RAISERROR (''Only %s MB (%s percent) is allocated to single-use plan cache - no need to clear cache now.'', 10, 1, @StrMB, @StrPercent)
			-- Note: this is only a warning message and not an actual error.
	END
go', 
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
		@active_start_date=20160622, 
		@active_end_date=99991231, 
		@active_start_time=200, 
		@active_end_time=235959 
		--@schedule_uid=N'c886f727-7ce8-4528-97c5-d79089d853db'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


