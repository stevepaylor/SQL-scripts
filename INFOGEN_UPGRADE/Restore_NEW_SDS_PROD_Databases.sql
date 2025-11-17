USE [master]
RESTORE DATABASE SDSVJPRD_Test
FROM DISK = N'\\CMKTDB13BPR\SQLBackup\SDSVJPRD.bak' 
WITH  
  FILE = 1
, MOVE N'SDS_DB' TO N'Y:\UserDBdata\SDSVJPRD_Test_data.mdf'
, MOVE N'SDS_DB_log'  TO 'Y:\UserDBlog\SDSVJPRD_Test_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO