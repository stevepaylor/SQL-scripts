DECLARE @SQL NVARCHAR(MAX);
 
SET @SQL = STUFF((
 
            SELECT '
 
UNION 
 
SELECT ' + quotename(NAME, '''') + ' as Db_Name, Name collate SQL_Latin1_General_CP1_CI_AS as Table_Name
 
FROM ' + quotename(NAME) + '.sys.tables WHERE NAME LIKE ''%'' + @TableName + ''%'''
 
            FROM sys.databases
 
            ORDER BY  NAME
 
            FOR XML PATH('')
 
                ,type
 
            ).value('.', 'nvarchar(max)'), 1, 8, '')
 
 
 
PRINT @SQL;
 
 
 
--EXECUTE sp_executeSQL @SQL
 
--    ,N'@TableName varchar(30)'
 
--    ,@TableName = '%additional%data%'