/*****************************************************************************************/
/*************************************** Create Logins ***********************************/
/*****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DBAdmin]')
CREATE LOGIN [DBAdmin] WITH PASSWORD=0x0200b71f5927ae90a9fb236027ad71ff688157516637c0de2336154d7dbd86c7405ba124e4de902e90878286df2de8e19df61d8ee9ea1fa2339e6fdccba9edab3ae6a900ad07 HASHED, SID=0x01, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyTsqlExecutionLogin##]')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=0x020034f41c896cc31cbefd1ef97529234061779b15f1ebe124ddef9b5ad04fc5c0767e9d4834c873dc01fdf0ecb5879ee9931ae76d9834ca9ec4eeec154da8e3673717ddb75e HASHED, SID=0xa9eeb439f4762546bd90d163703f6da1, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[ITappsDBA]')
CREATE LOGIN [ITappsDBA] WITH PASSWORD=0x02000f7c1ae34c6f8316612ced5bf654b2d9dc85207635c5359415fab5ebe9f69b09cf0ff8420eab02964b03ca2912896f6f21776a2df9e2f12a88e9792e9f495732de83a69b HASHED, SID=0xf590c1b3e90da041bf39802e0d3bdda7, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DPA]')
CREATE LOGIN [DPA] WITH PASSWORD=0x020028603aa37a8e30e8045372b2124051447d9dadfaa02a2e00872de8b5a9183dd0a1639ba9e27cfebf637a636be5b663c9fcdbdc7c217e7b42563cbbf25b8639423b1c0ae2 HASHED, SID=0xa3ee3b96c9cde34888aed9db4063f11a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[GlobalPayments]')
CREATE LOGIN [GlobalPayments] WITH PASSWORD=0x0200d10c576d6a5fe1998784a6deeb1929b26370140a9282b41af0422bff1cd154ad9676d20d2017d6f9d1520c4785b1df5633284c1b638032c4c90a3d5bb14b7df4bfe817e7 HASHED, SID=0xb509efdeca49034aad2b6437e81aed49, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[web_services]')
CREATE LOGIN [web_services] WITH PASSWORD=0x02001b09c2d2c8205c877432952090559e5cd38cd03de425a74b19fbda93c06e0e2b73fc3ac80ee9b5f7564041ec37294d47d4f58f5a285fa41903ce6903924c381c7f4797b2 HASHED, SID=0x0c7e4d6a57ba2f4cbdfcceae2afb6d4d, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[web_site]')
CREATE LOGIN [web_site] WITH PASSWORD=0x0200a5a44afa8fce11a92f20d145d48347402f7fff4b0562f485e0aebc9b0c4c93912520e54ead032009731a7b1dbaa9dcfbca5a71f5bbbd26b13d526cab1894a398a0c01895 HASHED, SID=0x0d05b1966033604f8bfcc2d3eb500e84, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[GP Reporting Cash Connect Service]')
CREATE LOGIN [GP Reporting Cash Connect Service] WITH PASSWORD=0x02006b261403020ab314713cf58c9ab462caca45443345f7d07174de2be28d26f706750164917e371f445b657cd983942fd739ba4606bdb7c396b6e4b7f316afad2c66e9448e HASHED, SID=0xbbd748421f6aaf43b465ab44a3e5edb6, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[GP_Install_Admin]')
CREATE LOGIN [GP_Install_Admin] WITH PASSWORD=0x02001df64d7953104394469954568a2e7d9c9be4789064d6845247144c4e1135bcebe84e219fb94b947da68e3baa1cee23c87eaad07d4749ab8a646f10d870f04271614051d9 HASHED, SID=0x3037d7f73ac27745b813905c94df908b, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyEventProcessingLogin##]')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=0x02007b8ff20dfc0ca9fcb4d651a51fdc1c27ee8e14db8ec52040c01548044f1168efa87746cc7769579bfa843c810ccfdaca4beab1a46152471eca6e26e52b28323333dddb01 HASHED, SID=0x05efc4fba19d83479b41c548f18625c0, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[SSRS_User]')
CREATE LOGIN [SSRS_User] WITH PASSWORD=0x0200abd61fee608b19487a78acb6d716f02dce3786246301614ef47caacf74b865c424740a6013ecea45f4950d5614b6815c3d005e269b1a1302f4283f8827e1903fb7c98077 HASHED, SID=0x0fa51dbe27bf5842b5b743c0caa202ae, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
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

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[IIS APPPOOL\GpAccessControlServiceAppPool]')
CREATE LOGIN [IIS APPPOOL\GpAccessControlServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[IIS APPPOOL\GpClientServiceAppPool]')
CREATE LOGIN [IIS APPPOOL\GpClientServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[IIS APPPOOL\GpReportingServiceAppPool]')
CREATE LOGIN [IIS APPPOOL\GpReportingServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[IIS APPPOOL\GpPortalServiceAppPool]')
CREATE LOGIN [IIS APPPOOL\GpPortalServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\HSimpson]')
CREATE LOGIN [VIEJAS\HSimpson] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\pparker]')
CREATE LOGIN [VIEJAS\pparker] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\SQLService1]')
CREATE LOGIN [VIEJAS\SQLService1] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\kwagner]')
CREATE LOGIN [VIEJAS\kwagner] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\GPPSDB01PR$]')
CREATE LOGIN [VIEJAS\GPPSDB01PR$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\iderasvc01]')
CREATE LOGIN [VIEJAS\iderasvc01] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ITappsSQLadmin]')
CREATE LOGIN [VIEJAS\ITappsSQLadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[NT SERVICE\SQLTELEMETRY]')
CREATE LOGIN [NT SERVICE\SQLTELEMETRY] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\vmadmin]')
CREATE LOGIN [VIEJAS\vmadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
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

EXEC sp_addsrvrolemember [VIEJAS\HSimpson], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\pparker], [sysadmin];
GO

EXEC sp_addsrvrolemember [ITappsDBA], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\SQLService1], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\kwagner], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\GPPSDB01PR$], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\iderasvc01], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\ITappsSQLadmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [DPA], [sysadmin];
GO

EXEC sp_addsrvrolemember [GlobalPayments], [sysadmin];
GO

EXEC sp_addsrvrolemember [GP_Install_Admin], [sysadmin];
GO

EXEC sp_addsrvrolemember [VIEJAS\vmadmin], [sysadmin];
GO

/*****************************************************************************************/
/*****************Add User and Roles membership to Indivdual Databases********************/
/*****************************************************************************************/
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bosDbUser')
CREATE USER [bosDbUser] FOR LOGIN [bosDbUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[bosDbUser]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bosDbUser')
CREATE USER [bosDbUser] FOR LOGIN [bosDbUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[bosDbUser]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bosDbUser')
CREATE USER [bosDbUser] FOR LOGIN [bosDbUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[bosDbUser]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Membership_FullAccess')
CREATE USER [aspnet_Membership_FullAccess] FOR LOGIN [aspnet_Membership_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Membership_BasicAccess', N'[aspnet_Membership_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Membership_FullAccess')
CREATE USER [aspnet_Membership_FullAccess] FOR LOGIN [aspnet_Membership_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Membership_ReportingAccess', N'[aspnet_Membership_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Profile_FullAccess')
CREATE USER [aspnet_Profile_FullAccess] FOR LOGIN [aspnet_Profile_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Profile_BasicAccess', N'[aspnet_Profile_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Profile_FullAccess')
CREATE USER [aspnet_Profile_FullAccess] FOR LOGIN [aspnet_Profile_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Profile_ReportingAccess', N'[aspnet_Profile_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Roles_FullAccess')
CREATE USER [aspnet_Roles_FullAccess] FOR LOGIN [aspnet_Roles_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Roles_BasicAccess', N'[aspnet_Roles_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Roles_FullAccess')
CREATE USER [aspnet_Roles_FullAccess] FOR LOGIN [aspnet_Roles_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Roles_ReportingAccess', N'[aspnet_Roles_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Personalization_FullAccess')
CREATE USER [aspnet_Personalization_FullAccess] FOR LOGIN [aspnet_Personalization_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Personalization_BasicAccess', N'[aspnet_Personalization_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'aspnet_Personalization_FullAccess')
CREATE USER [aspnet_Personalization_FullAccess] FOR LOGIN [aspnet_Personalization_FullAccess] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'aspnet_Personalization_ReportingAccess', N'[aspnet_Personalization_FullAccess]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ASAIBOG\tfs')
CREATE USER [ASAIBOG\tfs] FOR LOGIN [ASAIBOG\tfs] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[ASAIBOG\tfs]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ASAIBOG\tfs')
CREATE USER [ASAIBOG\tfs] FOR LOGIN [ASAIBOG\tfs] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[ASAIBOG\tfs]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ASAIBOG\BogotaTeam')
CREATE USER [ASAIBOG\BogotaTeam] FOR LOGIN [ASAIBOG\BogotaTeam] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[ASAIBOG\BogotaTeam]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ASAIBOG\BogotaTeam')
CREATE USER [ASAIBOG\BogotaTeam] FOR LOGIN [ASAIBOG\BogotaTeam] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[ASAIBOG\BogotaTeam]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ASAIBOG\BogotaTeam')
CREATE USER [ASAIBOG\BogotaTeam] FOR LOGIN [ASAIBOG\BogotaTeam] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[ASAIBOG\BogotaTeam]'; 
Go
Use BackOffice;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GPPSDB01PR$')
CREATE USER [VIEJAS\GPPSDB01PR$] FOR LOGIN [VIEJAS\GPPSDB01PR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\GPPSDB01PR$]'; 
Go
Use DBA;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Msg 911, Level 16, State 1, Line 1
Database 'GP' does not exist. Make sure that the name is entered correctly.

Completion time: 2021-11-15T16:37:19.4889082-08:00
