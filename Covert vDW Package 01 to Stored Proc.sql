---------------------------------------------
-- load pull date
---------------------------------------------
DECLARE @track_date datetime ;

SET @track_date =
(
SELECT track_date
FROM config.tab_datetime_tracker (nolock)
WHERE track_tab_name = 'player.tab_player_dim'
  AND track_ssis_name = 'etl_player_player_dim'
) ;

---------------------------------------------
-- truncate
---------------------------------------------