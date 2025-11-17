USE [master]
RESTORE DATABASE [86] 
FROM  DISK = N'K:\SQLBackup\86.bak' 
   WITH  FILE = 1
,  MOVE N'86_dat' TO N'K:\UserDBdata\86_data.mdf'
,  MOVE N'86_log' TO N'L:\UserDBlog\86_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[86]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [Auditorsdb] 
FROM  DISK = N'K:\SQLBackup\Auditorsdb.bak' 
   WITH  FILE = 1
,  MOVE N'Auditorsdb_Data' TO N'K:\UserDBdata\Auditorsdb_data.mdf'
,  MOVE N'Auditorsdb_Log' TO N'L:\UserDBlog\Auditorsdb_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[Auditorsdb]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [CommissionEmployee_Exclusionsdb] 
FROM  DISK = N'K:\SQLBackup\CommissionEmployee_Exclusionsdb.bak' 
   WITH  FILE = 1
,  MOVE N'CommissionEmployee_Exclusionsdb_Data' TO N'K:\UserDBdata\CommissionEmployee_Exclusionsdb_data.mdf'
,  MOVE N'CommissionEmployee_Exclusionsdb_Log' TO N'L:\UserDBlog\CommissionEmployee_Exclusionsdb_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[CommissionEmployee_Exclusionsdb]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [CorovanWareHouse] 
FROM  DISK = N'K:\SQLBackup\CorovanWareHouse.bak' 
   WITH  FILE = 1
,  MOVE N'CorovanWareHouse_Data' TO N'K:\UserDBdata\CorovanWareHouse_data.mdf'
,  MOVE N'CorovanWareHouse_Log' TO N'L:\UserDBlog\CorovanWareHouse_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[CorovanWareHouse]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [DepartmentStats] 
FROM  DISK = N'K:\SQLBackup\DepartmentStats.bak' 
   WITH  FILE = 1
,  MOVE N'DepartmentStats' TO N'K:\UserDBdata\DepartmentStats_data.mdf'
,  MOVE N'DepartmentStats_log' TO N'L:\UserDBlog\DepartmentStats_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[DepartmentStats]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [Exclusions Database] 
FROM  DISK = N'K:\SQLBackup\Exclusions Database.bak' 
   WITH  FILE = 1
,  MOVE N'Exclusions Database_Data' TO N'K:\UserDBdata\Exclusions_Database_data.mdf'
,  MOVE N'Exclusions Database_Log' TO N'L:\UserDBlog\Exclusions_Database_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[Exclusions Database]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [Exclusions_db_restore] 
FROM  DISK = N'K:\SQLBackup\Exclusions_db_restore.bak' 
   WITH  FILE = 1
,  MOVE N'Exclusions Database_Data' TO N'K:\UserDBdata\Exclusions_db_restore_data.mdf'
,  MOVE N'Exclusions Database_Log' TO N'L:\UserDBlog\Exclusions_db_restore_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[Exclusions_db_restore]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [Exclusions_iTrak] 
FROM  DISK = N'K:\SQLBackup\Exclusions_iTrak.bak' 
   WITH  FILE = 1
,  MOVE N'Exclusions Database_Data' TO N'K:\UserDBdata\Exclusions_iTrak_data.mdf'
,  MOVE N'Exclusions Database_Log' TO N'L:\UserDBlog\Exclusions_iTrak_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[Exclusions_iTrak]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [Exclusions_toship] 
FROM  DISK = N'K:\SQLBackup\Exclusions_toship.bak' 
   WITH  FILE = 1
,  MOVE N'Exclusions Database_Data' TO N'K:\UserDBdata\Exclusions_toship_data.mdf'
,  MOVE N'Exclusions Database_Log' TO N'L:\UserDBlog\Exclusions_toship_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[Exclusions_toship]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [GamingCommissiondb] 
FROM  DISK = N'K:\SQLBackup\GamingCommissiondb.bak' 
   WITH  FILE = 1
