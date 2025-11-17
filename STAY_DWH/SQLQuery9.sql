USE [master]
GO

/****** Object:  LinkedServer [POSTGRESQL]    Script Date: 3/15/2024 4:35:16 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'POSTGRESQL', @srvproduct=N'ODBC Driver for PostgreSQL', @provider=N'MSDASQL', @datasrc=N'PostgreSQL'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'POSTGRESQL',@useself=N'False',@locallogin=NULL,@rmtuser=N'viejas_paylors@stay-reporting-prod',@rmtpassword='6N7f6$d5JYsX!TJx'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'POSTGRESQL', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


