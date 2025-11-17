USE [master]
RESTORE DATABASE CMKTDB 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\CMKTDB.bak' 
WITH  
  FILE = 1
--, MOVE N'CMKTDB' TO N'K:\UserDBdata\CMKTDB_data.mdf'
--, MOVE N'CMKTDB_log' TO N'L:\UserDBlog\CMKTDB_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE CMKTDB
SET COMPATIBILITY_LEVEL = 130;

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'CMKTDB13QA' ;
GO

