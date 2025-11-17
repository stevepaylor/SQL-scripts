---- RUN FULL BACKUP before changing anything
--EXECUTE DBA..DatabaseBackup 
--  @Databases = 'CMP13'
--, @Directory = N'K:\SQLBackupTemp'
--, @BackupType = 'FULL'
--, @CleanupTime = 72
--, @BackupSoftware = NULL
--, @Compress  = 'Y'
--, @CopyOnly = 'N'
--, @Verify = 'N'
--, @CheckSum = 'Y'
--, @BufferCount = NULL
--, @MaxTransferSize = NULL
--, @BlockSize = NULL
--, @LogToTable = 'Y';
--GO

--ALTER DATABASE CMP13 SET RECOVERY SIMPLE
--GO

--CHECKPOINT
--GO

---- To find the name of the log file you can use the following query
--SELECT name 
--FROM sys.master_files
--WHERE database_id = DB_ID('CMP13')
--GO

--USE CMP13
--GO

----Shrink the file
--DBCC SHRINKFILE (N'CMKTDB13_Log' , 0, TRUNCATEONLY)
--GO

--ALTER DATABASE CMP13 SET RECOVERY FULL
--GO

-- Immediately run FULL BACKUP !!!!!
EXECUTE DBA..DatabaseBackup 
  @Databases = 'CMP13'
, @Directory = N'\\DBAMBK01PR\SQLBackup01'
, @BackupType = 'FULL'
, @CleanupTime = 99
, @BackupSoftware = NULL
, @Compress  = 'Y'
, @CopyOnly = 'N'
, @Verify = 'N'
, @CheckSum = 'Y'
, @BufferCount = NULL
, @MaxTransferSize = NULL
, @BlockSize = NULL
, @LogToTable = 'Y';

GO