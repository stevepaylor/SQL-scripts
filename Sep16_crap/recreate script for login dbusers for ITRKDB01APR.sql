/*****************************************************************************************/
/*************************************** Create Logins ***********************************/
/*****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DBAdmin]')
CREATE LOGIN [DBAdmin] WITH PASSWORD=0x02003386ce8768154fb8fafbe986ba9b9442b461bd479752006b0b74d4ee6d06b4c0f8fa26fdc6e41da45acd4b883b848449247bda2f3ae1ee6ec92f5049d21ab6276a3b62d1 HASHED, SID=0x01, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyTsqlExecutionLogin##]')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=0x020071cde15e58ab81d61e6772a598816e634b6e90102d925cf16cf201e387546553bf98877b6f35931b8f0bd6d6ed844c4afcf75685b3d667d14d06c351a1568844882a7254 HASHED, SID=0x6fdccb0634728d499251c4f30ad23d4e, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DPA]')
CREATE LOGIN [DPA] WITH PASSWORD=0x020028603aa37a8e30e8045372b2124051447d9dadfaa02a2e00872de8b5a9183dd0a1639ba9e27cfebf637a636be5b663c9fcdbdc7c217e7b42563cbbf25b8639423b1c0ae2 HASHED, SID=0xa3ee3b96c9cde34888aed9db4063f11a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[ITappsDBA]')
CREATE LOGIN [ITappsDBA] WITH PASSWORD=0x02007d848fd2284bf6c029fc69d2fc68947ffda53574319139b9464101590260e579b3fd0d2c67b430ac3a95ccc09d18c5f7c4eaf5a8a2785f539986e978f6e232793a856eca HASHED, SID=0xf5222764dfd3304b9348d49e527658bc, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[iTrakUser44681123]')
CREATE LOGIN [iTrakUser44681123] WITH PASSWORD=0x0200a49dc5dc5f656ae1905d43af2539e6fcae2dc83e26d328f71c4b21c750be5e8f4e207176baf87ffbe6aea39622bbe3c4cbc19f726e83a001c352a26750482b1bc8e432dc HASHED, SID=0xacdc8783e0423241a40936250a32843f, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[iTrakUser1258450617]')
CREATE LOGIN [iTrakUser1258450617] WITH PASSWORD=0x02003a3cfef94d54c4a6b374a6feb426a1a3ead3ca6cb70432f51d9e39798755d771821dda7b584543e3266f00ff52ef6c99c9f83c0391b27e4c132a1b833ac90ffddd152360 HASHED, SID=0x003780778bafb8488fa9cf9b893ae0fc, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[iTrakUser458727391]')
CREATE LOGIN [iTrakUser458727391] WITH PASSWORD=0x0200cac23f89fb872cdb942ca0928eb4907d0f6c6f78b8656c4297aed57b5e955c0e2b97d623e7223a85872a00a0e12bd97a1addd9a8602139e071544d1bea13068f2d0b424c HASHED, SID=0xb1e5675419490143ab13e5a073ced8b4, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyEventProcessingLogin##]')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=0x0200890b842afe3142a94c85c65fe9345a611c66c24720a920bc76d06451a7ebb78eee8d2bd0f42b5d0381f3f106784816083a2675d5f22649fc62224aef5e88b7b12fb779f0 HASHED, SID=0x93a7348f4c9cd14d99d6a177c1a05cf6, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[iTrakUser20250916]')
CREATE LOGIN [iTrakUser20250916] WITH PASSWORD=0x02004058d62f36c9b06fece2dfc1dbceaf35682cef1855c7a2aa8f15b8469c994303610948ab83c698f713b2ffab0493eeb19ad65bba96d84b77090287db2d4d104d64741cf1 HASHED, SID=0x1cd9803d7327bf44afef2aeeb4f73569, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\spaylor]')
CREATE LOGIN [VIEJAS\spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ADM_spaylor]')
CREATE LOGIN [VIEJAS\ADM_spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\SQLWriter]')
CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\Winmgmt]')
CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT Service\MSSQLSERVER]')
CREATE LOGIN [NT Service\MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\SQLSERVERAGENT]')
CREATE LOGIN [NT SERVICE\SQLSERVERAGENT] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\SQLTELEMETRY]')
CREATE LOGIN [NT SERVICE\SQLTELEMETRY] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\SQLService1]')
CREATE LOGIN [VIEJAS\SQLService1] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ITappsSQLadmin]')
CREATE LOGIN [VIEJAS\ITappsSQLadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\IT_Apps]')
CREATE LOGIN [VIEJAS\IT_Apps] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\itraksupport]')
CREATE LOGIN [VIEJAS\itraksupport] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ELE_qdang]')
CREATE LOGIN [VIEJAS\ELE_qdang] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ele_spaylor]')
CREATE LOGIN [VIEJAS\ele_spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\apps_ele_group]')
CREATE LOGIN [VIEJAS\apps_ele_group] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\AlVizcarra]')
CREATE LOGIN [VIEJAS\AlVizcarra] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

/*****************************************************************************************/
/******************************Add Server Role Members     *******************************/
/*****************************************************************************************/
EXEC sp_addsrvrolemember [DBAdmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\spaylor], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ADM_spaylor], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\SQLWriter], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\Winmgmt], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT Service\MSSQLSERVER], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\SQLSERVERAGENT], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\SQLService1], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ITappsSQLadmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [DPA], [sysadmin];
GO

