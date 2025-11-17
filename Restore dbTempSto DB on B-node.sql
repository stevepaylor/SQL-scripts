USE master;
GO

RESTORE DATABASE [dbTempSto] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\CMKTDB13CPR\dbTempSto\FULL\CMKTDB13CPR_dbTempSto_FULL_20180924_094900.bak' 
WITH
  MOVE N'dbTempSto' TO N'K:\UserDBdata\dbTempSto_data.mdf'
, MOVE N'dbTempSto_log' TO N'L:\UserDBlog\dbTempSto_log.ldf'
, REPLACE
, RECOVERY  
, STATS = 5
GO