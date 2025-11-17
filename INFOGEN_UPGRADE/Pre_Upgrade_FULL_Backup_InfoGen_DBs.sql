BACKUP DATABASE ig_app 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_app_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE ig_business 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_business_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE ig_dimension 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_dimension_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE ig_log 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_log_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE ig_revconfig 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_revconfig_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE ig_task 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_task_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE ig_transaction 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_transaction_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

--------BACKUP DATABASE ig_transform 
--------TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\ig_transform_FULL.bak' 
--------WITH 
--------  FORMAT
--------, INIT
--------, COMPRESSION
--------, STATS = 5

BACKUP DATABASE it_cfg 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\it_cfg_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE it_ga 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\it_ga_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE it_perms 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\it_perms_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE it_rlt 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\it_rlt_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE it_sysweb 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\it_sysweb_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

BACKUP DATABASE it_trn 
TO  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\it_trn_FULL.bak' 
WITH 
  FORMAT
, INIT
, COMPRESSION
, STATS = 5

GO

/**********************************************************************************************************************
-- RESTORE ON CASIDB24AQA\INFOGEN

--:CONNECT [AGINDB02QA\INFOGEN]

USE [master]
RESTORE DATABASE XXX_OLD
FROM  DISK = N'\\DBAMBK01PR\SQLBackup02\INFOGEN_UPGRADE\XXX_FULL.bak'
WITH  
  FILE = 1
--, MOVE N'XXXData' TO N'K:\UserDBdata\XXX_OLD_data.mdf'
--, MOVE N'XXXLog'  TO N'L:\UserDBlog\XXX_OLD_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

-- Must run update stats after databases are upgraded.  

--:CONNECT [CASIDB24AQA\INFOGEN]

ALTER DATABASE CRManalytics
SET COMPATIBILITY_LEVEL = 130;

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'MSBIDB01dv' ;
GO

**********************************************************************************************************************/
