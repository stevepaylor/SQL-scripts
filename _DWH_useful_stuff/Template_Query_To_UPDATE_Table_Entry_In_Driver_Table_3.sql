--INSERT INTO [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2] 
SELECT [Table]
      ,[Schema]
      ,[Database]
      ,'DWHDB01PR' AS [Server]
      ,[QueryGroup]
      ,[InactiveFlag]
      ,[WhereClause]
      ,'Entry copied from DWHDB01QA entry.' AS [Comments]
      ,GETDATE() AS [ModifiedDTTM]
      ,[ModifiedBy]
      ,[MinMaxField1]
      ,[MinMaxField2]
      ,[CountDistinctField1]
      ,[CountDistinctField2]

FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

 -- WHERE [Server] = 'DWHDB01QA'
 --   AND [Schema] <> 'myViejas'
	--AND [Table] <> 'v_daily_fact_all_records'
 --   AND [Table] NOT IN (
	--	SELECT [Table]
	--	FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
	--	WHERE [Server] = 'DWHDB01PR')

WHERE [Server] = 'DWHDB01PR'