:Connect CASIDB24AQA

BACKUP DATABASE [GlobalPayments] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\GlobalPayments.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [GP.AccessControl] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.AccessControl.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [GP.Client] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.Client.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [GP.Logs] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.Logs.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [GP.Reporting] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.Reporting.bak' WITH INIT, COMPRESSION,  STATS = 5

GO


:Connect CASIDB24Apr

--DROP DATABASE [GlobalPayments]

--DROP DATABASE [GP.AccessControl]

--DROP DATABASE [GP.Client]

--DROP DATABASE [GP.Logs]

--DROP DATABASE [GP.Reporting]


RESTORE DATABASE [GlobalPayments] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\GlobalPayments.bak' 
WITH 
  MOVE N'GlobalPayments' TO N'K:\UserDBdata\GlobalPayments_DATA.mdf'
, MOVE N'GlobalPayments_log' TO N'L:\UserDBlog\GlobalPayments_LOG.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [GP.AccessControl] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.AccessControl.bak' 
WITH 
  MOVE N'GP.AccessControl' TO N'K:\UserDBdata\GP.AccessControl_DATA.mdf'
, MOVE N'GP.AccessControl_log' TO N'L:\UserDBlog\GP.AccessControl_LOG.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [GP.Client] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.Client.bak' 
WITH 
  MOVE N'GP.Client' TO N'K:\UserDBdata\GP.Client_DATA.mdf'
, MOVE N'GP.Client_log' TO N'L:\UserDBlog\GP.Client_LOG.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [GP.Logs] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.Logs.bak' 
WITH 
  MOVE N'GP.Logs' TO N'K:\UserDBdata\GP.Logs_DATA.mdf'
, MOVE N'GP.Logs_log' TO N'L:\UserDBlog\GP.Logs_LOG.ldf'
,REPLACE, RECOVERY, STATS = 5

RESTORE DATABASE [GP.Reporting] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\GP.Reporting.bak' 
WITH 
  MOVE N'GP.Reporting' TO N'K:\UserDBdata\GP.Reporting_DATA.mdf'
, MOVE N'GP.Reporting_log' TO N'L:\UserDBlog\GP.Reporting_LOG.ldf'
,REPLACE, RECOVERY, STATS = 5

