SELECT [Table]
      ,[Schema]
      ,[Database]
      ,[Server]
      ,[QueryGroup]
      ,[InactiveFlag]
      ,[WhereClause]
      ,[Comments]
      ,[ModifiedDTTM]
      ,[ModifiedBy]
      ,[MinMaxField1]
	  ,[MinMaxField2]
	  ,[CountDistinctField1]
	  ,[CountDistinctField2]
	  ,[SourceServer]

FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

WHERE [Table] IN ('TRX_CODES')

INSERT INTO [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
(
  [Table]
, [Schema]
, [Database]
, [Server]
, [QueryGroup]
, [InactiveFlag]
, [WhereClause]
, [Comments]
, [ModifiedDTTM]
, [ModifiedBy]
, [MinMaxField1]
, [MinMaxField2]
, [CountDistinctField1]
, [CountDistinctField2]
, [SourceServer]
	)
VALUES (
  'TRX_CODES' --AS [Table]
, 'dbo' --AS [Schema]
, 'OperaDM' --AS [Database]
, 'MSBIDB02DV' --AS [Server]
, 8 --AS [QueryGroup]
, 'N' --AS [InactiveFlag]
, NULL --AS [WhereClause]
, NULL --AS [Comments]
, GETDATE() --AS [ModifiedDTTM]
, 'Viejas\spaylor' -- AS [ModifiedBy]
, 'TRX_CODES' --AS [MinMaxField1]
, 'UPDATE_DATE' --AS [MinMaxField2]
, NULL --AS [CountDistinctField1]
, NULL -- AS [CountDistinctField2]
, 'MSBIDB02DV' --AS [SourceServer]
)

  [Table] = 'NAME_RESERVATION_ETL_HISTORY_BATCH_COUNT'
, [Schema] = 'Opera_5_0'
, [Database] = 'iQ-Gaming'
, [Server] = 'DWHDB01PR'
, [QueryGroup] = 8
, [InactiveFlag] = 'N'
, [WhereClause] = 'WHERE BATCH_COMPLETION >= 2018'
, [Comments] = NULL 
, ModifiedDTTM = GETDATE()
, ModifiedBy = ORIGINAL_LOGIN()
, [MinMaxField1] = 'BATCH_COMPLETION'
, [MinMaxField2] = 'BATCH_NO'
, [CountDistinctField1] = NULL
, [CountDistinctField2] = NULL
, [SourceServer] = [Server]