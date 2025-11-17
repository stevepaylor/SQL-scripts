BACKUP DATABASE [EasitraxEmailService]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\EasitraxEmailService_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

--ALTER DATABASE [EasitraxEmailService] 
--SET READ_ONLY
--WITH ROLLBACK IMMEDIATE;
--GO

BACKUP DATABASE [EasitraxTasksConfigService]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\EasitraxTasksConfigService_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

--ALTER DATABASE [EasitraxTasksConfigService] 
--SET READ_ONLY
--WITH ROLLBACK IMMEDIATE;
--GO

BACKUP DATABASE [EasiTraxUserProfile]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\EasiTraxUserProfile_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

--ALTER DATABASE [EasiTraxUserProfile] 
--SET READ_ONLY
--WITH ROLLBACK IMMEDIATE;
--GO

BACKUP DATABASE [SwcEasiTraxBillValidatorData]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\SwcEasiTraxBillValidatorData_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

--ALTER DATABASE [SwcEasiTraxBillValidatorData] 
--SET READ_ONLY
--WITH ROLLBACK IMMEDIATE;
--GO

BACKUP DATABASE [SwcEasitraxLiveIncomingData]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\SwcEasitraxLiveIncomingData_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

--ALTER DATABASE [SwcEasitraxLiveIncomingData] 
--SET READ_ONLY
--WITH ROLLBACK IMMEDIATE;
--GO

BACKUP DATABASE [SwcEasitraxPermissions]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\SwcEasitraxPermissions_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

--ALTER DATABASE [SwcEasitraxPermissions] 
--SET READ_ONLY
--WITH ROLLBACK IMMEDIATE;
--GO

BACKUP DATABASE [Watson]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\Watson_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

--ALTER DATABASE [Watson] 
--SET READ_ONLY
--WITH ROLLBACK IMMEDIATE;
--GO

BACKUP DATABASE [WatsonAlerts]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\WatsonAlerts_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO

BACKUP DATABASE [WatsonAuthentication]
TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CPI\WatsonAuthentication_FULL.BAK' 
  WITH NOFORMAT
, INIT
, STATS = 5
GO
