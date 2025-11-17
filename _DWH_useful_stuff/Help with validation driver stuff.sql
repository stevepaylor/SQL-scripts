UPDATE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
SET ActiveFlag = 'Y' 
WHERE EXISTS 
(
SELECT DISTINCT 
  [Table]
, [Schema]
, [Database]
, [Server]

FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation]
) ;
GO

SELECT *
FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
WHERE ActiveFlag = 'Y' 


SELECT *
--INTO [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_SAVE]
FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation]

--TRUNCATE TABLE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
--INSERT INTO [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
--SELECT *
--FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver_SAVE]

TRUNCATE TABLE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation]


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
  FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

  WHERE [Table] = 'tab_daily_fact'

  --UPDATE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
  --SET [Server] = 'MSBIDB02DV'
  --WHERE [Server] = 'MSBIDB01DV'

  --UPDATE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
  --SET 
  --ValidationField2 = NULL 
  --, ValidationField1 = 'ModifiedDtm'
  --WHERE [Table] = 'tStorage'

  UPDATE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
  SET 
	QueryGroup = 99 
  , ActiveFlag = 'N'
  WHERE [Table] = 'tStorage'
    AND [Server] = 'DWHDB01PR'


INSERT INTO [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
SELECT *
--INTO [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
FROM [SystemMaintDB_1130AM].[dbo].[Repl_ETL_RowCounts_Validation_Driver]

--TRUNCATE TABLE [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Driver]
