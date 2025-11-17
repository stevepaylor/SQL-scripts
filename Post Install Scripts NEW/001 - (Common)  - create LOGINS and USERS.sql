USE [master]
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login [VIEJAS\SQLService1] 
------------------------------------------------------------------------------------------------------------------------------------------------
USE [master]
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\SQLService1')
CREATE LOGIN [VIEJAS\SQLService1] FROM WINDOWS WITH DEFAULT_DATABASE=master, DEFAULT_LANGUAGE=us_english
GO
EXEC sys.sp_addsrvrolemember @loginame = N'VIEJAS\SQLService1', @rolename = N'sysadmin'
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login [VIEJAS\ITappsSQLadmin] - Needed for login with our regular accounts.
------------------------------------------------------------------------------------------------------------------------------------------------
USE [master]
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\ITappsSQLadmin')
CREATE LOGIN [VIEJAS\ITappsSQLadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
EXEC sys.sp_addsrvrolemember @loginame = N'VIEJAS\ITappsSQLadmin', @rolename = N'sysadmin'
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login DPA and give it SA role - this is the admin login for Solarwinds DPA
------------------------------------------------------------------------------------------------------------------------------------------------

CREATE LOGIN [DPA] WITH PASSWORD = 0x020028603AA37A8E30E8045372B2124051447D9DADFAA02A2E00872DE8B5A9183DD0A1639BA9E27CFEBF637A636BE5B663C9FCDBDC7C217E7B42563CBBF25B8639423B1C0AE2 HASHED, SID = 0xA3EE3B96C9CDE34888AED9DB4063F11A, DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [DPA]
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login [ITappsDBA] - Needed for login when SA account does not have our standard PW.
-- Commented section out as it is replaced with the one directly below it.
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
-- 2014 +
------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ITappsDBA')
CREATE LOGIN [ITappsDBA] WITH PASSWORD=N'$QLisg00d4U!!!!', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ITappsDBA]
GO

USE [master]
GO
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = N'DBAdmin' and sid != 0x01)
DROP LOGIN [DBAdmin] 
GO
ALTER LOGIN SA WITH NAME=[DBAdmin]
GO

ALTER LOGIN [DBAdmin] WITH CHECK_POLICY=OFF, CHECK_EXPIRATION=OFF
ALTER LOGIN [DBAdmin] WITH PASSWORD = N'$QLisg00d4U!!!'
ALTER LOGIN [DBAdmin] WITH CHECK_POLICY=ON, CHECK_EXPIRATION=OFF
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Account to be added to all SQL Server to use for R/O access from SSRS packages - Database role db_reader must manually be added for all database needing the access
------------------------------------------------------------------------------------------------------------------------------------------------
--CREATE LOGIN [SSRS_User] 
--WITH 
--  PASSWORD = 0x0200ABD61FEE608B19487A78ACB6D716F02DCE3786246301614EF47CAACF74B865C424740A6013ECEA45F4950D5614B6815C3D005E269B1A1302F4283F8827E1903FB7C98077 HASHED
--, SID = 0x0FA51DBE27BF5842B5B743C0CAA202AE
--, DEFAULT_DATABASE = [master]
--, CHECK_POLICY = OFF
--, CHECK_EXPIRATION = OFF

-- password !SSRSreader99

------------------------------------------------------------------------------------------------------------------------------------------------
-- give NT AUTHORITY\SYSTEM SA rights
------------------------------------------------------------------------------------------------------------------------------------------------

ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login [VIEJAS\IT_Apps] 
------------------------------------------------------------------------------------------------------------------------------------------------
USE [master]
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\IT_Apps')
CREATE LOGIN [VIEJAS\IT_Apps] FROM WINDOWS WITH DEFAULT_DATABASE=master, DEFAULT_LANGUAGE=us_english
GO
EXEC sys.sp_addsrvrolemember @loginame = N'VIEJAS\IT_Apps', @rolename = N'sysadmin'
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login [VIEJAS\ele_spaylor] 
------------------------------------------------------------------------------------------------------------------------------------------------
USE [master]
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\ele_spaylor')
CREATE LOGIN [VIEJAS\ele_spaylor] FROM WINDOWS WITH DEFAULT_DATABASE=master, DEFAULT_LANGUAGE=us_english
GO
EXEC sys.sp_addsrvrolemember @loginame = N'VIEJAS\ele_spaylor', @rolename = N'sysadmin'
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login [VIEJAS\IT_Apps] 
------------------------------------------------------------------------------------------------------------------------------------------------
USE [master]
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\IT_APPS_Elevated')
CREATE LOGIN [VIEJAS\IT_APPS_Elevated] FROM WINDOWS WITH DEFAULT_DATABASE=master, DEFAULT_LANGUAGE=us_english
GO
EXEC sys.sp_addsrvrolemember @loginame = N'VIEJAS\IT_APPS_Elevated', @rolename = N'sysadmin'
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Login [LNW_SA] 
------------------------------------------------------------------------------------------------------------------------------------------------
--USE [master]
--GO

--CREATE LOGIN [LNW_SA] WITH PASSWORD=N'LNWadmin123456!', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
--GO

--ALTER SERVER ROLE [sysadmin] ADD MEMBER [LNW_SA]
--GO

