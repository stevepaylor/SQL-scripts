USE [master]
GO

/****** Object:  LinkedServer [10.44.180.5, 1433]    Script Date: 8/5/2025 9:20:15 AM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.44.180.5, 1433', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.44.180.5, 1433',@useself=N'False',@locallogin=NULL,@rmtuser=N'ViejasInHouseReports',@rmtpassword='RPx34Y90ZZnw'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.180.5, 1433', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


