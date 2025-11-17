USE	[SystemMaintDB] ;
GO

SELECT *
FROM [dbo].[Repl_ETL_RowCounts_Validation]

WHERE ValidationField1 = '9'

--WHERE [Table] IN ( 
-- '[tab_datetime_tracker]'
--, '[tab_player_id_pull]'
--, '[tab_general_dates]'
--, '[tab_aggregate_12month]'
--, '[tab_aggregate_6month]'
--, '[tab_aggregate_3month]'
--, '[tab_aggregate_3month_LGD]'
--, '[tab_merge_dim]'
--, '[awards_bonus]'
--, '[awards_view]'
--, '[offer_removal]'
--, '[tPlayerLimitConfig]'
--, '[tPlayerIdentType]'
--, '[tPlayerCompBal]'
--, '[tIdentType]'
--, '[tStorage]'
--, '[tPlayerCasinoHost]'
--)

--AND AsOfDTTM >= '2023-07-11 08:31:07.000'
--AND [Server] = 'DWHDB01QA'

ORDER BY 
  --[Table] ASC 
--, AsOfDTTM DESC 
 AsOfDTTM DESC 
,  [Table] ASC ;
GO