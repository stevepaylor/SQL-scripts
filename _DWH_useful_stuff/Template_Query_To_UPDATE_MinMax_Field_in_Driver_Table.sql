SELECT *
FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

--WHERE [MinMaxField1] IN ('dw_timestamp','

 WHERE [SourceServer] = 'CMKTDB13DPR'
   --AND [MinMaxField1] IS NULL


--WHERE ([MinMaxField1] IS NOT NULL
--  AND [MinMaxField1] NOT IN ('dw_timestamp','dws_timestamp','gaming_date','GamingDt','LastGamingDt','ModifiedDtm','TRX_DATE','UPDATE_DATE','BeginDate'))
--   OR [MinMaxField2] IS NOT NULL

ORDER BY
  [MinMaxField1]
, [MinMaxField2]

--UPDATE [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
--SET 
--  ModifiedDTTM = GETDATE()
--, ModifiedBy = ORIGINAL_LOGIN()
--, MinMaxField1 = 'ModifiedDtm'

-- WHERE [SourceServer] = 'CMKTDB13DPR'
--   AND [MinMaxField1] IS NULL

--WHERE [Schema] = 'myViejas'

--  WHERE [Table] IN ('IQC_Comps_EXT')
--  AND [Schema] = 'myViejas'