-- Run on AGINDB01QA\INFOGEN in SQLCMD mode (Menu: Query --> SQLCMD Mode)

:CONNECT [AGINDB01QA\INFOGEN]

BACKUP DATABASE ig_app 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_app.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_auditdata 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_auditdata.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_business 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_business.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_dimension 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_dimension.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_log 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_log.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_managedsoftware 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_managedsoftware.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_revconfig 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_revconfig.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_task 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_task.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_transaction 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_transaction.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_transform 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\ig_transform.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_cfg 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\it_cfg.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_ga 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\it_ga.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_perms 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\it_perms.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_rlt 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\it_rlt.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_sysweb 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\it_sysweb.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_trn 
TO  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\it_trn.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

GO

/**********************************************************************************************************************
-- RESTORE ON CASIDB24AQA\INFOGEN

:CONNECT [AGINDB02QA\INFOGEN]

USE [master]
RESTORE DATABASE XXX_OLD
FROM  DISK = N'\\CASIDB24AQA\AGINDB01QA_BAKs\XXX.bak'
WITH  
  FILE = 1
--, MOVE N'XXXData' TO N'K:\UserDBdata\XXX_OLD_data.mdf'
--, MOVE N'XXXLog'  TO N'L:\UserDBlog\XXX_OLD_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO

-- Must run update stats after databases are upgraded.  

:CONNECT [CASIDB24AQA\INFOGEN]

ALTER DATABASE CRManalytics
SET COMPATIBILITY_LEVEL = 130;

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'MSBIDB01dv' ;
GO

**********************************************************************************************************************/
