SELECT *
FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

WHERE  [Table]= 'tviewAllRatingsViejasNoAwards'
  AND [Schema] LIKE 'CMP_13-1'

UPDATE [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
SET 
  [Table]= 'tviewAllRatingsViejasNoAwards'
, ModifiedDTTM = GETDATE()
, ModifiedBy = ORIGINAL_LOGIN()
, MinMaxField1 = 'GamingDt'
, MinMaxField2 = 'TripDt'

WHERE [Table] LIKE 'OBI_RESERVATION_STAT_DAILY'
  AND [Schema] LIKE 'CMP_13-1'

SELECT *
FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

WHERE [Table] LIKE 'tviewAllRatingsViejasNoAwards'
