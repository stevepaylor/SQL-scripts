-- Run on CMKTDB13APR in SQLCMD mode (Menu: Query --> SQLCMD Mode)

--:CONNECT [CMKTDB13APR]

BACKUP DATABASE SDSVJPRD 
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\SDSVJPRD.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5
GO

--**********************************************************************************************************************
-- RESTORE ON CMKTDB13AQA

--:CONNECT [CMKTDB13AQA]

USE [master]
RESTORE DATABASE SDSVJPRD_Test
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\SDSVJPRD.bak'
WITH  
  FILE = 1
, MOVE N'SDS_DB' TO N'Y:\UserDBdata\SDSVJPRD_Test_data.mdf'
, MOVE N'SDS_DB_Log'  TO N'Y:\UserDBlog\SDSVJPRD_Test_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO