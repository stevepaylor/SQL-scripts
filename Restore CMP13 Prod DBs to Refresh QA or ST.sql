USE master;
GO

--RESTORE DATABASE CMKTCRYPTO 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\CMKTCRYPTO.bak'  
--WITH  
--  FILE = 1
--, MOVE N'CMKTCRYPTO' TO N'K:\UserDBdata\CMKTCRYPTO_data.mdf'
--, MOVE N'CMKTCRYPTO_Log' TO N'L:\UserDBlog\CMKTCRYPTO_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE CMP_RATING 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\CMP_RATING.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMP_RATING'     TO N'K:\UserDBdata\CMP_RATING_data.mdf'
--, MOVE N'CMP_RATING_Log' TO N'L:\UserDBlog\CMP_RATING_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

RESTORE DATABASE CMP13 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\CMP13.bak'  
WITH  
  FILE = 1
, MOVE N'CMKTDB13_Data' TO N'K:\UserDBdata\CMP13_data.mdf'
, MOVE N'CMKTDB13_Data2' TO N'K:\UserDBdata\CMP13_data2.ndf'
, MOVE N'CMKTDB13_Log' TO N'L:\UserDBlog\CMP13_log.1df'
, NOUNLOAD
, STATS = 5
, RECOVERY
GO

--RESTORE DATABASE CMPAPI 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\CMPAPI.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMPAPI' TO N'K:\UserDBdata\CMPAPI_data.mdf'
--, MOVE N'CMPAPI_Log' TO N'L:\UserDBlog\CMPAPI_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE CMPSDS 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\CMPSDS.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CMPSDS_Data' TO N'K:\UserDBdata\CMPSDS_data.mdf'
--, MOVE N'CMPSDS_Log' TO N'L:\UserDBlog\CMPSDS_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE dbInfogenesis 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\dbInfogenesis.bak'  
--WITH  
--  FILE = 1
--, MOVE N'dbInfogenesis_Data' TO N'K:\UserDBdata\dbInfogenesis_data.mdf'
--, MOVE N'dbInfogenesis_Log' TO N'L:\UserDBlog\dbInfogenesis_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE PKMS_OBJ 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\PKMS_OBJ.bak'   
--WITH  
--  FILE = 1
--, MOVE N'PKMS_OBJ'     TO N'K:\UserDBdata\PKMS_OBJ_data.mdf'
--, MOVE N'PKMS_OBJ_Log' TO N'L:\UserDBlog\PKMS_OBJ_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE PrintManager 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\PrintManager.bak' 
--WITH  
--  FILE = 1
--, MOVE N'PrintManager_Data' TO N'K:\UserDBdata\PrintManager_data.mdf'
--, MOVE N'PrintManager_Log' TO N'L:\UserDBlog\PrintManager_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE TV13 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\TV13.bak' 
--WITH  
--  FILE = 1
--, MOVE N'TV13_Data' TO N'K:\UserDBdata\TV13_data.mdf'
--, MOVE N'TV13_Log' TO N'L:\UserDBlog\TV13_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE TVAlert13 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\TVAlert13.bak'
--WITH  
--  FILE = 1
--, MOVE N'TVAlert13_Data' TO N'K:\UserDBdata\TVAlert13_data.mdf'
--, MOVE N'TVAlert13_Log' TO N'L:\UserDBlog\TVAlert13_log.1df'
--, NOUNLOAD
--, RECOVERY
--GO

--RESTORE DATABASE vCMSUpdate 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\vCMSUpdate.bak'
--WITH  
--  FILE = 1
--, MOVE N'vCMSUpdate_Data' TO N'K:\UserDBdata\vCMSUpdate_data.mdf'
--, MOVE N'vCMSUpdate_Log' TO N'L:\UserDBlog\vCMSUpdate_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO

--RESTORE DATABASE ZipCodes 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ZipCodes.bak'
--WITH  
--  FILE = 1
--, MOVE N'ZipCodes'     TO N'K:\UserDBdata\ZipCodes_data.mdf'
--, MOVE N'ZipCodes_Log' TO N'L:\UserDBlog\ZipCodes_log.1df'
--, NOUNLOAD
--, STATS = 5
--, RECOVERY
--GO
