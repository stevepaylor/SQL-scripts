------BACKUP DATABASE [BackOffice] 
------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\BackOffice.BAK' 
------WITH  
------  COPY_ONLY
------, NOFORMAT
------, INIT
------, STATS = 5
------GO

------USE master;
------GO
------ALTER DATABASE [BackOffice]
------SET SINGLE_USER
------WITH ROLLBACK IMMEDIATE;
------GO

------BACKUP DATABASE [GP.AccessControl] 
------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.AccessControl.BAK' 
------WITH  
------  COPY_ONLY
------, NOFORMAT
------, INIT
------, STATS = 5
------GO

------USE master;
------GO
------ALTER DATABASE [GP.AccessControl]
------SET SINGLE_USER
------WITH ROLLBACK IMMEDIATE;
------GO

------BACKUP DATABASE [GP.Client] 
------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Client.BAK' 
------WITH  
------  COPY_ONLY
------, NOFORMAT
------, INIT
------, STATS = 5
------GO

------USE master;
------GO
------ALTER DATABASE [GP.Client]
------SET SINGLE_USER
------WITH ROLLBACK IMMEDIATE;
------GO

------BACKUP DATABASE [GP.Logs] 
------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Logs.BAK' 
------WITH  
------  COPY_ONLY
------, NOFORMAT
------, INIT
------, STATS = 5
------GO

------USE master;
------GO
------ALTER DATABASE [GP.Logs]
------SET SINGLE_USER
------WITH ROLLBACK IMMEDIATE;
------GO

------BACKUP DATABASE [GP.Reporting] 
------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Reporting.BAK' 
------WITH  
------  COPY_ONLY
------, NOFORMAT
------, INIT
------, STATS = 5
------GO

------USE master;
------GO
------ALTER DATABASE [GP.Reporting]
------SET SINGLE_USER
------WITH ROLLBACK IMMEDIATE;
------GO

------BACKUP DATABASE [gp_kiosk_server] 
------TO  DISK = N'\\CMKTDB13BPR\SQLBackup\gp_kiosk_server.BAK' 
------WITH  
------  COPY_ONLY
------, NOFORMAT
------, INIT
------, STATS = 5
------GO


------USE master;
------GO
------ALTER DATABASE [gp_kiosk_server]
------SET SINGLE_USER
------WITH ROLLBACK IMMEDIATE;
------GO



USE [master]
RESTORE DATABASE [BackOffice] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\BackOffice.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [BackOffice] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [GP.AccessControl] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.AccessControl.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [GP.AccessControl] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [GP.Client] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Client.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [GP.Client] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [GP.Logs] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Logs.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [GP.Logs] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [GP.Reporting] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Reporting.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [GP.Reporting] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [gp_kiosk_server] 
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\gp_kiosk_server.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [gp_kiosk_server] SET COMPATIBILITY_LEVEL = 150
GO
