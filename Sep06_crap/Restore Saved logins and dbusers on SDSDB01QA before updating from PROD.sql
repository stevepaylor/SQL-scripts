/*****************************************************************************************/
/*************************************** Create Logins ***********************************/
/*****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DBAdmin]')
CREATE LOGIN [DBAdmin] WITH PASSWORD=0x0200d9a00435da88f19434f93f9ac6c18d1e9fec83b54f07d3b76f29bd610619a200f83cc5c8fe381db079f1503842658f2f0c629d6d614663c58839338fd886450df896da92 HASHED, SID=0x01, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyTsqlExecutionLogin##]')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=0x0200626df9a6b4722c3dcb6782e123f158b63b6bb04665f410c64b68bcdb925c66f62dd6cad6904ed66d7760fc548de900a686d2e929a873993149f18f8b7b0d62313d7e67b5 HASHED, SID=0x6fdccb0634728d499251c4f30ad23d4e, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyEventProcessingLogin##]')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=0x0200f5a9526a39af17c6c9037d3f21725dcae02704e25a490f8df8abd3f31453326192e7b12f2dc999cd33d467b6a0075d6039a83efd9d11986044bee0608409664a90b95a23 HASHED, SID=0x25d4ef94bc10224d97c6ae64a6326388, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DPA]')
CREATE LOGIN [DPA] WITH PASSWORD=0x020028603aa37a8e30e8045372b2124051447d9dadfaa02a2e00872de8b5a9183dd0a1639ba9e27cfebf637a636be5b663c9fcdbdc7c217e7b42563cbbf25b8639423b1c0ae2 HASHED, SID=0xa3ee3b96c9cde34888aed9db4063f11a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[ITappsDBA]')
CREATE LOGIN [ITappsDBA] WITH PASSWORD=0x0200b73fec0f7a2b8c8568553ac6efff691eef73d2218456c785c118dadc70353344898844ce0286038c28c1636dc7309838c95f983d60ae8fc7b304ece5b371b95fa9290fc4 HASHED, SID=0xdd65881a17e6cc4bbe8bcacdff3ab79a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\spaylor]')
CREATE LOGIN [VIEJAS\spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ELE_spaylor]')
CREATE LOGIN [VIEJAS\ELE_spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
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

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\IT_APPS_Elevated]')
CREATE LOGIN [VIEJAS\IT_APPS_Elevated] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

/*****************************************************************************************/
/******************************Add Server Role Members     *******************************/
/*****************************************************************************************/
EXEC sp_addsrvrolemember [DBAdmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\spaylor], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ELE_spaylor], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\SQLWriter], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\Winmgmt], [sysadmin];
GO

EXEC sp_addsrvrolemember [NT SERVICE\MSSQLSERVER], [sysadmin];
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

EXEC sp_addsrvrolemember [VIEJAS\IT_APPS_Elevated], [sysadmin];
GO

/*****************************************************************************************/
/*****************Add User and Roles membership to Indivdual Databases********************/
/*****************************************************************************************/
Use Bally_Activity;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Bally_BCC_Meters;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use DBA;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DataExtractor')
CREATE USER [DataExtractor] FOR LOGIN [DataExtractor] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DataExtractor]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ERevak')
CREATE USER [VIEJAS\ERevak] FOR LOGIN [VIEJAS\ERevak] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ERevak]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JGiolitto')
CREATE USER [VIEJAS\JGiolitto] FOR LOGIN [VIEJAS\JGiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JGiolitto]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NVanDyk')
CREATE USER [VIEJAS\NVanDyk] FOR LOGIN [VIEJAS\NVanDyk] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\NVanDyk]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'sdsDW')
CREATE USER [sdsDW] FOR LOGIN [sdsDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[sdsDW]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CASI_Link')
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[CASI_Link]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Optxusr')
CREATE USER [Optxusr] FOR LOGIN [Optxusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[Optxusr]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MThompson')
CREATE USER [VIEJAS\MThompson] FOR LOGIN [VIEJAS\MThompson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MThompson]'; 
Go
Use SDSVJPRD;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'sdsjb_ro')
CREATE USER [sdsjb_ro] FOR LOGIN [sdsjb_ro] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[sdsjb_ro]'; 
Go

Completion time: 2025-09-08T10:57:14.1940205-07:00
