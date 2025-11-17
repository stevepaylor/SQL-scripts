--SwcEasitraxLiveIncomingData, Watson
--RequalDB, OperaDM,vDW

EXECUTE DBA.[dbo].[DatabaseBackup] @Databases = 'SwcEasitraxLiveIncomingData, Watson', @Directory = N'\\DBAMBK01PR\SQLBackup01', @BackupType = 'FULL', @CleanupTime = 180, @BackupSoftware = NULL, @Compress  = 'Y', @CopyOnly = 'N', @Verify = 'N', @CheckSum = 'Y', @BufferCount = 512, @MaxTransferSize = 262144, @BlockSize = 8192, @LogToTable = 'Y'

