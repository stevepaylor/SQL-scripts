/*****************************************************************************************/
/*************************************** Create Logins ***********************************/
/*****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyTsqlExecutionLogin##]')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=0x020039c99f9fdc1704a5113a86413ef4274b7d9b916a3ad48feaf8f3c1a6187c3106e80e003398f622dffa4d1180b0f4f4f626659b0e4e3575e5ce91b93b2f2e893102fa90bd HASHED, SID=0x6fdccb0634728d499251c4f30ad23d4e, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[##MS_PolicyEventProcessingLogin##]')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=0x02006fcbbc4b84c18472db11122e8f4aa2880421127f154966305e06fb23eeeffb61613b6c0cd6bcef830deacc69f54039dd07596c07bc14d7db9f32e6f996b26d5feaab2096 HASHED, SID=0x97d243d55ece2147b91e0ff6ed846f2f, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DPA]')
CREATE LOGIN [DPA] WITH PASSWORD=0x020028603aa37a8e30e8045372b2124051447d9dadfaa02a2e00872de8b5a9183dd0a1639ba9e27cfebf637a636be5b663c9fcdbdc7c217e7b42563cbbf25b8639423b1c0ae2 HASHED, SID=0xa3ee3b96c9cde34888aed9db4063f11a, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[ITappsDBA]')
CREATE LOGIN [ITappsDBA] WITH PASSWORD=0x02001471fd72af827a46d96bf7eff0e1a54888536b68c5fc621fea08cc08bea94271911f6c7ba761e360a626a55e38e4910bb151cbf713709104bae0014434164bbadd2c2f3f HASHED, SID=0x2d63ceb5f6d2ac4995710adef7628270, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[DBAdmin]')
CREATE LOGIN [DBAdmin] WITH PASSWORD=0x0200934e0e7a5a54d43cada61470b81eb0f7b2bd37b4bdb6efb85b5fa6438f19faa3799872bd402f2d3e675f62cf3298b586b4bd889a296b0758868d7a098bb78953347ca462 HASHED, SID=0xe43945b36478364e93ba2635d5d56c78, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[cmktuser]')
CREATE LOGIN [cmktuser] WITH PASSWORD=0x0200e1adec3cfb5f5d7ca33b302a867a48ee331e4c2dcb586610657d05062b0eed53ff30ddd1397e30c04c88ec9b176a9bbeb6991f54693b18a1e5ba19618a2b9ff28c37921e HASHED, SID=0x6027dba64ffe694f8e26a3ebb109c877, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
Go

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'[cmktuser2]')
CREATE LOGIN [cmktuser2] WITH PASSWORD=0x0200f9bbba5728e23e9ccab1b91c97b3d7bb2edc1ae64b8a6af65568e014414df2f470b7234011556c0f286cc32de5a9694e53834fa654dd6e1aebc5d32873a83b1d44edafd2 HASHED, SID=0x1a642b2254f4754ca09700ef522f8b1b, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
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

EXEC sp_addsrvrolemember [DBAdmin], [sysadmin];
GO

EXEC sp_addsrvrolemember [cmktuser], [sysadmin];
GO

EXEC sp_addsrvrolemember [cmktuser2], [sysadmin];
GO

/*****************************************************************************************/
/*****************Add User and Roles membership to Indivdual Databases********************/
/*****************************************************************************************/

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use BOSS_30Sep;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmktuser')
CREATE USER [cmktuser] FOR LOGIN [cmktuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[cmktuser]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmktuser2')
CREATE USER [cmktuser2] FOR LOGIN [cmktuser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[cmktuser2]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpReports')
CREATE USER [cmpReports] FOR LOGIN [cmpReports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpReports]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\sbauer')
CREATE USER [VIEJAS\sbauer] FOR LOGIN [VIEJAS\sbauer] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\sbauer]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CASI_Link')
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[CASI_Link]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CMP13_Reader')
CREATE USER [CMP13_Reader] FOR LOGIN [CMP13_Reader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[CMP13_Reader]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'datareader')
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[datareader]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ewallace')
CREATE USER [VIEJAS\ewallace] FOR LOGIN [VIEJAS\ewallace] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ewallace]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\kerazo')
CREATE USER [VIEJAS\kerazo] FOR LOGIN [VIEJAS\kerazo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\kerazo]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\apham')
CREATE USER [VIEJAS\apham] FOR LOGIN [VIEJAS\apham] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\apham]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\dmehta')
CREATE USER [VIEJAS\dmehta] FOR LOGIN [VIEJAS\dmehta] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\dmehta]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\erevak')
CREATE USER [VIEJAS\erevak] FOR LOGIN [VIEJAS\erevak] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\erevak]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\datamart')
CREATE USER [VIEJAS\datamart] FOR LOGIN [VIEJAS\datamart] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\datamart]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\LCarr')
CREATE USER [VIEJAS\LCarr] FOR LOGIN [VIEJAS\LCarr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\LCarr]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\kgibson')
CREATE USER [VIEJAS\kgibson] FOR LOGIN [VIEJAS\kgibson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\kgibson]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\vmenjares')
CREATE USER [VIEJAS\vmenjares] FOR LOGIN [VIEJAS\vmenjares] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\vmenjares]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\alunsford')
CREATE USER [VIEJAS\alunsford] FOR LOGIN [VIEJAS\alunsford] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\alunsford]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\cmendez')
CREATE USER [VIEJAS\cmendez] FOR LOGIN [VIEJAS\cmendez] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\cmendez]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ssothras')
CREATE USER [VIEJAS\ssothras] FOR LOGIN [VIEJAS\ssothras] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ssothras]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RScott')
CREATE USER [VIEJAS\RScott] FOR LOGIN [VIEJAS\RScott] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RScott]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TGrady')
CREATE USER [VIEJAS\TGrady] FOR LOGIN [VIEJAS\TGrady] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TGrady]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NDollins')
CREATE USER [VIEJAS\NDollins] FOR LOGIN [VIEJAS\NDollins] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\NDollins]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MGoens')
CREATE USER [VIEJAS\MGoens] FOR LOGIN [VIEJAS\MGoens] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MGoens]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JLAYNO')
CREATE USER [VIEJAS\JLAYNO] FOR LOGIN [VIEJAS\JLAYNO] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JLAYNO]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\sdraper')
CREATE USER [VIEJAS\sdraper] FOR LOGIN [VIEJAS\sdraper] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\sdraper]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\LLofstrom')
CREATE USER [VIEJAS\LLofstrom] FOR LOGIN [VIEJAS\LLofstrom] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\LLofstrom]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\tsimons')
CREATE USER [VIEJAS\tsimons] FOR LOGIN [VIEJAS\tsimons] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\tsimons]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\vmena')
CREATE USER [VIEJAS\vmena] FOR LOGIN [VIEJAS\vmena] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\vmena]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NVanDyk')
CREATE USER [VIEJAS\NVanDyk] FOR LOGIN [VIEJAS\NVanDyk] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\NVanDyk]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpDW')
CREATE USER [cmpDW] FOR LOGIN [cmpDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpDW]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MCass')
CREATE USER [VIEJAS\MCass] FOR LOGIN [VIEJAS\MCass] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MCass]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SWright')
CREATE USER [VIEJAS\SWright] FOR LOGIN [VIEJAS\SWright] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SWright]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Outsource_Developers')
CREATE USER [VIEJAS\Outsource_Developers] FOR LOGIN [VIEJAS\Outsource_Developers] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Outsource_Developers]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'JoeBlow')
CREATE USER [JoeBlow] FOR LOGIN [JoeBlow] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[JoeBlow]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'PowerKiosk')
CREATE USER [PowerKiosk] FOR LOGIN [PowerKiosk] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[PowerKiosk]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ckeener')
CREATE USER [VIEJAS\ckeener] FOR LOGIN [VIEJAS\ckeener] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ckeener]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\bjaeger')
CREATE USER [VIEJAS\bjaeger] FOR LOGIN [VIEJAS\bjaeger] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\bjaeger]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\bbilliet')
CREATE USER [VIEJAS\bbilliet] FOR LOGIN [VIEJAS\bbilliet] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\bbilliet]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\cnorton')
CREATE USER [VIEJAS\cnorton] FOR LOGIN [VIEJAS\cnorton] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\cnorton]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'EveriReadOnly')
CREATE USER [EveriReadOnly] FOR LOGIN [EveriReadOnly] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[EveriReadOnly]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\APemberton')
CREATE USER [VIEJAS\APemberton] FOR LOGIN [VIEJAS\APemberton] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\APemberton]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Slewis')
CREATE USER [VIEJAS\Slewis] FOR LOGIN [VIEJAS\Slewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Slewis]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DDobson')
CREATE USER [VIEJAS\DDobson] FOR LOGIN [VIEJAS\DDobson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DDobson]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TTabert')
CREATE USER [VIEJAS\TTabert] FOR LOGIN [VIEJAS\TTabert] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TTabert]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TVazquez')
CREATE USER [VIEJAS\TVazquez] FOR LOGIN [VIEJAS\TVazquez] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TVazquez]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\WRosa')
CREATE USER [VIEJAS\WRosa] FOR LOGIN [VIEJAS\WRosa] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\WRosa]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CAlvarado')
CREATE USER [VIEJAS\CAlvarado] FOR LOGIN [VIEJAS\CAlvarado] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CAlvarado]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ADauphinais')
CREATE USER [VIEJAS\ADauphinais] FOR LOGIN [VIEJAS\ADauphinais] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ADauphinais]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JCrow')
CREATE USER [VIEJAS\JCrow] FOR LOGIN [VIEJAS\JCrow] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JCrow]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\spaylor')
CREATE USER [VIEJAS\spaylor] FOR LOGIN [VIEJAS\spaylor] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\spaylor]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SNicoll')
CREATE USER [VIEJAS\SNicoll] FOR LOGIN [VIEJAS\SNicoll] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SNicoll]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JNakelsky')
CREATE USER [VIEJAS\JNakelsky] FOR LOGIN [VIEJAS\JNakelsky] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JNakelsky]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\LTorres')
CREATE USER [VIEJAS\LTorres] FOR LOGIN [VIEJAS\LTorres] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\LTorres]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\THewey')
CREATE USER [VIEJAS\THewey] FOR LOGIN [VIEJAS\THewey] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\THewey]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JDavis')
CREATE USER [VIEJAS\JDavis] FOR LOGIN [VIEJAS\JDavis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JDavis]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DRuderman')
CREATE USER [VIEJAS\DRuderman] FOR LOGIN [VIEJAS\DRuderman] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DRuderman]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CBeale')
CREATE USER [VIEJAS\CBeale] FOR LOGIN [VIEJAS\CBeale] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CBeale]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DMy')
CREATE USER [VIEJAS\DMy] FOR LOGIN [VIEJAS\DMy] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DMy]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VVasquez')
CREATE USER [VIEJAS\VVasquez] FOR LOGIN [VIEJAS\VVasquez] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\VVasquez]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NWillan')
CREATE USER [VIEJAS\NWillan] FOR LOGIN [VIEJAS\NWillan] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\NWillan]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SMarshall')
CREATE USER [VIEJAS\SMarshall] FOR LOGIN [VIEJAS\SMarshall] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SMarshall]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MPaine')
CREATE USER [VIEJAS\MPaine] FOR LOGIN [VIEJAS\MPaine] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MPaine]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\JBrown')
CREATE USER [VIEJAS\JBrown] FOR LOGIN [VIEJAS\JBrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\JBrown]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CMPINTF13APR$')
CREATE USER [VIEJAS\CMPINTF13APR$] FOR LOGIN [VIEJAS\CMPINTF13APR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CMPINTF13APR$]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\YAragon')
CREATE USER [VIEJAS\YAragon] FOR LOGIN [VIEJAS\YAragon] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\YAragon]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MSpellman')
CREATE USER [VIEJAS\MSpellman] FOR LOGIN [VIEJAS\MSpellman] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MSpellman]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AMayorga')
CREATE USER [VIEJAS\AMayorga] FOR LOGIN [VIEJAS\AMayorga] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AMayorga]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\gMSA018$')
CREATE USER [VIEJAS\gMSA018$] FOR LOGIN [VIEJAS\gMSA018$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\gMSA018$]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DGorton')
CREATE USER [VIEJAS\DGorton] FOR LOGIN [VIEJAS\DGorton] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DGorton]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ci360agent')
CREATE USER [ci360agent] FOR LOGIN [ci360agent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[ci360agent]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA1')
CREATE USER [VIEJAS\RWA1] FOR LOGIN [VIEJAS\RWA1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA1]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA1')
CREATE USER [VIEJAS\RWA1] FOR LOGIN [VIEJAS\RWA1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\RWA1]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA2')
CREATE USER [VIEJAS\RWA2] FOR LOGIN [VIEJAS\RWA2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA2]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA3')
CREATE USER [VIEJAS\RWA3] FOR LOGIN [VIEJAS\RWA3] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA3]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA4')
CREATE USER [VIEJAS\RWA4] FOR LOGIN [VIEJAS\RWA4] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA4]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'sasdbagent')
CREATE USER [sasdbagent] FOR LOGIN [sasdbagent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[sasdbagent]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA5')
CREATE USER [VIEJAS\RWA5] FOR LOGIN [VIEJAS\RWA5] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA5]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MThompson')
CREATE USER [VIEJAS\MThompson] FOR LOGIN [VIEJAS\MThompson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MThompson]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\gMSA022$')
CREATE USER [VIEJAS\gMSA022$] FOR LOGIN [VIEJAS\gMSA022$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\gMSA022$]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Marketing_DWH')
CREATE USER [VIEJAS\Marketing_DWH] FOR LOGIN [VIEJAS\Marketing_DWH] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Marketing_DWH]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ISandoval')
CREATE USER [VIEJAS\ISandoval] FOR LOGIN [VIEJAS\ISandoval] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ISandoval]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CASINOAPP01PR$')
CREATE USER [VIEJAS\CASINOAPP01PR$] FOR LOGIN [VIEJAS\CASINOAPP01PR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CASINOAPP01PR$]'; 
Go
Use CMP13_UAT;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CMKTAP08PR$')
CREATE USER [VIEJAS\CMKTAP08PR$] FOR LOGIN [VIEJAS\CMKTAP08PR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CMKTAP08PR$]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpapi')
CREATE USER [cmpapi] FOR LOGIN [cmpapi] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpapi]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpapi')
CREATE USER [cmpapi] FOR LOGIN [cmpapi] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[cmpapi]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ViejasTagPrizeUpload')
CREATE USER [ViejasTagPrizeUpload] FOR LOGIN [ViejasTagPrizeUpload] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[ViejasTagPrizeUpload]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ViejasTagPrizeUpload')
CREATE USER [ViejasTagPrizeUpload] FOR LOGIN [ViejasTagPrizeUpload] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[ViejasTagPrizeUpload]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CASI_Link')
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[CASI_Link]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CASI_Link')
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[CASI_Link]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CASI_Link')
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[CASI_Link]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CASINOAPP01PR$')
CREATE USER [VIEJAS\CASINOAPP01PR$] FOR LOGIN [VIEJAS\CASINOAPP01PR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\CASINOAPP01PR$]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CASINOAPP01PR$')
CREATE USER [VIEJAS\CASINOAPP01PR$] FOR LOGIN [VIEJAS\CASINOAPP01PR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\CASINOAPP01PR$]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CMKTAP08PR$')
CREATE USER [VIEJAS\CMKTAP08PR$] FOR LOGIN [VIEJAS\CMKTAP08PR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\CMKTAP08PR$]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CMKTAP08PR$')
CREATE USER [VIEJAS\CMKTAP08PR$] FOR LOGIN [VIEJAS\CMKTAP08PR$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\CMKTAP08PR$]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'linkedserver')
CREATE USER [linkedserver] FOR LOGIN [linkedserver] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[linkedserver]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'linkedserver')
CREATE USER [linkedserver] FOR LOGIN [linkedserver] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[linkedserver]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'linkedserver')
CREATE USER [linkedserver] FOR LOGIN [linkedserver] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[linkedserver]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpReports')
CREATE USER [cmpReports] FOR LOGIN [cmpReports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[cmpReports]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpReports')
CREATE USER [cmpReports] FOR LOGIN [cmpReports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpReports]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpReports')
CREATE USER [cmpReports] FOR LOGIN [cmpReports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[cmpReports]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ITD065TW$')
CREATE USER [VIEJAS\ITD065TW$] FOR LOGIN [VIEJAS\ITD065TW$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[VIEJAS\ITD065TW$]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ITD065TW$')
CREATE USER [VIEJAS\ITD065TW$] FOR LOGIN [VIEJAS\ITD065TW$] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ITD065TW$]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpDW')
CREATE USER [cmpDW] FOR LOGIN [cmpDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[cmpDW]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpDW')
CREATE USER [cmpDW] FOR LOGIN [cmpDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpDW]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Outsource_Developers')
CREATE USER [VIEJAS\Outsource_Developers] FOR LOGIN [VIEJAS\Outsource_Developers] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Outsource_Developers]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'PowerKiosk')
CREATE USER [PowerKiosk] FOR LOGIN [PowerKiosk] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[PowerKiosk]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NVanDyk')
CREATE USER [VIEJAS\NVanDyk] FOR LOGIN [VIEJAS\NVanDyk] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\NVanDyk]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CMPTagPrizeUpload')
CREATE USER [CMPTagPrizeUpload] FOR LOGIN [CMPTagPrizeUpload] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'ss_application', N'[CMPTagPrizeUpload]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CMPTagPrizeUpload')
CREATE USER [CMPTagPrizeUpload] FOR LOGIN [CMPTagPrizeUpload] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[CMPTagPrizeUpload]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\hsimpson')
CREATE USER [VIEJAS\hsimpson] FOR LOGIN [VIEJAS\hsimpson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\hsimpson]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Marketing')
CREATE USER [VIEJAS\Marketing] FOR LOGIN [VIEJAS\Marketing] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\Marketing]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Marketing')
CREATE USER [VIEJAS\Marketing] FOR LOGIN [VIEJAS\Marketing] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Marketing]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VVasquez')
CREATE USER [VIEJAS\VVasquez] FOR LOGIN [VIEJAS\VVasquez] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\VVasquez]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VVasquez')
CREATE USER [VIEJAS\VVasquez] FOR LOGIN [VIEJAS\VVasquez] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\VVasquez]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MPaine')
CREATE USER [VIEJAS\MPaine] FOR LOGIN [VIEJAS\MPaine] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MPaine]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\CBeale')
CREATE USER [VIEJAS\CBeale] FOR LOGIN [VIEJAS\CBeale] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\CBeale]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DGorton')
CREATE USER [VIEJAS\DGorton] FOR LOGIN [VIEJAS\DGorton] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DGorton]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AMayorga')
CREATE USER [VIEJAS\AMayorga] FOR LOGIN [VIEJAS\AMayorga] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AMayorga]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\YAragon')
CREATE USER [VIEJAS\YAragon] FOR LOGIN [VIEJAS\YAragon] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\YAragon]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA1')
CREATE USER [VIEJAS\RWA1] FOR LOGIN [VIEJAS\RWA1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA1]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA2')
CREATE USER [VIEJAS\RWA2] FOR LOGIN [VIEJAS\RWA2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA2]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA3')
CREATE USER [VIEJAS\RWA3] FOR LOGIN [VIEJAS\RWA3] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA3]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA4')
CREATE USER [VIEJAS\RWA4] FOR LOGIN [VIEJAS\RWA4] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA4]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\RWA5')
CREATE USER [VIEJAS\RWA5] FOR LOGIN [VIEJAS\RWA5] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\RWA5]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Marketing_DWH')
CREATE USER [VIEJAS\Marketing_DWH] FOR LOGIN [VIEJAS\Marketing_DWH] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Marketing_DWH]'; 
Go
Use CMPAPI;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ISandoval')
CREATE USER [VIEJAS\ISandoval] FOR LOGIN [VIEJAS\ISandoval] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ISandoval]'; 
Go
Use DBA;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use DBA_mounted_0901;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_accessadmin', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_securityadmin', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_ddladmin', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_backupoperator', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_denydatareader', N'[bicmuser]'; 
Go
Use dbBICM;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bicmuser')
CREATE USER [bicmuser] FOR LOGIN [bicmuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_denydatawriter', N'[bicmuser]'; 
Go
Use dbInfogenesis;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use dbInfogenesis;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'MUUser')
CREATE USER [MUUser] FOR LOGIN [MUUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[MUUser]'; 
Go
Use HALo_Onboard;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Kiosk18;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'kskuser')
CREATE USER [kskuser] FOR LOGIN [kskuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[kskuser]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'kskusr')
CREATE USER [kskusr] FOR LOGIN [kskusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[kskusr]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'kskrpt')
CREATE USER [kskrpt] FOR LOGIN [kskrpt] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[kskrpt]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'kskrpt')
CREATE USER [kskrpt] FOR LOGIN [kskrpt] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[kskrpt]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpDW')
CREATE USER [cmpDW] FOR LOGIN [cmpDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpDW]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DWH_User')
CREATE USER [DWH_User] FOR LOGIN [DWH_User] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DWH_User]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MThompson')
CREATE USER [VIEJAS\MThompson] FOR LOGIN [VIEJAS\MThompson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\MThompson]'; 
Go
Use Kiosk18_2Upgraded;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\MThompson')
CREATE USER [VIEJAS\MThompson] FOR LOGIN [VIEJAS\MThompson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\MThompson]'; 
Go
Use master_mount_0831;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use master_mount_0831;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SQLService1')
CREATE USER [VIEJAS\SQLService1] FOR LOGIN [VIEJAS\SQLService1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'RSExecRole', N'[VIEJAS\SQLService1]'; 
Go
Use master_mount_0831;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpuser')
CREATE USER [cmpuser] FOR LOGIN [cmpuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[cmpuser]'; 
Go
Use master_mount_0831;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmktuser')
CREATE USER [cmktuser] FOR LOGIN [cmktuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[cmktuser]'; 
Go
Use master_mount_0831;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bossuser')
CREATE USER [bossuser] FOR LOGIN [bossuser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[bossuser]'; 
Go
Use PM16;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use PrintManager;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use PrintManager;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpDW')
CREATE USER [cmpDW] FOR LOGIN [cmpDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpDW]'; 
Go
Use PrintManager;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmktuser2')
CREATE USER [cmktuser2] FOR LOGIN [cmktuser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[cmktuser2]'; 
Go