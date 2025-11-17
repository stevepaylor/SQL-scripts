USE [iQ-Gaming]
GO

--SELECT * FROM sys.schemas
SELECT
s.[name] AS Schema_Name,
t.NAME AS Table_Name,
MAX(p.rows) AS RowCounts,
(SUM(a.total_pages) * 8) / 1024.0 as TotalSpaceMB,
(SUM(a.used_pages) * 8) / 1024.0 as UsedSpaceMB,
(SUM(a.data_pages) * 8) /1024.0 as DataSpaceMB
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE i.OBJECT_ID > 255
  AND s.[name] IN ('CMP_13-1','CMPAP1')
  AND t.[name] NOT LIKE '%staging%'
  --AND P.rows >= 100000
  AND i.index_id IN (0,1)

GROUP BY s.[name], t.NAME

ORDER BY --RowCounts DESC, 
s.[name], t.NAME