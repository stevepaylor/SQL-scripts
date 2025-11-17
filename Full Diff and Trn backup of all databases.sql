EXECUTE DBA..DatabaseBackup 
@Databases = 'CMP13'
--,-CMKTCRYPTO10
--, -CMKTDB10
--, -CMKTIMPORT10
--, -CmktOffers10'
, @Directory = N'\\CMKTDB13BPR\SQLBackup'
, @BackupType = 'FULL'
, @CleanupTime = 1
, @BackupSoftware = NULL
, @Compress  = 'Y'
, @CopyOnly = 'N'
, @Verify = 'N', @CheckSum = 'Y'
, @BufferCount = NULL
, @MaxTransferSize = NULL
, @BlockSize = NULL
, @LogToTable = 'Y'
GO

EXECUTE DBA..DatabaseBackup 
@Databases = 'CMP13'
, @Directory = N'\\CMKTDB13BPR\SQLBackup'
, @BackupType = 'DIFF'
, @CleanupTime = 1
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

EXECUTE DBA..DatabaseBackup 
@Databases = 'CMP13'
, @Directory = N'\\CMKTDB13BPR\SQLBackup'
, @BackupType = 'LOG'
, @CleanupTime = 1
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
