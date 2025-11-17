--USE [master]
--RESTORE DATABASE ig_app_v1
--FROM   DISK = N'K:\INFOGEN_0113\ig_app.bak' 
--WITH  
--  FILE = 1
--, MOVE N'ig_appData' TO N'K:\UserDBdata\ig_app_v1_data.mdf'
--, MOVE N'ig_appLog'  TO N'L:\UserDBlog\ig_app_v1_log.ldf'
--, NOUNLOAD
----, REPLACE
--, STATS = 5
--GO


------USE [master]
------RESTORE DATABASE ig_auditdata
------FROM  DISK = N'K:\INFOGEN_0113\ig_auditdata.bak' 
------WITH  
------  FILE = 1
------, MOVE N'ig_auditdataData' TO N'K:\UserDBdata\ig_auditdata_v1_data.mdf'
------, MOVE N'ig_auditdataLog'  TO N'L:\UserDBlog\ig_auditdata_v1_log.ldf'
------, NOUNLOAD
--------, REPLACE
------, STATS = 5
------GO



--USE [master]
--RESTORE DATABASE ig_business_v1
--FROM  DISK = N'K:\INFOGEN_0113\ig_business.bak' 
--WITH  
--  FILE = 1
--, MOVE N'ig_businessData' TO N'K:\UserDBdata\ig_business_v1_data.mdf'
--, MOVE N'ig_businessLog'  TO N'L:\UserDBlog\ig_business_v1_log.ldf'
--, NOUNLOAD
----, REPLACE
--, STATS = 5
--GO



--USE [master]
--RESTORE DATABASE ig_dimension_v1
--FROM  DISK = N'K:\INFOGEN_0113\ig_dimension.bak' 
--WITH  
--  FILE = 1
--, MOVE N'ig_dimensionData' TO N'K:\UserDBdata\ig_dimension_v1_data.mdf'
--, MOVE N'ig_dimensionLog'  TO N'L:\UserDBlog\ig_dimension_v1_log.ldf'
--, NOUNLOAD
----, REPLACE
--, STATS = 5
--GO



--USE [master]
--RESTORE DATABASE ig_log_v1
--FROM  DISK = N'K:\INFOGEN_0113\ig_log.bak' 
--WITH  
--  FILE = 1
--, MOVE N'ig_logData' TO N'K:\UserDBdata\ig_log_v1_data.mdf'
--, MOVE N'ig_logLog'  TO N'L:\UserDBlog\ig_log_v1_log.ldf'
--, NOUNLOAD
----, REPLACE
--, STATS = 5
--GO



--------USE [master]
--------RESTORE DATABASE ig_managedsoftware
--------FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\ig_managedsoftware.bak'
--------WITH  
--------  FILE = 1
----------, MOVE N'ig_managedsoftwareData' TO N'K:\UserDBdata\ig_managedsoftware_v1_data.mdf'
----------, MOVE N'ig_managedsoftwareLog'  TO N'L:\UserDBlog\ig_managedsoftware_v1_log.ldf'
--------, NOUNLOAD
----------, REPLACE
--------, STATS = 5
--------GO



--USE [master]
--RESTORE DATABASE ig_revconfig_v1
--FROM  DISK = N'K:\INFOGEN_0113\ig_revconfig.bak'
--WITH  
--  FILE = 1
--, MOVE N'ig_revconfigData' TO N'K:\UserDBdata\ig_revconfig_v1_data.mdf'
--, MOVE N'ig_revconfigLog'  TO N'L:\UserDBlog\ig_revconfig_v1_log.ldf'
--, NOUNLOAD
----, REPLACE
--, STATS = 5
--GO



--USE [master]
--RESTORE DATABASE ig_task_v1
--FROM  DISK = N'K:\INFOGEN_0113\ig_task.bak' 
--WITH  
--  FILE = 1
--, MOVE N'ig_taskData' TO N'K:\UserDBdata\ig_task_v1_data.mdf'
--, MOVE N'ig_taskLog'  TO N'L:\UserDBlog\ig_task_v1_log.ldf'
--, NOUNLOAD
----, REPLACE
--, STATS = 5
--GO



USE [master]
RESTORE DATABASE ig_transaction_v1
FROM  DISK = N'K:\INFOGEN_0113\ig_transaction.bak'
WITH  
  FILE = 1
, MOVE N'ig_transactionData' TO N'K:\UserDBdata\ig_transaction_v1_data.mdf'
, MOVE N'ig_transactionLog'  TO N'L:\UserDBlog\ig_transaction_v1_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO



------USE [master]
------RESTORE DATABASE ig_transform
------FROM  DISK = N'\\DBAMBK01PR\SQLBackup04_NONPROD\AGINDB01QA$INFOGEN\ig_transform\FULL\AGINDB01QA$INFOGEN_ig_transform_FULL_20191001_112626.bak'
------WITH  
------  FILE = 1
------, MOVE N'ig_transformData' TO N'K:\UserDBdata\ig_transform_v1_data.mdf'
------, MOVE N'ig_transformLog'  TO N'L:\UserDBlog\ig_transform_v1_log.ldf'
------, NOUNLOAD
--------, REPLACE
------, STATS = 5
------GO



USE [master]
RESTORE DATABASE it_cfg_v1
FROM  DISK = N'K:\INFOGEN_0113\it_cfg.bak' 
WITH  
  FILE = 1
, MOVE N'it_cfgData' TO N'K:\UserDBdata\it_cfg_v1_data.mdf'
, MOVE N'it_cfgLog'  TO N'L:\UserDBlog\it_cfg_v1_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO



USE [master]
RESTORE DATABASE it_ga_v1
FROM  DISK = N'K:\INFOGEN_0113\it_ga.bak'
WITH  
  FILE = 1
, MOVE N'it_gaData' TO N'K:\UserDBdata\it_ga_v1_data.mdf'
, MOVE N'it_gaLog'  TO N'L:\UserDBlog\it_ga_v1_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO



USE [master]
RESTORE DATABASE it_perms_v1
FROM  DISK = N'K:\INFOGEN_0113\it_perms.bak'
WITH  
  FILE = 1
, MOVE N'it_permsData' TO N'K:\UserDBdata\it_perms_v1_data.mdf'
, MOVE N'it_permsLog'  TO N'L:\UserDBlog\it_perms_v1_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO



USE [master]
RESTORE DATABASE it_rlt_v1
FROM  DISK = N'K:\INFOGEN_0113\it_rlt.bak' 
WITH  
  FILE = 1
, MOVE N'it_rltData' TO N'K:\UserDBdata\it_rlt_v1_data.mdf'
, MOVE N'it_rltLog'  TO N'L:\UserDBlog\it_rlt_v1_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO



USE [master]
RESTORE DATABASE it_sysweb_v1
FROM  DISK = N'K:\INFOGEN_0113\it_sysweb.bak'
WITH  
  FILE = 1
, MOVE N'it_syswebData' TO N'K:\UserDBdata\it_sysweb_v1_data.mdf'
, MOVE N'it_syswebLog'  TO N'L:\UserDBlog\it_sysweb_v1_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO



USE [master]
RESTORE DATABASE it_trn_v1
FROM  DISK = N'K:\INFOGEN_0113\it_trn.bak'
WITH  
  FILE = 1
, MOVE N'it_trnData' TO N'K:\UserDBdata\it_trn_v1_data.mdf'
, MOVE N'it_trnLog'  TO N'L:\UserDBlog\it_trn_v1_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO




