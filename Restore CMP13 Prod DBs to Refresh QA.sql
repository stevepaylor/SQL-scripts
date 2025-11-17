USE master;
GO


RESTORE DATABASE CMP13 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup06\CMKTMC13PR$CMKTAG13pr\CMP13\FULL\CMKTMC13PR$CMKTAG13pr_CMP13_FULL_20190508_023218.bak' 
WITH  
  FILE = 1
, MOVE N'CMKTDB13_Data' TO N'K:\UserDBdata\CMP13_data.mdf'
, MOVE N'CMKTDB13_Data2' TO N'K:\UserDBdata\CMP13_data2.ndf'
, MOVE N'CMKTDB13_Log' TO N'L:\UserDBlog\CMP13_log.1df'
, NOUNLOAD
, REPLACE
, STATS = 5
, NORECOVERY
GO

--RESTORE DATABASE CMKTDB_ARCHIVE 
--FROM  DISK = N'\\DBAMBK02PR\SQLBackup06\CMKTDB13APR\CMKTDB_ARCHIVE\FULL_COPY_ONLY\CMKTDB13APR_CMKTDB_ARCHIVE_FULL_COPY_ONLY_20190507_140025.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMKTDB_ARCHIVE_Data' TO N'F:\UserDBdata\CMKTDB_ARCHIVE_data.mdf'
--, MOVE N'CMKTDB_ARCHIVE_Log' TO N'G:\UserDBlog\CMKTDB_ARCHIVE_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE CMKTCRYPTO 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\CMKTCRYPTO\FULL\CMKTDB13QA_CMKTCRYPTO_FULL_20190425_040001.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMKTCRYPTO' TO N'K:\UserDBdata\CMKTCRYPTO_data.mdf'
--, MOVE N'CMKTCRYPTO_Log' TO N'L:\UserDBlog\CMKTCRYPTO_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, NORECOVERY
--GO

--RESTORE DATABASE CMPSDS 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\CMPSDS\FULL\CMKTDB13QA_CMPSDS_FULL_20190425_112657.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMPSDS_Data' TO N'K:\UserDBdata\CMPSDS_data.mdf'
--, MOVE N'CMPSDS_Log' TO N'L:\UserDBlog\CMPSDS_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, NORECOVERY
--GO

--RESTORE DATABASE dbInfogenesis 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\dbInfogenesis\FULL\CMKTDB13QA_dbInfogenesis_FULL_20190425_112723.bak' 
--WITH  
--  FILE = 1
--, MOVE N'dbInfogenesis_Data' TO N'K:\UserDBdata\dbInfogenesis_data.mdf'
--, MOVE N'dbInfogenesis_Log' TO N'L:\UserDBlog\dbInfogenesis_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, NORECOVERY
--GO

--RESTORE DATABASE PKMS_OBJ 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\PKMS_OBJ\FULL\CMKTDB13QA_PKMS_OBJ_FULL_20190425_112849.bak' 
--WITH  
--  FILE = 1
--, MOVE N'PKMS_OBJ'     TO N'K:\UserDBdata\PKMS_OBJ_data.mdf'
--, MOVE N'PKMS_OBJ_Log' TO N'L:\UserDBlog\PKMS_OBJ_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, NORECOVERY
--GO

--RESTORE DATABASE PrintManager 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\PrintManager\FULL\CMKTDB13QA_PrintManager_FULL_20190425_112851.bak' 
--WITH  
--  FILE = 1
--, MOVE N'PrintManager_Data' TO N'K:\UserDBdata\PrintManager_data.mdf'
--, MOVE N'PrintManager_Log' TO N'L:\UserDBlog\PrintManager_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, NORECOVERY
--GO

--RESTORE DATABASE TV13 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\TV13\FULL\CMKTDB13QA_TV13_FULL_20190425_112906.bak' 
--WITH  
--  FILE = 1
--, MOVE N'TV13_Data' TO N'K:\UserDBdata\TV13_data.mdf'
--, MOVE N'TV13_Log' TO N'L:\UserDBlog\TV13_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, NORECOVERY
--GO

--RESTORE DATABASE TVAlert13 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\TVAlert13\FULL\CMKTDB13QA_TVAlert13_FULL_20190425_112908.bak' 
--WITH  
--  FILE = 1
--, MOVE N'TVAlert13_Data' TO N'K:\UserDBdata\TVAlert13_data.mdf'
--, MOVE N'TVAlert13_Log' TO N'L:\UserDBlog\TVAlert13_log.1df'
--, NOUNLOAD
--, REPLACE
--, STATS = 5
--, NORECOVERY
--GO

--- APPLY FINAL DIFF BACKUPS


RESTORE DATABASE CMP13 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup06\CMKTMC13PR$CMKTAG13pr\CMP13\DIFF\CMKTMC13PR$CMKTAG13pr_CMP13_DIFF_20190508_151601.bak' 
WITH  
  FILE = 1
, MOVE N'CMKTDB13_Data' TO N'K:\UserDBdata\CMP13_data.mdf'
, MOVE N'CMKTDB13_Data2' TO N'K:\UserDBdata\CMP13_data2.ndf'
, MOVE N'CMKTDB13_Log' TO N'L:\UserDBlog\CMP13_log.1df'
, NOUNLOAD
, STATS = 5
, RECOVERY
GO

--RESTORE DATABASE CMKTCRYPTO 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\CMKTCRYPTO\DIFF\-----------------------------.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMKTCRYPTO'     TO N'K:\UserDBdata\CMKTCRYPTO_data.mdf'
--, MOVE N'CMKTCRYPTO_Log' TO N'L:\UserDBlog\CMKTCRYPTO_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE CMPSDS 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\CMPSDS\DIFF\-----------------------------.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMPSDS_Data' TO N'K:\UserDBdata\CMPSDS_data.mdf'
--, MOVE N'CMPSDS_Log' TO N'L:\UserDBlog\CMPSDS_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE dbInfogenesis 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\dbInfogenesis\DIFF\-----------------------------.bak' 
--WITH  
--  FILE = 1
--, MOVE N'dbInfogenesis_Data' TO N'K:\UserDBdata\dbInfogenesis_data.mdf'
--, MOVE N'dbInfogenesis_Log' TO N'L:\UserDBlog\dbInfogenesis_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE PKMS_OBJ 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\PKMS_OBJ\DIFF\-----------------------------.bak' 
--WITH  
--  FILE = 1
--, MOVE N'PKMS_OBJ'     TO N'K:\UserDBdata\PKMS_OBJ_data.mdf'
--, MOVE N'PKMS_OBJ_Log' TO N'L:\UserDBlog\PKMS_OBJ_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE PrintManager 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\PrintManager\DIFF\-----------------------------.bak' 
--WITH  
--  FILE = 1
--, MOVE N'PrintManager_Data' TO N'K:\UserDBdata\PrintManager_data.mdf'
--, MOVE N'PrintManager_Log' TO N'L:\UserDBlog\PrintManager_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE TV13 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\TV13\DIFF\-----------------------------.bak' 
--WITH  
--  FILE = 1
--, MOVE N'TV13_Data' TO N'K:\UserDBdata\TV13_data.mdf'
--, MOVE N'TV13_Log' TO N'L:\UserDBlog\TV13_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE TVAlert13 
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\CMKTDB13QA\TVAlert13\DIFF\-----------------------------.bak' 
--WITH  
--  FILE = 1
--, MOVE N'TVAlert13_Data' TO N'K:\UserDBdata\TVAlert13_data.mdf'
--, MOVE N'TVAlert13_Log' TO N'L:\UserDBlog\TVAlert13_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO