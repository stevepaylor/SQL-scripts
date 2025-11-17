/*****************************************************************************************/
/*************************************** Create Logins ***********************************/
/*****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DBAdmin]')
CREATE LOGIN [DBAdmin] WITH PASSWORD=0x020051c528a39e223d84bc321a02f6ddbff9c71c18d202ab4ffa3b8317d9793bf7ca137514734afa02638ec5684b22bcad7597c714b5a7aec46c29df3f62b2dce7ef015e647c HASHED, SID=0x01, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyTsqlExecutionLogin##]')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=0x0200bfe4b4bc400cf62c4a12077650bfb7746ca5df2e915d818b8848a1ec7c656c88447f99509918f4127558b1b4a79f3fd558e420c984dc5e4ffe0b2583fbfc0fb742fbea17 HASHED, SID=0x27578d8516843e4094efa2ceed085c82, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DPA]')
CREATE LOGIN [DPA] WITH PASSWORD=0x020028603aa37a8e30e8045372b2124051447d9dadfaa02a2e00872de8b5a9183dd0a1639ba9e27cfebf637a636be5b663c9fcdbdc7c217e7b42563cbbf25b8639423b1c0ae2 HASHED, SID=0xa3ee3b96c9cde34888aed9db4063f11a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[ITappsDBA]')
CREATE LOGIN [ITappsDBA] WITH PASSWORD=0x02003b81082f85cb7c9511a7226b3880ce547a23947af11f7e311ca8e470aa4fa7236412787ea0842b13ce2c78b5966c34f2697fbba072ef14a127a20d955c88f47cd56dfd22 HASHED, SID=0x16257c4c230c91449e1e995d56e03221, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[SSRS_User]')
CREATE LOGIN [SSRS_User] WITH PASSWORD=0x0200abd61fee608b19487a78acb6d716f02dce3786246301614ef47caacf74b865c424740a6013ecea45f4950d5614b6815c3d005e269b1a1302f4283f8827e1903fb7c98077 HASHED, SID=0x0fa51dbe27bf5842b5b743c0caa202ae, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyEventProcessingLogin##]')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=0x02004affd242b9a4ad7c97d3336924b8d8283d3492eda8197347228545bcead17e3eddfb2d51ffac1f5b7ee757cce5bb25ab480dcf9cff7855e48642857d7a7f600da2272bf4 HASHED, SID=0x19b09ece8b764a43b379f2e07201b11a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\hmccoy]')
CREATE LOGIN [VIEJAS\hmccoy] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\spaylor]')
CREATE LOGIN [VIEJAS\spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\SQLWriter]')
CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\Winmgmt]')
CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\MSSQLSERVER]')
CREATE LOGIN [NT SERVICE\MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\SQLSERVERAGENT]')
CREATE LOGIN [NT SERVICE\SQLSERVERAGENT] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\MSA005$]')
CREATE LOGIN [VIEJAS\MSA005$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\SQLTELEMETRY]')
CREATE LOGIN [NT SERVICE\SQLTELEMETRY] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\SQLService1]')
CREATE LOGIN [VIEJAS\SQLService1] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\vmadmin]')
CREATE LOGIN [VIEJAS\vmadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\IT_Apps]')
CREATE LOGIN [VIEJAS\IT_Apps] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ITappsSQLadmin]')
CREATE LOGIN [VIEJAS\ITappsSQLadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\RWA1]')
CREATE LOGIN [VIEJAS\RWA1] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\RWA2]')
CREATE LOGIN [VIEJAS\RWA2] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\RWA3]')
CREATE LOGIN [VIEJAS\RWA3] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\RWA4]')
CREATE LOGIN [VIEJAS\RWA4] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\adm_spaylor]')
CREATE LOGIN [VIEJAS\adm_spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ndabbara]')
CREATE LOGIN [VIEJAS\ndabbara] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

/*****************************************************************************************/
/******************************Add Server Role Members     *******************************/
/*****************************************************************************************/
EXEC sp_addsrvrolemember [DBAdmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\hmccoy], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\spaylor], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\SQLWriter], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\Winmgmt], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\MSSQLSERVER], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\SQLSERVERAGENT], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\MSA005$], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\SQLService1], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\vmadmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [ITappsDBA], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\IT_Apps], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ITappsSQLadmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\adm_spaylor], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ndabbara], [sysadmin];
GO

