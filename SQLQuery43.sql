USE [master]
GO

--IF @@VERSION NOT LIKE '%9.0%' PRINT @@VERSION;

BEGIN
	SELECT [name] FROM sys.databases WHERE name = N'DBA'
END
--ELSE
--BEGIN
--	SELECT 'NOT 2005'
--END

--SELECT db_name(database_id) as DatabaseName,name,type_desc,physical_name FROM sys.master_files