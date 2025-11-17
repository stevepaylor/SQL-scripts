--SELECT [name] AS TableName
--FROM sys.tables
--ORDER BY [name];

SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length AS MaxLength,
    c.is_nullable AS IsNullable
FROM 
    sys.tables AS t
INNER JOIN 
    sys.columns AS c ON t.object_id = c.object_id
LEFT JOIN 
    sys.types AS ty ON c.user_type_id = ty.user_type_id

WHERE t.name not like '%_Snapshot' 
  AND t.name not like '%_ADD_to_PROD_from_QA%'
  AND t.name not like '%_COMBINED_QA_PR%'
  AND t.name not like '%_FIX%'
  AND t.name not like 'flash_aggregate_load_tracking'
  AND t.name not like '%_OLD%'
  AND t.name not like 'flash_aggregate_raw'
  AND t.name not like '%_SAVE%'
  AND t.name not like '%_Delta'
  AND t.name not like 'STAY_ETL_Validation_Total_Counts'

ORDER BY 
    t.name, c.column_id;
