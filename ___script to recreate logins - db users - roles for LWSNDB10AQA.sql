/*****************************************************************************************/
/*************************************** Create Logins ***********************************/
/*****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyTsqlExecutionLogin##]')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=0x02003da9cf6c3af4eab68d81507d725122afca75efeca73169290dd7b4d319a62594ff865d712c8449dfd1b86c37cde1fbd2c86bc0fd8687d59ef5459067c9b137d351ac774d HASHED, SID=0xa9eeb439f4762546bd90d163703f6da1, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyEventProcessingLogin##]')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=0x02009618bebf157d0687b00b243cd692e0b00126468befe9405a5724dffc5e796c9bf8b3b273dee7826116d2a8e3c312b6670832711938dfbabcd80b5c663aa1a78cb0483628 HASHED, SID=0x16db10cd2e0a62498e2b0109694ab153, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[ITappsDBA]')
CREATE LOGIN [ITappsDBA] WITH PASSWORD=0x0200b30eaeaa6ba639185a4d40e87467351698ce2038bd0c3b7bea7371edee3542b3883f901311701312baeb4a92be95706151d288a4b2b45f079e1a7d44d91f7a5c9d451f6b HASHED, SID=0xa693bcf9cd42f64c9c1a70f7a02c7a8c, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[Lawson10]')
CREATE LOGIN [Lawson10] WITH PASSWORD=0x0200f5bd624341ecbcc6ec55196cc66ed0ba67c21873622a246106023f62d00e72f9f72d242f62a954e416f5c7b77c48ffdcf22af224d52c9c98004284dd39398ab636f50c7b HASHED, SID=0xf3ae071b97d81844ba98199b69fc730c, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[lmgen]')
CREATE LOGIN [lmgen] WITH PASSWORD=0x020074ab81893123e4aec349c23ba1577679191aaccf7062ccd895de33c4918bcb91ec6d726303252d1989ff3092ccb489ce5bc1c6ca7507796f26c2c22834ef2291e8419305 HASHED, SID=0x9c2d6472d73aeb49bb58e72d354dd0b6, DEFAULT_DATABASE=[lmgen], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[IPA_PROD10]')
CREATE LOGIN [IPA_PROD10] WITH PASSWORD=0x020011f66580cdf05170d1cb99f6ae0b460727f4d8faa252d59cdeaabf441cbf54254826209a1d66d7bd6f4e9d1163956f740b6bc3c01b4c57981af403d93ade945ae9e35b26 HASHED, SID=0x0769719e9fb4ce47b5838328a21ad6de, DEFAULT_DATABASE=[IPA_PROD10], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DPA]')
CREATE LOGIN [DPA] WITH PASSWORD=0x020028603aa37a8e30e8045372b2124051447d9dadfaa02a2e00872de8b5a9183dd0a1639ba9e27cfebf637a636be5b663c9fcdbdc7c217e7b42563cbbf25b8639423b1c0ae2 HASHED, SID=0xa3ee3b96c9cde34888aed9db4063f11a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[SSRS_User]')
CREATE LOGIN [SSRS_User] WITH PASSWORD=0x0200abd61fee608b19487a78acb6d716f02dce3786246301614ef47caacf74b865c424740a6013ecea45f4950d5614b6815c3d005e269b1a1302f4283f8827e1903fb7c98077 HASHED, SID=0x0fa51dbe27bf5842b5b743c0caa202ae, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
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

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\spaylor]')
CREATE LOGIN [VIEJAS\spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\gMSA007$]')
CREATE LOGIN [VIEJAS\gMSA007$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\hmccoy]')
CREATE LOGIN [VIEJAS\hmccoy] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\SQLService1]')
CREATE LOGIN [VIEJAS\SQLService1] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\ITappsSQLadmin]')
CREATE LOGIN [VIEJAS\ITappsSQLadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\Lawson]')
CREATE LOGIN [VIEJAS\Lawson] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\SPInstall]')
CREATE LOGIN [VIEJAS\SPInstall] FROM WINDOWS WITH DEFAULT_DATABASE=[SharePoint_Config], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\SPServices]')
CREATE LOGIN [VIEJAS\SPServices] FROM WINDOWS WITH DEFAULT_DATABASE=[SharePoint_Config], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\SPFarm]')
CREATE LOGIN [VIEJAS\SPFarm] FROM WINDOWS WITH DEFAULT_DATABASE=[SharePoint_Config], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\hsimpson]')
CREATE LOGIN [VIEJAS\hsimpson] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\cwalters]')
CREATE LOGIN [VIEJAS\cwalters] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\APPSWB23DV$]')
CREATE LOGIN [VIEJAS\APPSWB23DV$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\Outsource_Developers]')
CREATE LOGIN [VIEJAS\Outsource_Developers] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\LWSNMG10QA$]')
CREATE LOGIN [VIEJAS\LWSNMG10QA$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\vmadmin]')
CREATE LOGIN [VIEJAS\vmadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[VIEJAS\IT_Apps]')
CREATE LOGIN [VIEJAS\IT_Apps] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
Go

/*****************************************************************************************/
/******************************Add Server Role Members     *******************************/
/*****************************************************************************************/
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

