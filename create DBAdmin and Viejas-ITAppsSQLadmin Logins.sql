-- 2005 +
USE [master]
GO

CREATE LOGIN [DBAdmin] WITH PASSWORD=N'H/hhGUcq6S0rA0hwEnRI8z+w3mhLCs3sAbqOlvelvYE=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [DBAdmin]
GO

CREATE LOGIN [VIEJAS\ITAppsSQLadmin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [VIEJAS\ITAppsSQLadmin]
GO



-- 2000

USE [master]
GO
EXEC sp_addlogin 'DBAdmin', '$QLisg00d4U', 'master'
GO
EXEC master.dbo.sp_addsrvrolemember @loginame = N'DBAdmin', @rolename = N'sysadmin'
GO

EXEC sp_grantlogin 'VIEJAS\ITAppsSQLadmin'
GO
EXEC master.dbo.sp_addsrvrolemember @loginame = N'VIEJAS\ITAppsSQLadmin', @rolename = N'sysadmin'
GO