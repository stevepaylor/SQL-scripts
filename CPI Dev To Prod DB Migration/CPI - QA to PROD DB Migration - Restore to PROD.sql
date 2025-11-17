USE [master]
RESTORE DATABASE [EasitraxEmailService] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\EasitraxEmailService_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [EasitraxTasksConfigService] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\EasitraxTasksConfigService_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [EasiTraxUserProfile] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\EasiTraxUserProfile_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [SwcEasiTraxBillValidatorData] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\SwcEasiTraxBillValidatorData_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [SwcEasitraxLiveIncomingData] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\SwcEasitraxLiveIncomingData_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [SwcEasitraxPermissions] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\SwcEasitraxPermissions_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [Watson] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\Watson_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [WatsonAlerts] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\WatsonAlerts_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO

USE [master]
RESTORE DATABASE [WatsonAuthentication] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\WatsonAuthentication_FULL.bak' 
WITH
   REPLACE
,  STATS = 5
GO