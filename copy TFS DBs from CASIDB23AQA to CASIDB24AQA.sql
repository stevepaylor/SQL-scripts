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

BACKUP DATABASE [Tfs_TestCollection] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_TestCollection.bak' 
WITH 
  NOFORMAT
, INIT
, COPY_ONLY
, STATS = 5
GO

BACKUP DATABASE [Tfs_Tfs_ViejasCollection] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_Tfs_ViejasCollection.bak' 
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

-- RESTORE ON CASIDB24AQA

:CONNECT CASIDB24AQA

USE [master]
RESTORE DATABASE [Tfs_Configuration] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_Configuration.bak' 
WITH  
  FILE = 1
, NOUNLOAD
, REPLACE
, STATS = 5
GO

:CONNECT CASIDB24AQA

USE [master]
RESTORE DATABASE [Tfs_DefaultCollection] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_DefaultCollection.bak' 
WITH  
  FILE = 1
, NOUNLOAD
, REPLACE
, STATS = 5
GO

:CONNECT CASIDB24AQA

USE [master]
RESTORE DATABASE [Tfs_TestCollection] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_TestCollection.bak' 
WITH  
  FILE = 1
, NOUNLOAD
, REPLACE
, STATS = 5
GO

:CONNECT CASIDB24AQA

USE [master]
RESTORE DATABASE [Tfs_Tfs_ViejasCollection] 
FROM  DISK = N'\\DBAMBK02PR\SQLBackup07\TFS_upgrade\Tfs_Tfs_ViejasCollection.bak' 
WITH  
  FILE = 1
, NOUNLOAD
, REPLACE
, STATS = 5
GO

:CONNECT CASIDB24AQA

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

:CONNECT CASIDB24AQA

EXEC msdb.dbo.sp_start_job N'DBA - Update Stats', @server_name = 'CASIDB24AQA' ;
GO

