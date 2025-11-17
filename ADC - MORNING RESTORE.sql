USE [master]
GO


RESTORE DATABASE [CCMData] 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ACD_Upgrade\CCMData.DIF' 
WITH  
  FILE = 1
, MOVE N'CCMData' TO N'K:\UserDBdata\CCMData_data.mdf'
, MOVE N'CCMData_log' TO N'L:\UserDBlog\CCMData_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO



RESTORE DATABASE [CCMRouting] 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ACD_Upgrade\CCMRouting.bak' 
WITH  
  FILE = 1
, MOVE N'CCMRouting' TO N'K:\UserDBdata\CCMRouting_data.mdf'
, MOVE N'CCMRouting_log' TO N'L:\UserDBlog\CCMRouting_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO



RESTORE DATABASE [CCMRuntimeServices] 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ACD_Upgrade\CCMRuntimeServices.bak' 
WITH  
  FILE = 1
, MOVE N'CCMRuntimeServices' TO N'K:\UserDBdata\CCMRuntimeServices_data.mdf'
, MOVE N'CCMRuntimeServices_log' TO N'L:\UserDBlog\CCMRuntimeServices_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO



RESTORE DATABASE [CCMStatisticalData] 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ACD_Upgrade\CCMStatisticalData.DIF' 
WITH  
  FILE = 1
, MOVE N'CCMStatisticalData' TO N'K:\UserDBdata\CCMStatisticalData_data.mdf'
, MOVE N'CCMStatisticalData_log' TO N'L:\UserDBlog\CCMStatisticalData_log.ldf'
, NOUNLOAD
--, REPLACE
, STATS = 5
GO




RESTORE DATABASE [Ccmwa] 
FROM  DISK = N'\\CMKTDB13Bpr\SQLBackup\ACD_Upgrade\Ccmwa.bak' 
WITH  
  FILE = 1
, MOVE N'Ccmwa' TO N'K:\UserDBdata\Ccmwa_data.mdf'
, MOVE N'Ccmwa_log' TO N'L:\UserDBlog\Ccmwa_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO
