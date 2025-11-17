EXECUTE [dbo].[DatabaseBackup]
  @Databases = 'ALL_DATABASES'
, @Directory = N'F:\SQLBackup'
, @BackupType = 'FULL'
, @CleanupTime = 72
, @BackupSoftware = NULL
, @Compress  = 'N'
, @CopyOnly = 'N'
, @Verify = 'N'
, @CheckSum = 'Y'
, @BufferCount = 512
, @MaxTransferSize = 1048576
, @BlockSize = 8192
, @LogToTable = 'Y'