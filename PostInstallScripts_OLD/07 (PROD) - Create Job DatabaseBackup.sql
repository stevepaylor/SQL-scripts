/***********************************************************************************************************************************************
- OLD 5a
***********************************************************************************************************************************************/
USE [DBA] 

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'DatabaseBackup' AND ROUTINE_TYPE = 'PROCEDURE')
	DROP PROCEDURE [dbo].[DatabaseBackup]


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DatabaseBackup]

@Databases nvarchar(max),
@Directory nvarchar(max) = NULL,
@BackupType nvarchar(max),
@Verify nvarchar(max) = 'N',
@CleanupTime int = NULL,
@Compress nvarchar(max) = NULL,
@CopyOnly nvarchar(max) = 'N',
@ChangeBackupType nvarchar(max) = 'N',
@BackupSoftware nvarchar(max) = NULL,
@CheckSum nvarchar(max) = 'N',
@BlockSize int = NULL,
@BufferCount int = NULL,
@MaxTransferSize int = NULL,
@NumberOfFiles int = NULL,
@CompressionLevel int = NULL,
@Description nvarchar(max) = NULL,
@Threads int = NULL,
@Throttle int = NULL,
@Encrypt nvarchar(max) = 'N',
@EncryptionType nvarchar(max) = NULL,
@EncryptionKey nvarchar(max) = NULL,
@ReadWriteFileGroups nvarchar(max) = 'N',
@LogToTable nvarchar(max) = 'N',
@Execute nvarchar(max) = 'Y'

AS

