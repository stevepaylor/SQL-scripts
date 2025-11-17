USE [iQ-Gaming]
GO

select 
  s.name as [Schema]
, o.[name] as Object_Name
, o.type_desc as Object_Type

from sys.all_objects o

join sys.schemas s
on o.schema_id = s.schema_id

where o.object_id IN (SELECT object_id FROM sys.sql_modules WHERE definition LIKE '%player_daily_fact%')

order by o.type_desc DESC
go

--SELECT TABLE_NAME, COLUMN_NAME
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE COLUMN_NAME LIKE '%AllowedPurgeDt%'
--ORDER BY TABLE_NAME;

--SELECT *
--FROM sys.objects
--WHERE object_id = 1051150790