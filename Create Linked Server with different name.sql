USE [master]
GO

/****** Object:  LinkedServer [172.16.0.10, 1433]    Script Date: 1/17/2023 10:57:43 AM ******/
--EXEC master.dbo.sp_addlinkedserver @server = N'Bingo', @srvproduct=N'SQL Server'
EXEC sp_addlinkedserver @server= 'Bingo' ,@provider='SQLNCLI' ,@datasrc='172.16.0.10' ,@srvproduct = 'SQL'
GO

--EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'172.16.0.10, 1433',@useself=N'False',@locallogin=NULL,@rmtuser=N'ViejasInHouseReports',@rmtpassword='RPx34Y90ZZnw'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'Bingo',@useself=N'False',@locallogin=NULL,@rmtuser=N'ViejasInHouseReports',@rmtpassword='RPx34Y90ZZnw'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server= 'Bingo', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


