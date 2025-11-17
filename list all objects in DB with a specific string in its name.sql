USE [iQ-Gaming] ;
GO

select 
  s.name as [Schema]
, o.[name] as Object_Name
, o.type_desc as Type

from sys.all_objects o

join sys.schemas s
on o.schema_id = s.schema_id

where o.object_id IN (SELECT object_id FROM sys.sql_modules WHERE o.[name] LIKE '%_NEW')
  and s.name <> 'deprecated'

UNION ALL

select 
  s.name as [Schema]
, t.[name] as Object_Name
, t.type_desc as Type

from sys.tables t

join sys.schemas s
on t.schema_id = s.schema_id

where t.object_id IN (SELECT object_id FROM sys.tables WHERE t.[name] LIKE '%_NEW')
  and s.name <> 'deprecated'

ORDER BY
  type desc
, [Schema] 
, Object_Name