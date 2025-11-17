SELECT
  REPLACE(REPLACE([Table] , '[' , '') , ']', '') AS [Table]
, REPLACE(REPLACE([Schema] , '[' , '') , ']', '') AS [Schema]
, REPLACE(REPLACE([Database] , '[' , '') , ']', '') AS [Database]
, REPLACE(REPLACE([Server] , '[' , '') , ']', '') AS [Server]

--, [QueryGroup]
--, [ActiveFlag]
--, [WhereClause]
--, [Comments ]
--, [ModifiedDTTM]
--, [ModifiedBy]
--, [ValidationField1]
--, [ValidationField2]

FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]


UPDATE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
SET [Table] =  REPLACE(REPLACE([Table] , '[' , '') , ']', '')
,   [Schema] = REPLACE(REPLACE([Schema] , '[' , '') , ']', '')
,   [Database] = REPLACE(REPLACE([Database] , '[' , '') , ']', '')
,   [Server] = REPLACE(REPLACE([Server] , '[' , '') , ']', '')


SELECT * 
FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]