/*****************************************************************************************/
/*****************Add User and Roles membership to Indivdual Databases********************/
/*****************************************************************************************/
Use AdventureWorks;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use AdventureWorks2014;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Alliance')
CREATE USER [Alliance] FOR LOGIN [Alliance] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[Alliance]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'NoTrigger')
CREATE USER [NoTrigger] FOR LOGIN [NoTrigger] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[NoTrigger]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationA')
CREATE USER [ReplicationA] FOR LOGIN [ReplicationA] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationA]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationB')
CREATE USER [ReplicationB] FOR LOGIN [ReplicationB] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationB]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationC')
CREATE USER [ReplicationC] FOR LOGIN [ReplicationC] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationC]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationD')
CREATE USER [ReplicationD] FOR LOGIN [ReplicationD] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationD]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationE')
CREATE USER [ReplicationE] FOR LOGIN [ReplicationE] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationE]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationF')
CREATE USER [ReplicationF] FOR LOGIN [ReplicationF] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationF]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationG')
CREATE USER [ReplicationG] FOR LOGIN [ReplicationG] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationG]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationH')
CREATE USER [ReplicationH] FOR LOGIN [ReplicationH] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationH]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationI')
CREATE USER [ReplicationI] FOR LOGIN [ReplicationI] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationI]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationJ')
CREATE USER [ReplicationJ] FOR LOGIN [ReplicationJ] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationJ]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationK')
CREATE USER [ReplicationK] FOR LOGIN [ReplicationK] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationK]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationL')
CREATE USER [ReplicationL] FOR LOGIN [ReplicationL] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationL]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationM')
CREATE USER [ReplicationM] FOR LOGIN [ReplicationM] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationM]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationN')
CREATE USER [ReplicationN] FOR LOGIN [ReplicationN] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationN]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationO')
CREATE USER [ReplicationO] FOR LOGIN [ReplicationO] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationO]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationP')
CREATE USER [ReplicationP] FOR LOGIN [ReplicationP] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationP]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationQ')
CREATE USER [ReplicationQ] FOR LOGIN [ReplicationQ] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationQ]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationR')
CREATE USER [ReplicationR] FOR LOGIN [ReplicationR] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationR]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationS')
CREATE USER [ReplicationS] FOR LOGIN [ReplicationS] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationS]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationT')
CREATE USER [ReplicationT] FOR LOGIN [ReplicationT] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationT]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationU')
CREATE USER [ReplicationU] FOR LOGIN [ReplicationU] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationU]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationV')
CREATE USER [ReplicationV] FOR LOGIN [ReplicationV] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationV]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationW')
CREATE USER [ReplicationW] FOR LOGIN [ReplicationW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationW]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationX')
CREATE USER [ReplicationX] FOR LOGIN [ReplicationX] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationX]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationY')
CREATE USER [ReplicationY] FOR LOGIN [ReplicationY] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationY]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReplicationZ')
CREATE USER [ReplicationZ] FOR LOGIN [ReplicationZ] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ReplicationGroup', N'[ReplicationZ]'; 
Go
Use Alliance;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MMETCALFE')
CREATE USER [VIEJAS\MMETCALFE] FOR LOGIN [VIEJAS\MMETCALFE] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\MMETCALFE]'; 
Go
Use Backup_Tracking;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Bally_Activity;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Bally_Activity;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\BallyWindowsServices')
CREATE USER [VIEJAS\BallyWindowsServices] FOR LOGIN [VIEJAS\BallyWindowsServices] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\BallyWindowsServices]'; 
Go
Use DBA;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use dpa_repository;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use dpa_repository;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ignite')
CREATE USER [ignite] FOR LOGIN [ignite] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[ignite]'; 
Go
Use dpa_repository;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DPA')
CREATE USER [DPA] FOR LOGIN [DPA] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[DPA]'; 
Go
Use Job_Tracking;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use pscv4;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use pscv4;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\wbsnadmin')
CREATE USER [VIEJAS\wbsnadmin] FOR LOGIN [VIEJAS\wbsnadmin] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\wbsnadmin]'; 
Go
Use pscv4;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\wbsnadmin')
CREATE USER [VIEJAS\wbsnadmin] FOR LOGIN [VIEJAS\wbsnadmin] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\wbsnadmin]'; 
Go
Use pscv4;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'KeytracerReportsUser')
CREATE USER [KeytracerReportsUser] FOR LOGIN [KeytracerReportsUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[KeytracerReportsUser]'; 
Go
Use ReportServer;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ReportServer;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'RSExecRole')
CREATE USER [RSExecRole] FOR LOGIN [RSExecRole] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[RSExecRole]'; 
Go
Use ReportServer;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'NT SERVICE\SQLServerReportingServices')
CREATE USER [NT SERVICE\SQLServerReportingServices] FOR LOGIN [NT SERVICE\SQLServerReportingServices] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'RSExecRole', N'[NT SERVICE\SQLServerReportingServices]'; 
Go
Use ReportServerTempDB;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ReportServerTempDB;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'RSExecRole')
CREATE USER [RSExecRole] FOR LOGIN [RSExecRole] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[RSExecRole]'; 
Go
Use ReportServerTempDB;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'NT SERVICE\SQLServerReportingServices')
CREATE USER [NT SERVICE\SQLServerReportingServices] FOR LOGIN [NT SERVICE\SQLServerReportingServices] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'RSExecRole', N'[NT SERVICE\SQLServerReportingServices]'; 
Go
