--USE CMP13 ;
--GO

select 
  s.name as [Schema]
, o.[name] as Object_Name
, o.type_desc as Object_Type

from sys.all_objects o

join sys.schemas s
on o.schema_id = s.schema_id

where o.object_id IN (SELECT object_id FROM sys.sql_modules WHERE definition LIKE '%ADP_3MonthLGD%')