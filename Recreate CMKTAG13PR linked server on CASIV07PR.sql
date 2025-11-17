USE [master]
GO

/****** Object:  LinkedServer [CMKTAG13PR]    Script Date: 3/14/2017 3:34:47 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'CMKTAG13PR', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'CMKTAG13PR',@useself=N'False',@locallogin=NULL,@rmtuser=N'DBAdmin',@rmtpassword='$QLisg00d4U'

GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTAG13PR', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


