-- Run on CASIDB23AQA in SQLCMD mode (Menu: Query --> SQLCMD Mode)

BACKUP DATABASE [Tfs_Configuration] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_Configuration.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5
GO

BACKUP DATABASE [Tfs_DefaultCollection] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_DefaultCollection.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5
GO



BACKUP DATABASE [Tfs_ViejasITSS] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_ViejasITSS.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5
GO

-- RESTORE ON CASIDB24Apr

:CONNECT CASIDB24Apr

USE [master]
RESTORE DATABASE [Tfs_Configuration] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_Configuration.bak' 
WITH  
  FILE = 1
, NOUNLOAD
, REPLACE
, STATS = 5
GO

:CONNECT CASIDB24Apr

USE [master]
RESTORE DATABASE [Tfs_DefaultCollection] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_DefaultCollection.bak' 
WITH  
  FILE = 1
, NOUNLOAD
, REPLACE
, STATS = 5
GO


:CONNECT CASIDB24Apr

USE [master]
RESTORE DATABASE [Tfs_ViejasITSS] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_ViejasITSS.bak' 
WITH  
  FILE = 1
, NOUNLOAD
, REPLACE
, STATS = 5
GO

-- Must run update stats after databases are upgraded.  

:CONNECT CASIDB24Apr

ALTER DATABASE Tfs_Configuration
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE Tfs_DefaultCollection
SET COMPATIBILITY_LEVEL = 140;

ALTER DATABASE Tfs_ViejasITSS
SET COMPATIBILITY_LEVEL = 140;

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'CASIDB24Apr' ;
GO

