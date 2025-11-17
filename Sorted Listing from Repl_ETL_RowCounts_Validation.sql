SELECT [Table]
      ,[Schema]
      ,[Database]
      ,[Server]
      ,[AsOfDTTM]
      ,[RowCount]
      ,[Comments]
      ,[WhereClause]
      ,[RunTimeSeconds]
      ,[QueryGroup]
      ,[InactiveFlag]
      ,[ValidationField1]
      ,[ValidationField1_Result]
      ,[ValidationField2]
      ,[ValidationField2_Result]
  FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation]

ORDER BY
  [AsOfDTTM] DESC
, [Table]
, [Schema]

