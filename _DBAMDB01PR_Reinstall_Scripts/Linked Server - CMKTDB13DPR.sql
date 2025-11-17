USE [master]
GO

/****** Object:  LinkedServer [CMKTDB13DPR]    Script Date: 5/16/2024 3:55:19 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'CMKTDB13DPR', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'CMKTDB13DPR',@useself=N'False',@locallogin=NULL,@rmtuser=N'cmpDW',@rmtpassword='Frejuy@2'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CMKTDB13DPR', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

