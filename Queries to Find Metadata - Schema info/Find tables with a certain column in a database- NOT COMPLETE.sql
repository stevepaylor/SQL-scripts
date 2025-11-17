--sp_MSforeachdb 'SELECT "?" AS DB, * FROM [?].sys.tables WHERE name like ''%additional%data%'''

sp_MSforeachdb 
'SELECT "?" AS DB, t.name AS table_name,
SCHEMA_NAME(schema_id) AS schema_name,
c.name AS column_name
FROM [?].sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE ''%additional_tender_data%''
ORDER BY schema_name, table_name;'



--SELECT v.name AS view_name,
--SCHEMA_NAME(schema_id) AS schema_name,
--c.name AS column_name
--FROM sys.views AS v
--INNER JOIN sys.columns c ON v.OBJECT_ID = c.OBJECT_ID
--WHERE c.name LIKE '%additional_tender_data%'
--ORDER BY schema_name, view_name;