EXEC sp_addsrvrolemember [ITappsDBA], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\IT_Apps], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\itraksupport], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ELE_qdang], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ele_spaylor], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\apps_ele_group], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\AlVizcarra], [sysadmin];
GO

EXEC sp_addsrvrolemember [iTrakUser20250916], [sysadmin];
GO

EXEC sp_addsrvrolemember [iTrakUser44681123], [dbcreator];
GO

EXEC sp_addsrvrolemember [iTrakUser1258450617], [dbcreator];
GO

EXEC sp_addsrvrolemember [iTrakUser458727391], [dbcreator];
GO

/*****************************************************************************************/
/*****************Add User and Roles membership to Indivdual Databases********************/
/*****************************************************************************************/
Use AAG_TEST;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use AdHoc;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use AdHoc;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser1258450617')
CREATE USER [iTrakUser1258450617] FOR LOGIN [iTrakUser1258450617] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser1258450617]'; 
Go
Use AdHoc;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser458727391')
CREATE USER [iTrakUser458727391] FOR LOGIN [iTrakUser458727391] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser458727391]'; 
Go
Use DBA;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use iXAlert;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use iXAlert;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser1258450617')
CREATE USER [iTrakUser1258450617] FOR LOGIN [iTrakUser1258450617] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser1258450617]'; 
Go
Use iXAlert;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser458727391')
CREATE USER [iTrakUser458727391] FOR LOGIN [iTrakUser458727391] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser458727391]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iGData1522770877')
CREATE USER [iGData1522770877] FOR LOGIN [iGData1522770877] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iGData1522770877]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iGData275404049')
CREATE USER [iGData275404049] FOR LOGIN [iGData275404049] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iGData275404049]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iGData298248021')
CREATE USER [iGData298248021] FOR LOGIN [iGData298248021] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iGData298248021]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iGData825015321')
CREATE USER [iGData825015321] FOR LOGIN [iGData825015321] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iGData825015321]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iGData89720831')
CREATE USER [iGData89720831] FOR LOGIN [iGData89720831] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iGData89720831]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser471899477')
CREATE USER [iTrakUser471899477] FOR LOGIN [iTrakUser471899477] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser471899477]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser1258450617')
CREATE USER [iTrakUser1258450617] FOR LOGIN [iTrakUser1258450617] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser1258450617]'; 
Go
Use iXData;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser458727391')
CREATE USER [iTrakUser458727391] FOR LOGIN [iTrakUser458727391] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser458727391]'; 
Go
Use iXLPR;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use iXLPR;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser1258450617')
CREATE USER [iTrakUser1258450617] FOR LOGIN [iTrakUser1258450617] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser1258450617]'; 
Go
Use iXLPR;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'iTrakUser458727391')
CREATE USER [iTrakUser458727391] FOR LOGIN [iTrakUser458727391] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[iTrakUser458727391]'; 
Go

Completion time: 2025-09-16T08:05:38.8615112-07:00