,  MOVE N'GamingCommissiondb_Data' TO N'K:\UserDBdata\GamingCommissiondb_data.mdf'
,  MOVE N'GamingCommissiondb_Log' TO N'L:\UserDBlog\GamingCommissiondb_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[GamingCommissiondb]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [IncidentReportsdb] 
FROM  DISK = N'K:\SQLBackup\IncidentReportsdb.bak' 
   WITH  FILE = 1
,  MOVE N'IncidentReportsdb_Data' TO N'K:\UserDBdata\IncidentReportsdb_data.mdf'
,  MOVE N'IncidentReportsdb_Log' TO N'L:\UserDBlog\IncidentReportsdb_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[IncidentReportsdb]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [iXData] 
FROM  DISK = N'K:\SQLBackup\iXData.bak' 
   WITH  FILE = 1
,  MOVE N'iXData' TO N'K:\UserDBdata\iXData_data.mdf'
,  MOVE N'iXData_log' TO N'L:\UserDBlog\iXData_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[iXData]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [LicensingActions] 
FROM  DISK = N'K:\SQLBackup\LicensingActions.bak' 
   WITH  FILE = 1
,  MOVE N'LicensingActions_Data' TO N'K:\UserDBdata\LicensingActions_data.mdf'
,  MOVE N'LicensingActions_Log' TO N'L:\UserDBlog\LicensingActions_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[LicensingActions]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [PatronsDisputeDB] 
FROM  DISK = N'K:\SQLBackup\PatronsDisputeDB.bak' 
   WITH  FILE = 1
,  MOVE N'PatronsDisputeDB_Data' TO N'K:\UserDBdata\PatronsDisputeDB_data.mdf'
,  MOVE N'PatronsDisputeDB_Log' TO N'L:\UserDBlog\PatronsDisputeDB_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[PatronsDisputeDB]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [ReportServerOrig] 
FROM  DISK = N'K:\SQLBackup\ReportServer.bak' 
   WITH  FILE = 1
,  MOVE N'ReportServer' TO N'K:\UserDBdata\ReportServerOrig_data.mdf'
,  MOVE N'ReportServer_log' TO N'L:\UserDBlog\ReportServerOrig_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[ReportServerOrig]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [ReportServerOrigTempDB] 
FROM  DISK = N'K:\SQLBackup\ReportServerTempDB.bak' 
   WITH  FILE = 1
,  MOVE N'ReportServerTempDB' TO N'K:\UserDBdata\ReportServerOrigTempDB_data.mdf'
,  MOVE N'ReportServerTempDB_log' TO N'L:\UserDBlog\ReportServerOrigTempDB_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[ReportServerOrigTempDB]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [SurveillanceStatsdb] 
FROM  DISK = N'K:\SQLBackup\SurveillanceStatsdb.bak' 
   WITH  FILE = 1
,  MOVE N'InspectorsStatisticsdb_Data' TO N'K:\UserDBdata\SurveillanceStatsdb_data.mdf'
,  MOVE N'InspectorsStatisticsdb_Log' TO N'L:\UserDBlog\SurveillanceStatsdb_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[SurveillanceStatsdb]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [VendorLicense] 
FROM  DISK = N'K:\SQLBackup\VendorLicense.bak' 
   WITH  FILE = 1
,  MOVE N'VendorLicense_Data' TO N'K:\UserDBdata\VendorLicense_data.mdf'
,  MOVE N'VendorLicense_Log' TO N'L:\UserDBlog\VendorLicense_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[VendorLicense]
SET MULTI_USER;
GO

----------------------------------------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [VisualCasino] 
FROM  DISK = N'K:\SQLBackup\VisualCasino.bak' 
   WITH  FILE = 1
,  MOVE N'VisualCasino_Data' TO N'K:\UserDBdata\VisualCasino_data.mdf'
,  MOVE N'VisualCasino_Log' TO N'L:\UserDBlog\VisualCasino_log.ldf'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO

ALTER DATABASE[VisualCasino]
SET MULTI_USER;
GO

sp_helpserver
GO
sp_dropserver GCSQLTEST ;  
GO  
sp_addserver GCSQL, local;  
GO  

sp_helpserver
GO