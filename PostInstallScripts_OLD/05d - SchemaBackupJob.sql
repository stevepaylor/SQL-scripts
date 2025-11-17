----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 144 $
----------------------------------------------------------------------------------------------------


use [DBA]

-- 1. Table to hold backup job configuration --
if not exists (select TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'BackupJob')
begin
	create table DBA.dbo.BackupJob (
		ID								int identity (1,1),
		BackupJob						varchar(50),
		BackupDirectory					varchar(500),
		CleanupTime						int,
		BackupSoftware					varchar(50),
		Compress						char(1),
		BufferCount						int,
		MaxTransferSize					int,
		BlockSize						int,
		OutputFileDirectory				varchar(50),
		NumOfLogFiles					int,
		LogToTable						char(1),
		CopyOnly						char(1),
		schedulefreq_type				int,  
		schedulefreq_interval			int, 
		schedulefreq_subday_type		int,  
		schedulefreq_subday_interval	int, 
		scheduleactive_start_date		int,
		scheduleactive_start_time		int,
		scheduleactive_end_time			int,
		IsProductionEnvironment			bit				
	)
	-- drop table dba.dbo.backupjob
	-- select * from dba.dbo.backupjob
end

-- 2. Stored procedure to populate table --
if exists (select * from INFORMATION_SCHEMA.ROUTINES where routine_name = 'usp_PopulateBackupJobTable' and ROUTINE_TYPE = 'PROCEDURE')
	drop procedure [dbo].[usp_PopulateBackupJobTable]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_PopulateBackupJobTable] (
	@BackupJob varchar(50),
	@BackupDirectory varchar(500),	
	@CleanupTime int,					
	@BackupSoftware	varchar(50),		
	@Compress char(1),					
	@BufferCount int,					
	@MaxTransferSize int,				
	@BlockSize int,						
	@OutputFileDirectory varchar(50),	
	@NumOfLogFiles int, 				
	@LogToTable	char(1),						
	@CopyOnly char(1),
	@schedulefreq_type int,  
	@schedulefreq_interval int, 
	@schedulefreq_subday_type int,  
	@schedulefreq_subday_interval int,  
	@scheduleactive_start_date int,
	@scheduleactive_start_time int,
	@scheduleactive_end_time int,
	@IsProductionEnvironment bit					
)
as 
	set nocount on

	if (@BackupDirectory Is Not Null and @IsProductionEnvironment Is Not Null )
	begin
		insert into DBA.dbo.BackupJob (BackupJob, BackupDirectory, CleanupTime, BackupSoftware, Compress, BufferCount, MaxTransferSize, BlockSize, OutputFileDirectory, NumOfLogFiles, LogToTable, CopyOnly, schedulefreq_type, schedulefreq_interval, schedulefreq_subday_type, schedulefreq_subday_interval, scheduleactive_start_date, scheduleactive_start_time, scheduleactive_end_time, IsProductionEnvironment)
		values (@BackupJob, @BackupDirectory, @CleanupTime, @BackupSoftware, @Compress, @BufferCount, @MaxTransferSize, @BlockSize, @OutputFileDirectory, @NumOfLogFiles, @LogToTable, @CopyOnly, @schedulefreq_type, @schedulefreq_interval, @schedulefreq_subday_type, @schedulefreq_subday_interval, @scheduleactive_start_date, @scheduleactive_start_time, @scheduleactive_end_time, @IsProductionEnvironment)
	end
	else
	begin
		RaisError('ERROR: Check FULL, DIFF and INCR backup directory values and @IsProductionEnvironment value.', -1,-1) With NoWait
		Return -1
	end
go


-- 3. Stored procedure to create backup jobs -- 
if exists (select * from INFORMATION_SCHEMA.ROUTINES where routine_name = 'usp_CreateBackupJob' and ROUTINE_TYPE = 'PROCEDURE')
	drop procedure [dbo].[usp_CreateBackupJob]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_CreateBackupJob]