EXEC sp_addsrvrolemember [VIEJAS\spaylor], [sysadmin];
GO

/*****************************************************************************************/
/*****************Add User and Roles membership to Indivdual Databases********************/
/*****************************************************************************************/
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendba')
CREATE USER [infogendba] FOR LOGIN [infogendba] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[infogendba]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendts')
CREATE USER [infogendts] FOR LOGIN [infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[infogendts]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendts')
CREATE USER [infogendts] FOR LOGIN [infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_accessadmin', N'[infogendts]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendts')
CREATE USER [infogendts] FOR LOGIN [infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_securityadmin', N'[infogendts]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendts')
CREATE USER [infogendts] FOR LOGIN [infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[infogendts]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendts')
CREATE USER [infogendts] FOR LOGIN [infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[infogendts]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendts')
CREATE USER [infogendts] FOR LOGIN [infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[infogendts]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[VIEJAS\EOmbui]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\EOmbui]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\EOmbui]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[VIEJAS\NBrown]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\NBrown]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\NBrown]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\frxuser]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'frxuser')
CREATE USER [frxuser] FOR LOGIN [frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[frxuser]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lawson')
CREATE USER [lawson] FOR LOGIN [lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[lawson]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Lawson')
CREATE USER [VIEJAS\Lawson] FOR LOGIN [VIEJAS\Lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\Lawson]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ssannicolas')
CREATE USER [VIEJAS\ssannicolas] FOR LOGIN [VIEJAS\ssannicolas] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ssannicolas]'; 
Go
Use Fin_Data_WH;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DashboardUser]'; 
Go
Use GEN;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use GEN;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson10')
CREATE USER [Lawson10] FOR LOGIN [Lawson10] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[Lawson10]'; 
Go
Use GEN;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Lawson')
CREATE USER [VIEJAS\Lawson] FOR LOGIN [VIEJAS\Lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\Lawson]'; 
Go
Use GEN;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\LWSNMG10QA$')
CREATE USER [VIEJAS\LWSNMG10QA$] FOR LOGIN [VIEJAS\LWSNMG10QA$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\LWSNMG10QA$]'; 
Go
Use IPA_PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use IPA_PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'IPA_PROD10')
CREATE USER [IPA_PROD10] FOR LOGIN [IPA_PROD10] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[IPA_PROD10]'; 
Go
Use IPA_PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'IPA_PROD10')
CREATE USER [IPA_PROD10] FOR LOGIN [IPA_PROD10] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[IPA_PROD10]'; 
Go
Use IPA_PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'IPA_PROD10')
CREATE USER [IPA_PROD10] FOR LOGIN [IPA_PROD10] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[IPA_PROD10]'; 
Go
Use KT_FP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use KT_FP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\wbsnadmin')
CREATE USER [VIEJAS\wbsnadmin] FOR LOGIN [VIEJAS\wbsnadmin] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\wbsnadmin]'; 
Go
Use KT_FP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\wbsnadmin')
CREATE USER [VIEJAS\wbsnadmin] FOR LOGIN [VIEJAS\wbsnadmin] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\wbsnadmin]'; 
Go
Use KT_FP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Keytracer')
CREATE USER [Keytracer] FOR LOGIN [Keytracer] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[Keytracer]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'IT_test_user')
CREATE USER [IT_test_user] FOR LOGIN [IT_test_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'time_attendance_role', N'[IT_test_user]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\EOmbui]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[VIEJAS\EOmbui]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\EOmbui]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\EOmbui]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'MCiolino')
CREATE USER [MCiolino] FOR LOGIN [MCiolino] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[MCiolino]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DGraves')
CREATE USER [DGraves] FOR LOGIN [DGraves] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[DGraves]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\NBrown]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[VIEJAS\NBrown]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\NBrown]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\NBrown]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Crystal NT')
CREATE USER [Crystal NT] FOR LOGIN [Crystal NT] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[Crystal NT]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'adp_user')
CREATE USER [adp_user] FOR LOGIN [adp_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[adp_user]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_LexID')
CREATE USER [Lawson_LexID] FOR LOGIN [Lawson_LexID] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_LexID', N'[Lawson_LexID]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CEPGJBSVR')
CREATE USER [VIEJAS\CEPGJBSVR] FOR LOGIN [VIEJAS\CEPGJBSVR] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CEPGJBSVR]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CEPGJBSVR')
CREATE USER [VIEJAS\CEPGJBSVR] FOR LOGIN [VIEJAS\CEPGJBSVR] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\CEPGJBSVR]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\frxuser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\payroll_srv')
CREATE USER [VIEJAS\payroll_srv] FOR LOGIN [VIEJAS\payroll_srv] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_payroll', N'[VIEJAS\payroll_srv]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cthompson')
CREATE USER [cthompson] FOR LOGIN [cthompson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_OSHA', N'[cthompson]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'frxuser')
CREATE USER [frxuser] FOR LOGIN [frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[frxuser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'frxuser')
CREATE USER [frxuser] FOR LOGIN [frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_ddladmin', N'[frxuser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'frxuser')
CREATE USER [frxuser] FOR LOGIN [frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[frxuser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'frxuser')
CREATE USER [frxuser] FOR LOGIN [frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_FRX', N'[frxuser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'hr_emp')
CREATE USER [hr_emp] FOR LOGIN [hr_emp] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_emp', N'[hr_emp]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'hr_payroll')
CREATE USER [hr_payroll] FOR LOGIN [hr_payroll] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[hr_payroll]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'hr_payroll')
CREATE USER [hr_payroll] FOR LOGIN [hr_payroll] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[hr_payroll]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lawson')
CREATE USER [lawson] FOR LOGIN [lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[lawson]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\fin_hr')
CREATE USER [VIEJAS\fin_hr] FOR LOGIN [VIEJAS\fin_hr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_FIN_HR', N'[VIEJAS\fin_hr]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\hr_osha')
CREATE USER [VIEJAS\hr_osha] FOR LOGIN [VIEJAS\hr_osha] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_OSHA', N'[VIEJAS\hr_osha]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Lawson')
CREATE USER [VIEJAS\Lawson] FOR LOGIN [VIEJAS\Lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\Lawson]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jfreedman')
CREATE USER [VIEJAS\jfreedman] FOR LOGIN [VIEJAS\jfreedman] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\jfreedman]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CGarcia')
CREATE USER [VIEJAS\CGarcia] FOR LOGIN [VIEJAS\CGarcia] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\CGarcia]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\cwalters')
CREATE USER [VIEJAS\cwalters] FOR LOGIN [VIEJAS\cwalters] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\cwalters]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\adpuser')
CREATE USER [VIEJAS\adpuser] FOR LOGIN [VIEJAS\adpuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\adpuser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\adpuser')
CREATE USER [VIEJAS\adpuser] FOR LOGIN [VIEJAS\adpuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\adpuser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GCreech')
CREATE USER [VIEJAS\GCreech] FOR LOGIN [VIEJAS\GCreech] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GCreech]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\dozbirn')
CREATE USER [VIEJAS\dozbirn] FOR LOGIN [VIEJAS\dozbirn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\dozbirn]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\dozbirn')
CREATE USER [VIEJAS\dozbirn] FOR LOGIN [VIEJAS\dozbirn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\dozbirn]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DTexara')
CREATE USER [VIEJAS\DTexara] FOR LOGIN [VIEJAS\DTexara] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DTexara]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DTexara')
CREATE USER [VIEJAS\DTexara] FOR LOGIN [VIEJAS\DTexara] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\DTexara]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\PTran')
CREATE USER [VIEJAS\PTran] FOR LOGIN [VIEJAS\PTran] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\PTran]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VImmanni')
CREATE USER [VIEJAS\VImmanni] FOR LOGIN [VIEJAS\VImmanni] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\VImmanni]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VImmanni')
CREATE USER [VIEJAS\VImmanni] FOR LOGIN [VIEJAS\VImmanni] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\VImmanni]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DashboardUser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\whickman')
CREATE USER [VIEJAS\whickman] FOR LOGIN [VIEJAS\whickman] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\whickman]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\whickman')
CREATE USER [VIEJAS\whickman] FOR LOGIN [VIEJAS\whickman] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\whickman]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Akelleher')
CREATE USER [VIEJAS\Akelleher] FOR LOGIN [VIEJAS\Akelleher] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\Akelleher]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TCanicosa')
CREATE USER [VIEJAS\TCanicosa] FOR LOGIN [VIEJAS\TCanicosa] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TCanicosa]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReportsUser')
CREATE USER [ReportsUser] FOR LOGIN [ReportsUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[ReportsUser]'; 
Go
Use LAWSON_EXTRACT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MTallarida')
CREATE USER [VIEJAS\MTallarida] FOR LOGIN [VIEJAS\MTallarida] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\MTallarida]'; 
Go
Use lmgen;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use lmgen;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lmgen')
CREATE USER [lmgen] FOR LOGIN [lmgen] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[lmgen]'; 
Go
Use lmgen;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lmgen')
CREATE USER [lmgen] FOR LOGIN [lmgen] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[lmgen]'; 
Go
Use lmgen;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lmgen')
CREATE USER [lmgen] FOR LOGIN [lmgen] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[lmgen]'; 
Go
Use Logan;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Logan;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lawson')
CREATE USER [lawson] FOR LOGIN [lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[lawson]'; 
Go
Use Logan;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Lawson')
CREATE USER [VIEJAS\Lawson] FOR LOGIN [VIEJAS\Lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\Lawson]'; 
Go
Use Logan;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DashboardUser]'; 
Go
Use Logan;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson10')
CREATE USER [Lawson10] FOR LOGIN [Lawson10] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[Lawson10]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[VIEJAS\EOmbui]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\EOmbui]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\EOmbui')
CREATE USER [VIEJAS\EOmbui] FOR LOGIN [VIEJAS\EOmbui] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\EOmbui]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'infogendba')
CREATE USER [infogendba] FOR LOGIN [infogendba] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[infogendba]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\infogendts')
CREATE USER [VIEJAS\infogendts] FOR LOGIN [VIEJAS\infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\infogendts]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\infogendts')
CREATE USER [VIEJAS\infogendts] FOR LOGIN [VIEJAS\infogendts] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\infogendts]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[VIEJAS\NBrown]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\NBrown]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\NBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\NBrown]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\frxuser]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'frxuser')
CREATE USER [frxuser] FOR LOGIN [frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[frxuser]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lawson')
CREATE USER [lawson] FOR LOGIN [lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[lawson]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Lawson')
CREATE USER [VIEJAS\Lawson] FOR LOGIN [VIEJAS\Lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\Lawson]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ssannicolas')
CREATE USER [VIEJAS\ssannicolas] FOR LOGIN [VIEJAS\ssannicolas] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ssannicolas]'; 
Go
Use PR_Data_DW;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DashboardUser]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'lawson10')
CREATE USER [lawson10] FOR LOGIN [lawson10] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[lawson10]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\lawson')
CREATE USER [VIEJAS\lawson] FOR LOGIN [VIEJAS\lawson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\lawson]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Crystal NT')
CREATE USER [VIEJAS\Crystal NT] FOR LOGIN [VIEJAS\Crystal NT] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Crystal NT]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Lawson CR SQL')
CREATE USER [VIEJAS\Lawson CR SQL] FOR LOGIN [VIEJAS\Lawson CR SQL] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Lawson CR SQL]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Nelson Brown')
CREATE USER [Nelson Brown] FOR LOGIN [Nelson Brown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[Nelson Brown]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Nelson Brown')
CREATE USER [Nelson Brown] FOR LOGIN [Nelson Brown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[Nelson Brown]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_FRX', N'[VIEJAS\frxuser]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_ddladmin', N'[VIEJAS\frxuser]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\frxuser')
CREATE USER [VIEJAS\frxuser] FOR LOGIN [VIEJAS\frxuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\frxuser]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'adp_user')
CREATE USER [adp_user] FOR LOGIN [adp_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[adp_user]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CEPGJBSVR')
CREATE USER [VIEJAS\CEPGJBSVR] FOR LOGIN [VIEJAS\CEPGJBSVR] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CEPGJBSVR]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CEPGJBSVR')
CREATE USER [VIEJAS\CEPGJBSVR] FOR LOGIN [VIEJAS\CEPGJBSVR] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\CEPGJBSVR]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\FIN_HR')
CREATE USER [VIEJAS\FIN_HR] FOR LOGIN [VIEJAS\FIN_HR] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_FIN_HR', N'[VIEJAS\FIN_HR]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\HR_EMP')
CREATE USER [VIEJAS\HR_EMP] FOR LOGIN [VIEJAS\HR_EMP] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_emp', N'[VIEJAS\HR_EMP]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\HR_OSHA')
CREATE USER [VIEJAS\HR_OSHA] FOR LOGIN [VIEJAS\HR_OSHA] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'Lawson_OSHA', N'[VIEJAS\HR_OSHA]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\hr_payroll')
CREATE USER [VIEJAS\hr_payroll] FOR LOGIN [VIEJAS\hr_payroll] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\hr_payroll]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\hr_payroll')
CREATE USER [VIEJAS\hr_payroll] FOR LOGIN [VIEJAS\hr_payroll] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\hr_payroll]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jfreedman')
CREATE USER [VIEJAS\jfreedman] FOR LOGIN [VIEJAS\jfreedman] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jfreedman]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\cwalters')
CREATE USER [VIEJAS\cwalters] FOR LOGIN [VIEJAS\cwalters] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\cwalters]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson_LexID')
CREATE USER [Lawson_LexID] FOR LOGIN [Lawson_LexID] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_LexID', N'[Lawson_LexID]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\adpuser')
CREATE USER [VIEJAS\adpuser] FOR LOGIN [VIEJAS\adpuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\adpuser]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'GC_LawsonITrak')
CREATE USER [GC_LawsonITrak] FOR LOGIN [GC_LawsonITrak] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[GC_LawsonITrak]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DTexara')
CREATE USER [VIEJAS\DTexara] FOR LOGIN [VIEJAS\DTexara] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\DTexara]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VImmanni')
CREATE USER [VIEJAS\VImmanni] FOR LOGIN [VIEJAS\VImmanni] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\VImmanni]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VImmanni')
CREATE USER [VIEJAS\VImmanni] FOR LOGIN [VIEJAS\VImmanni] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\VImmanni]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DashboardUser')
CREATE USER [DashboardUser] FOR LOGIN [DashboardUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DashboardUser]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Prophix_RO')
CREATE USER [Prophix_RO] FOR LOGIN [Prophix_RO] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[Prophix_RO]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\dmehta')
CREATE USER [VIEJAS\dmehta] FOR LOGIN [VIEJAS\dmehta] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\dmehta]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ReportsUser')
CREATE USER [ReportsUser] FOR LOGIN [ReportsUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[ReportsUser]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Akelleher')
CREATE USER [VIEJAS\Akelleher] FOR LOGIN [VIEJAS\Akelleher] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Akelleher]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SWright')
CREATE USER [VIEJAS\SWright] FOR LOGIN [VIEJAS\SWright] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SWright]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\APham')
CREATE USER [VIEJAS\APham] FOR LOGIN [VIEJAS\APham] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\APham]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TCanicosa')
CREATE USER [VIEJAS\TCanicosa] FOR LOGIN [VIEJAS\TCanicosa] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TCanicosa]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ERevak')
CREATE USER [VIEJAS\ERevak] FOR LOGIN [VIEJAS\ERevak] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ERevak]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CrystalNT_Training')
CREATE USER [VIEJAS\CrystalNT_Training] FOR LOGIN [VIEJAS\CrystalNT_Training] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CrystalNT_Training]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JLayno')
CREATE USER [VIEJAS\JLayno] FOR LOGIN [VIEJAS\JLayno] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JLayno]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MTallarida')
CREATE USER [VIEJAS\MTallarida] FOR LOGIN [VIEJAS\MTallarida] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MTallarida]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MCass')
CREATE USER [VIEJAS\MCass] FOR LOGIN [VIEJAS\MCass] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MCass]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TDeleon')
CREATE USER [VIEJAS\TDeleon] FOR LOGIN [VIEJAS\TDeleon] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TDeleon]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JGiolitto')
CREATE USER [VIEJAS\JGiolitto] FOR LOGIN [VIEJAS\JGiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JGiolitto]'; 
Go
Use PROD10;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lawson10')
CREATE USER [Lawson10] FOR LOGIN [Lawson10] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[Lawson10]'; 
Go
Msg 911, Level 16, State 1, Line 11
Database 'SharePoint_AdminContent_f232ca6a' does not exist. Make sure that the name is entered correctly.

Completion time: 2023-10-06T16:28:42.6956923-07:00
