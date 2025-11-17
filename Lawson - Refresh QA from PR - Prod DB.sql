USE master;
GO

RESTORE DATABASE [Prod] 
FROM  DISK = N'\\DBAMBK01PR\SQLBackup01\LWSNVC04PR\Prod\FULL\LWSNVC04PR_Prod_FULL_20180227_040543.bak'
WITH
  MOVE N'Prod' TO N'K:\UserDBdata\Prod_data_1.mdf'
, MOVE N'Prod1' TO N'K:\UserDBdata\Prod_data_2.ndf'
, MOVE N'Prod_log' TO N'L:\UserDBlog\Prod_log.ldf'
, REPLACE
, NORECOVERY  
, STATS = 5
GO

RESTORE DATABASE [Prod] 
FROM  DISK = N'\\DBAMBK01PR\SQLBackup01\LWSNVC04PR\Prod\DIFF\LWSNVC04PR_Prod_DIFF_20180227_112816.bak' 
WITH
  RECOVERY 
, STATS = 5
GO

USE [Prod];
GO

sp_changedbowner 'sa';