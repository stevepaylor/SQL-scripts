SELECT *
--FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2]
FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1]

WHERE [Table] IN ('tab_award_fact','tab_daily_fact','player_dim','tab_player_hist_dim','tab_geo_dim')
  AND SortKey = 1

ORDER BY
  [AsOfDTTM] desc
, [Table]
--, [Server]
, [Schema]

--from player.tab_award_fact a (nolock)
--left join player.tab_daily_fact df (nolock)
--on a.PLAYER_KEY = df.PLAYER_KEY 
--and a.DATE_KEY = df.DATE_KEY
--inner join tableau.player_dim b (nolock)
--on a.PLAYER_KEY = b.PLAYER_KEY
--left join player.tab_player_hist_dim c (nolock)
--on a.PLAYER_KEY = c.PLAYER_KEY
--and a.DATE_KEY between c.START_DATE_KEY and c.END_DATE_KEY
--left join player.tab_geo_dim d (nolock)
--on isnull(c.player_zip, b.player_zip) = d.geo_zip
