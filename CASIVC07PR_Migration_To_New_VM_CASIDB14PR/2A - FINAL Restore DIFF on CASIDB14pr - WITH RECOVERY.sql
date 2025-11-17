/****** CASH_VARIANCE ******/

USE master;
GO

RESTORE DATABASE [CASH_VARIANCE] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIIVC07PR_Migration_To_New_VM_Server\CASH_VARIANCE_diff.bak' 
WITH
  RECOVERY 
, STATS = 5
GO

USE CASH_VARIANCE;
GO

sp_changedbowner 'DBAdmin';

USE master;
GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS CASH_VARIANCE

ALTER DATABASE [CASH_VARIANCE]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'CASH_VARIANCE'
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
GO


/****** COMMON_SECURITY ******/


USE master;
GO

RESTORE DATABASE [COMMON_SECURITY] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIIVC07PR_Migration_To_New_VM_Server\COMMON_SECURITY_diff.bak' 
WITH
  RECOVERY 
, STATS = 5
GO

USE COMMON_SECURITY;
GO

sp_changedbowner 'DBAdmin';

USE master;
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
GO


/****** FLOORVIZ ******/

USE master;
GO

RESTORE DATABASE [FLOORVIZ] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIIVC07PR_Migration_To_New_VM_Server\FLOORVIZ_diff.bak' 
WITH
  RECOVERY
, STATS = 5
GO

USE FLOORVIZ;
GO

sp_changedbowner 'DBAdmin';

USE master;
GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS FLOORVIZ

ALTER DATABASE [FLOORVIZ]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'FLOORVIZ'
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
GO


/****** GUEST_MOBILE ******/

USE master;
GO

RESTORE DATABASE [GUEST_MOBILE] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIIVC07PR_Migration_To_New_VM_Server\GUEST_MOBILE_diff.bak' 
WITH
  RECOVERY  
, STATS = 5
GO

USE GUEST_MOBILE;
GO

sp_changedbowner 'DBAdmin';

USE master;
GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS GUEST_MOBILE

ALTER DATABASE [GUEST_MOBILE]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'GUEST_MOBILE'
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
GO


/****** ICBWebReports ******/

USE master;
GO

RESTORE DATABASE [ICBWebReports] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIIVC07PR_Migration_To_New_VM_Server\ICBWebReports_diff.bak' 
WITH
  RECOVERY 
, STATS = 5
GO

USE ICBWebReports;
GO

sp_changedbowner 'DBAdmin';

USE master;
GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS ICBWebReports

ALTER DATABASE [ICBWebReports]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'ICBWebReports'
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
GO



/****** SLOT_SERVICE ******/

USE master;
GO

RESTORE DATABASE [SLOT_SERVICE] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIIVC07PR_Migration_To_New_VM_Server\SLOT_SERVICE_diff.bak' 
WITH
  RECOVERY 
, STATS = 5
GO

USE SLOT_SERVICE;
GO

sp_changedbowner 'DBAdmin';

USE master;
GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS SLOT_SERVICE

ALTER DATABASE [SLOT_SERVICE]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'SLOT_SERVICE'
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
GO


/****** SLOT_PARTICIPATION ******/

USE master;
GO

RESTORE DATABASE [SLOT_PARTICIPATION] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CASIIVC07PR_Migration_To_New_VM_Server\SLOT_PARTICIPATION_diff.bak' 
WITH
  RECOVERY  
, STATS = 5
GO

USE SLOT_PARTICIPATION;
GO

sp_changedbowner 'DBAdmin';

USE master;
GO

EXEC DBA.dbo.isp_UPDATE_STATISTICS SLOT_PARTICIPATION

ALTER DATABASE [SLOT_PARTICIPATION]
SET MULTI_USER;
GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'SLOT_PARTICIPATION'
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
GO


