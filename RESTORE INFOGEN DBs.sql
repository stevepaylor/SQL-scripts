-- RESTORE ON CASIDB24AQA\INFOGEN

----USE [master]
----RESTORE DATABASE ig_app
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_app\FULL\AGINDB01QA$INFOGEN_ig_app_FULL_20191001_103552.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_appData' TO N'K:\UserDBdata_INFOGEN\ig_app_data.mdf'
----, MOVE N'ig_appLog'  TO N'L:\UserDBlog_INFOGEN\ig_app_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO


----USE [master]
----RESTORE DATABASE ig_auditdata
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_auditdata\FULL\AGINDB01QA$INFOGEN_ig_auditdata_FULL_20191001_103552.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_auditdataData' TO N'K:\UserDBdata_INFOGEN\ig_auditdata_data.mdf'
----, MOVE N'ig_auditdataLog'  TO N'L:\UserDBlog_INFOGEN\ig_auditdata_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



--USE [master]
--RESTORE DATABASE ig_business
--FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_business\FULL\AGINDB01QA$INFOGEN_ig_business_FULL_20191001_103554.bak'
--WITH  
--  FILE = 1
--, MOVE N'ig_businessData' TO N'K:\UserDBdata_INFOGEN\ig_business_data.mdf'
--, MOVE N'ig_businessLog'  TO N'L:\UserDBlog_INFOGEN\ig_business_log.ldf'
--, NOUNLOAD
----, REPLACE
--, STATS = 5
--GO



----USE [master]
----RESTORE DATABASE ig_dimension
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_dimension\FULL\AGINDB01QA$INFOGEN_ig_dimension_FULL_20191001_110702.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_dimensionData' TO N'K:\UserDBdata_INFOGEN\ig_dimension_data.mdf'
----, MOVE N'ig_dimensionLog'  TO N'L:\UserDBlog_INFOGEN\ig_dimension_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE ig_log
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_log\FULL\AGINDB01QA$INFOGEN_ig_log_FULL_20191001_110704.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_logData' TO N'K:\UserDBdata_INFOGEN\ig_log_data.mdf'
----, MOVE N'ig_logLog'  TO N'L:\UserDBlog_INFOGEN\ig_log_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



------USE [master]
------RESTORE DATABASE ig_managedsoftware
------FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\ig_managedsoftware.bak'
------WITH  
------  FILE = 1
--------, MOVE N'ig_managedsoftwareData' TO N'K:\UserDBdata_INFOGEN\ig_managedsoftware_data.mdf'
--------, MOVE N'ig_managedsoftwareLog'  TO N'L:\UserDBlog_INFOGEN\ig_managedsoftware_log.ldf'
------, NOUNLOAD
--------, REPLACE
------, STATS = 5
------GO



----USE [master]
----RESTORE DATABASE ig_revconfig
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_revconfig\FULL\AGINDB01QA$INFOGEN_ig_revconfig_FULL_20191001_110928.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_revconfigData' TO N'K:\UserDBdata_INFOGEN\ig_revconfig_data.mdf'
----, MOVE N'ig_revconfigLog'  TO N'L:\UserDBlog_INFOGEN\ig_revconfig_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE ig_task
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_task\FULL\AGINDB01QA$INFOGEN_ig_task_FULL_20191001_110929.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_taskData' TO N'K:\UserDBdata_INFOGEN\ig_task_data.mdf'
----, MOVE N'ig_taskLog'  TO N'L:\UserDBlog_INFOGEN\ig_task_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE ig_transaction
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_transaction\FULL\AGINDB01QA$INFOGEN_ig_transaction_FULL_20191001_110930.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_transactionData' TO N'K:\UserDBdata_INFOGEN\ig_transaction_data.mdf'
----, MOVE N'ig_transactionLog'  TO N'L:\UserDBlog_INFOGEN\ig_transaction_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE ig_transform
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_transform\FULL\AGINDB01QA$INFOGEN_ig_transform_FULL_20191001_112626.bak'
----WITH  
----  FILE = 1
----, MOVE N'ig_transformData' TO N'K:\UserDBdata_INFOGEN\ig_transform_data.mdf'
----, MOVE N'ig_transformLog'  TO N'L:\UserDBlog_INFOGEN\ig_transform_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE it_cfg
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\it_cfg\FULL\AGINDB01QA$INFOGEN_it_cfg_FULL_20191001_112627.bak'
----WITH  
----  FILE = 1
----, MOVE N'it_cfgData' TO N'K:\UserDBdata_INFOGEN\it_cfg_data.mdf'
----, MOVE N'it_cfgLog'  TO N'L:\UserDBlog_INFOGEN\it_cfg_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE it_ga
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\it_ga\FULL\AGINDB01QA$INFOGEN_it_ga_FULL_20191001_112816.bak'
----WITH  
----  FILE = 1
----, MOVE N'it_gaData' TO N'K:\UserDBdata_INFOGEN\it_ga_data.mdf'
----, MOVE N'it_gaLog'  TO N'L:\UserDBlog_INFOGEN\it_ga_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE it_perms
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\it_perms\FULL\AGINDB01QA$INFOGEN_it_perms_FULL_20191001_112817.bak'
----WITH  
----  FILE = 1
----, MOVE N'it_permsData' TO N'K:\UserDBdata_INFOGEN\it_perms_data.mdf'
----, MOVE N'it_permsLog'  TO N'L:\UserDBlog_INFOGEN\it_perms_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE it_rlt
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\it_rlt\FULL\AGINDB01QA$INFOGEN_it_rlt_FULL_20191001_112818.bak'
----WITH  
----  FILE = 1
----, MOVE N'it_rltData' TO N'K:\UserDBdata_INFOGEN\it_rlt_data.mdf'
----, MOVE N'it_rltLog'  TO N'L:\UserDBlog_INFOGEN\it_rlt_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE it_sysweb
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\it_sysweb\FULL\AGINDB01QA$INFOGEN_it_sysweb_FULL_20191001_113133.bak'
----WITH  
----  FILE = 1
----, MOVE N'it_syswebData' TO N'K:\UserDBdata_INFOGEN\it_sysweb_data.mdf'
----, MOVE N'it_syswebLog'  TO N'L:\UserDBlog_INFOGEN\it_sysweb_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO



----USE [master]
----RESTORE DATABASE it_trn
----FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\it_trn\FULL\AGINDB01QA$INFOGEN_it_trn_FULL_20191001_113135.bak'
----WITH  
----  FILE = 1
----, MOVE N'it_trnData' TO N'K:\UserDBdata_INFOGEN\it_trn_data.mdf'
----, MOVE N'it_trnLog'  TO N'L:\UserDBlog_INFOGEN\it_trn_log.ldf'
----, NOUNLOAD
------, REPLACE
----, STATS = 5
----GO

*****************************************************/

-- Must run update stats after databases are upgraded.  



ALTER DATABASE ig_app
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_auditdata
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_business
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_dimension
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_log
SET COMPATIBILITY_LEVEL = 140;

----ALTER DATABASE ig_managedsoftware
----SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_revconfig
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_task
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_transaction
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE ig_transform
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE it_cfg
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE it_ga
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE it_perms
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE it_rlt
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE it_sysweb
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE it_trn
SET COMPATIBILITY_LEVEL = 140;

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'CASIDB24AQA\INFOGEN' ;
GO


