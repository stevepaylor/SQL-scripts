----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 143 $
----------------------------------------------------------------------------------------------------
USE [DBA]
GO

if exists (select * from INFORMATION_SCHEMA.ROUTINES where routine_name = 'usp_FinalProcToCreateBKjobs' and ROUTINE_TYPE = 'PROCEDURE')
	drop procedure [dbo].[usp_FinalProcToCreateBKjobs]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.usp_FinalProcToCreateBKjobs
(
	@BackupFolderNumber INT = 6
)

AS

set nocount on 

declare @ErrorCode int
set @ErrorCode = 0

DECLARE @BackupDirectoryFULL	nvarchar(max)
DECLARE @BackupDirectoryDIFF	nvarchar(max)
DECLARE @BackupDirectoryINCR	nvarchar(max)
declare @CleanupTime			nvarchar(max)
DECLARE @CleanupTimeFULL		nvarchar(max)
DECLARE @CleanupTimeDIFF		nvarchar(max)
DECLARE @CleanupTimeINCR		nvarchar(max)
DECLARE @BackupSoftware			nvarchar(max)
DECLARE @Compress				nvarchar(max)
DECLARE @BufferCount			nvarchar(max)
DECLARE @MaxTransferSize		nvarchar(max)
DECLARE @BlockSize				nvarchar(max)
DECLARE @OutputFileDirectory	nvarchar(max)
DECLARE @NumOfLogFiles			nvarchar(max)
DECLARE @LogToTable				nvarchar(max)
DECLARE @CopyOnly				nvarchar(max)
declare @FULL_schedulefreq_type				int
declare @FULL_schedulefreq_interval			int
declare @FULL_schedulefreq_subday_type		int
declare @FULL_schedulefreq_subday_interval  int
declare @FULL_scheduleactive_start_time		int
declare @FULL_scheduleactive_start_date		int
declare @FULL_scheduleactive_end_time		int
declare @DIFF_schedulefreq_type				int
declare @DIFF_schedulefreq_interval			int
declare @DIFF_schedulefreq_subday_type		int
declare @DIFF_schedulefreq_subday_interval	int
declare @DIFF_scheduleactive_start_date		int
declare @DIFF_scheduleactive_start_time		int
declare @DIFF_scheduleactive_end_time		int
declare @INCR_schedulefreq_type				int
declare @INCR_schedulefreq_interval			int
declare @INCR_schedulefreq_subday_type		int
declare @INCR_schedulefreq_subday_interval	int
declare @INCR_scheduleactive_start_date		int
declare @INCR_scheduleactive_start_time		int
declare @INCR_scheduleactive_end_time		int
declare @IsProductionEnvironment			bit


------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ***** Update to the appropriate values ***** 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
set @IsProductionEnvironment	= 1 						-- 1 = Production; 0  Non-Porduction. Impacts default job schedule.

set @BackupDirectoryFULL = -- Specify the backup root directory for the FULLs. Example: \\sequel\sql_nonprod2
CASE @BackupFolderNumber 
WHEN 1 THEN '\\DBAMBK01PR\SQLBackup01'
WHEN 2 THEN '\\DBAMBK01PR\SQLBackup02'
WHEN 3 THEN '\\DBAMBK01PR\SQLBackup03'
WHEN 4 THEN '\\DBAMBK01PR\SQLBackup04_NONPROD'
WHEN 5 THEN '\\DBAMBK01PR\SQLBackup05'
WHEN 6 THEN '\\DBAMBK02PR\SQLBackup06'
WHEN 7 THEN '\\DBAMBK02PR\SQLBackup07'
WHEN 8 THEN '\\DBAMBK02PR\SQLBackup08'
WHEN 9 THEN '\\DBAMBK02PR\SQLBackup09'
ELSE '\\DBAMBK02PR\SQLBackup09'
END

set @BackupDirectoryDIFF = -- Specify the backup root directory for the DIFFs.
CASE @BackupFolderNumber 
WHEN 1 THEN '\\DBAMBK01PR\SQLBackup01'
WHEN 2 THEN '\\DBAMBK01PR\SQLBackup02'
WHEN 3 THEN '\\DBAMBK01PR\SQLBackup03'
WHEN 4 THEN '\\DBAMBK01PR\SQLBackup04_NONPROD'
WHEN 5 THEN '\\DBAMBK01PR\SQLBackup05'
WHEN 6 THEN '\\DBAMBK02PR\SQLBackup06'
WHEN 7 THEN '\\DBAMBK02PR\SQLBackup07'
WHEN 8 THEN '\\DBAMBK02PR\SQLBackup08'
WHEN 9 THEN '\\DBAMBK02PR\SQLBackup09'
ELSE '\\DBAMBK02PR\SQLBackup09'
END

