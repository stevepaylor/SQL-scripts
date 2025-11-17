USE [master]
GO

/****** Object:  LinkedServer [CASINODBLIS01PR]    Script Date: 11/26/2024 4:27:10 PM ******/
EXEC master.dbo.sp_dropserver @server=N'CASINODBLIS01PR', @droplogins='droplogins'
GO

/****** Object:  LinkedServer [CASINODBLIS01PR]    Script Date: 11/26/2024 3:50:51 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'CASINODBLIS01PR', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'CASINODBLIS01PR',@useself=N'False',@locallogin=NULL,@rmtuser=N'DBAdmin',@rmtpassword='$QLisg00d4U!!!'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CASINODBLIS01PR', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


