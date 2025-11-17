SELECT * 
FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]

WHERE [Table] LIKE 'tviewAllRatingsViejasNoAwards'

--WHERE [Schema] = 'config'

--WHERE [Table] IN ('tab_merge_dim','tab_monthly_fact','tab_offer_dim','tab_offer_fact','tab_offer_fact_redeem')

----WHERE [Schema] = 'player'
----  AND InactiveFlag <>'Y'



UPDATE [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
SET 
----  [Table] = 'NAME_RESERVATION_ETL_HISTORY'
----, [Schema] = 'Opera_5_0'
----, [Database] = 'iQ-Gaming'
----, [Server] = 'DWHDB01PR'
-- --[QueryGroup] = 8
 [InactiveFlag] = 'Y'
-- --[WhereClause] = NULL
----, [Comments] = NULL 
, ModifiedDTTM = GETDATE()
, ModifiedBy = ORIGINAL_LOGIN()
----, [MinMaxField1] = 'TRX_CODE'
----, [MinMaxField2] = 'UPDATE_DATE'
----, [CountDistinctField1] = NULL
----, [CountDistinctField2] = NULL
----, [SourceServer] = [Server]

WHERE [Table] LIKE 'tviewAllRatingsViejasNoAwards'

