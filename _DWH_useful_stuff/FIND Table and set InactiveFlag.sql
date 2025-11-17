SELECT TOP (1000) [Table]
      ,[Schema]
      ,[Database]
      ,[Server]
      ,[QueryGroup]
      ,[InactiveFlag]
      ,[WhereClause]
      ,[Comments ]
      ,[ModifiedDTTM]
      ,[ModifiedBy]
      ,[ValidationField1]
      ,[ValidationField2]
  FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver]

  where [Table] = 'tStorage'

  UPDATE [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver]
  SET [InactiveFlag] = 'Y'
  where [Table] = 'tStorage'
    and [Server] = 'DWHDB01PR'


