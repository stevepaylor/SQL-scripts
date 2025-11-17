USE [master]
GO

CREATE LOGIN [CASI_Link] WITH PASSWORD=N'C@$1_L!nk', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

USE [CMP13]
GO
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CASI_Link'
CREATE ROLE db_executor
GRANT EXECUTE TO db_executor
EXEC sp_addrolemember N'db_executor', N'CASI_Link'
GO

USE [CMP13_temp]
GO
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CASI_Link'
CREATE ROLE [db_executor]
GRANT EXECUTE TO [db_executor]
EXEC sp_addrolemember N'db_executor', N'CASI_Link'
GO

USE [CMPAPI]
GO
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CASI_Link'
CREATE ROLE [db_executor]
GRANT EXECUTE TO [db_executor]
EXEC sp_addrolemember N'db_executor', N'CASI_Link'
GO

USE [CMPSDS]
GO
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CASI_Link'
CREATE ROLE [db_executor]
GRANT EXECUTE TO [db_executor]
EXEC sp_addrolemember N'db_executor', N'CASI_Link'
GO

USE [dbInfogenesis]
GO
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CASI_Link'
CREATE ROLE [db_executor]
GRANT EXECUTE TO [db_executor]
EXEC sp_addrolemember N'db_executor', N'CASI_Link'
GO

USE [TV13]
GO
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CASI_Link'
CREATE ROLE [db_executor]
GRANT EXECUTE TO [db_executor]
EXEC sp_addrolemember N'db_executor', N'CASI_Link'
GO

USE [TVAlert13]
GO
CREATE USER [CASI_Link] FOR LOGIN [CASI_Link] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CASI_Link'
CREATE ROLE [db_executor]
GRANT EXECUTE TO [db_executor]
EXEC sp_addrolemember N'db_executor', N'CASI_Link'
GO