BEGIN

  ----------------------------------------------------------------------------------------------------
  --// Source: http://ola.hallengren.com                                                          //--
  ----------------------------------------------------------------------------------------------------
  -- Revision      $Revision: 6 $
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  DECLARE @StartMessage nvarchar(max)
  DECLARE @EndMessage nvarchar(max)
  DECLARE @DatabaseMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)

  DECLARE @Version numeric(18,10)

  DECLARE @Cluster nvarchar(max)

  DECLARE @DefaultDirectory nvarchar(4000)

  DECLARE @CurrentRootDirectoryID int
  DECLARE @CurrentRootDirectoryPath nvarchar(4000)

  DECLARE @CurrentDBID int
  DECLARE @CurrentDatabaseID int
  DECLARE @CurrentDatabaseName nvarchar(max)
  DECLARE @CurrentBackupType nvarchar(max)
  DECLARE @CurrentFileExtension nvarchar(max)
  DECLARE @CurrentFileNumber int
  DECLARE @CurrentDifferentialBaseLSN numeric(25,0)
  DECLARE @CurrentDifferentialBaseIsSnapshot bit
  DECLARE @CurrentLogLSN numeric(25,0)
  DECLARE @CurrentLatestBackup datetime
  DECLARE @CurrentDatabaseNameFS nvarchar(max)
  DECLARE @CurrentDirectoryID int
  DECLARE @CurrentDirectoryPath nvarchar(max)
  DECLARE @CurrentFilePath nvarchar(max)
  DECLARE @CurrentDate datetime
  DECLARE @CurrentCleanupDate datetime
  DECLARE @CurrentIsDatabaseAccessible bit
  DECLARE @CurrentAvailabilityGroup nvarchar(max)
  DECLARE @CurrentAvailabilityGroupRole nvarchar(max)
  DECLARE @CurrentIsPreferredBackupReplica bit
  DECLARE @CurrentDatabaseMirroringRole nvarchar(max)
  DECLARE @CurrentLogShippingRole nvarchar(max)

  DECLARE @CurrentCommand01 nvarchar(max)
  DECLARE @CurrentCommand02 nvarchar(max)
  DECLARE @CurrentCommand03 nvarchar(max)
  DECLARE @CurrentCommand04 nvarchar(max)

  DECLARE @CurrentCommandOutput01 int
  DECLARE @CurrentCommandOutput02 int
  DECLARE @CurrentCommandOutput03 int
  DECLARE @CurrentCommandOutput04 int

  DECLARE @CurrentCommandType01 nvarchar(max)
  DECLARE @CurrentCommandType02 nvarchar(max)
  DECLARE @CurrentCommandType03 nvarchar(max)
  DECLARE @CurrentCommandType04 nvarchar(max)

  DECLARE @Directories TABLE (ID int PRIMARY KEY,
                              DirectoryPath nvarchar(max),
                              Completed bit)

  DECLARE @DirectoryInfo TABLE (FileExists bit,
                                FileIsADirectory bit,
                                ParentDirectoryExists bit)

  DECLARE @tmpDatabases TABLE (ID int IDENTITY,
                               DatabaseName nvarchar(max),
                               DatabaseNameFS nvarchar(max),
                               DatabaseType nvarchar(max),
                               Selected bit,
                               Completed bit,
                               PRIMARY KEY(Selected, Completed, ID))

  DECLARE @SelectedDatabases TABLE (DatabaseName nvarchar(max),
                                    DatabaseType nvarchar(max),
                                    Selected bit)

  DECLARE @CurrentDirectories TABLE (ID int PRIMARY KEY,
                                     DirectoryPath nvarchar(max),
                                     CreateCompleted bit,
                                     CleanupCompleted bit,
                                     CreateOutput int,
                                     CleanupOutput int)

  DECLARE @CurrentFiles TABLE (CurrentFilePath nvarchar(max))

  DECLARE @Error int
  DECLARE @ReturnCode int

  SET @Error = 0
  SET @ReturnCode = 0

  SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))
    
  -- Added by JM 4/15 --
  Declare @ReadOnlyNeedsBackup Bit
  Set @ReadOnlyNeedsBackup = 0
  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Procedure: ' + QUOTENAME(DB_NAME(DB_ID())) + '.' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + '.' + QUOTENAME(OBJECT_NAME(@@PROCID)) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Parameters: @Databases = ' + ISNULL('''' + REPLACE(@Databases,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @Directory = ' + ISNULL('''' + REPLACE(@Directory,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @BackupType = ' + ISNULL('''' + REPLACE(@BackupType,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @Verify = ' + ISNULL('''' + REPLACE(@Verify,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @CleanupTime = ' + ISNULL(CAST(@CleanupTime AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @Compress = ' + ISNULL('''' + REPLACE(@Compress,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @CopyOnly = ' + ISNULL('''' + REPLACE(@CopyOnly,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @ChangeBackupType = ' + ISNULL('''' + REPLACE(@ChangeBackupType,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @BackupSoftware = ' + ISNULL('''' + REPLACE(@BackupSoftware,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @CheckSum = ' + ISNULL('''' + REPLACE(@CheckSum,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @BlockSize = ' + ISNULL(CAST(@BlockSize AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @BufferCount = ' + ISNULL(CAST(@BufferCount AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @MaxTransferSize = ' + ISNULL(CAST(@MaxTransferSize AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @NumberOfFiles = ' + ISNULL(CAST(@NumberOfFiles AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @CompressionLevel = ' + ISNULL(CAST(@CompressionLevel AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @Description = ' + ISNULL('''' + REPLACE(@Description,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @Threads = ' + ISNULL(CAST(@Threads AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @Throttle = ' + ISNULL(CAST(@Throttle AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @Encrypt = ' + ISNULL('''' + REPLACE(@Encrypt,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @EncryptionType = ' + ISNULL('''' + REPLACE(@EncryptionType,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @EncryptionKey = ' + ISNULL('''' + REPLACE(@EncryptionKey,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @ReadWriteFileGroups = ' + ISNULL('''' + REPLACE(@ReadWriteFileGroups,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @LogToTable = ' + ISNULL('''' + REPLACE(@LogToTable,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @Execute = ' + ISNULL('''' + REPLACE(@Execute,'''','''''') + '''','NULL') + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Source: http://ola.hallengren.com' + CHAR(13) + CHAR(10)
  SET @StartMessage = REPLACE(@StartMessage,'%','%%') + ' '
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute is missing. Download http://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute' AND OBJECT_DEFINITION(objects.[object_id]) NOT LIKE '%@LogToTable%')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute needs to be updated. Download http://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download http://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ReturnCode = @Error
    GOTO Logging
  END;

  ----------------------------------------------------------------------------------------------------
  --// Select databases                                                                           //--
  ----------------------------------------------------------------------------------------------------

  WITH Databases1 (DatabaseItems) AS
  (
  SELECT REPLACE(@Databases, ', ', ',') AS DatabaseItems
  ),
  Databases2 (DatabaseItem, String, [Continue]) AS
  (
  SELECT CASE WHEN CHARINDEX(',', DatabaseItems) = 0 THEN @Databases ELSE SUBSTRING(DatabaseItems, 1, CHARINDEX(',', DatabaseItems) - 1) END AS DatabaseItem,
         CASE WHEN CHARINDEX(',', DatabaseItems) = 0 THEN '' ELSE SUBSTRING(DatabaseItems, CHARINDEX(',', DatabaseItems) + 1, LEN(DatabaseItems)) END AS String,
         CASE WHEN CHARINDEX(',', DatabaseItems) = 0 THEN 0 ELSE 1 END [Continue]
  FROM Databases1
  WHERE @Databases IS NOT NULL
  UNION ALL
  SELECT CASE WHEN CHARINDEX(',', String) = 0 THEN String ELSE SUBSTRING(String, 1, CHARINDEX(',', String) - 1) END AS DatabaseItem,
         CASE WHEN CHARINDEX(',', String) = 0 THEN '' ELSE SUBSTRING(String, CHARINDEX(',', String) + 1, LEN(String)) END AS String,
         CASE WHEN CHARINDEX(',', String) = 0 THEN 0 ELSE 1 END [Continue]
  FROM Databases2
  WHERE [Continue] = 1
  ),
  Databases3 (DatabaseItem, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem LIKE '-%' THEN RIGHT(DatabaseItem,LEN(DatabaseItem) - 1) ELSE DatabaseItem END AS DatabaseItem,
         CASE WHEN DatabaseItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Databases2
  ),
  Databases4 (DatabaseItem, DatabaseType, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem IN('ALL_DATABASES','SYSTEM_DATABASES','USER_DATABASES') THEN '%' ELSE DatabaseItem END AS DatabaseItem,
         CASE WHEN DatabaseItem = 'SYSTEM_DATABASES' THEN 'S' WHEN DatabaseItem = 'USER_DATABASES' THEN 'U' ELSE NULL END AS DatabaseType,
         Selected
  FROM Databases3
  ),
  Databases5 (DatabaseName, DatabaseType, Selected) AS
  (
  SELECT CASE WHEN LEFT(DatabaseItem,1) = '[' AND RIGHT(DatabaseItem,1) = ']' THEN PARSENAME(DatabaseItem,1) ELSE DatabaseItem END AS DatabaseItem,
         DatabaseType,
         Selected
  FROM Databases4
  )
  INSERT INTO @SelectedDatabases (DatabaseName, DatabaseType, Selected)
  SELECT DatabaseName,
         DatabaseType,
         Selected
  FROM Databases5

  INSERT INTO @tmpDatabases (DatabaseName, DatabaseNameFS, DatabaseType, Selected, Completed)
  SELECT [name] AS DatabaseName,
         REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([name],'\',''),'/',''),':',''),'*',''),'?',''),'"',''),'<',''),'>',''),'|',''),' ','') AS DatabaseNameFS,
         CASE WHEN name IN('master','msdb','model') THEN 'S' ELSE 'U' END AS DatabaseType,
         0 AS Selected,
         0 AS Completed
  FROM sys.databases
  WHERE [name] <> 'tempdb'
  AND source_database_id IS NULL
  ORDER BY [name] ASC

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  WHERE SelectedDatabases.Selected = 1

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  WHERE SelectedDatabases.Selected = 0

  IF @Databases IS NULL OR NOT EXISTS(SELECT * FROM @SelectedDatabases) OR EXISTS(SELECT * FROM @SelectedDatabases WHERE DatabaseName IS NULL OR DatabaseName = '')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Databases is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END;

  ----------------------------------------------------------------------------------------------------
  --// Check database names                                                                       //--
  ----------------------------------------------------------------------------------------------------

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @tmpDatabases
  WHERE Selected = 1
  AND DatabaseNameFS = ''
  ORDER BY DatabaseName ASC
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The names of the following databases are not supported: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @tmpDatabases
  WHERE UPPER(DatabaseNameFS) IN(SELECT UPPER(DatabaseNameFS) FROM @tmpDatabases GROUP BY UPPER(DatabaseNameFS) HAVING COUNT(*) > 1)
  AND UPPER(DatabaseNameFS) IN(SELECT UPPER(DatabaseNameFS) FROM @tmpDatabases WHERE Selected = 1)
  AND DatabaseNameFS <> ''
  ORDER BY DatabaseName ASC
  OPTION (RECOMPILE)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The names of the following databases are not unique in the file system: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select directories                                                                         //--
  ----------------------------------------------------------------------------------------------------

  IF @Directory IS NULL
  BEGIN
    EXECUTE [master].dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', N'BackupDirectory', @DefaultDirectory OUTPUT

    INSERT INTO @Directories (ID, DirectoryPath, Completed)
    SELECT 1, @DefaultDirectory, 0
  END
  ELSE
  BEGIN
    WITH Directory AS
    (
    SELECT REPLACE(@Directory, ', ', ',') AS DirectoryName
    ),
    Directories AS
    (
    SELECT CASE WHEN CHARINDEX(',', DirectoryName) = 0 THEN DirectoryName ELSE SUBSTRING(DirectoryName, 1, CHARINDEX(',', DirectoryName) - 1) END AS Directory,
           CASE WHEN CHARINDEX(',', DirectoryName) = 0 THEN '' ELSE SUBSTRING(DirectoryName, CHARINDEX(',', DirectoryName) + 1, LEN(DirectoryName)) END AS String,
           1 AS [ID],
         CASE WHEN CHARINDEX(',', DirectoryName) = 0 THEN 0 ELSE 1 END [Continue]
    FROM Directory
    UNION ALL
    SELECT CASE WHEN CHARINDEX(',', String) = 0 THEN String ELSE SUBSTRING(String, 1, CHARINDEX(',', String) - 1) END AS Directory,
           CASE WHEN CHARINDEX(',', String) = 0 THEN '' ELSE SUBSTRING(String, CHARINDEX(',', String) + 1, LEN(String)) END AS String,
           [ID] + 1  AS [ID],
           CASE WHEN CHARINDEX(',', String) = 0 THEN 0 ELSE 1 END [Continue]
    FROM Directories
    WHERE [Continue] = 1
    )
    INSERT INTO @Directories (ID, DirectoryPath, Completed)
    SELECT ID, Directory, 0
    FROM Directories
  END

  ----------------------------------------------------------------------------------------------------
  --// Check directories                                                                          //--
  ----------------------------------------------------------------------------------------------------

  IF EXISTS(SELECT * FROM @Directories WHERE NOT (DirectoryPath LIKE '_:' OR DirectoryPath LIKE '_:\%' OR DirectoryPath LIKE '\\%\%') OR DirectoryPath IS NULL OR LEFT(DirectoryPath,1) = ' ' OR RIGHT(DirectoryPath,1) = ' ') OR EXISTS (SELECT * FROM @Directories GROUP BY DirectoryPath HAVING COUNT(*) <> 1)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Directory is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END
  ELSE
  BEGIN
    WHILE EXISTS(SELECT * FROM @Directories WHERE Completed = 0)
    BEGIN
      SELECT TOP 1 @CurrentRootDirectoryID = ID,
                   @CurrentRootDirectoryPath = DirectoryPath
      FROM @Directories
      WHERE Completed = 0
      ORDER BY ID ASC

      INSERT INTO @DirectoryInfo (FileExists, FileIsADirectory, ParentDirectoryExists)
      EXECUTE [master].dbo.xp_fileexist @CurrentRootDirectoryPath

      IF NOT EXISTS (SELECT * FROM @DirectoryInfo WHERE FileExists = 0 AND FileIsADirectory = 1 AND ParentDirectoryExists = 1)
      BEGIN
        SET @ErrorMessage = 'The directory ' + @CurrentRootDirectoryPath + ' does not exist.' + CHAR(13) + CHAR(10) + ' '
        RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
        SET @Error = @@ERROR
      END

      UPDATE @Directories
      SET Completed = 1
      WHERE ID = @CurrentRootDirectoryID

      SET @CurrentRootDirectoryID = NULL
      SET @CurrentRootDirectoryPath = NULL

      DELETE FROM @DirectoryInfo
    END
  END

  ----------------------------------------------------------------------------------------------------
  --// Get default compression                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF @Compress IS NULL
  BEGIN
    SELECT @Compress = CASE
    WHEN @BackupSoftware IS NULL AND EXISTS(SELECT * FROM sys.configurations WHERE name = 'backup compression default' AND value_in_use = 1) THEN 'Y'
    WHEN @BackupSoftware IS NULL AND NOT EXISTS(SELECT * FROM sys.configurations WHERE name = 'backup compression default' AND value_in_use = 1) THEN 'N'
    WHEN @BackupSoftware IS NOT NULL AND (@CompressionLevel IS NULL OR @CompressionLevel > 0)  THEN 'Y'
    WHEN @BackupSoftware IS NOT NULL AND @CompressionLevel = 0  THEN 'N'
    END
  END

  ----------------------------------------------------------------------------------------------------
  --// Get number of files                                                                        //--
  ----------------------------------------------------------------------------------------------------

  IF @NumberOfFiles IS NULL
  BEGIN
    SELECT @NumberOfFiles = (SELECT COUNT(*) FROM @Directories)
  END

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF @BackupType NOT IN ('FULL','DIFF','LOG') OR @BackupType IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BackupType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Verify NOT IN ('Y','N') OR @Verify IS NULL OR (@BackupSoftware = 'SQLSAFE' AND @Encrypt = 'Y' AND @Verify = 'Y')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Verify is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupTime < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupTime is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Compress NOT IN ('Y','N') OR @Compress IS NULL OR (@Compress = 'Y' AND @BackupSoftware IS NULL AND NOT ((@Version >= 10 AND @Version < 10.5 AND SERVERPROPERTY('EngineEdition') = 3) OR (@Version >= 10.5 AND (SERVERPROPERTY('EngineEdition') = 3 OR SERVERPROPERTY('EditionID') IN (-1534726760, 284895786))))) OR (@Compress = 'N' AND @BackupSoftware IS NOT NULL AND (@CompressionLevel IS NULL OR @CompressionLevel >= 1)) OR (@Compress = 'Y' AND @BackupSoftware IS NOT NULL AND @CompressionLevel = 0)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Compress is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CopyOnly NOT IN ('Y','N') OR @CopyOnly IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CopyOnly is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @ChangeBackupType NOT IN ('Y','N') OR @ChangeBackupType IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ChangeBackupType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware NOT IN ('LITESPEED','SQLBACKUP','HYPERBAC','SQLSAFE')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BackupSoftware is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware = 'LITESPEED' AND NOT EXISTS (SELECT * FROM [master].sys.objects WHERE [type] = 'X' AND [name] = 'xp_backup_database')
  BEGIN
    SET @ErrorMessage = 'NetVault LiteSpeed for SQL Server is not installed. Download http://www.quest.com/litespeed-for-sql-server/.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware = 'SQLBACKUP' AND NOT EXISTS (SELECT * FROM [master].sys.objects WHERE [type] = 'X' AND [name] = 'sqlbackup')
  BEGIN
    SET @ErrorMessage = 'Red Gate SQL Backup is not installed. Download http://www.red-gate.com/products/dba/sql-backup/.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware = 'SQLSAFE' AND NOT EXISTS (SELECT * FROM [master].sys.objects WHERE [type] = 'X' AND [name] = 'xp_ss_backup')
  BEGIN
    SET @ErrorMessage = 'Idera SQL safe backup is not installed. Download http://www.idera.com/Products/SQL-Server/SQL-safe-backup/.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CheckSum NOT IN ('Y','N') OR @CheckSum IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CheckSum is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BlockSize NOT IN (512,1024,2048,4096,8192,16384,32768,65536) OR (@BlockSize IS NOT NULL AND @BackupSoftware = 'SQLBACKUP') OR (@BlockSize IS NOT NULL AND @BackupSoftware = 'SQLSAFE')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BlockSize is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BufferCount <= 0 OR @BufferCount > 2147483647 OR (@BufferCount IS NOT NULL AND @BackupSoftware = 'SQLBACKUP') OR (@BufferCount IS NOT NULL AND @BackupSoftware = 'SQLSAFE')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BufferCount is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxTransferSize < 65536 OR @MaxTransferSize > 4194304 OR @MaxTransferSize % 65536 > 0 OR (@MaxTransferSize > 1048576 AND @BackupSoftware = 'SQLBACKUP') OR (@MaxTransferSize IS NOT NULL AND @BackupSoftware = 'SQLSAFE')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MaxTransferSize is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @NumberOfFiles < 1 OR @NumberOfFiles > 64 OR (@NumberOfFiles > 32 AND @BackupSoftware = 'SQLBACKUP') OR @NumberOfFiles IS NULL OR @NumberOfFiles < (SELECT COUNT(*) FROM @Directories) OR @NumberOfFiles % (SELECT COUNT(*) FROM @Directories) > 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @NumberOfFiles is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@BackupSoftware IS NULL AND @CompressionLevel IS NOT NULL) OR (@BackupSoftware = 'HYPERBAC' AND @CompressionLevel IS NOT NULL) OR (@BackupSoftware = 'LITESPEED' AND (@CompressionLevel < 0 OR @CompressionLevel > 8)) OR (@BackupSoftware = 'SQLBACKUP' AND (@CompressionLevel < 0 OR @CompressionLevel > 4)) OR (@BackupSoftware = 'SQLSAFE' AND (@CompressionLevel < 1 OR @CompressionLevel > 4))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CompressionLevel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF LEN(@Description) > 255 OR (@BackupSoftware = 'LITESPEED' AND LEN(@Description) > 128)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Description is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Threads IS NOT NULL AND (@BackupSoftware NOT IN('LITESPEED','SQLBACKUP','SQLSAFE') OR @BackupSoftware IS NULL) OR @Threads < 2 OR @Threads > 32
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Threads is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Throttle IS NOT NULL AND (@BackupSoftware NOT IN('LITESPEED') OR @BackupSoftware IS NULL) OR @Throttle < 1 OR @Throttle > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Throttle is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Encrypt NOT IN('Y','N') OR @Encrypt IS NULL OR (@Encrypt = 'Y' AND @BackupSoftware IS NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Encrypt is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@EncryptionType IS NOT NULL AND @BackupSoftware IS NULL) OR (@EncryptionType IS NOT NULL AND @BackupSoftware = 'HYPERBAC') OR (@EncryptionType IS NOT NULL AND @Encrypt = 'N') OR ((@EncryptionType NOT IN('RC2-40','RC2-56','RC2-112','RC2-128','3DES-168','RC4-128','AES-128','AES-192','AES-256') OR @EncryptionType IS NULL) AND @Encrypt = 'Y' AND @BackupSoftware = 'LITESPEED') OR ((@EncryptionType NOT IN('AES-128','AES-256') OR @EncryptionType IS NULL) AND @Encrypt = 'Y' AND @BackupSoftware = 'SQLBACKUP') OR ((@EncryptionType NOT IN('AES-128','AES-256') OR @EncryptionType IS NULL) AND @Encrypt = 'Y' AND @BackupSoftware = 'SQLSAFE')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @EncryptionType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@EncryptionKey IS NOT NULL AND @BackupSoftware IS NULL) OR (@EncryptionKey IS NOT NULL AND @BackupSoftware = 'HYPERBAC') OR (@EncryptionKey IS NOT NULL AND @Encrypt = 'N') OR (@EncryptionKey IS NULL AND @Encrypt = 'Y' AND @BackupSoftware IN('LITESPEED','SQLBACKUP','SQLSAFE'))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @EncryptionKey is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @ReadWriteFileGroups NOT IN('Y','N') OR @ReadWriteFileGroups IS NULL OR (@ReadWriteFileGroups = 'Y' AND @BackupType = 'LOG')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ReadWriteFileGroups is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ErrorMessage = 'The documentation is available at http://ola.hallengren.com/sql-server-backup.html.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @ReturnCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Check Availability Group cluster name                                                      //--
  ----------------------------------------------------------------------------------------------------

  IF @Version >= 11
  BEGIN
    SELECT @Cluster = cluster_name
    FROM sys.dm_hadr_cluster
  END

  ----------------------------------------------------------------------------------------------------
  --// Execute backup commands                                                                    //--
  ----------------------------------------------------------------------------------------------------

  WHILE EXISTS (SELECT * FROM @tmpDatabases WHERE Selected = 1 AND Completed = 0)
  BEGIN

    SELECT TOP 1 @CurrentDBID = ID,
                 @CurrentDatabaseName = DatabaseName,
                 @CurrentDatabaseNameFS = DatabaseNameFS
    FROM @tmpDatabases
    WHERE Selected = 1
    AND Completed = 0
    ORDER BY ID ASC

    SET @CurrentDatabaseID = DB_ID(@CurrentDatabaseName)

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    BEGIN
      IF EXISTS (SELECT * FROM sys.database_recovery_status WHERE database_id = @CurrentDatabaseID AND database_guid IS NOT NULL)
      BEGIN
        SET @CurrentIsDatabaseAccessible = 1
      END
      ELSE
      BEGIN
        SET @CurrentIsDatabaseAccessible = 0
      END
    END
    ELSE
    BEGIN
      SET @CurrentIsDatabaseAccessible = 0
    END

    SELECT @CurrentDifferentialBaseLSN = differential_base_lsn
    FROM sys.master_files
    WHERE database_id = @CurrentDatabaseID
    AND [type] = 0
    AND [file_id] = 1

    -- Workaround for a bug in SQL Server 2005
    IF @Version >= 9 AND @Version < 10
    AND EXISTS(SELECT * FROM sys.master_files WHERE database_id = @CurrentDatabaseID AND [type] = 0 AND [file_id] = 1 AND differential_base_lsn IS NOT NULL AND differential_base_guid IS NOT NULL AND differential_base_time IS NULL)
    BEGIN
      SET @CurrentDifferentialBaseLSN = NULL
    END

    SELECT @CurrentDifferentialBaseIsSnapshot = is_snapshot
    FROM msdb.dbo.backupset
    WHERE database_name = @CurrentDatabaseName
    AND [type] = 'D'
    AND checkpoint_lsn = @CurrentDifferentialBaseLSN

	-- If database is ready only and last full backup is older than 21 days then a backup is needed. Added by JM 4/15 --
	If (DATABASEPROPERTYEX(@CurrentDatabaseName,'Updateability') = 'READ_ONLY') 
	Begin
		-- If no backup has ever been taken then value is set to 99 so backup with be executed
		If (Select ISNULL(STR(ABS(DATEDIFF(day, GetDate(),MAX(backup_finish_date)))), '99') From msdb.dbo.backupset Where database_name = @CurrentDatabaseName and type = 'D') > 21
		Begin
			-- Backup is needed
			Set @ReadOnlyNeedsBackup = 1
		End
		Else
		Begin
			-- Backup is not needed
			Set @ReadOnlyNeedsBackup = 0
		End
	End

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    BEGIN
      SELECT @CurrentLogLSN = last_log_backup_lsn
      FROM sys.database_recovery_status
      WHERE database_id = @CurrentDatabaseID
    END

    SET @CurrentBackupType = @BackupType

    IF @ChangeBackupType = 'Y'
    BEGIN
      IF @CurrentBackupType = 'LOG' AND DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') <> 'SIMPLE' AND @CurrentLogLSN IS NULL AND @CurrentDatabaseName <> 'master'
      BEGIN
        SET @CurrentBackupType = 'DIFF'
      END
      IF @CurrentBackupType = 'DIFF' AND @CurrentDifferentialBaseLSN IS NULL AND @CurrentDatabaseName <> 'master'
      BEGIN
        SET @CurrentBackupType = 'FULL'
      END
    END

    IF @CurrentBackupType = 'LOG'
    BEGIN
      SELECT @CurrentLatestBackup = MAX(backup_finish_date)
      FROM msdb.dbo.backupset
      WHERE [type] IN('D','I')
      AND is_damaged = 0
      AND database_name = @CurrentDatabaseName
    END

    IF @Version >= 11 AND @Cluster IS NOT NULL
    BEGIN
      SELECT @CurrentAvailabilityGroup = availability_groups.name,
             @CurrentAvailabilityGroupRole = dm_hadr_availability_replica_states.role_desc
      FROM sys.databases databases
      INNER JOIN sys.availability_databases_cluster availability_databases_cluster ON databases.group_database_id = availability_databases_cluster.group_database_id
      INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
      INNER JOIN sys.dm_hadr_availability_replica_states dm_hadr_availability_replica_states ON availability_groups.group_id = dm_hadr_availability_replica_states.group_id AND databases.replica_id = dm_hadr_availability_replica_states.replica_id
      WHERE databases.name = @CurrentDatabaseName
    END

    IF @Version >= 11 AND @Cluster IS NOT NULL AND @CurrentAvailabilityGroup IS NOT NULL
    BEGIN
      SELECT @CurrentIsPreferredBackupReplica = sys.fn_hadr_backup_is_preferred_replica(@CurrentDatabaseName)
    END

    SELECT @CurrentDatabaseMirroringRole = UPPER(mirroring_role_desc)
    FROM sys.database_mirroring
    WHERE database_id = @CurrentDatabaseID

    IF EXISTS (SELECT * FROM msdb.dbo.log_shipping_primary_databases WHERE primary_database = @CurrentDatabaseName)
    BEGIN
      SET @CurrentLogShippingRole = 'PRIMARY'
    END
    ELSE
    IF EXISTS (SELECT * FROM msdb.dbo.log_shipping_secondary_databases WHERE secondary_database = @CurrentDatabaseName)
    BEGIN
      SET @CurrentLogShippingRole = 'SECONDARY'
    END

    -- Set database message
    SET @DatabaseMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Database: ' + QUOTENAME(@CurrentDatabaseName) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Status: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') AS nvarchar) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Standby: ' + CASE WHEN DATABASEPROPERTYEX(@CurrentDatabaseName,'IsInStandBy') = 1 THEN 'Yes' ELSE 'No' END + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Updateability: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Updateability') AS nvarchar) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'User access: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'UserAccess') AS nvarchar) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Is accessible: ' + CASE WHEN @CurrentIsDatabaseAccessible = 1 THEN 'Yes' ELSE 'No' END + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Recovery model: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') AS nvarchar) + CHAR(13) + CHAR(10)
    IF @CurrentAvailabilityGroup IS NOT NULL SET @DatabaseMessage = @DatabaseMessage + 'Availability group: ' + @CurrentAvailabilityGroup + CHAR(13) + CHAR(10)
    IF @CurrentAvailabilityGroup IS NOT NULL SET @DatabaseMessage = @DatabaseMessage + 'Availability group role: ' + @CurrentAvailabilityGroupRole + CHAR(13) + CHAR(10)
    IF @CurrentAvailabilityGroup IS NOT NULL SET @DatabaseMessage = @DatabaseMessage + 'Is preferred backup replica: ' + CASE WHEN @CurrentIsPreferredBackupReplica = 1 THEN 'Yes' WHEN @CurrentIsPreferredBackupReplica = 0 THEN 'No' ELSE 'N/A' END + CHAR(13) + CHAR(10)
    IF @CurrentDatabaseMirroringRole IS NOT NULL SET @DatabaseMessage = @DatabaseMessage + 'Database mirroring role: ' + @CurrentDatabaseMirroringRole + CHAR(13) + CHAR(10)
    IF @CurrentLogShippingRole IS NOT NULL SET @DatabaseMessage = @DatabaseMessage + 'Log shipping role: ' + @CurrentLogShippingRole + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Differential base LSN: ' + ISNULL(CAST(@CurrentDifferentialBaseLSN AS nvarchar),'N/A') + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Differential base is snapshot: ' + CASE WHEN @CurrentDifferentialBaseIsSnapshot = 1 THEN 'Yes' WHEN @CurrentDifferentialBaseIsSnapshot = 0 THEN 'No' ELSE 'N/A' END + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Last log backup LSN: ' + ISNULL(CAST(@CurrentLogLSN AS nvarchar),'N/A') + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = REPLACE(@DatabaseMessage,'%','%%') + ' '
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

	-- Backup read-only databases if @ReadOnlyNeedsBackup = 1. Added by JM 4/15 --
    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    AND NOT (DATABASEPROPERTYEX(@CurrentDatabaseName,'UserAccess') = 'SINGLE_USER' AND @CurrentIsDatabaseAccessible = 0)
    AND DATABASEPROPERTYEX(@CurrentDatabaseName,'IsInStandBy') = 0
    AND NOT (@CurrentBackupType = 'LOG' AND (DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') = 'SIMPLE' OR @CurrentLogLSN IS NULL))
    AND NOT (@CurrentBackupType = 'DIFF' AND @CurrentDifferentialBaseLSN IS NULL)
    AND NOT (@CurrentBackupType IN('DIFF','LOG') AND @CurrentDatabaseName = 'master')
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'FULL' AND @CopyOnly = 'N' AND (@CurrentAvailabilityGroupRole <> 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL))
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'FULL' AND @CopyOnly = 'Y' AND (@CurrentIsPreferredBackupReplica <> 1 OR @CurrentIsPreferredBackupReplica IS NULL))
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'DIFF' AND (@CurrentAvailabilityGroupRole <> 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL))
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'LOG' AND @CopyOnly = 'N' AND (@CurrentIsPreferredBackupReplica <> 1 OR @CurrentIsPreferredBackupReplica IS NULL))
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'LOG' AND @CopyOnly = 'Y' AND (@CurrentAvailabilityGroupRole <> 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL))
    AND NOT ((@CurrentLogShippingRole = 'PRIMARY' AND @CurrentLogShippingRole IS NOT NULL) AND @CurrentBackupType = 'LOG')
	and (DATABASEPROPERTYEX(@CurrentDatabaseName,'Updateability') = 'READ_WRITE' 
	or DATABASEPROPERTYEX(@CurrentDatabaseName,'Updateability') = 'READ_ONLY' and @ReadOnlyNeedsBackup = 1)
    BEGIN

      -- Set variables
      SET @CurrentDate = GETDATE()

      IF @CleanupTime IS NULL OR (@CurrentBackupType = 'LOG' AND @CurrentLatestBackup IS NULL) OR @CurrentBackupType <> @BackupType
      BEGIN
        SET @CurrentCleanupDate = NULL
      END
      ELSE
      IF @CurrentBackupType = 'LOG'
      BEGIN
        SET @CurrentCleanupDate = (SELECT MIN([Date]) FROM(SELECT DATEADD(hh,-(@CleanupTime),@CurrentDate) AS [Date] UNION SELECT @CurrentLatestBackup AS [Date]) Dates)
      END
      ELSE
      BEGIN
        SET @CurrentCleanupDate = DATEADD(hh,-(@CleanupTime),@CurrentDate)
      END

      SELECT @CurrentFileExtension = CASE
      WHEN @BackupSoftware IS NULL AND @CurrentBackupType = 'FULL' THEN 'bak'
      WHEN @BackupSoftware IS NULL AND @CurrentBackupType = 'DIFF' THEN 'bak'
      WHEN @BackupSoftware IS NULL AND @CurrentBackupType = 'LOG' THEN 'trn'
      WHEN @BackupSoftware = 'LITESPEED' AND @CurrentBackupType = 'FULL' THEN 'bak'
      WHEN @BackupSoftware = 'LITESPEED' AND @CurrentBackupType = 'DIFF' THEN 'bak'
      WHEN @BackupSoftware = 'LITESPEED' AND @CurrentBackupType = 'LOG' THEN 'trn'
      WHEN @BackupSoftware = 'SQLBACKUP' AND @CurrentBackupType = 'FULL' THEN 'sqb'
      WHEN @BackupSoftware = 'SQLBACKUP' AND @CurrentBackupType = 'DIFF' THEN 'sqb'
      WHEN @BackupSoftware = 'SQLBACKUP' AND @CurrentBackupType = 'LOG' THEN 'sqb'
      WHEN @BackupSoftware = 'HYPERBAC' AND @CurrentBackupType = 'FULL' AND @Encrypt = 'N' THEN 'hbc'
      WHEN @BackupSoftware = 'HYPERBAC' AND @CurrentBackupType = 'DIFF' AND @Encrypt = 'N' THEN 'hbc'
      WHEN @BackupSoftware = 'HYPERBAC' AND @CurrentBackupType = 'LOG' AND @Encrypt = 'N' THEN 'hbc'
      WHEN @BackupSoftware = 'HYPERBAC' AND @CurrentBackupType = 'FULL' AND @Encrypt = 'Y' THEN 'hbe'
      WHEN @BackupSoftware = 'HYPERBAC' AND @CurrentBackupType = 'DIFF' AND @Encrypt = 'Y' THEN 'hbe'
      WHEN @BackupSoftware = 'HYPERBAC' AND @CurrentBackupType = 'LOG' AND @Encrypt = 'Y' THEN 'hbe'
      WHEN @BackupSoftware = 'SQLSAFE' AND @CurrentBackupType = 'FULL' THEN 'safe'
      WHEN @BackupSoftware = 'SQLSAFE' AND @CurrentBackupType = 'DIFF' THEN 'safe'
      WHEN @BackupSoftware = 'SQLSAFE' AND @CurrentBackupType = 'LOG' THEN 'safe'
      END

      INSERT INTO @CurrentDirectories (ID, DirectoryPath, CreateCompleted, CleanupCompleted)
      SELECT ROW_NUMBER() OVER (ORDER BY ID), DirectoryPath + CASE WHEN RIGHT(DirectoryPath,1) = '\' THEN '' ELSE '\' END + CASE WHEN @CurrentAvailabilityGroup IS NOT NULL THEN @Cluster + '$' + @CurrentAvailabilityGroup ELSE REPLACE(CAST(SERVERPROPERTY('servername') AS nvarchar),'\','$') END + '\' + @CurrentDatabaseNameFS + '\' + UPPER(@CurrentBackupType) + CASE WHEN @ReadWriteFileGroups = 'Y' THEN '_PARTIAL' ELSE '' END + CASE WHEN @CopyOnly = 'Y' THEN '_COPY_ONLY' ELSE '' END, 0, 0
      FROM @Directories
      ORDER BY ID ASC

      SET @CurrentFileNumber = 0

      WHILE @CurrentFileNumber < @NumberOfFiles
      BEGIN
        SET @CurrentFileNumber = @CurrentFileNumber + 1

        SELECT @CurrentDirectoryPath = DirectoryPath
        FROM @CurrentDirectories
        WHERE @CurrentFileNumber >= (ID - 1) * (SELECT @NumberOfFiles / COUNT(*) FROM @CurrentDirectories) + 1
        AND @CurrentFileNumber <= ID * (SELECT @NumberOfFiles / COUNT(*) FROM @CurrentDirectories)

        SET @CurrentFilePath = @CurrentDirectoryPath + '\' + CASE WHEN @CurrentAvailabilityGroup IS NOT NULL THEN @Cluster + '$' + @CurrentAvailabilityGroup ELSE REPLACE(CAST(SERVERPROPERTY('servername') AS nvarchar),'\','$') END + '_' + @CurrentDatabaseNameFS + '_' + UPPER(@CurrentBackupType) + CASE WHEN @ReadWriteFileGroups = 'Y' THEN '_PARTIAL' ELSE '' END + CASE WHEN @CopyOnly = 'Y' THEN '_COPY_ONLY' ELSE '' END + '_' + REPLACE(REPLACE(REPLACE((CONVERT(nvarchar,@CurrentDate,120)),'-',''),' ','_'),':','') + CASE WHEN @NumberOfFiles > 1 AND @NumberOfFiles <= 9 THEN '_' + CAST(@CurrentFileNumber AS nvarchar) WHEN @NumberOfFiles >= 10 THEN '_' + RIGHT('0' + CAST(@CurrentFileNumber AS nvarchar),2) ELSE '' END + '.' + @CurrentFileExtension

        IF LEN(@CurrentFilePath) > 259
        BEGIN
          SET @CurrentFilePath = @CurrentDirectoryPath + '\' + CASE WHEN @CurrentAvailabilityGroup IS NOT NULL THEN @Cluster + '$' + @CurrentAvailabilityGroup ELSE REPLACE(CAST(SERVERPROPERTY('servername') AS nvarchar),'\','$') END + '_' + LEFT(@CurrentDatabaseNameFS,CASE WHEN (LEN(@CurrentDatabaseNameFS) + 259 - LEN(@CurrentFilePath) - 3) < 20 THEN 20 ELSE (LEN(@CurrentDatabaseNameFS) + 259 - LEN(@CurrentFilePath) - 3) END) + '...' + '_' + UPPER(@CurrentBackupType) + CASE WHEN @ReadWriteFileGroups = 'Y' THEN '_PARTIAL' ELSE '' END + CASE WHEN @CopyOnly = 'Y' THEN '_COPY_ONLY' ELSE '' END + '_' + REPLACE(REPLACE(REPLACE((CONVERT(nvarchar,@CurrentDate,120)),'-',''),' ','_'),':','') + CASE WHEN @NumberOfFiles > 1 AND @NumberOfFiles <= 9 THEN '_' + CAST(@CurrentFileNumber AS nvarchar) WHEN @NumberOfFiles >= 10 THEN '_' + RIGHT('0' + CAST(@CurrentFileNumber AS nvarchar),2) ELSE '' END + '.' + @CurrentFileExtension
        END

        INSERT INTO @CurrentFiles (CurrentFilePath)
        SELECT @CurrentFilePath

        SET @CurrentDirectoryPath = NULL
        SET @CurrentFilePath = NULL
      END

      -- Create directory
      WHILE EXISTS (SELECT * FROM @CurrentDirectories WHERE CreateCompleted = 0)
      BEGIN
        SELECT TOP 1 @CurrentDirectoryID = ID,
                     @CurrentDirectoryPath = DirectoryPath
        FROM @CurrentDirectories
        WHERE CreateCompleted = 0
        ORDER BY ID ASC

        SET @CurrentCommandType01 = 'xp_create_subdir'
        SET @CurrentCommand01 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_create_subdir N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''' IF @ReturnCode <> 0 RAISERROR(''Error creating directory.'', 16, 1)'
        EXECUTE @CurrentCommandOutput01 = [dbo].[CommandExecute] @Command = @CurrentCommand01, @CommandType = @CurrentCommandType01, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
        SET @Error = @@ERROR
        IF @Error <> 0 SET @CurrentCommandOutput01 = @Error
        IF @CurrentCommandOutput01 <> 0 SET @ReturnCode = @CurrentCommandOutput01

        UPDATE @CurrentDirectories
        SET CreateCompleted = 1,
            CreateOutput = @CurrentCommandOutput01
        WHERE ID = @CurrentDirectoryID

        SET @CurrentDirectoryID = NULL
        SET @CurrentDirectoryPath = NULL

        SET @CurrentCommand01 = NULL

        SET @CurrentCommandOutput01 = NULL

        SET @CurrentCommandType01 = NULL
      END

      -- Perform a backup
      IF NOT EXISTS (SELECT * FROM @CurrentDirectories WHERE CreateOutput <> 0 OR CreateOutput IS NULL)
      BEGIN
        IF @BackupSoftware IS NULL
        BEGIN
          SELECT @CurrentCommandType02 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'BACKUP_DATABASE'
          WHEN @CurrentBackupType = 'LOG' THEN 'BACKUP_LOG'
          END

          SELECT @CurrentCommand02 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'BACKUP DATABASE ' + QUOTENAME(@CurrentDatabaseName)
          WHEN @CurrentBackupType = 'LOG' THEN 'BACKUP LOG ' + QUOTENAME(@CurrentDatabaseName)
          END

          IF @ReadWriteFileGroups = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ' READ_WRITE_FILEGROUPS'

          SET @CurrentCommand02 = @CurrentCommand02 + ' TO'

          SELECT @CurrentCommand02 = @CurrentCommand02 + ' DISK = N''' + REPLACE(CurrentFilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand02 = @CurrentCommand02 + ' WITH '
          IF @CheckSum = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand02 = @CurrentCommand02 + 'NO_CHECKSUM'
          IF @Compress = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ', COMPRESSION'
          IF @Compress = 'N' AND @Version >= 10 SET @CurrentCommand02 = @CurrentCommand02 + ', NO_COMPRESSION'
          IF @CurrentBackupType = 'DIFF' SET @CurrentCommand02 = @CurrentCommand02 + ', DIFFERENTIAL'
          IF @CopyOnly = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ', COPY_ONLY'
          IF @BlockSize IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', BLOCKSIZE = ' + CAST(@BlockSize AS nvarchar)
          IF @BufferCount IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', BUFFERCOUNT = ' + CAST(@BufferCount AS nvarchar)
          IF @MaxTransferSize IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', MAXTRANSFERSIZE = ' + CAST(@MaxTransferSize AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', DESCRIPTION = N''' + REPLACE(@Description,'''','''''') + ''''
        END

        IF @BackupSoftware = 'LITESPEED'
        BEGIN
          SELECT @CurrentCommandType02 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'xp_backup_database'
          WHEN @CurrentBackupType = 'LOG' THEN 'xp_backup_log'
          END

          SELECT @CurrentCommand02 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_backup_database @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''
          WHEN @CurrentBackupType = 'LOG' THEN 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_backup_log @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''
          END

          SELECT @CurrentCommand02 = @CurrentCommand02 + ', @filename = N''' + REPLACE(CurrentFilePath,'''','''''') + ''''
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand02 = @CurrentCommand02 + ', @with = '''
          IF @CheckSum = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand02 = @CurrentCommand02 + 'NO_CHECKSUM'
          IF @CurrentBackupType = 'DIFF' SET @CurrentCommand02 = @CurrentCommand02 + ', DIFFERENTIAL'
          IF @CopyOnly = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ', COPY_ONLY'
          IF @BlockSize IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', BLOCKSIZE = ' + CAST(@BlockSize AS nvarchar)
          SET @CurrentCommand02 = @CurrentCommand02 + ''''
          IF @ReadWriteFileGroups = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ', @read_write_filegroups = 1'
          IF @CompressionLevel IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @compressionlevel = ' + CAST(@CompressionLevel AS nvarchar)
          IF @BufferCount IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @buffercount = ' + CAST(@BufferCount AS nvarchar)
          IF @MaxTransferSize IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @maxtransfersize = ' + CAST(@MaxTransferSize AS nvarchar)
          IF @Threads IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @threads = ' + CAST(@Threads AS nvarchar)
          IF @Throttle IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @throttle = ' + CAST(@Throttle AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @desc = N''' + REPLACE(@Description,'''','''''') + ''''

          IF @EncryptionType IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @cryptlevel = ' + CASE
          WHEN @EncryptionType = 'RC2-40' THEN '0'
          WHEN @EncryptionType = 'RC2-56' THEN '1'
          WHEN @EncryptionType = 'RC2-112' THEN '2'
          WHEN @EncryptionType = 'RC2-128' THEN '3'
          WHEN @EncryptionType = '3DES-168' THEN '4'
          WHEN @EncryptionType = 'RC4-128' THEN '5'
          WHEN @EncryptionType = 'AES-128' THEN '6'
          WHEN @EncryptionType = 'AES-192' THEN '7'
          WHEN @EncryptionType = 'AES-256' THEN '8'
          END

          IF @EncryptionKey IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @encryptionkey = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''
          SET @CurrentCommand02 = @CurrentCommand02 + ' IF @ReturnCode <> 0 RAISERROR(''Error performing LiteSpeed backup.'', 16, 1)'
        END

        IF @BackupSoftware = 'SQLBACKUP'
        BEGIN
          SET @CurrentCommandType02 = 'sqlbackup'

          SELECT @CurrentCommand02 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'BACKUP DATABASE ' + QUOTENAME(@CurrentDatabaseName)
          WHEN @CurrentBackupType = 'LOG' THEN 'BACKUP LOG ' + QUOTENAME(@CurrentDatabaseName)
          END

          IF @ReadWriteFileGroups = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ' READ_WRITE_FILEGROUPS'

          SET @CurrentCommand02 = @CurrentCommand02 + ' TO'

          SELECT @CurrentCommand02 = @CurrentCommand02 + ' DISK = N''' + REPLACE(CurrentFilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand02 = @CurrentCommand02 + ' WITH '
          IF @CheckSum = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand02 = @CurrentCommand02 + 'NO_CHECKSUM'
          IF @CurrentBackupType = 'DIFF' SET @CurrentCommand02 = @CurrentCommand02 + ', DIFFERENTIAL'
          IF @CopyOnly = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ', COPY_ONLY'
          IF @CompressionLevel IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', COMPRESSION = ' + CAST(@CompressionLevel AS nvarchar)
          IF @Threads IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', THREADCOUNT = ' + CAST(@Threads AS nvarchar)
          IF @MaxTransferSize IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', MAXTRANSFERSIZE = ' + CAST(@MaxTransferSize AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', DESCRIPTION = N''' + REPLACE(@Description,'''','''''') + ''''

          IF @EncryptionType IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', KEYSIZE = ' + CASE
          WHEN @EncryptionType = 'AES-128' THEN '128'
          WHEN @EncryptionType = 'AES-256' THEN '256'
          END

          IF @EncryptionKey IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', PASSWORD = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''
          SET @CurrentCommand02 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.sqlbackup N''-SQL "' + REPLACE(@CurrentCommand02,'''','''''') + '"''' + ' IF @ReturnCode <> 0 RAISERROR(''Error performing SQLBackup backup.'', 16, 1)'
        END

        IF @BackupSoftware = 'HYPERBAC'
        BEGIN
          SET @CurrentCommandType02 = 'BACKUP_DATABASE'

          SELECT @CurrentCommand02 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'BACKUP DATABASE ' + QUOTENAME(@CurrentDatabaseName)
          WHEN @CurrentBackupType = 'LOG' THEN 'BACKUP LOG ' + QUOTENAME(@CurrentDatabaseName)
          END

          IF @ReadWriteFileGroups = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ' READ_WRITE_FILEGROUPS'

          SET @CurrentCommand02 = @CurrentCommand02 + ' TO'

          SELECT @CurrentCommand02 = @CurrentCommand02 + ' DISK = N''' + REPLACE(CurrentFilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand02 = @CurrentCommand02 + ' WITH '
          IF @CheckSum = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand02 = @CurrentCommand02 + 'NO_CHECKSUM'
          IF @CurrentBackupType = 'DIFF' SET @CurrentCommand02 = @CurrentCommand02 + ', DIFFERENTIAL'
          IF @CopyOnly = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ', COPY_ONLY'
          IF @BlockSize IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', BLOCKSIZE = ' + CAST(@BlockSize AS nvarchar)
          IF @BufferCount IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', BUFFERCOUNT = ' + CAST(@BufferCount AS nvarchar)
          IF @MaxTransferSize IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', MAXTRANSFERSIZE = ' + CAST(@MaxTransferSize AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', DESCRIPTION = N''' + REPLACE(@Description,'''','''''') + ''''
        END

        IF @BackupSoftware = 'SQLSAFE'
        BEGIN
          SET @CurrentCommandType02 = 'xp_ss_backup'

          SET @CurrentCommand02 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_ss_backup @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''

          SELECT @CurrentCommand02 = @CurrentCommand02 + ', ' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) = 1 THEN '@filename' ELSE '@backupfile' END + ' = N''' + REPLACE(CurrentFilePath,'''','''''') + ''''
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand02 = @CurrentCommand02 + ', @backuptype = ' + CASE WHEN @CurrentBackupType = 'FULL' THEN '''Full''' WHEN @CurrentBackupType = 'DIFF' THEN '''Differential''' WHEN @CurrentBackupType = 'LOG' THEN '''Log''' END
          IF @ReadWriteFileGroups = 'Y' SET @CurrentCommand02 = @CurrentCommand02 + ', @readwritefilegroups = 1'
          SET @CurrentCommand02 = @CurrentCommand02 + ', @checksum = ' + CASE WHEN @CheckSum = 'Y' THEN '1' WHEN @CheckSum = 'N' THEN '0' END
          SET @CurrentCommand02 = @CurrentCommand02 + ', @copyonly = ' + CASE WHEN @CopyOnly = 'Y' THEN '1' WHEN @CopyOnly = 'N' THEN '0' END
          IF @CompressionLevel IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @compressionlevel = ' + CAST(@CompressionLevel AS nvarchar)
          IF @Threads IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @threads = ' + CAST(@Threads AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @desc = N''' + REPLACE(@Description,'''','''''') + ''''

          IF @EncryptionType IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @encryptiontype = N''' + CASE
          WHEN @EncryptionType = 'AES-128' THEN 'AES128'
          WHEN @EncryptionType = 'AES-256' THEN 'AES256'
          END + ''''

          IF @EncryptionKey IS NOT NULL SET @CurrentCommand02 = @CurrentCommand02 + ', @encryptedbackuppassword = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''
          SET @CurrentCommand02 = @CurrentCommand02 + ' IF @ReturnCode <> 0 RAISERROR(''Error performing SQLsafe backup.'', 16, 1)'
        END

        EXECUTE @CurrentCommandOutput02 = [dbo].[CommandExecute] @Command = @CurrentCommand02, @CommandType = @CurrentCommandType02, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
        SET @Error = @@ERROR
        IF @Error <> 0 SET @CurrentCommandOutput02 = @Error
        IF @CurrentCommandOutput02 <> 0 SET @ReturnCode = @CurrentCommandOutput02
      END

      -- Verify the backup
      IF @CurrentCommandOutput02 = 0 AND @Verify = 'Y'
      BEGIN
        IF @BackupSoftware IS NULL
        BEGIN
          SET @CurrentCommandType03 = 'RESTORE_VERIFYONLY'

          SET @CurrentCommand03 = 'RESTORE VERIFYONLY FROM'

          SELECT @CurrentCommand03 = @CurrentCommand03 + ' DISK = N''' + REPLACE(CurrentFilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand03 = @CurrentCommand03 + ' WITH '
          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand03 = @CurrentCommand03 + 'NO_CHECKSUM'
        END

        IF @BackupSoftware = 'LITESPEED'
        BEGIN
          SET @CurrentCommandType03 = 'xp_restore_verifyonly'

          SET @CurrentCommand03 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_restore_verifyonly'

          SELECT @CurrentCommand03 = @CurrentCommand03 + ' @filename = N''' + REPLACE(CurrentFilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand03 = @CurrentCommand03 + ', @with = '''
          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand03 = @CurrentCommand03 + 'NO_CHECKSUM'
          SET @CurrentCommand03 = @CurrentCommand03 + ''''
          IF @EncryptionKey IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @encryptionkey = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''

          SET @CurrentCommand03 = @CurrentCommand03 + ' IF @ReturnCode <> 0 RAISERROR(''Error verifying LiteSpeed backup.'', 16, 1)'
        END

        IF @BackupSoftware = 'SQLBACKUP'
        BEGIN
          SET @CurrentCommandType03 = 'sqlbackup'

          SET @CurrentCommand03 = 'RESTORE VERIFYONLY FROM'

          SELECT @CurrentCommand03 = @CurrentCommand03 + ' DISK = N''' + REPLACE(CurrentFilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand03 = @CurrentCommand03 + ' WITH '
          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand03 = @CurrentCommand03 + 'NO_CHECKSUM'
          IF @EncryptionKey IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', PASSWORD = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''

          SET @CurrentCommand03 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.sqlbackup N''-SQL "' + REPLACE(@CurrentCommand03,'''','''''') + '"''' + ' IF @ReturnCode <> 0 RAISERROR(''Error verifying SQLBackup backup.'', 16, 1)'
        END

        IF @BackupSoftware = 'HYPERBAC'
        BEGIN
          SET @CurrentCommandType03 = 'RESTORE_VERIFYONLY'

          SET @CurrentCommand03 = 'RESTORE VERIFYONLY FROM'

          SELECT @CurrentCommand03 = @CurrentCommand03 + ' DISK = N''' + REPLACE(CurrentFilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand03 = @CurrentCommand03 + ' WITH '
          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand03 = @CurrentCommand03 + 'NO_CHECKSUM'
        END

        IF @BackupSoftware = 'SQLSAFE'
        BEGIN
          SET @CurrentCommandType03 = 'xp_ss_verify'

          SET @CurrentCommand03 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_ss_verify @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''

          SELECT @CurrentCommand03 = @CurrentCommand03 + ', ' + CASE WHEN ROW_NUMBER() OVER (ORDER BY CurrentFilePath ASC) = 1 THEN '@filename' ELSE '@backupfile' END + ' = N''' + REPLACE(CurrentFilePath,'''','''''') + ''''
          FROM @CurrentFiles
          ORDER BY CurrentFilePath ASC

          SET @CurrentCommand03 = @CurrentCommand03 + ' IF @ReturnCode <> 0 RAISERROR(''Error verifying SQLsafe backup.'', 16, 1)'
        END

        EXECUTE @CurrentCommandOutput03 = [dbo].[CommandExecute] @Command = @CurrentCommand03, @CommandType = @CurrentCommandType03, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
        SET @Error = @@ERROR
        IF @Error <> 0 SET @CurrentCommandOutput03 = @Error
        IF @CurrentCommandOutput03 <> 0 SET @ReturnCode = @CurrentCommandOutput03
      END

      -- Delete old backup files
      IF (@CurrentCommandOutput02 = 0 AND @Verify = 'N' AND @CurrentCleanupDate IS NOT NULL)
      OR (@CurrentCommandOutput02 = 0 AND @Verify = 'Y' AND @CurrentCommandOutput03 = 0 AND @CurrentCleanupDate IS NOT NULL)
      BEGIN
        WHILE EXISTS (SELECT * FROM @CurrentDirectories WHERE CleanupCompleted = 0)
        BEGIN
          SELECT TOP 1 @CurrentDirectoryID = ID,
                       @CurrentDirectoryPath = DirectoryPath
          FROM @CurrentDirectories
          WHERE CleanupCompleted = 0
          ORDER BY ID ASC

          IF @BackupSoftware IS NULL
          BEGIN
            SET @CurrentCommandType04 = 'xp_delete_file'

            SET @CurrentCommand04 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_delete_file 0, N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''', ''' + @CurrentFileExtension + ''', ''' + CONVERT(nvarchar(19),@CurrentCleanupDate,126) + ''' IF @ReturnCode <> 0 RAISERROR(''Error deleting files.'', 16, 1)'
          END

          IF @BackupSoftware = 'LITESPEED'
          BEGIN
            SET @CurrentCommandType04 = 'xp_slssqlmaint'

            SET @CurrentCommand04 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_slssqlmaint N''-MAINTDEL -DELFOLDER "' + REPLACE(@CurrentDirectoryPath,'''','''''') + '" -DELEXTENSION "' + @CurrentFileExtension + '" -DELUNIT "' + CAST(DATEDIFF(mi,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + '" -DELUNITTYPE "minutes" -DELUSEAGE'' IF @ReturnCode <> 0 RAISERROR(''Error deleting LiteSpeed backup files.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLBACKUP'
          BEGIN
            SET @CurrentCommandType04 = 'sqbutility'

            SET @CurrentCommand04 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.sqbutility 1032, N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''', N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''', ''' + CASE WHEN @CurrentBackupType = 'FULL' THEN 'D' WHEN @CurrentBackupType = 'DIFF' THEN 'I' WHEN @CurrentBackupType = 'LOG' THEN 'L' END + ''', ''' + CAST(DATEDIFF(hh,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + 'h'', ' + ISNULL('''' + REPLACE(@EncryptionKey,'''','''''') + '''','NULL') + ' IF @ReturnCode <> 0 RAISERROR(''Error deleting SQLBackup backup files.'', 16, 1)'
          END

          IF @BackupSoftware = 'HYPERBAC'
          BEGIN
            SET @CurrentCommandType04 = 'xp_delete_file'

            SET @CurrentCommand04 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_delete_file 0, N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''', ''' + @CurrentFileExtension + ''', ''' + CONVERT(nvarchar(19),@CurrentCleanupDate,126) + ''' IF @ReturnCode <> 0 RAISERROR(''Error deleting files.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLSAFE'
          BEGIN
            SET @CurrentCommandType04 = 'xp_ss_delete'

            SET @CurrentCommand04 = 'DECLARE @ReturnCode int EXECUTE @ReturnCode = [master].dbo.xp_ss_delete @filename = N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + '\*.' + @CurrentFileExtension + ''', @age = ''' + CAST(DATEDIFF(mi,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + 'Minutes'' IF @ReturnCode <> 0 RAISERROR(''Error deleting SQLsafe backup files.'', 16, 1)'
          END

          EXECUTE @CurrentCommandOutput04 = [dbo].[CommandExecute] @Command = @CurrentCommand04, @CommandType = @CurrentCommandType04, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput04 = @Error
          IF @CurrentCommandOutput04 <> 0 SET @ReturnCode = @CurrentCommandOutput04

          UPDATE @CurrentDirectories
          SET CleanupCompleted = 1,
              CleanupOutput = @CurrentCommandOutput04
          WHERE ID = @CurrentDirectoryID

          SET @CurrentDirectoryID = NULL
          SET @CurrentDirectoryPath = NULL

          SET @CurrentCommand04 = NULL

          SET @CurrentCommandOutput04 = NULL

          SET @CurrentCommandType04 = NULL
        END
      END
    END

    -- Update that the database is completed
    UPDATE @tmpDatabases
    SET Completed = 1
    WHERE Selected = 1
    AND Completed = 0
    AND ID = @CurrentDBID

    -- Clear variables
    SET @CurrentDBID = NULL
    SET @CurrentDatabaseID = NULL
    SET @CurrentDatabaseName = NULL
    SET @CurrentBackupType = NULL
    SET @CurrentFileExtension = NULL
    SET @CurrentFileNumber = NULL
    SET @CurrentDifferentialBaseLSN = NULL
    SET @CurrentDifferentialBaseIsSnapshot = NULL
    SET @CurrentLogLSN = NULL
    SET @CurrentLatestBackup = NULL
    SET @CurrentDatabaseNameFS = NULL
    SET @CurrentDate = NULL
    SET @CurrentCleanupDate = NULL
    SET @CurrentIsDatabaseAccessible = NULL
    SET @CurrentAvailabilityGroup = NULL
    SET @CurrentAvailabilityGroupRole = NULL
    SET @CurrentIsPreferredBackupReplica = NULL
    SET @CurrentDatabaseMirroringRole = NULL
    SET @CurrentLogShippingRole = NULL

    SET @CurrentCommand02 = NULL
    SET @CurrentCommand03 = NULL

    SET @CurrentCommandOutput02 = NULL
    SET @CurrentCommandOutput03 = NULL

    SET @CurrentCommandType02 = NULL
    SET @CurrentCommandType03 = NULL

    DELETE FROM @CurrentDirectories
    DELETE FROM @CurrentFiles

  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  Logging:
  SET @EndMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
  SET @EndMessage = REPLACE(@EndMessage,'%','%%')
  RAISERROR(@EndMessage,10,1) WITH NOWAIT

  IF @ReturnCode <> 0
  BEGIN
    RETURN @ReturnCode
  END

  ----------------------------------------------------------------------------------------------------

END
GO

/***********************************************************************************************************************************************
- OLD 5b
***********************************************************************************************************************************************/
USE [DBA] 


IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'DatabaseSelect' and ROUTINE_TYPE = 'FUNCTION')
	DROP FUNCTION [dbo].[DatabaseSelect]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DatabaseSelect] (@DatabaseList nvarchar(max))

RETURNS @Database TABLE (DatabaseName nvarchar(max) NOT NULL)

AS

BEGIN

  ----------------------------------------------------------------------------------------------------
  --// Source: http://ola.hallengren.com                                                          //--
  ----------------------------------------------------------------------------------------------------
  -- Revision      $Revision: 7 $
  ----------------------------------------------------------------------------------------------------

  DECLARE @DatabaseItem nvarchar(max)
  DECLARE @Position int

  DECLARE @CurrentID int
  DECLARE @CurrentDatabaseName nvarchar(max)
  DECLARE @CurrentDatabaseStatus bit

  DECLARE @Database01 TABLE (DatabaseName nvarchar(max))

  DECLARE @Database02 TABLE (ID int IDENTITY PRIMARY KEY,
                             DatabaseName nvarchar(max),
                             DatabaseStatus bit,
                             Completed bit)

  DECLARE @Database03 TABLE (DatabaseName nvarchar(max),
                             DatabaseStatus bit)

  DECLARE @Sysdatabases TABLE (DatabaseName nvarchar(max))

  ----------------------------------------------------------------------------------------------------
  --// Split input string into elements                                                           //--
  ----------------------------------------------------------------------------------------------------

  WHILE CHARINDEX(', ',@DatabaseList) > 0 SET @DatabaseList = REPLACE(@DatabaseList,', ',',')
  WHILE CHARINDEX(' ,',@DatabaseList) > 0 SET @DatabaseList = REPLACE(@DatabaseList,' ,',',')
  WHILE CHARINDEX(',,',@DatabaseList) > 0 SET @DatabaseList = REPLACE(@DatabaseList,',,',',')

  IF RIGHT(@DatabaseList,1) = ',' SET @DatabaseList = LEFT(@DatabaseList,LEN(@DatabaseList) - 1)
  IF LEFT(@DatabaseList,1) = ','  SET @DatabaseList = RIGHT(@DatabaseList,LEN(@DatabaseList) - 1)

  SET @DatabaseList = LTRIM(RTRIM(@DatabaseList))

  WHILE LEN(@DatabaseList) > 0
  BEGIN
    SET @Position = CHARINDEX(',', @DatabaseList)
    IF @Position = 0
    BEGIN
      SET @DatabaseItem = @DatabaseList
      SET @DatabaseList = ''
    END
    ELSE
    BEGIN
      SET @DatabaseItem = LEFT(@DatabaseList, @Position - 1)
      SET @DatabaseList = RIGHT(@DatabaseList, LEN(@DatabaseList) - @Position)
    END
    IF @DatabaseItem <> '-' INSERT INTO @Database01 (DatabaseName) VALUES(@DatabaseItem)
  END

  ----------------------------------------------------------------------------------------------------
  --// Handle database exclusions                                                                 //--
  ----------------------------------------------------------------------------------------------------

  INSERT INTO @Database02 (DatabaseName, DatabaseStatus, Completed)
  SELECT DISTINCT DatabaseName = CASE WHEN DatabaseName LIKE '-%' THEN RIGHT(DatabaseName,LEN(DatabaseName) - 1) ELSE DatabaseName END,
                  DatabaseStatus = CASE WHEN DatabaseName LIKE '-%' THEN 0 ELSE 1 END,
                  0 AS Completed
  FROM @Database01

  ----------------------------------------------------------------------------------------------------
  --// Resolve elements                                                                           //--
  ----------------------------------------------------------------------------------------------------

  WHILE EXISTS (SELECT * FROM @Database02 WHERE Completed = 0)
  BEGIN

    SELECT TOP 1 @CurrentID = ID,
                 @CurrentDatabaseName = DatabaseName,
                 @CurrentDatabaseStatus = DatabaseStatus
    FROM @Database02
    WHERE Completed = 0
    ORDER BY ID ASC

    IF @CurrentDatabaseName = 'SYSTEM_DATABASES'
    BEGIN
      INSERT INTO @Database03 (DatabaseName, DatabaseStatus)
      SELECT [name], @CurrentDatabaseStatus
      FROM sys.databases
      WHERE [name] IN('master','model','msdb','tempdb')
    END
    ELSE IF @CurrentDatabaseName = 'USER_DATABASES'
    BEGIN
      INSERT INTO @Database03 (DatabaseName, DatabaseStatus)
      SELECT [name], @CurrentDatabaseStatus
      FROM sys.databases
      WHERE [name] NOT IN('master','model','msdb','tempdb')
    END
    ELSE IF @CurrentDatabaseName = 'ALL_DATABASES'
    BEGIN
      INSERT INTO @Database03 (DatabaseName, DatabaseStatus)
      SELECT [name], @CurrentDatabaseStatus
      FROM sys.databases
    END
    ELSE IF CHARINDEX('%',@CurrentDatabaseName) > 0
    BEGIN
      INSERT INTO @Database03 (DatabaseName, DatabaseStatus)
      SELECT [name], @CurrentDatabaseStatus
      FROM sys.databases
      WHERE [name] LIKE REPLACE(CASE WHEN LEFT(@CurrentDatabaseName,1) = '[' AND RIGHT(@CurrentDatabaseName,1) = ']' THEN PARSENAME(@CurrentDatabaseName,1) ELSE @CurrentDatabaseName END,'_','[_]')
    END
    ELSE
    BEGIN
      INSERT INTO @Database03 (DatabaseName, DatabaseStatus)
      SELECT [name], @CurrentDatabaseStatus
      FROM sys.databases
      WHERE [name] = CASE WHEN LEFT(@CurrentDatabaseName,1) = '[' AND RIGHT(@CurrentDatabaseName,1) = ']' THEN PARSENAME(@CurrentDatabaseName,1) ELSE @CurrentDatabaseName END
    END

    UPDATE @Database02
    SET Completed = 1
    WHERE ID = @CurrentID

    SET @CurrentID = NULL
    SET @CurrentDatabaseName = NULL
    SET @CurrentDatabaseStatus = NULL

  END

  ----------------------------------------------------------------------------------------------------
  --// Handle tempdb and database snapshots                                                       //--
  ----------------------------------------------------------------------------------------------------

  INSERT INTO @Sysdatabases (DatabaseName)
  SELECT [name]
  FROM sys.databases
  WHERE [name] <> 'tempdb'
  AND source_database_id IS NULL

  ----------------------------------------------------------------------------------------------------
  --// Return results                                                                             //--
  ----------------------------------------------------------------------------------------------------

  INSERT INTO @Database (DatabaseName)
  SELECT DatabaseName
  FROM @Sysdatabases
  INTERSECT
  SELECT DatabaseName
  FROM @Database03
  WHERE DatabaseStatus = 1
  EXCEPT
  SELECT DatabaseName
  FROM @Database03
  WHERE DatabaseStatus = 0

  RETURN

  ----------------------------------------------------------------------------------------------------

END
GO

/***********************************************************************************************************************************************
- OLD 5c
***********************************************************************************************************************************************/
USE [DBA] 

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'CommandExecute' AND ROUTINE_TYPE = 'PROCEDURE')
	DROP PROCEDURE [dbo].[CommandExecute]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CommandExecute]

@Command nvarchar(max),
@CommandType nvarchar(max),
@Mode int,
@Comment nvarchar(max) = NULL,
@DatabaseName nvarchar(max) = NULL,
@SchemaName nvarchar(max) = NULL,
@ObjectName nvarchar(max) = NULL,
@ObjectType nvarchar(max) = NULL,
@IndexName nvarchar(max) = NULL,
@IndexType int = NULL,
@StatisticsName nvarchar(max) = NULL,
@PartitionNumber int = NULL,
@ExtendedInfo xml = NULL,
@LogToTable nvarchar(max),
@Execute nvarchar(max)

AS

BEGIN

  ----------------------------------------------------------------------------------------------------
  --// Source: http://ola.hallengren.com                                                          //--
  ----------------------------------------------------------------------------------------------------
  -- Revision      $Revision: 116 $
  ----------------------------------------------------------------------------------------------------

    SET NOCOUNT ON

  DECLARE @StartMessage nvarchar(max)
  DECLARE @EndMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)
  DECLARE @ErrorMessageOriginal nvarchar(max)

  DECLARE @StartTime datetime
  DECLARE @EndTime datetime

  DECLARE @StartTimeSec datetime
  DECLARE @EndTimeSec datetime

  DECLARE @ID int

  DECLARE @Error int
  DECLARE @ReturnCode int

  SET @Error = 0
  SET @ReturnCode = 0

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download http://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ReturnCode = @Error
    GOTO ReturnCode
  END

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF @Command IS NULL OR @Command = ''
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Command is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CommandType IS NULL OR @CommandType = '' OR LEN(@CommandType) > 60
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CommandType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Mode NOT IN(1,2) OR @Mode IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Mode is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ReturnCode = @Error
    GOTO ReturnCode
  END

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = GETDATE()
  SET @StartTimeSec = CONVERT(datetime,CONVERT(nvarchar,@StartTime,120),120)

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,@StartTimeSec,120) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Command: ' + @Command
  IF @Comment IS NOT NULL SET @StartMessage = @StartMessage + CHAR(13) + CHAR(10) + 'Comment: ' + @Comment
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  IF @LogToTable = 'Y'
  BEGIN
    INSERT INTO dbo.CommandLog (DatabaseName, SchemaName, ObjectName, ObjectType, IndexName, IndexType, StatisticsName, PartitionNumber, ExtendedInfo, CommandType, Command, StartTime)
    VALUES (@DatabaseName, @SchemaName, @ObjectName, @ObjectType, @IndexName, @IndexType, @StatisticsName, @PartitionNumber, @ExtendedInfo, @CommandType, @Command, @StartTime)
  END

  SET @ID = SCOPE_IDENTITY()

  ----------------------------------------------------------------------------------------------------
  --// Execute command                                                                            //--
  ----------------------------------------------------------------------------------------------------

  IF @Mode = 1 AND @Execute = 'Y'
  BEGIN
    EXECUTE(@Command)
    SET @Error = @@ERROR
    SET @ReturnCode = @Error
  END

  IF @Mode = 2 AND @Execute = 'Y'
  BEGIN
    BEGIN TRY
      EXECUTE(@Command)
    END TRY
    BEGIN CATCH
      SET @Error = ERROR_NUMBER()
      SET @ReturnCode = @Error
      SET @ErrorMessageOriginal = ERROR_MESSAGE()
      SET @ErrorMessage = 'Msg ' + CAST(@Error AS nvarchar) + ', ' + ISNULL(@ErrorMessageOriginal,'')
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    END CATCH
  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  SET @EndTime = GETDATE()
  SET @EndTimeSec = CONVERT(datetime,CONVERT(varchar,@EndTime,120),120)

  SET @EndMessage = 'Outcome: ' + CASE WHEN @Execute = 'N' THEN 'Not Executed' WHEN @Error = 0 THEN 'Succeeded' ELSE 'Failed' END + CHAR(13) + CHAR(10)
  SET @EndMessage = @EndMessage + 'Duration: ' + CASE WHEN DATEDIFF(ss,@StartTimeSec, @EndTimeSec)/(24*3600) > 0 THEN CAST(DATEDIFF(ss,@StartTimeSec, @EndTimeSec)/(24*3600) AS nvarchar) + '.' ELSE '' END + CONVERT(nvarchar,@EndTimeSec - @StartTimeSec,108) + CHAR(13) + CHAR(10)
  SET @EndMessage = @EndMessage + 'Date and time: ' + CONVERT(nvarchar,@EndTimeSec,120) + CHAR(13) + CHAR(10) + ' '
  SET @EndMessage = REPLACE(@EndMessage,'%','%%')
  RAISERROR(@EndMessage,10,1) WITH NOWAIT

  IF @LogToTable = 'Y'
  BEGIN
    UPDATE dbo.CommandLog
    SET EndTime = @EndTime,
        ErrorNumber = CASE WHEN @Execute = 'N' THEN NULL ELSE @Error END,
        ErrorMessage = @ErrorMessageOriginal
    WHERE ID = @ID
  END

  ReturnCode:
  IF @ReturnCode <> 0
  BEGIN
    RETURN @ReturnCode
  END

  ----------------------------------------------------------------------------------------------------

END
GO

/***********************************************************************************************************************************************
- OLD 5d
***********************************************************************************************************************************************/
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
GO

/***********************************************************************************************************************************************
- OLD 5e
***********************************************************************************************************************************************/
----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 143 $
----------------------------------------------------------------------------------------------------

USE [DBA] 

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
set @BackupDirectoryFULL		= '\\DBAMBK01PR\SQLBackup03' -- Specify the backup root directory for the FULLs. Example: \\sequel\sql_nonprod2
set @BackupDirectoryDIFF		= '\\DBAMBK01PR\SQLBackup03' -- Specify the backup root directory for the DIFFs. Example: \\sequel\sql_nonprod2
set	@BackupDirectoryINCR		= '\\DBAMBK01PR\SQLBackupLogs01' -- Specify the backup root directory for the INCRs. Example: \\sequel\sql_incr   
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
	SET @BufferCount		= NULL
	SET @MaxTransferSize	= NULL
	SET @BlockSize			= NULL 
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

GO