set	@BackupDirectoryINCR = -- Specify the backup root directory for the INCRs. 
CASE @BackupFolderNumber 
WHEN 1 THEN '\\DBAMBK01PR\SQLBackup01'
WHEN 2 THEN '\\DBAMBK01PR\SQLBackup02'
WHEN 3 THEN '\\DBAMBK01PR\SQLBackup03'
WHEN 4 THEN '\\DBAMBK01PR\SQLBackup04_NONPROD'
WHEN 5 THEN '\\DBAMBK01PR\SQLBackup05'
WHEN 6 THEN '\\DBAMBK02PR\SQLBackup06'
WHEN 7 THEN '\\DBAMBK02PR\SQLBackup07'
WHEN 8 THEN '\\DBAMBK02PR\SQLBackup08'
WHEN 9 THEN '\\DBAMBK02PR\SQLBackup09'
ELSE '\\DBAMBK02PR\SQLBackup09'
END

set	@CleanupTime				= 180						-- Retention value for the backup files in hours for the FULL,DIFF and INCR job
set	@BackupSoftware				= NULL						-- NULL = SQL Server native backup; LITESPEED = Quest LiteSpeed; SQLBACKUP = Red Gate SQL Backup
set	@Compress					= 'Y'						-- Compress the backup. Y = Yes, N = No
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- These are the default options. Change if desired --
set	@OutputFileDirectory		= NULL  -- Specify the output file directory. If no directory is specified, then the SQL Server error log directory is used.
set	@NumOfLogFiles				= 2 	-- Specifies the number of log files to keep. A log file is created every time a job runs so tlog backups create lots of logs
set	@LogToTable					= 'Y'   -- Log commands to a table. Y = Yes, N = No
set	@CopyOnly				    = 'N'	-- Perform copy-only backup. Y = Yes, N = No
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Backup Job Schedule. These are the default options. Change if desired --

-- FULL: Occurs every 2 day(s) at 10:30:00 PM --
set @FULL_schedulefreq_type				= 4
set @FULL_schedulefreq_interval			= 1
set @FULL_schedulefreq_subday_type		= 1
set @FULL_schedulefreq_subday_interval  = 0
set @FULL_scheduleactive_start_time		= 223000
set @FULL_scheduleactive_end_time		= 235959

-- DIFF: Occurs every day every 8 hour(s) --
set @DIFF_schedulefreq_type				= 4
set @DIFF_schedulefreq_interval			= 1
set @DIFF_schedulefreq_subday_type		= 8
set @DIFF_schedulefreq_subday_interval	= 4
set @DIFF_scheduleactive_start_date		= 20140717

-- INCR: Occurs every day every 15 minute(s) --
set @INCR_schedulefreq_type				= 4
set @INCR_schedulefreq_interval			= 1
set @INCR_schedulefreq_subday_type		= 4
set @INCR_schedulefreq_subday_interval	= 15
set @INCR_scheduleactive_start_date		= 20140717


if @IsProductionEnvironment = 1
begin
	-- Default Production INCR Schedule: Between 12:05:00 AM and 12:04:59 AM --
	set @INCR_scheduleactive_start_time	= 500
	set @INCR_scheduleactive_end_time = (@INCR_scheduleactive_start_time - 41)

	-- Default Production DIFF Schedule: Between 12:00:00 PM and 11:59:59 PM --
	set @DIFF_scheduleactive_start_time = 000000
	set @DIFF_scheduleactive_end_time = 235959

	-- Default Production FULL Schedule: Schedule will be used starting on 7/18/2014 --
	set @FULL_scheduleactive_start_date	= 20140718

end else
begin
	-- Default Non-Production INCR Schedule: Between 12:10:00 AM and 12:09:59 AM --
	set @INCR_scheduleactive_start_time	= 1000
	set @INCR_scheduleactive_end_time = (@INCR_scheduleactive_start_time - 41)

	-- Default Non-Production DIFF Schedule: Between 1:00:00 PM and 11:59:59 PM --
	set @DIFF_scheduleactive_start_time	= 130000
	set @DIFF_scheduleactive_end_time = 235959

	-- Default Non-Production FULL Schedule: Schedule will be used starting on 7/17/2014 --
	set @FULL_scheduleactive_start_date	= 20140717
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Set default values for VMs and Physical Servers --
if exists (select TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'TJM_SystemManufacturer')
	drop table TJM_SystemManufacturer

create table TJM_SystemManufacturer (LogDate DateTime, ProcessInfo varchar(50), TextData varchar(500))
insert into DBA.dbo.TJM_SystemManufacturer exec sp_readerrorlog 0, 1, 'System Manufacturer'

if (select charindex('VMware', TextData, 0) from DBA.dbo.TJM_SystemManufacturer) > 0
begin
	-- Virtual Machine --
	SET @BufferCount		= 512
	SET @MaxTransferSize	= 262144
	SET @BlockSize			= 8192 
