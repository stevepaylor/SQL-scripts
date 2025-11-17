EXECUTE DBA.dbo.DatabaseBackup 
  @Databases = 'WSS_Content_Viejas' 
, @Directory = N'\\DBAMBK01PR\SQLBackup01'
, @BackupType = 'FULL'
, @CleanupTime = 25
, @BackupSoftware = NULL
, @Compress  = 'Y'
, @CopyOnly = 'N'
, @Verify = 'N'
, @CheckSum = 'Y'
, @BufferCount = NULL
, @MaxTransferSize = NULL
, @BlockSize = NULL
, @LogToTable = 'Y'