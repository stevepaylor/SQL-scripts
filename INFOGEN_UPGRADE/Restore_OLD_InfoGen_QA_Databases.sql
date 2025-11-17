 -- RESTORE ON CASIDB24BQA\INFOGEN

USE master
RESTORE DATABASE ig_app
FROM   DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_app.bak' 
WITH  
  FILE = 1
, MOVE N'ig_appData' TO N'K:\UserDBdata_INFOGEN\ig_app_data.mdf'
, MOVE N'ig_appLog'  TO N'L:\UserDBlog_INFOGEN\ig_app_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE ig_app SET COMPATIBILITY_LEVEL = 130;
GO


----USE master
----RESTORE DATABASE ig_auditdata
----FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_auditdata.bak' 
----WITH  
----  FILE = 1
----, MOVE N'ig_auditdataData' TO N'K:\UserDBdata_INFOGEN\ig_auditdata_data.mdf'
----, MOVE N'ig_auditdataLog'  TO N'L:\UserDBlog_INFOGEN\ig_auditdata_log.ldf'
----, NOUNLOAD
----, REPLACE
----, STATS = 5
----GO

------ALTER DATABASE ig_auditdata SET COMPATIBILITY_LEVEL = 130;
------GO

USE master
RESTORE DATABASE ig_business
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_business.bak' 
WITH  
  FILE = 1
, MOVE N'ig_businessData' TO N'K:\UserDBdata_INFOGEN\ig_business_data.mdf'
, MOVE N'ig_businessLog'  TO N'L:\UserDBlog_INFOGEN\ig_business_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE ig_business SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE ig_dimension
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_dimension.bak' 
WITH  
  FILE = 1
, MOVE N'ig_dimensionData' TO N'K:\UserDBdata_INFOGEN\ig_dimension_data.mdf'
, MOVE N'ig_dimensionLog'  TO N'L:\UserDBlog_INFOGEN\ig_dimension_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE ig_dimension SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE ig_log
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_log.bak' 
WITH  
  FILE = 1
, MOVE N'ig_logData' TO N'K:\UserDBdata_INFOGEN\ig_log_data.mdf'
, MOVE N'ig_logLog'  TO N'L:\UserDBlog_INFOGEN\ig_log_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE ig_log SET COMPATIBILITY_LEVEL = 130;
GO

----USE master
----RESTORE DATABASE ig_managedsoftware
----FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_managedsoftware.bak'
----WITH  
----  FILE = 1
------, MOVE N'ig_managedsoftwareData' TO N'K:\UserDBdata_INFOGEN\ig_managedsoftware_data.mdf'
------, MOVE N'ig_managedsoftwareLog'  TO N'L:\UserDBlog_INFOGEN\ig_managedsoftware_log.ldf'
----, NOUNLOAD
----, REPLACE
----, STATS = 5
----GO

----ALTER DATABASE ig_managedsoftware SET COMPATIBILITY_LEVEL = 130;
----GO

USE master
RESTORE DATABASE ig_revconfig
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_revconfig.bak'
WITH  
  FILE = 1
, MOVE N'ig_revconfigData' TO N'K:\UserDBdata_INFOGEN\ig_revconfig_data.mdf'
, MOVE N'ig_revconfigLog'  TO N'L:\UserDBlog_INFOGEN\ig_revconfig_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE ig_revconfig SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE ig_task
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_task.bak' 
WITH  
  FILE = 1
, MOVE N'ig_taskData' TO N'K:\UserDBdata_INFOGEN\ig_task_data.mdf'
, MOVE N'ig_taskLog'  TO N'L:\UserDBlog_INFOGEN\ig_task_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE ig_task SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE ig_transaction
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_transaction.bak'
WITH  
  FILE = 1
, MOVE N'ig_transactionData' TO N'K:\UserDBdata_INFOGEN\ig_transaction_data.mdf'
, MOVE N'ig_transactionLog'  TO N'L:\UserDBlog_INFOGEN\ig_transaction_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE ig_transaction SET COMPATIBILITY_LEVEL = 130;
GO

------USE master
------RESTORE DATABASE ig_transform
------FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\ig_transform.bak'
------WITH  
------  FILE = 1
------, MOVE N'ig_transformData' TO N'K:\UserDBdata_INFOGEN\ig_transform_data.mdf'
------, MOVE N'ig_transformLog'  TO N'L:\UserDBlog_INFOGEN\ig_transform_log.ldf'
------, NOUNLOAD
------, REPLACE
------, STATS = 5
------GO

ALTER DATABASE ig_transform SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE it_cfg
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\it_cfg.bak' 
WITH  
  FILE = 1
, MOVE N'it_cfgData' TO N'K:\UserDBdata_INFOGEN\it_cfg_data.mdf'
, MOVE N'it_cfgLog'  TO N'L:\UserDBlog_INFOGEN\it_cfg_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE it_cfg SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE it_ga
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\it_ga.bak'
WITH  
  FILE = 1
, MOVE N'it_gaData' TO N'K:\UserDBdata_INFOGEN\it_ga_data.mdf'
, MOVE N'it_gaLog'  TO N'L:\UserDBlog_INFOGEN\it_ga_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE it_ga SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE it_perms
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\it_perms.bak'
WITH  
  FILE = 1
, MOVE N'it_permsData' TO N'K:\UserDBdata_INFOGEN\it_perms_data.mdf'
, MOVE N'it_permsLog'  TO N'L:\UserDBlog_INFOGEN\it_perms_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE it_perms SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE it_rlt
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\it_rlt.bak' 
WITH  
  FILE = 1
, MOVE N'it_rltData' TO N'K:\UserDBdata_INFOGEN\it_rlt_data.mdf'
, MOVE N'it_rltLog'  TO N'L:\UserDBlog_INFOGEN\it_rlt_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE it_rlt SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE it_sysweb
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\it_sysweb.bak'
WITH  
  FILE = 1
, MOVE N'it_syswebData' TO N'K:\UserDBdata_INFOGEN\it_sysweb_data.mdf'
, MOVE N'it_syswebLog'  TO N'L:\UserDBlog_INFOGEN\it_sysweb_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE it_sysweb SET COMPATIBILITY_LEVEL = 130;
GO

USE master
RESTORE DATABASE it_trn
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_old_PROD\it_trn.bak'
WITH  
  FILE = 1
, MOVE N'it_trnData' TO N'K:\UserDBdata_INFOGEN\it_trn_data.mdf'
, MOVE N'it_trnLog'  TO N'L:\UserDBlog_INFOGEN\it_trn_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

ALTER DATABASE it_trn SET COMPATIBILITY_LEVEL = 130;
GO

-- Must Update stats after changing compatibility level

EXEC msdb.dbo.sp_start_job @job_name = N'DBA - Update Stats';
GO




