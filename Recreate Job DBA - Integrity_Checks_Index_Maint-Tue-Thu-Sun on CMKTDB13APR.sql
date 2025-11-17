USE [msdb]
GO

/****** Object:  Job [DBA - Integrity_Checks_Index_Maint-Tue-Thu-Sun]    Script Date: 3/31/2023 3:08:07 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 3/31/2023 3:08:07 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Integrity_Checks_Index_Maint-Tue-Thu-Sun', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DBAdmin', 
		@notify_email_operator_name=N'ITappsDBA', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback[DBA - Index_Maint_Everyday]
/****** Object:  Step [Integrity_Checks]    Script Date: 3/31/2023 3:08:07 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Integrity_Checks', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE DBA.dbo.DatabaseIntegrityCheck
  @Databases = ''ALL_DATABASES,-CMKTDB_ARCHIVE,-CMKTDB_ARCHIVE_OLD,-CMP13_live_mount_03_14_2023_3_45AM''
, @CheckCommands = ''CHECKDB''
, @PhysicalOnly = ''N''
, @LogToTable = ''Y''', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQLAgent_Jobs_Output\DBA - Index_Maint_Integrity_Checks_output.txt', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Index Optimize All Databases]    Script Date: 3/31/2023 3:08:07 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Index Optimize All Databases', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE DBA.[dbo].[IndexOptimize] 
 -- @Databases = ''ALL_DATABASES,-CMP13,-CMKTDB_ARCHIVE,-CMKTDB_ARCHIVE_OLD''

  @Databases = ''ALL_DATABASES''
, @Indexes = ''ALL_INDEXES''
, @FragmentationLow = NULL
, @FragmentationMedium = ''INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE''
, @FragmentationHigh = ''INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE''
, @FragmentationLevel1 = 5
, @FragmentationLevel2 = 40
, @SortInTempdb = ''Y''
, @MaxDOP = 8
, @FillFactor = NULL
, @PadIndex = NULL
, @LOBCompaction = ''Y''
, @UpdateStatistics = ''ALL''
, @OnlyModifiedStatistics = ''Y''
, @StatisticsSample = NULL
, @StatisticsResample = ''N''
, @PartitionLevel = ''Y''
, @MinNumberOfPages = 1
--, @TimeLimit = 0
, @Delay = NULL
, @LogToTable = ''Y''', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQLAgent_Jobs_Output\DBA - Index_Maint_Integrity_Checks_output.txt', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Defrag Report]    Script Date: 3/31/2023 3:08:07 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Defrag Report', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT DB_NAME(ips.database_id) AS DatabaseName,
       SCHEMA_NAME(ob.[schema_id]) SchemaNames,
       ob.[name] AS ObjectName,
       ix.[name] AS IndexName,
       ob.type_desc AS ObjectType,
       ix.type_desc AS IndexType,
       -- ips.partition_number AS PartitionNumber,
       ips.page_count AS [PageCount], -- Only Available in DETAILED Mode
       ips.record_count AS [RecordCount],
       ips.avg_fragmentation_in_percent AS AvgFragmentationInPercent
--FROM sys.dm_db_index_physical_stats (NULL, NULL, NULL, NULL, ''DETAILED'') ips
FROM sys.dm_db_index_physical_stats (NULL, NULL, NULL, NULL, ''SAMPLED'') ips -- QuickResult
INNER JOIN sys.indexes ix ON ips.[object_id] = ix.[object_id] 
                AND ips.index_id = ix.index_id
INNER JOIN sys.objects ob ON ix.[object_id] = ob.[object_id]
WHERE ob.[type] IN(''U'',''V'')
AND ob.is_ms_shipped = 0
AND ix.[type] IN(1,2,3,4)
AND ix.is_disabled = 0
AND ix.is_hypothetical = 0
AND ips.alloc_unit_type_desc = ''IN_ROW_DATA''
AND ips.index_level = 0
--AND ips.page_count >= 1000 -- Filter to check only table with over 1000 pages
--AND ips.record_count >= 100 -- Filter to check only table with over 100 rows
--AND ips.database_id = 7 --DB_ID() -- Filter to check only the CMP13 database
AND ips.avg_fragmentation_in_percent > 30 -- Filter to check over 30% indexes

ORDER BY
  DB_NAME(ips.database_id)
, ips.avg_fragmentation_in_percent DESC', 
		@database_name=N'master', 
		@output_file_name=N'E:\SQLAgent_Jobs_Output\DBA - Index_Maint_Integrity_Checks_output.txt', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'2AM Tue-Thu-Sun', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=21, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20230329, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'c47426b7-dd79-4755-b355-57240b018718'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'6AM Tue-Thu-Sun', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=21, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20230329, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'1bc80933-4832-4a86-9abb-86d893fae27f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


