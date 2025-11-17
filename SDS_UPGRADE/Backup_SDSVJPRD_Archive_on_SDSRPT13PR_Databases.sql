BACKUP DATABASE SDSVJPRD_Archive 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\_PreUpgrade\SDSVJPRD_Archive_DIFF.bak' 
WITH
  DIFFERENTIAL 
, NOFORMAT
, INIT
, STATS = 5
, COMPRESSION
, CHECKSUM

BACKUP DATABASE SDSVJPRD_Archive 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\_PreUpgrade\SDSVJPRD_Archive_FULL.bak' 
WITH 
  NOFORMAT
, INIT
, STATS = 5
, COMPRESSION
, CHECKSUM

--EXECUTE DBA.[dbo].[DatabaseBackup] 
--  @Databases = 'SDSVJPRD_Archive'
--, @Directory = N'\\DBAMBK01PR\SQLBackup02'
--, @BackupType = 'FULL'
--, @CleanupTime = 180
--, @BackupSoftware = NULL
--, @Compress  = 'Y'
--, @CopyOnly = 'N'
--, @Verify = 'N'
--, @CheckSum = 'Y'
--, @BufferCount = NULL
--, @MaxTransferSize = NULL
--, @BlockSize = NULL
--, @LogToTable = 'Y'