USE master;
GO

RESTORE DATABASE [Prod] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\Lawson\Prod_full.bak' 
WITH
  --MOVE N'CASH_VARIANCE_data' TO N'K:\UserDBdata\CASH_VARIANCE.mdf'
--, MOVE N'CASH_VARIANCE_log' TO N'L:\UserDBlog\CASH_VARIANCE_log.ldf'
  REPLACE
--, NORECOVERY
, STATS = 5
GO