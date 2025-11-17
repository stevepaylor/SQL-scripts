SELECT [Table]
      ,[Schema]
      ,[Database]
      ,[Server]
      ,[AsOfDTTM]
      ,[Metric]
      ,[SourceServer]
      ,[QueryGroup]
      ,[SortKey]
      ,[Metric_Value]
  FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Metrics_V2]

  SELECT 
  COUNT(*)
, [AsOfDTTM]
--FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1]
--FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Metrics_V2]
FROM [SystemMaintDB].[dbo].Repl_ETL_Table_RowCount_Keys_Validation_V2
GROUP BY [AsOfDTTM]
ORDER BY [AsOfDTTM] DESC
