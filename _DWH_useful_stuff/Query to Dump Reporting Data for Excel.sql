SELECT [Table]
      ,[Schema]
      ,[Database]
      ,[QueryGroup]
      ,[AsOfDTTM]
      ,[SortKey]
      ,[Metric]
      ,[CMKTDB13DPR]
      ,[DWHDB01PR]
      ,[DWHDB01QA]
      ,[DWHDB02PR]
      ,[MSBIDB02DV]
      ,[PLAYERPORTALRDS]
      ,[PLAYERPORTALRDS_QA]
  FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1]

  WHERE QueryGroup = 6
    AND SortKey = 1
	AND [Database] <> 'app'
    AND [AsOfDTTM] >= DATEADD(DAY,-1,GETDATE())

ORDER BY 
  [Table]
, [AsOfDTTM] DESC
, [Database]
, [Schema]