as
	set nocount on

	DECLARE @CreateJobs				nvarchar(max)
	DECLARE @BackupDirectoryFULL	nvarchar(max)
	DECLARE @BackupDirectoryDIFF	nvarchar(max)
	DECLARE @BackupDirectoryINCR	nvarchar(max)
	DECLARE @OutputFileDirectory	nvarchar(max)
	DECLARE @LogToTable				nvarchar(max)
	DECLARE @Version				numeric(18,10)
	DECLARE @Error					int
	DECLARE @NumOfLogFiles			nvarchar(max)
	DECLARE @CleanupTimeFULL		nvarchar(max)
	DECLARE @CleanupTimeDIFF		nvarchar(max)
	DECLARE @CleanupTimeINCR		nvarchar(max)
	DECLARE @BufferCount			nvarchar(max)
	DECLARE @MaxTransferSize		nvarchar(max)
	DECLARE @BlockSize				nvarchar(max)
	DECLARE @CopyOnly				nvarchar(max)
	DECLARE @BackupSoftware			nvarchar(max)
	DECLARE @DatabaseName			nvarchar(max)
	DECLARE @Compress				nvarchar(max)
	DECLARE @Flags					int
	declare @maxID					int
	declare @FULL_schedulefreq_type				int
	declare @FULL_schedulefreq_interval			int
	declare @FULL_schedulefreq_subday_type		int
	declare @FULL_schedulefreq_subday_interval  int
	declare @FULL_scheduleactive_start_date		int
	declare @FULL_scheduleactive_start_time		int
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
	declare	@IsProductionEnvironment			bit

		
	-- Use values configured for the max ID in the DBA.dbo.BackupJob table
	select @maxID = max(ID) from DBA.dbo.BackupJob
	
	select top 1 @BackupDirectoryFULL = BackupDirectory from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc
	select top 1 @CleanupTimeFULL = CleanupTime from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc

	select top 1 @FULL_schedulefreq_type = schedulefreq_type from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc
	select top 1 @FULL_schedulefreq_interval = schedulefreq_interval from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc
	select top 1 @FULL_schedulefreq_subday_type = schedulefreq_subday_type from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc
	select top 1 @FULL_schedulefreq_subday_interval = schedulefreq_subday_interval from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc
	select top 1 @FULL_scheduleactive_start_date = scheduleactive_start_date from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc
	select top 1 @FULL_scheduleactive_start_time = scheduleactive_start_time from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc
	select top 1 @FULL_scheduleactive_end_time = scheduleactive_end_time from DBA.dbo.BackupJob where BackupJob = 'FULL' order by ID desc

	select top 1 @BackupDirectoryDIFF = BackupDirectory from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @CleanupTimeDIFF = CleanupTime from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @DIFF_schedulefreq_type = schedulefreq_type from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @DIFF_schedulefreq_interval = schedulefreq_interval from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @DIFF_schedulefreq_subday_type = schedulefreq_subday_type from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @DIFF_schedulefreq_subday_interval = schedulefreq_subday_interval from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @DIFF_scheduleactive_start_date = scheduleactive_start_date from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @DIFF_scheduleactive_start_time = scheduleactive_start_time from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc
	select top 1 @DIFF_scheduleactive_end_time = scheduleactive_end_time from DBA.dbo.BackupJob where BackupJob = 'DIFF' order by ID desc

	select top 1 @BackupDirectoryINCR = BackupDirectory from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @CleanupTimeINCR = CleanupTime from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @INCR_schedulefreq_type = schedulefreq_type from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @INCR_schedulefreq_interval = schedulefreq_interval from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @INCR_schedulefreq_subday_type = schedulefreq_subday_type from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @INCR_schedulefreq_subday_interval = schedulefreq_subday_interval from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @INCR_scheduleactive_start_date = scheduleactive_start_date from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @INCR_scheduleactive_start_time = scheduleactive_start_time from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc
	select top 1 @INCR_scheduleactive_end_time = scheduleactive_end_time from DBA.dbo.BackupJob where BackupJob = 'INCR' order by ID desc

	select @BackupSoftware = BackupSoftware from DBA.dbo.BackupJob where ID = @maxID
	select @Compress = Compress from DBA.dbo.BackupJob where ID = @maxID
	select @BufferCount = [BufferCount] from DBA.dbo.BackupJob where ID = @maxID
	select @MaxTransferSize = [MaxTransferSize] from DBA.dbo.BackupJob where ID = @maxID
	select @BlockSize = [BlockSize] from DBA.dbo.BackupJob where ID = @maxID
	select @OutputFileDirectory = OutputFileDirectory from DBA.dbo.BackupJob where ID = @maxID
	select @NumOfLogFiles = NumOfLogFiles from DBA.dbo.BackupJob where ID = @maxID
	select @LogToTable = LogToTable from DBA.dbo.BackupJob where ID = @maxID
	select @CopyOnly = CopyOnly from DBA.dbo.BackupJob where ID = @maxID
	select @IsProductionEnvironment = IsProductionEnvironment from DBA.dbo.BackupJob where ID = @maxID
	

	SET @Error = 0
	SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))
	SET @DatabaseName = DB_NAME(DB_ID())

	IF IS_SRVROLEMEMBER('sysadmin') = 0
	BEGIN
		RAISERROR('You need to be a member of the SysAdmin server role to install the solution.',16,1)
		SET @Error = @@ERROR
	END

	IF (SELECT [compatibility_level] FROM sys.databases WHERE database_id = DB_ID()) < 80
	BEGIN
		RAISERROR('The database that you are creating the objects in has to be in compatibility level 80, 90, 100, or 110.',16,1)
		SET @Error = @@ERROR
	END

	-- @Flags value is different for SQL 2012 --
	If @Version >= 11  -- SQL 2012 
		Set @Flags = 8
	Else
		Set @Flags = 12

	DECLARE @ErrorLog TABLE (LogDate datetime, ProcessInfo nvarchar(max), ErrorText nvarchar(max))

	IF @OutputFileDirectory IS NULL
	BEGIN
		INSERT INTO @ErrorLog (LogDate, ProcessInfo, ErrorText)
		EXECUTE [master].dbo.sp_readerrorlog 0

		IF @@ERROR <> 0
		BEGIN
			RAISERROR('Error reading from the error log.',16,1)
			SET @Error = @@ERROR
		END

		SELECT @OutputFileDirectory = SUBSTRING(ErrorText,38,LEN(ErrorText) - 37 - CHARINDEX('\',REVERSE(ErrorText)))
		FROM @ErrorLog
		WHERE ErrorText LIKE 'Logging SQL Server messages in file%'

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			RAISERROR('The log directory could not be found.',16,1)
			SET @Error = @@ERROR
		END
	END

	IF OBJECT_ID('[dbo].[CommandLog]') IS NULL AND OBJECT_ID('[dbo].[PK_CommandLog]') IS NULL
	BEGIN
		CREATE TABLE [dbo].[CommandLog](
		[ID] int IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CommandLog] PRIMARY KEY CLUSTERED,
		[DatabaseName] sysname NULL,
		[SchemaName] sysname NULL,
		[ObjectName] sysname NULL,
		[ObjectType] char(2) NULL,
		[IndexName] sysname NULL,
		[IndexType] tinyint NULL,
		[StatisticsName] sysname NULL,
		[PartitionNumber] int NULL,
		[ExtendedInfo] xml NULL,
		[Command] nvarchar(max) NOT NULL,
		[CommandType] nvarchar(60) NOT NULL,
		[StartTime] datetime NOT NULL,
		[EndTime] datetime NULL,
		[ErrorNumber] int NULL,
		[ErrorMessage] nvarchar(max) NULL
		)
	END

	DECLARE @TokenServer nvarchar(max)
	DECLARE @TokenJobID nvarchar(max)
	DECLARE @TokenStepID nvarchar(max)
	DECLARE @TokenDate nvarchar(max)
	DECLARE @TokenTime nvarchar(max)
	DECLARE @JobDescription nvarchar(max)
	DECLARE @JobCategory nvarchar(max)
	DECLARE @JobOwner nvarchar(max)
	DECLARE @JobName01 nvarchar(max)
	DECLARE @JobName02 nvarchar(max)
	DECLARE @JobName04 nvarchar(max)
	DECLARE @JobName10 nvarchar(max)
	DECLARE @JobName11 nvarchar(max)
	DECLARE @JobCommand01 nvarchar(max)
	DECLARE @JobCommand02 nvarchar(max)
	DECLARE @JobCommand04 nvarchar(max)
	DECLARE @JobCommand10 nvarchar(max)
	DECLARE @JobCommand11 nvarchar(max)
	DECLARE @OutputFile01 nvarchar(max)
	DECLARE @OutputFile02 nvarchar(max)
	DECLARE @OutputFile04 nvarchar(max)
	DECLARE @OutputFile10 nvarchar(max)
	DECLARE @OutputFile11 nvarchar(max)

	SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

	IF @Version >= 9.002047
	BEGIN
		SET @TokenServer = '$' + '(ESCAPE_SQUOTE(SRVR))'
		SET @TokenJobID = '$' + '(ESCAPE_SQUOTE(JOBID))'
		SET @TokenStepID = '$' + '(ESCAPE_SQUOTE(STEPID))'
		SET @TokenDate = '$' + '(ESCAPE_SQUOTE(STRTDT))'
		SET @TokenTime = '$' + '(ESCAPE_SQUOTE(STRTTM))'
	END
	ELSE
	BEGIN
		SET @TokenServer = '$' + '(SRVR)'
		SET @TokenJobID = '$' + '(JOBID)'
		SET @TokenStepID = '$' + '(STEPID)'
		SET @TokenDate = '$' + '(STRTDT)'
		SET @TokenTime = '$' + '(STRTTM)'
	END

	SET @JobDescription = 'Source: http://ola.hallengren.com'
	SET @JobCategory = 'Database Maintenance'
	SET @JobOwner = SUSER_SNAME(0x01)

	-- Create job syntax that is the same for all three backup types --
	Declare @SharedJobCommand nvarchar(max)
	Set @SharedJobCommand = 
		+ CASE WHEN @BackupSoftware IS NULL THEN ' @BackupSoftware = NULL,' ELSE ' @BackupSoftware = ''' + @BackupSoftware + ''',' END 
		+ ' @Compress  = ''' + @Compress 
		+ ''', @CopyOnly = ''' + @CopyOnly 
		+ ''', @Verify = ''N'',' 
		+ ' @CheckSum = ''Y'',' 
		+ CASE WHEN @BackupSoftware IS NOT NULL THEN ' @BufferCount = NULL,' ELSE ' @BufferCount = ' + IsNull(@BufferCount, 'NULL') + ',' END
		+ CASE WHEN @BackupSoftware IS NOT NULL THEN ' @MaxTransferSize = NULL,' ELSE ' @MaxTransferSize = ' + IsNull(@MaxTransferSize, 'NULL') + ',' END
		+ CASE WHEN @BackupSoftware IS NOT NULL THEN ' @BlockSize = NULL' ELSE ' @BlockSize = ' + IsNull(@BlockSize, 'NULL') END
		+ CASE WHEN @LogToTable = 'Y' THEN ', @LogToTable = ''Y''' ELSE '' END

	-- ** Build Job Syntax ** --
	-- Full Backup Job --
	SET @JobName01 = 'DBA - Backup FULL (All Databases)'
	SET @JobCommand01 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + @DatabaseName + ' -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''ALL_DATABASES'', @Directory = ' + ISNULL('N''' + REPLACE(@BackupDirectoryFULL,'''','''''') + '''','NULL') + ', @BackupType = ''FULL'', @CleanupTime = ' + @CleanupTimeFULL + ','
		+ @SharedJobCommand + '" -b'
	SET @OutputFile01 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + 'DatabaseBackup_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile01) > 200 SET @OutputFile01 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile01) > 200 SET @OutputFile01 = NULL

	-- Diff Backup Job --
	SET @JobName02 = 'DBA - Backup DIFF (All Databases)'
	SET @JobCommand02 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + @DatabaseName + ' -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''ALL_DATABASES'', @Directory = ' + ISNULL('N''' + REPLACE(@BackupDirectoryDIFF,'''','''''') + '''','NULL') + ', @BackupType = ''DIFF'', @CleanupTime = ' + @CleanupTimeDIFF + ','
		+ @SharedJobCommand + '" -b'
	SET @OutputFile02 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + 'DatabaseBackup_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile02) > 200 SET @OutputFile02 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile02) > 200 SET @OutputFile02 = NULL

	-- Log Backup Job --
	SET @JobName04 = 'DBA - Backup LOG (All Databases)'
	SET @JobCommand04 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + @DatabaseName + ' -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''ALL_DATABASES'', @Directory = ' + ISNULL('N''' + REPLACE(@BackupDirectoryINCR,'''','''''') + '''','NULL') + ', @BackupType = ''LOG'', @CleanupTime = ' + @CleanupTimeINCR + ','
		+ @SharedJobCommand + '" -b'
	SET @OutputFile04 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + 'DatabaseBackup_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile04) > 200 SET @OutputFile04 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile04) > 200 SET @OutputFile04 = NULL

	-- File Cleanup Job --
	SET @JobName10 = 'DBA - Output File Cleanup'
	SET @JobCommand10 = 'cmd /q /c "For /F "tokens=1 delims=" %v In (''ForFiles /P "' + @OutputFileDirectory + '" /m *_*_*_*.txt /d -' + @NumOfLogFiles + ' 2^>^&1'') do if EXIST "' + @OutputFileDirectory + '"\%v echo del "' 
						+ @OutputFileDirectory + '"\%v& del "' + @OutputFileDirectory + '"\%v"'
	SET @OutputFile10 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + 'OutputFileCleanup_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile10) > 200 SET @OutputFile10 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
	IF LEN(@OutputFile10) > 200 SET @OutputFile10 = NULL

	-- Table Cleanup Job --
	IF @LogToTable = 'Y'
	BEGIN
		SET @JobName11 = 'DBA - CommandLog Cleanup'
		SET @JobCommand11 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + @DatabaseName + ' -Q "DELETE FROM [dbo].[CommandLog] WHERE DATEDIFF(dd,StartTime,GETDATE()) > 30" -b'
		SET @OutputFile11 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + 'CommandLogCleanup_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
		IF LEN(@OutputFile11) > 200 SET @OutputFile11 = @OutputFileDirectory + CASE WHEN RIGHT(@OutputFileDirectory,1) = '\' THEN '' ELSE '\' END + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '_' + @TokenTime + '.txt'
		IF LEN(@OutputFile11) > 200 SET @OutputFile11 = NULL
	END


	-- ** Create Jobs ** --
	-- Updates job step and schedule if job already exists --

	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName01)
	BEGIN
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName01, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName01, @step_name = @JobName01, @subsystem = 'CMDEXEC', @command = @JobCommand01, @output_file_name = @OutputFile01, @flags=@Flags
		EXECUTE msdb.dbo.sp_add_jobschedule @job_name = @JobName01, @name=N'Full Schedule', @enabled=1, @freq_type=@FULL_schedulefreq_type, @freq_interval=@FULL_schedulefreq_interval, 
			@freq_subday_type=@FULL_schedulefreq_subday_type, @freq_subday_interval=@FULL_schedulefreq_subday_interval, @freq_relative_interval=0, @freq_recurrence_factor=0, 
			@active_start_date=@FULL_scheduleactive_start_date, @active_end_date=99991231, @active_start_time=@FULL_scheduleactive_start_time, @active_end_time=@FULL_scheduleactive_end_time
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName01
	END
	ELSE
	BEGIN
		EXEC msdb.dbo.sp_update_jobstep @job_name = @JobName01, @step_Name = @JobName01, @step_id = 1, @command = @JobCommand01;	
		EXEC msdb.dbo.sp_update_jobschedule @job_name = @JobName01, @name = N'Full Schedule', @freq_type=@FULL_schedulefreq_type, @freq_interval=@FULL_schedulefreq_interval, 
			@freq_subday_type=@FULL_schedulefreq_subday_type, @freq_subday_interval=@FULL_schedulefreq_subday_interval, @active_start_date=@FULL_scheduleactive_start_date, 
			@active_start_time=@FULL_scheduleactive_start_time, @active_end_time=@FULL_scheduleactive_end_time
	END

	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName02)
	BEGIN
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName02, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName02, @step_name = @JobName02, @subsystem = 'CMDEXEC', @command = @JobCommand02, @output_file_name = @OutputFile02, @flags=@Flags, @retry_attempts = 1, @retry_interval = 10
		EXECUTE msdb.dbo.sp_add_jobschedule @job_name = @JobName02, @name=N'Differential Schedule', @enabled=1, @freq_type=@DIFF_schedulefreq_type, @freq_interval=@DIFF_schedulefreq_interval,
			@freq_subday_type=@DIFF_schedulefreq_subday_type, @freq_subday_interval=@DIFF_schedulefreq_subday_interval, @freq_relative_interval=0, @freq_recurrence_factor=0, 
			@active_start_date=@DIFF_scheduleactive_start_date, @active_end_date=99991231, @active_start_time=@DIFF_scheduleactive_start_time, @active_end_time=@DIFF_scheduleactive_end_time    
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName02
	END
	ELSE
	BEGIN
		EXEC msdb.dbo.sp_update_jobstep @job_name = @JobName02, @step_Name = @JobName02, @step_id = 1, @command = @JobCommand02, @retry_attempts = 1, @retry_interval = 10;	
		EXECUTE msdb.dbo.sp_update_jobschedule @job_name = @JobName02, @name=N'Differential Schedule', @freq_type=@DIFF_schedulefreq_type, @freq_interval=@DIFF_schedulefreq_interval,
		@freq_subday_type=@DIFF_schedulefreq_subday_type, @freq_subday_interval=@DIFF_schedulefreq_subday_interval, @active_start_date=@DIFF_scheduleactive_start_date, 
		@active_start_time=@DIFF_scheduleactive_start_time, @active_end_time=@DIFF_scheduleactive_end_time  
	END

	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName04)
	BEGIN
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName04, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName04, @step_name = @JobName04, @subsystem = 'CMDEXEC', @command = @JobCommand04, @output_file_name = @OutputFile04, @flags=@Flags, @retry_attempts = 2, @retry_interval = 3
		EXECUTE msdb.dbo.sp_add_jobschedule @job_name = @JobName04, @name=N'Incremental Schedule', @enabled=1, @freq_type=@INCR_schedulefreq_type, @freq_interval=@INCR_schedulefreq_interval,
			@freq_subday_type=@INCR_schedulefreq_subday_type, @freq_subday_interval=@INCR_schedulefreq_subday_interval, @freq_relative_interval=0, @freq_recurrence_factor=0, 
			@active_start_date=@INCR_scheduleactive_start_date, @active_end_date=99991231, @active_start_time=@INCR_scheduleactive_start_time, @active_end_time=@INCR_scheduleactive_end_time
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName04
	END
	ELSE
	BEGIN
		EXEC msdb.dbo.sp_update_jobstep @job_name = @JobName04, @step_Name = @JobName04, @step_id = 1, @command = @JobCommand04, @retry_attempts = 2, @retry_interval = 3;	
		EXECUTE msdb.dbo.sp_update_jobschedule @job_name = @JobName04, @name=N'Incremental Schedule', @freq_type=@INCR_schedulefreq_type, @freq_interval=@INCR_schedulefreq_interval,
			@freq_subday_type=@INCR_schedulefreq_subday_type, @freq_subday_interval=@INCR_schedulefreq_subday_interval, @active_start_date=@INCR_scheduleactive_start_date, 
			@active_start_time=@INCR_scheduleactive_start_time, @active_end_time=@INCR_scheduleactive_end_time
	END

	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName10)
	BEGIN
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName10, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName10, @step_name = @JobName10, @subsystem = 'CMDEXEC', @command = @JobCommand10, @output_file_name = @OutputFile10, @flags=@Flags
		EXECUTE msdb.dbo.sp_add_jobschedule @job_name = @JobName10, @name=N'Cleanup Schedule', @enabled=1, @freq_type=4, @freq_interval=1, @freq_subday_type=1, 
			@freq_subday_interval=0, @freq_relative_interval=0, @freq_recurrence_factor=0, @active_start_date=20120801, @active_end_date=99991231, 
			@active_start_time=10000, @active_end_time=235959
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName10
	END

	IF @LogToTable = 'Y'
	BEGIN
		IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName11)
		BEGIN
			EXECUTE msdb.dbo.sp_add_job @job_name = @JobName11, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
			EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName11, @step_name = @JobName11, @subsystem = 'CMDEXEC', @command = @JobCommand11, @output_file_name = @OutputFile11, @flags=@Flags
			EXECUTE msdb.dbo.sp_add_jobschedule @job_name = @JobName11, @name=N'CommandLog Schedule', @enabled=1, @freq_type=4, @freq_interval=1, @freq_subday_type=1, 
				@freq_subday_interval=0, @freq_relative_interval=0, @freq_recurrence_factor=0, @active_start_date=20120801, @active_end_date=99991231, 
				@active_start_time=20000, @active_end_time=235959
			EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName11
		END
	END

go
