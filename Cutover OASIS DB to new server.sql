:Connect OASISDB01PR

BACKUP DATABASE [CTSDevices] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSDevices.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [CTSReportEngine] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSReportEngine.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [CTSSystemStats] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSSystemStats.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [FuzzyMatch] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\FuzzyMatch.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Historian] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\Historian.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Housekeeping] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\Housekeeping.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [PerformanceStats] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\PerformanceStats.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [ReportServer] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServer.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [ReportServerTempDB] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServerTempDB.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [SpeechTransactions] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\SpeechTransactions.bak' WITH INIT, COMPRESSION,  STATS = 5

GO


:Connect OASISDB01QA

DROP DATABASE [CTSDevices]

DROP DATABASE [CTSReportEngine]

DROP DATABASE [CTSSystemStats]

DROP DATABASE [FuzzyMatch]

DROP DATABASE [Historian]

DROP DATABASE [Housekeeping]

DROP DATABASE [PerformanceStats]

DROP DATABASE [ReportServer]

DROP DATABASE [ReportServerTempDB]

DROP DATABASE [SpeechTransactions]


RESTORE DATABASE [CTSDevices] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSDevices.bak' 
WITH 
  MOVE N'CTSDevices' TO N'C:\SQL_UserDBdata\CTSDevices_data.mdf'
, MOVE N'CTSDevices_log' TO N'C:\SQL_UserDBlog\CTSDevices_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [CTSReportEngine] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSReportEngine.bak' 
WITH 
  MOVE N'CTSReportEngine' TO N'C:\SQL_UserDBdata\CTSReportEngine_data.mdf'
, MOVE N'CTSReportEngine_log' TO N'C:\SQL_UserDBlog\CTSReportEngine_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [CTSSystemStats] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSSystemStats.bak'
WITH 
  MOVE N'CTSSystemStats' TO N'C:\SQL_UserDBdata\CTSSystemStats_data.mdf'
, MOVE N'CTSSystemStats_log' TO N'C:\SQL_UserDBlog\CTSSystemStats_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [FuzzyMatch] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\FuzzyMatch.bak'
WITH 
  MOVE N'FuzzyMatch' TO N'C:\SQL_UserDBdata\FuzzyMatch_data.mdf'
, MOVE N'FuzzyMatch_log' TO N'C:\SQL_UserDBlog\FuzzyMatch_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [Historian] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\Historian.bak'
WITH 
  MOVE N'Historian' TO N'C:\SQL_UserDBdata\Historian_data.mdf'
, MOVE N'Historian_log' TO N'C:\SQL_UserDBlog\Historian_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [Housekeeping] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\Housekeeping.bak'
WITH 
  MOVE N'Housekeeping' TO N'C:\SQL_UserDBdata\Housekeeping_data.mdf'
, MOVE N'Housekeeping_log' TO N'C:\SQL_UserDBlog\Housekeeping_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [PerformanceStats] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\PerformanceStats.bak'
WITH 
  MOVE N'PerformanceStats' TO N'C:\SQL_UserDBdata\PerformanceStats_data.mdf'
, MOVE N'PerformanceStats_log' TO N'C:\SQL_UserDBlog\PerformanceStats_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [ReportServer] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServer.bak'
WITH 
  MOVE N'ReportServer' TO N'C:\SQL_UserDBdata\ReportServer_data.mdf'
, MOVE N'ReportServer_log' TO N'C:\SQL_UserDBlog\ReportServer_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [ReportServerTempDB] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServerTempDB.bak'
WITH 
  MOVE N'ReportServerTempDB' TO N'C:\SQL_UserDBdata\ReportServerTempDB_data.mdf'
, MOVE N'ReportServerTempDB_log' TO N'C:\SQL_UserDBlog\ReportServerTempDB_log.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [SpeechTransactions] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\SpeechTransactions.bak'
WITH 
  MOVE N'SpeechTransactions' TO N'C:\SQL_UserDBdata\SpeechTransactions_data.mdf'
, MOVE N'SpeechTransactions_log' TO N'C:\SQL_UserDBlog\SpeechTransactions_log.ldf'
,REPLACE, RECOVERY, STATS = 5

GO

----:Connect OASISDB01PR

----BACKUP LOG [CTSDevices] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSDevices.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [CTSReportEngine] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSReportEngine.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [CTSSystemStats] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSSystemStats.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [FuzzyMatch] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\FuzzyMatch.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [Historian] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\Historian.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [Housekeeping] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\Housekeeping.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [PerformanceStats] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\PerformanceStats.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [ReportServer] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServer.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [ReportServerTempDB] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServerTempDB.trn' WITH COMPRESSION,  STATS = 5

----BACKUP LOG [SpeechTransactions] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\SpeechTransactions.trn' WITH COMPRESSION,  STATS = 5

----GO


----:Connect OASISDB01QA

----RESTORE LOG [CTSDevices] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSDevices.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [CTSReportEngine] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSReportEngine.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [CTSSystemStats] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CTSSystemStats.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [FuzzyMatch] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\FuzzyMatch.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [Historian] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\Historian.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [Housekeeping] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\Housekeeping.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [PerformanceStats] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\PerformanceStats.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [ReportServer] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServer.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [ReportServerTempDB] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\ReportServerTempDB.trn' WITH RECOVERY, STATS = 5

----RESTORE LOG [SpeechTransactions] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\SpeechTransactions.trn' WITH RECOVERY, STATS = 5

----GO

