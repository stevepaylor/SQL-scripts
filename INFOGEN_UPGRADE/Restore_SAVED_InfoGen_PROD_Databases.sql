USE master
RESTORE DATABASE SAVED_ig_app
FROM   DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\ig_app_FULL.bak' 
WITH  
  FILE = 1
, MOVE N'ig_appData' TO N'K:\UserDBdata\ig_app_SAVED_data.mdf'
, MOVE N'ig_appLog'  TO N'L:\UserDBlog\ig_app_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_ig_business
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\ig_business_FULL.bak' 
WITH  
  FILE = 1
, MOVE N'ig_businessData' TO N'K:\UserDBdata\ig_business_SAVED_data.mdf'
, MOVE N'ig_businessLog'  TO N'L:\UserDBlog\ig_business_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_ig_dimension
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\ig_dimension_FULL.bak' 
WITH  
  FILE = 1
, MOVE N'ig_dimensionData' TO N'K:\UserDBdata\ig_dimension_SAVED_data.mdf'
, MOVE N'ig_dimensionLog'  TO N'L:\UserDBlog\ig_dimension_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_ig_log
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\ig_log_FULL.bak' 
WITH  
  FILE = 1
, MOVE N'ig_logData' TO N'K:\UserDBdata\ig_log_SAVED_data.mdf'
, MOVE N'ig_logLog'  TO N'L:\UserDBlog\ig_log_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_ig_revconfig
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\ig_revconfig_FULL.bak'
WITH  
  FILE = 1
, MOVE N'ig_revconfigData' TO N'K:\UserDBdata\ig_revconfig_SAVED_data.mdf'
, MOVE N'ig_revconfigLog'  TO N'L:\UserDBlog\ig_revconfig_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_ig_task
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\ig_task_FULL.bak' 
WITH  
  FILE = 1
, MOVE N'ig_taskData' TO N'K:\UserDBdata\ig_task_SAVED_data.mdf'
, MOVE N'ig_taskLog'  TO N'L:\UserDBlog\ig_task_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_ig_transaction
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\ig_transaction_FULL.bak'
WITH  
  FILE = 1
, MOVE N'ig_transactionData' TO N'K:\UserDBdata\ig_transaction_SAVED_data.mdf'
, MOVE N'ig_transactionLog'  TO N'L:\UserDBlog\ig_transaction_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_it_cfg
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\it_cfg_FULL.bak' 
WITH  
  FILE = 1
, MOVE N'it_cfgData' TO N'K:\UserDBdata\it_cfg_SAVED_data.mdf'
, MOVE N'it_cfgLog'  TO N'L:\UserDBlog\it_cfg_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_it_ga
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\it_ga_FULL.bak'
WITH  
  FILE = 1
, MOVE N'it_gaData' TO N'K:\UserDBdata\it_ga_SAVED_data.mdf'
, MOVE N'it_gaLog'  TO N'L:\UserDBlog\it_ga_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_it_perms
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\it_perms_FULL.bak'
WITH  
  FILE = 1
, MOVE N'it_permsData' TO N'K:\UserDBdata\it_perms_SAVED_data.mdf'
, MOVE N'it_permsLog'  TO N'L:\UserDBlog\it_perms_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_it_rlt
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\it_rlt_FULL.bak' 
WITH  
  FILE = 1
, MOVE N'it_rltData' TO N'K:\UserDBdata\it_rlt_SAVED_data.mdf'
, MOVE N'it_rltLog'  TO N'L:\UserDBlog\it_rlt_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_it_sysweb
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\it_sysweb_FULL.bak'
WITH  
  FILE = 1
, MOVE N'it_syswebData' TO N'K:\UserDBdata\it_sysweb_SAVED_data.mdf'
, MOVE N'it_syswebLog'  TO N'L:\UserDBlog\it_sysweb_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO



USE master
RESTORE DATABASE SAVED_it_trn
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_FAILED_UPGRADE\it_trn_FULL.bak'
WITH  
  FILE = 1
, MOVE N'it_trnData' TO N'K:\UserDBdata\it_trn_SAVED_data.mdf'
, MOVE N'it_trnLog'  TO N'L:\UserDBlog\it_trn_SAVED_log.ldf'
, NOUNLOAD
, STATS = 5
GO