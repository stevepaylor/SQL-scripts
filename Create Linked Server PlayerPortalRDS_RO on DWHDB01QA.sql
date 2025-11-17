USE [master]
GO

/****** Object:  LinkedServer [172.16.0.10, 1433]    Script Date: 1/17/2023 10:57:43 AM ******/
--EXEC master.dbo.sp_addlinkedserver @server = N'PlayerPortalRDS_RO', @srvproduct=N'SQL Server'
EXEC sp_addlinkedserver @server= 'PlayerPortalRDS_RO' ,@provider='SQLNCLI' ,@datasrc='10.16.0.126' ,@srvproduct = 'SQL'
GO

--EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'172.16.0.10, 1433',@useself=N'False',@locallogin=NULL,@rmtuser=N'ViejasInHouseReports',@rmtpassword='RPx34Y90ZZnw'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'PlayerPortalRDS_RO',@useself=N'False',@locallogin=NULL,@rmtuser=N'QA_Reader',@rmtpassword='ReadMeSomeData99!'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server= 'PlayerPortalRDS_RO', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


