EXEC master.dbo.sp_addlinkedserver @server = N'AGINDB01pr', @srvproduct=N'SQL Server'
GO

EXEC sp_setnetname 'AGINDB01pr', 'CASI24LS02pr';
GO