USE [master]
GO

/****** Object:  LinkedServer [CASIVC07PR]    Script Date: 4/6/2016 2:29:23 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'CASIVC07PR', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'CASIVC07PR',@useself=N'False',@locallogin=NULL,@rmtuser=N'CMP13_reader',@rmtpassword='R3@ds0medata'

GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASIVC07PR', @optname=N'use remote collation', @optvalue=N'true'
GO

