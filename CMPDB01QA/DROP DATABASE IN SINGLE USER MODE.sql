USE master;
GO

ALTER DATABASE [AAGTEST]
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'AAGTEST'
GO
USE [master]
GO
/****** Object:  Database [AAGTEST]    Script Date: 7/31/2024 10:43:01 AM ******/
DROP DATABASE [AAGTEST]
GO
