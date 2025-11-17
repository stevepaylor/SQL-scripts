USE [master]
GO

/****** Object:  LinkedServer [Bingo]    Script Date: 8/5/2025 9:13:55 AM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'Bingo', @srvproduct=N'SQL', @provider=N'SQLNCLI', @datasrc=N'10.44.180.5'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'Bingo',@useself=N'False',@locallogin=NULL,@rmtuser=N'ViejasInHouseReports',@rmtpassword='RPx34Y90ZZnw'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'Bingo', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


