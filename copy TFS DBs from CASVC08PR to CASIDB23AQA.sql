-- Run on [CASIVC08PR/CASIVC08PR] in SQLCMD mode (Menu: Query --> SQLCMD Mode)

----BACKUP DATABASE [Tfs_ViejasITSS] 
----TO  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_ViejasITSS.bak' 
----WITH 
----  NOFORMAT
----, INIT
----, COPY_ONLY
----, STATS = 5
----GO

-- RESTORE ON CASIDB23AQA

:CONNECT CASIDB23AQA

USE [master]
RESTORE DATABASE [Tfs_ViejasITSS] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_ViejasITSS.bak' 
WITH  
  FILE = 1
, MOVE N'Tfs_ViejasITSS' TO N'K:\UserDBdata\Tfs_ViejasITSS_data2.mdf'
, MOVE N'Tfs_ViejasITSS_log' TO N'L:\UserDBlog\Tfs_ViejasITSS_log2.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

-- Must run update stats after databases are upgraded.  

:CONNECT CASIDB23AQA

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'CASIDB23AQA' ;
GO

