USE [master]
RESTORE DATABASE SDSVJPRD_Archive2
FROM DISK = N'\\DBAMBK01PR\SQLBackup02\_PreUpgrade\SDSVJPRD_Archive_FULL.bak'  
WITH  
  FILE = 1
, MOVE N'SDS_DB' TO N'X:\UserDBdata\SDSVJPRD_Archive2_data.mdf'
, MOVE N'SDS_DB_log'  TO 'X:\UserDBlog\SDSVJPRD_Archive2_log.ldf'
, NOUNLOAD
, REPLACE
, NORECOVERY
, STATS = 5
GO

USE [master]
RESTORE DATABASE SDSVJPRD_Archive2
FROM DISK = N'\\DBAMBK01PR\SQLBackup02\_PreUpgrade\SDSVJPRD_Archive_DIFF.bak'   
WITH  
  FILE = 1
, MOVE N'SDS_DB' TO N'X:\UserDBdata\SDSVJPRD_Archive2_data.mdf'
, MOVE N'SDS_DB_log'  TO 'X:\UserDBlog\SDSVJPRD_Archive2_log.ldf'
, NOUNLOAD
, RECOVERY
, STATS = 5
GO