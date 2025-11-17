----BACKUP DATABASE [GlobalPayments] 
----TO  DISK = N'\\DBAMBK02PR\SQLBackup07\_GP_migration\GlobalPayments.BAK' 
----WITH
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, SKIP
----, STATS = 5
----GO

BACKUP DATABASE [GP.AccessControl] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\_GP_migration\GP.AccessControl.BAK' 
WITH
  COPY_ONLY
, NOFORMAT
, INIT
, SKIP
, STATS = 5
GO


BACKUP DATABASE [GP.Client] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\_GP_migration\GP.Client.BAK' 
WITH
  COPY_ONLY
, NOFORMAT
, INIT
, SKIP
, STATS = 5
GO


BACKUP DATABASE [GP.Logs] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\_GP_migration\GP.Logs.BAK' 
WITH
  COPY_ONLY
, NOFORMAT
, INIT
, SKIP
, STATS = 5
GO


BACKUP DATABASE [GP.Reporting] 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\_GP_migration\GP.Reporting.BAK' 
WITH
  COPY_ONLY
, NOFORMAT
, INIT
, SKIP
, STATS = 5
GO

BACKUP DATABASE gp_kiosk_server 
TO  DISK = N'\\DBAMBK02PR\SQLBackup07\_GP_migration\gp_kiosk_server.BAK' 
WITH
  COPY_ONLY
, NOFORMAT
, INIT
, SKIP
, STATS = 5
GO