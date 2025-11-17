--RESTORE DATABASE [CCMData] 
--FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ACD_Upgrade\CCMData.bak' 
--WITH  
--  FILE = 1
--, MOVE N'CCMData' TO N'K:\UserDBdata\CCMData_data.mdf'
--, MOVE N'CCMData_log' TO N'L:\UserDBlog\CCMData_log.ldf'
--, NOUNLOAD
--, REPLACE
--, NORECOVERY
--, STATS = 5
--GO


RESTORE DATABASE [CCMStatisticalData] 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ACD_Upgrade\CCMStatisticalData.bak' 
WITH  
  FILE = 1
, MOVE N'CCMStatisticalData' TO N'K:\UserDBdata\CCMStatisticalData_data.mdf'
, MOVE N'CCMStatisticalData_log' TO N'L:\UserDBlog\CCMStatisticalData_log.ldf'
, NOUNLOAD
, REPLACE
, NORECOVERY
, STATS = 5
GO