SELECT count(*)
      ,[AsOfDTTM]

  FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]

  group by [AsOfDTTM]

  ORDER BY [AsOfDTTM] DESC


  DELETE FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]
  WHERE [AsOfDTTM] = '2023-07-21 06:02:42.000'
