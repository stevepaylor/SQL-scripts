EXECUTE DBA.dbo.DatabaseBackup 
 @Databases = 'WSS_Content_Viejas'
, @Directory = N'N:\SQLBackup'
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
, @LogToTable = 'Y'