:Connect BCCSDB13QA

BACKUP DATABASE [Bally_Activity] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Activity.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Bally_BCC_Meters] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_Meters.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Bally_BCC_User] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_User.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Bally_Config] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Config.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Bally_Core] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Core.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Bally_CPMan] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_CPMan.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Bally_DCM_Core] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_DCM_Core.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [Bally_Download] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Download.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [ReportServer] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\ReportServer.bak' WITH INIT, COMPRESSION,  STATS = 5

BACKUP DATABASE [ReportServerTempDB] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\ReportServerTempDB.bak' WITH INIT, COMPRESSION,  STATS = 5

GO


:Connect BCCSDB13AQA

DROP DATABASE [Bally_Activity]

DROP DATABASE [Bally_BCC_Meters]

DROP DATABASE [Bally_BCC_User]

DROP DATABASE [Bally_Config]

DROP DATABASE [Bally_Core]

DROP DATABASE [Bally_CPMan]

DROP DATABASE [Bally_DCM_Core]

DROP DATABASE [Bally_Download]

DROP DATABASE [ReportServer]

DROP DATABASE [ReportServerTempDB]

RESTORE DATABASE [Bally_Activity] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Activity.bak' 
WITH 
  MOVE N'Bally_Activity_DATA' TO N'K:\UserDBdata\Bally_Activity_DATA.mdf'
, MOVE N'Bally_Activity_LOG' TO N'L:\UserDBlog\Bally_Activity_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [Bally_BCC_Meters] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_Meters.bak' 
WITH 
  MOVE N'Bally_BCC_Meters_DATA' TO N'K:\UserDBdata\Bally_BCC_Meters_DATA.mdf'
, MOVE N'Bally_BCC_Meters_LOG' TO N'L:\UserDBlog\Bally_BCC_Meters_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [Bally_BCC_User] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_User.bak' 
WITH 
  MOVE N'Bally_BCC_User_DATA' TO N'K:\UserDBdata\Bally_BCC_User_DATA.mdf'
, MOVE N'Bally_BCC_User_LOG' TO N'L:\UserDBlog\Bally_BCC_User_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [Bally_Config] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Config.bak' 
WITH 
  MOVE N'Bally_Config_DATA' TO N'K:\UserDBdata\Bally_Config_DATA.mdf'
, MOVE N'Bally_Config_LOG' TO N'L:\UserDBlog\Bally_Config_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [Bally_Core] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Core.bak' 
WITH 
  MOVE N'Bally_Core_DATA' TO N'K:\UserDBdata\Bally_Core_DATA.mdf'
, MOVE N'Bally_Core_LOG' TO N'L:\UserDBlog\Bally_Core_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [Bally_CPMan] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_CPMan.bak' 
WITH 
  MOVE N'Bally_CPMan_DATA' TO N'K:\UserDBdata\Bally_CPMan_DATA.mdf'
, MOVE N'Bally_CPMan_LOG' TO N'L:\UserDBlog\Bally_CPMan_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [Bally_DCM_Core] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_DCM_Core.bak' 
WITH 
  MOVE N'Bally_DCM_Core_DATA' TO N'K:\UserDBdata\Bally_DCM_Core_DATA.mdf'
, MOVE N'Bally_DCM_Core_LOG' TO N'L:\UserDBlog\Bally_DCM_Core_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [Bally_Download] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Download.bak' 
WITH 
  MOVE N'Bally_Download_DATA' TO N'K:\UserDBdata\Bally_Download_DATA.mdf'
, MOVE N'Bally_Download_LOG' TO N'L:\UserDBlog\Bally_Download_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [ReportServer] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\ReportServer.bak' 
WITH 
  MOVE N'ReportServer' TO N'K:\UserDBdata\ReportServer_DATA.mdf'
, MOVE N'ReportServer_LOG' TO N'L:\UserDBlog\ReportServer_LOG.ldf'
,REPLACE, NORECOVERY, STATS = 5

RESTORE DATABASE [ReportServerTempDB] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\ReportServerTempDB.bak' 
WITH 
  MOVE N'ReportServerTempDB' TO N'K:\UserDBdata\ReportServerTempDB_DATA.mdf'
, MOVE N'ReportServerTempDB_LOG' TO N'L:\UserDBlog\ReportServerTempDB_LOG.ldf'
,REPLACE, RECOVERY, STATS = 5

GO

:Connect BCCSDB13QA

BACKUP LOG [Bally_Activity] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Activity.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [Bally_BCC_Meters] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_Meters.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [Bally_BCC_User] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_User.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [Bally_Config] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Config.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [Bally_Core] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Core.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [Bally_CPMan] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_CPMan.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [Bally_DCM_Core] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_DCM_Core.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [Bally_Download] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Download.trn' WITH COMPRESSION,  STATS = 5

BACKUP LOG [ReportServer] TO  DISK = N'\\DBAMBK02PR\SQLBackup05\ReportServer.trn' WITH COMPRESSION,  STATS = 5

GO


:Connect BCCSDB13AQA

RESTORE LOG [Bally_Activity] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Activity.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [Bally_BCC_Meters] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_Meters.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [Bally_BCC_User] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_BCC_User.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [Bally_Config] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Config.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [Bally_Core] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Core.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [Bally_CPMan] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_CPMan.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [Bally_DCM_Core] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_DCM_Core.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [Bally_Download] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\Bally_Download.trn' WITH RECOVERY, STATS = 5

RESTORE LOG [ReportServer] FROM  DISK = N'\\DBAMBK02PR\SQLBackup05\ReportServer.trn' WITH RECOVERY, STATS = 5


GO

