-- Run on CMKTDB13APR in SQLCMD mode (Menu: Query --> SQLCMD Mode)

----:CONNECT [CMKTDB13APR]

----BACKUP DATABASE CMPSDS 
----TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CMPSDS.bak' 
----WITH 
----  NOFORMAT
----, INIT
----, COPY_ONLY
----, STATS = 5
----GO

--**********************************************************************************************************************
-- RESTORE ON CMKTDB13AQA

--:CONNECT [CMKTDB13AQA]

USE [master]
RESTORE DATABASE CMPSDS
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CMPSDS.bak'
WITH  
  --FILE = 1
--, MOVE N'CMPSDS_Data' TO N'K:\UserDBdata\CMPSDS_data.mdf'
--, MOVE N'CMPSDS_Log'  TO N'L:\UserDBlog\CMPSDS_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

-- Must run update stats after databases are upgraded.  

--:CONNECT [CMKTDB13AQA]

ALTER DATABASE CMPSDS
SET COMPATIBILITY_LEVEL = 100;

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'CMKTDB13AQA' ;
GO

--**********************************************************************************************************************/
