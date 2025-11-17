----------------------------------------------
-- PKMS_OBJ
----------------------------------------------
USE [master]
RESTORE DATABASE PKMS_OBJ
FROM DISK = N'\\CMKTDB13BPR\SQLBackup\PKMS_OBJ_FULL.bak'
WITH  
  FILE = 1
, MOVE N'PKMS_OBJ'  TO N'K:\UserDBdata\PKMS_OBJ_data.mdf'
, MOVE N'PKMS_OBJ_Log'   TO N'L:\UserDBlog\PKMS_OBJ_log.ldf'
, NOUNLOAD
, REPLACE
, RECOVERY
, STATS = 5
GO