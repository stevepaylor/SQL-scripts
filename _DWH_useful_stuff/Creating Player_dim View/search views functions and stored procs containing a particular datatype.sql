USE [iQ-Gaming] ;
GO

SELECT OBJECT_NAME(object_id), definition
FROM sys.sql_modules
WHERE definition LIKE '%basepoints%'

