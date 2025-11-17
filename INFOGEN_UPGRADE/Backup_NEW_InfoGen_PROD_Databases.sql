-- Run on AGINDB02APR in SQLCMD mode (Menu: Query --> SQLCMD Mode)

--:CONNECT [AGINDB02APR]

BACKUP DATABASE ig_app 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_app.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

--------BACKUP DATABASE ig_auditdata 
--------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_auditdata.bak' 
--------WITH 
--------  NOFORMAT
--------, INIT
--------, COPY_ONLY
--------, STATS = 5

BACKUP DATABASE ig_business 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_business.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_dimension 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_dimension.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_log 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_log.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

--------BACKUP DATABASE ig_managedsoftware 
--------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_managedsoftware.bak' 
--------WITH 
--------  NOFORMAT
--------, INIT
--------, COPY_ONLY
--------, STATS = 5

BACKUP DATABASE ig_revconfig 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_revconfig.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_task 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_task.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE ig_transaction 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_transaction.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

--------BACKUP DATABASE ig_transform 
--------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\ig_transform.bak' 
--------WITH 
--------  NOFORMAT
--------, INIT
--------, COPY_ONLY
--------, STATS = 5

BACKUP DATABASE it_cfg 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\it_cfg.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_ga 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\it_ga.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_perms 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\it_perms.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_rlt 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\it_rlt.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_sysweb 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\it_sysweb.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

BACKUP DATABASE it_trn 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\InfoGen_new_PROD\it_trn.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5

GO