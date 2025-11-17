SELECT
  '1) MSBIDB02DV.vDW.tableau.player_dim - with where clause' as source_table
, COUNT(*) as total_row_count
, COUNT(DISTINCT player_id) as distinct_player_id_count
, COUNT(DISTINCT pd.player_last_name) as distinct_player_last_name_count

FROM MSBIDB02DV.vDW.tableau.player_dim pd (nolock)
--FROM myViejas.tab_player_dim pd (nolock) 

WHERE pd.player_last_name not in ('*Table', 'giftcard')
AND pd.player_account_number <> 0
AND pd.player_type <> 'Viejas Gift Card'
--AND pd.dw_timestamp >= '2018-01-01'
AND pd.player_last_trip_date >= '2018-01-01'

UNION ALL

SELECT
  '2) [iQ-Gaming].tableau.player_dim - with where clause' as source_table
, COUNT(*) as total_row_count
, COUNT(DISTINCT player_id) as distinct_player_id_count
, COUNT(DISTINCT pd.player_last_name) as distinct_player_last_name_count

--FROM player.tab_player_dim pd (nolock)
FROM [iQ-Gaming].tableau.player_dim pd (nolock) 

WHERE pd.player_last_name not in ('*Table', 'giftcard')
AND pd.player_account_number <> 0
AND pd.player_type <> 'Viejas Gift Card'
--AND pd.dw_timestamp >= '2018-01-01'
AND pd.player_last_trip_date >= '2018-01-01'

UNION ALL

SELECT
  '3) player.tab_player_dim - w/o where clause' as source_table
, COUNT(*) as total_row_count
, COUNT(DISTINCT player_id) as distinct_player_id_count
, COUNT(DISTINCT pd.player_last_name) as distinct_player_last_name_count

FROM player.tab_player_dim pd (nolock)
--FROM myViejas.tab_player_dim pd (nolock) 

--WHERE pd.player_last_name not in ('*Table', 'giftcard')
--AND pd.player_account_number <> 0
--AND pd.player_type <> 'Viejas Gift Card'
--AND pd.dw_timestamp >= '2018-01-01'
--AND pd.player_last_trip_date >= '2018-01-01'

UNION ALL

SELECT
  '4) myViejas.tab_player_dim - w/o where clause' as source_table
, COUNT(*) as total_row_count
, COUNT(DISTINCT player_id) as distinct_player_id_count
, COUNT(DISTINCT pd.player_last_name) as distinct_player_last_name_count

--FROM player.tab_player_dim pd (nolock)
FROM myViejas.tab_player_dim pd (nolock) 

--WHERE pd.player_last_name not in ('*Table', 'giftcard')
--AND pd.player_account_number <> 0
--AND pd.player_type <> 'Viejas Gift Card'
--AND pd.dw_timestamp >= '2018-01-01'
--AND pd.player_last_trip_date >= '2018-01-01'





--SELECT
--  COUNT(*) as total_row_count
--, COUNT(DISTINCT player_id) 
--, COUNT(DISTINCT player_account_number)
----, COUNT(DISTINCT pd.player_last_name) as distinct_player_last_name_count

----FROM player.tab_player_dim pd (nolock) 
--FROM myViejas.tab_player_dim pd (nolock) 

----WHERE pd.player_last_name in ('*Table', 'giftcard')
----WHERE player_account_number = 0
----AND pd.player_type <> 'Viejas Gift Card'


--SELECT
--  COUNT(*) as total_row_count
--, pd.player_last_name

----FROM player.tab_player_dim pd (nolock) 
--FROM myViejas.tab_player_dim pd (nolock) 

--WHERE pd.player_last_name not in ('*Table', 'giftcard')
--AND pd.player_account_number <> 0
--AND pd.player_type <> 'Viejas Gift Card'

--GROUP BY 
--  pd.player_last_name

--HAVING COUNT(*) > 1

--ORDER BY 
--  total_row_count DESC