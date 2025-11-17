USE [master]
GO

/****** Object:  LinkedServer [CASI24LS01QA]    Script Date: 5/16/2024 3:54:03 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'CASI24LS01QA', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'CASI24LS01QA',@useself=N'False',@locallogin=NULL,@rmtuser=N'DPA',@rmtpassword='$QLisg00d4U'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CASI24LS01QA', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

