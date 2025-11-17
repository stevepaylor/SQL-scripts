USE [STAYDWH_TEMP]
GO

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

WHERE t.name like 'additional_guests' 


ORDER BY 
    t.name, c.column_id;