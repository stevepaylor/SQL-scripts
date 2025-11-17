USE [master]
GO
SELECT   [name]
 ,[is_broker_enabled] 
 ,[service_broker_guid]
FROM [sys].[databases] 
GO

USE [master]
GO
ALTER DATABASE [vTOURNAMENT] SET NEW_BROKER
GO