-- Run on CASIDB02pr in SQLCMD mode (Menu: Query --> SQLCMD Mode)

BACKUP DATABASE CRManalytics 
TO  DISK = N'\\CMKTDB13Bpr\SQLBackup\CRManalytics.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5
GO

-- RESTORE ON MSBIDB01dv

:CONNECT MSBIDB01dv

USE [master]
RESTORE DATABASE CRManalytics 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\CRManalytics.bak' 
WITH  
  FILE = 1
--, MOVE N'CRManalytics' TO N'K:\UserDBdata\CRManalytics_data.mdf'
--, MOVE N'CRManalytics_log' TO N'L:\UserDBlog\CRManalytics_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

-- Must run update stats after databases are upgraded.  

:CONNECT MSBIDB01dv

ALTER DATABASE CRManalytics
SET COMPATIBILITY_LEVEL = 130;

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'MSBIDB01dv' ;
GO

