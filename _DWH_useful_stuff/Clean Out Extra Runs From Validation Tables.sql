--SELECT *
--FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]

SELECT 
  COUNT(*)
, [AsOfDTTM]
FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]
GROUP BY [AsOfDTTM]
ORDER BY [AsOfDTTM] DESC

DELETE FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]
WHERE [AsOfDTTM] < '2023-08-01 12:41:05.000'