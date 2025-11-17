select
fact.player_id as A_player_id ,
hist.player_id as hist_player_id ,
card.Acct as card_acct ,
hist.player_type				AS player_type_hist,
hist.player_club_level			AS player_club_level_hist,
hist.player_zip				AS player_zip_hist,
ISNULL(REPLACE(hist.player_host,'CONVHOST, CONVHOST', 'N/A'),'N/A') AS player_host_hist,
hist.player_age_category		AS player_age_category_hist,
hist.player_gaming_type		AS player_gaming_type_hist,
hist.player_slot_type			AS player_slot_type_hist,
hist.player_table_type			AS player_table_type_hist,
hist.player_frequency			AS player_frequency_hist,
hist.player_adt_category		AS player_adt_category_hist,
hist.player_lifecycle			AS player_lifecycle_hist,
fact.DATE_KEY as hist_DATE_KEY ,
hist.START_DATE_KEY ,
hist.PLAYER_HIST_KEY


from player.tab_daily_fact fact (nolock)

left JOIN player.tab_player_hist_dim hist (nolock) 
on fact.player_id = hist.player_id 
and fact.DATE_KEY between hist.START_DATE_KEY 
and hist.END_DATE_KEY  --fact.PLAYER_HIST_KEY = hist.PLAYER_HIST_KEY

join [CMP_13-1].[tPlayerCard] card  (nolock) 
on fact.player_id = card.playerid

where card.Acct = 10009689


select *
from [iQ-Gaming].[Tableau].[player_daily_fact] (nolock)


