USE [master]
GO

/****** Object:  LinkedServer [CASIDB24BQA]    Script Date: 5/16/2024 3:54:48 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'CASIDB24BQA', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'CASIDB24BQA',@useself=N'False',@locallogin=NULL,@rmtuser=N'DPA',@rmtpassword='$QLisg00d4U'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIDB24BQA', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

