USE master;
GO

RESTORE DATABASE [cage_inventory] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIDB01PR_Migration_To_AAG\cage_inventory_full.bak' 
WITH
  REPLACE  
, STATS = 5
GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS cage_inventory

ALTER DATABASE [cage_inventory]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'cage_inventory'
, @Directory = N'\\DBAMBK01PR\SQLBackup01'
, @BackupType = 'FULL'
, @CleanupTime = 180
, @BackupSoftware = NULL
, @Compress  = 'Y'
, @CopyOnly = 'N'
, @Verify = 'N'
, @CheckSum = 'Y'
, @BufferCount = NULL
, @MaxTransferSize = NULL
, @BlockSize = NULL
, @LogToTable = 'Y'



USE [master]
RESTORE DATABASE [COMMON_SECURITY] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIDB01PR_Migration_To_AAG\COMMON_SECURITY_full.bak' 
WITH
  MOVE N'COMMON_SECURITY_data' TO N'K:\UserDBdata\COMMON_SECURITY_RESTORE.mdf'
, MOVE N'COMMON_SECURITY_log' TO N'L:\UserDBlog\COMMON_SECURITY_RESTORE_1.ldf'
, REPLACE  
, STATS = 5

GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS COMMON_SECURITY

ALTER DATABASE [COMMON_SECURITY]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'COMMON_SECURITY'
, @Directory = N'\\DBAMBK01PR\SQLBackup01'
, @BackupType = 'FULL'
, @CleanupTime = 180
, @BackupSoftware = NULL
, @Compress  = 'Y'
, @CopyOnly = 'N'
, @Verify = 'N'
, @CheckSum = 'Y'
, @BufferCount = NULL
, @MaxTransferSize = NULL
, @BlockSize = NULL
, @LogToTable = 'Y'