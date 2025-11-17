----USE master;
----GO

----RESTORE DATABASE ReportServer 
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\CASIVC08PR$CASIVC08PR\ReportServer\FULL\CASIVC08PR$CASIVC08PR_ReportServer_FULL_20190226_074159.bak' 
----WITH  
----  FILE = 1
----, MOVE N'ReportServer'     TO N'D:\Data\ReportServer_data.mdf'
----, MOVE N'ReportServer_Log' TO N'L:\Log\ReportServer_log.ldf'
----, NOUNLOAD
----, REPLACE
----, STATS = 5
----, NORECOVERY
----GO

----RESTORE DATABASE ReportServer 
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\CASIVC08PR$CASIVC08PR\ReportServer\DIFF\CASIVC08PR$CASIVC08PR_ReportServer_DIFF_20190227_105426.bak' 
----WITH  
----  FILE = 1
----, MOVE N'ReportServer'     TO N'D:\Data\ReportServer_data.mdf'
----, MOVE N'ReportServer_Log' TO N'L:\Log\ReportServer_log.ldf'
----, NOUNLOAD
----, STATS = 5
----, RECOVERY
----GO

USE master;
GO

RESTORE DATABASE ReportServerTempDB 
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\CASIVC08PR$CASIVC08PR\ReportServerTempDB\FULL\CASIVC08PR$CASIVC08PR_ReportServerTempDB_FULL_20190226_074221.bak' 
WITH  
  FILE = 1
, MOVE N'ReportServerTempDB'     TO N'D:\Data\ReportServerTempDB_data.mdf'
, MOVE N'ReportServerTempDB_Log' TO N'L:\Log\ReportServerTempDB_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
, NORECOVERY
GO

RESTORE DATABASE ReportServerTempDB 
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\CASIVC08PR$CASIVC08PR\ReportServerTempDB\DIFF\CASIVC08PR$CASIVC08PR_ReportServerTempDB_DIFF_20190227_105428.bak' 
WITH  
  FILE = 1
, MOVE N'ReportServerTempDB'     TO N'D:\Data\ReportServerTempDB_data.mdf'
, MOVE N'ReportServerTempDB_Log' TO N'L:\Log\ReportServerTempDB_log.ldf'
, NOUNLOAD
, STATS = 5
, RECOVERY
GO