USE SystemMaintDB
GO

INSERT INTO [dbo].[Repl_ETL_RowCounts_Validation_Driver]
SELECT
  t.NAME AS [Table]
, s.[name] AS [Schema]
, 'iQ-Gaming' AS [Database]
, @@SERVERNAME AS [Server]
, 1 AS [QueryGroup]
, 'Y' AS [ActiveFlag]
, NULL AS [WhereClause]
, NULL AS [Comments]
, GETDATE() AS ModifiedDTTM
, ORIGINAL_LOGIN()  AS ModifiedBy
, 'ModifiedDtm' AS ValidationField1
, 'PlayerId' AS ValidationField2

FROM DWHDB01QA.[iQ-Gaming].sys.tables t

INNER JOIN DWHDB01QA.[iQ-Gaming].sys.schemas s 
ON t.schema_id = s.schema_id

INNER JOIN DWHDB01QA.[iQ-Gaming].sys.indexes i 
ON t.OBJECT_ID = i.object_id

INNER JOIN DWHDB01QA.[iQ-Gaming].sys.partitions p 
ON i.object_id = p.OBJECT_ID 
AND i.index_id = p.index_id

INNER JOIN DWHDB01QA.[iQ-Gaming].sys.allocation_units a 
ON p.partition_id = a.container_id

WHERE i.OBJECT_ID > 255
  --AND s.[name] NOT IN ('CMP_13-1','CMPAPI','dbo','deprecated','Marketing','REPL','test','VCR','VCUST','ViejasApp')
  AND s.[name] IN ('CMP_13-1','config','DBM','Opera_5_0', 'player','slot','stage','table_games','vDW2')
  AND t.[name] NOT LIKE '%staging%'
  AND i.index_id IN (0,1)

GROUP BY 
  s.[name]
, t.[name]

ORDER BY 
  s.[name]
, t.[name]