end
else
begin
	-- Physical Hardware --
	SET @BufferCount		= 512		-- Specify the number of I/O buffers to be used for the backup operation
	SET @MaxTransferSize	= 1048576	-- Specify the largest unit of transfer, in bytes, to be used between SQL Server and the backup media
	SET @BlockSize			= 8192		-- Specify the physical blocksize in bytes.
end

-- Populate DBA.dbo.BackupJob --

-- FULL Backup Job --
exec DBA.[dbo].[usp_PopulateBackupJobTable]
	@BackupJob					= 'FULL',
	@BackupDirectory			= @BackupDirectoryFULL,  
	@CleanupTime				= @CleanupTime,		
	@BackupSoftware				= @BackupSoftware,		
	@Compress					= @Compress,		
	@BufferCount				= @BufferCount,		
	@MaxTransferSize			= @MaxTransferSize,		
	@BlockSize					= @BlockSize,	
	@OutputFileDirectory		= @OutputFileDirectory,	
	@NumOfLogFiles				= @NumOfLogFiles, 		
	@LogToTable					= @LogToTable,      	
	@CopyOnly				    = @CopyOnly,
	@schedulefreq_type			= @FULL_schedulefreq_type, 
	@schedulefreq_interval		= @FULL_schedulefreq_interval,
	@schedulefreq_subday_type	= @FULL_schedulefreq_subday_type,
	@schedulefreq_subday_interval = @FULL_schedulefreq_subday_interval,
	@scheduleactive_start_date	= @FULL_scheduleactive_start_date,
	@scheduleactive_start_time	= @FULL_scheduleactive_start_time,
	@scheduleactive_end_time	= @FULL_scheduleactive_end_time,
	@IsProductionEnvironment	= @IsProductionEnvironment

-- DIFF Backup Job --
exec DBA.[dbo].[usp_PopulateBackupJobTable]
	@BackupJob					= 'DIFF',
	@BackupDirectory			= @BackupDirectoryDIFF,  
	@CleanupTime				= @CleanupTime,		
	@BackupSoftware				= @BackupSoftware,		
	@Compress					= @Compress,		
	@BufferCount				= @BufferCount,		
	@MaxTransferSize			= @MaxTransferSize,		
	@BlockSize					= @BlockSize,	
	@OutputFileDirectory		= @OutputFileDirectory,	
	@NumOfLogFiles				= @NumOfLogFiles, 		
	@LogToTable					= @LogToTable,      	
	@CopyOnly				    = @CopyOnly,
	@schedulefreq_type			= @DIFF_schedulefreq_type, 
	@schedulefreq_interval		= @DIFF_schedulefreq_interval,
	@schedulefreq_subday_type	= @DIFF_schedulefreq_subday_type,
	@schedulefreq_subday_interval = @DIFF_schedulefreq_subday_interval,
	@scheduleactive_start_date	= @DIFF_scheduleactive_start_date,
	@scheduleactive_start_time	= @DIFF_scheduleactive_start_time,
	@scheduleactive_end_time	= @DIFF_scheduleactive_end_time,
	@IsProductionEnvironment	= @IsProductionEnvironment	

-- INCR Backup Job --
exec DBA.[dbo].[usp_PopulateBackupJobTable]
	@BackupJob					= 'INCR',
	@BackupDirectory			= @BackupDirectoryINCR,  
	@CleanupTime				= @CleanupTime,		
	@BackupSoftware				= @BackupSoftware,		
	@Compress					= @Compress,		
	@BufferCount				= @BufferCount,		
	@MaxTransferSize			= @MaxTransferSize,		
	@BlockSize					= @BlockSize,	
	@OutputFileDirectory		= @OutputFileDirectory,	
	@NumOfLogFiles				= @NumOfLogFiles, 		
	@LogToTable					= @LogToTable,      	
	@CopyOnly				    = @CopyOnly,
	@schedulefreq_type			= @INCR_schedulefreq_type, 
	@schedulefreq_interval		= @INCR_schedulefreq_interval,
	@schedulefreq_subday_type	= @INCR_schedulefreq_subday_type,
	@schedulefreq_subday_interval = @INCR_schedulefreq_subday_interval,
	@scheduleactive_start_date	= @INCR_scheduleactive_start_date,
	@scheduleactive_start_time	= @INCR_scheduleactive_start_time,
	@scheduleactive_end_time	= @INCR_scheduleactive_end_time,
	@IsProductionEnvironment	= @IsProductionEnvironment	
		

-- Execute stored procedure to create jobs --
exec DBA.[dbo].[usp_CreateBackupJob]

-- Drop table --
if exists (select TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'TJM_SystemManufacturer')
	drop table TJM_SystemManufacturer
