USE [master]
GO

CREATE LOGIN [datareader] WITH PASSWORD=N'R3@dsomeD@TA!', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

USE [CMP13]
GO
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'datareader'
--CREATE ROLE db_executor
--GRANT EXECUTE TO db_executor
--EXEC sp_addrolemember N'db_executor', N'datareader'
GO

USE [CMP13_temp]
GO
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'datareader'
--CREATE ROLE [db_executor]
--GRANT EXECUTE TO [db_executor]
--EXEC sp_addrolemember N'db_executor', N'datareader'
GO

USE [CMPAPI]
GO
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'datareader'
--CREATE ROLE [db_executor]
--GRANT EXECUTE TO [db_executor]
--EXEC sp_addrolemember N'db_executor', N'datareader'
GO

USE [CMPSDS]
GO
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'datareader'
--CREATE ROLE [db_executor]
--GRANT EXECUTE TO [db_executor]
--EXEC sp_addrolemember N'db_executor', N'datareader'
GO

USE [dbInfogenesis]
GO
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'datareader'
--CREATE ROLE [db_executor]
--GRANT EXECUTE TO [db_executor]
--EXEC sp_addrolemember N'db_executor', N'datareader'
GO

USE [TV13]
GO
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'datareader'
--CREATE ROLE [db_executor]
--GRANT EXECUTE TO [db_executor]
--EXEC sp_addrolemember N'db_executor', N'datareader'
GO

USE [TVAlert13]
GO
CREATE USER [datareader] FOR LOGIN [datareader] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'datareader'
--CREATE ROLE [db_executor]
--GRANT EXECUTE TO [db_executor]
--EXEC sp_addrolemember N'db_executor', N'datareader'
GO


