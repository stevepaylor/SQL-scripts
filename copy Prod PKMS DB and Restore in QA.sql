-- Run on CASIDB23APR in SQLCMD mode (Menu: Query --> SQLCMD Mode)

--:CONNECT [CASIDB23APR]

BACKUP DATABASE PKMS 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\PKMS.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5
GO

--**********************************************************************************************************************
-- RESTORE ON CASIDB23AQA

:CONNECT [CASIDB23AQA]

USE [master]
RESTORE DATABASE PKMS_Test
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\PKMS.bak'
WITH  
  FILE = 1
--, MOVE N'kiosk' TO N'Y:\UserDBdata\PKMS_Test_data.mdf'
--, MOVE N'kiosk_Log'  TO N'Y:\UserDBlog\PKMS_Test_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO