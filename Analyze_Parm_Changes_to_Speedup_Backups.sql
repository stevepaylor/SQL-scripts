------------------------------------------------
---- CMP13
------------------------------------------------
--BACKUP DATABASE vCMSUpdate 
--TO DISK = N'\\CMKTDB13BPR\SQLBackup\vCMSUpdate_QA_FULL.bak' 
--WITH 
--  CHECKSUM
--, NOFORMAT
--, COMPRESSION
--, INIT
--, STATS = 5
--GO

EXECUTE DBA.[dbo].[DatabaseBackup] 
  @Databases = 'ALL_DATABASES'
, @Directory = N'\\DBAMBK01PR\SQLBackup04_NONPROD'
, @BackupType = 'FULL'
, @CleanupTime = 180
, @BackupSoftware = NULL
, @Compress  = 'Y'
, @CopyOnly = 'N'
, @Verify = 'N'
, @CheckSum = 'Y'
, @BufferCount = 500
, @MaxTransferSize = 262144
, @BlockSize = 8192
, @LogToTable = 'Y';

-- Nothing 1:27:52
-- 262144   256  500  8192  0:44 (-CMP13, -CMKTDB_ARCHIVE) 22:01
-- 262144   256  500  8192   (-CMP13)

-- 262144   256  50   1024  0:58
-- 262144   256  100  2048
-- 262144   256  200  4096  0:50
-- 262144   256  500  8192  0:46

-- 4194304  4096 50   1024  0:47
-- 4194304  4096 100  2048
-- 4194304  4096 200  4096
-- 4194304  4096 500  8196  0:57



-- 262144   256   1024
-- 524288   512   2048
-- 1048576  1024  4096
-- 2097152  2048


-- 4194304  4096  4:11


-- 262144   256  50   1:55 
-- 262144   256  100  1:17
-- 262144   256  200  1:05
-- 262144   256  500  1:11

-- 1048576  1024

-- 4194304  4096 50   1:07 
-- 4194304  4096 100  1:02
-- 4194304  4096 200  1:07
-- 4194304  4096 500  2:02

-- 262144   256  50   1024 
-- 262144   256  100  2048
-- 262144   256  200  4096
-- 262144   256  500  8192