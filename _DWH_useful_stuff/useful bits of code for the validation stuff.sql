--INSERT INTO [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
SELECT --TOP 1 
		[Table]
      ,[Schema]

      --,'app' AS [Database]
	  ,[Database]

      --,'PLAYERPORTALRDS' AS [Server]
	  --,'DWHDB01PR' AS [Server]
      , [Server]

      ,[QueryGroup]

	  --,'N' AS [InactiveFlag]
      ,[InactiveFlag]

      ,[WhereClause]
      ,[Comments]

      --,GETDATE() AS [ModifiedDTTM]
      ,[ModifiedDTTM]

      ,[ModifiedBy]
      ,[MinMaxField1]
      ,[MinMaxField2]
      ,[CountDistinctField1]
      ,[CountDistinctField2]

  FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

  WHERE [Table] = 'iQC_tPlayer_ClubState_Repl'

  --WHERE QueryGroup = 3


  -------------------------------------------------------------------------------------------------------------------------------------------

  --SELECT TOP (1000) [Table]
  --    ,[Schema]
  --    ,[Database]
  --    ,[Server]
  --    ,[AsOfDTTM]
  --    ,[RowCount]
  --    ,[Comments]
  --    ,[WhereClause]
  --    ,[RunTimeSeconds]
  --    ,[QueryGroup]
  --    ,[InactiveFlag]
  --    ,[MinMaxField1]
  --    ,[MinField1_Result]
  --    ,[MaxField1_Result]
  --    ,[MinMaxField2]
  --    ,[MinField2_Result]
  --    ,[MaxField2_Result]
  --    ,[CountDistinctField1]
  --    ,[CountDistinctField1_Result]
  --    ,[CountDistinctField2]
  --    ,[CountDistinctField2_Result]
  --FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]

  --SELECT COUNT(*)
  -- , max([AsOfDTTM])
  -- FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]

  -- GROUP BY  [AsOfDTTM]


  -- DELETE FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]
  -- WHERE [AsOfDTTM] < '2023-07-16 14:39:43.000'

  -- UPDATE [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
  -- SET [Schema] = 'CMP_13-1'
  -- WHERE [Table] = 'tPlayerPhone' 
  --   AND [Server] LIKE 'PLAY%'

--UPDATE [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
--SET [InactiveFlag] = 'Y'
--where [Table] = 'iQC_tPlayer_ClubState_Repl'


--SELECT 
--  COUNT(*)
--, [AsOfDTTM]
--FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]
--GROUP BY
--[AsOfDTTM]
--ORDER BY
--[AsOfDTTM]  


--DELETE FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]
--WHERE [AsOfDTTM] = '2023-07-17 16:35:06.000'