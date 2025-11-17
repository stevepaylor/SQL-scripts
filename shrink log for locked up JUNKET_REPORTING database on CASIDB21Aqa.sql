-- If PROD or otherwise important database, RUN FULL BACKUP before changing anything
--EXECUTE DBA..DatabaseBackup 
--  @Databases = 'JUNKET_REPORTING'
--, @Directory = 'K:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup'
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

-- change log mode to simple
ALTER DATABASE JUNKET_REPORTING SET RECOVERY SIMPLE
GO

-- apply above change
CHECKPOINT
GO

-- To find the name of the log file you can use the following query
--SELECT name 
--FROM sys.master_files
--WHERE database_id = DB_ID('JUNKET_REPORTING')
--GO

USE JUNKET_REPORTING
GO

--Shrink the log file
DBCC SHRINKFILE (N'JUNKET_REPORTING_log' , 0, TRUNCATEONLY)
GO

--Set log mode back to full
ALTER DATABASE JUNKET_REPORTING SET RECOVERY FULL
GO

-- Immediately run FULL BACKUP !!!!!
EXECUTE DBA..DatabaseBackup 
  @Databases = 'JUNKET_REPORTING'
, @Directory = 'K:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup'
, @BackupType = 'FULL'
, @CleanupTime = 72
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