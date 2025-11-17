-- PACKAGE - 02_etl_player_merge_dim


--=============================================
-- LOAD MERGE DIM (DATA FLOW)
--=============================================

-------------------------------
-- read
-------------------------------
select RetiredID, OldPlayerID, ActivePlayerID, MergeDtm
from tRetired (nolock)

-------------------------------
-- map
-------------------------------
-- adds columns:
-- merge_id
-- player_id_old
-- player_id_active
-- merge_date

-------------------------------
-- exists (match lookup)
-------------------------------
select
  MERGE_KEY
, merge_id
, player_id_old
, player_id_active

from player.tab_merge_dim b (nolock)

-------------------------------
-- insert new
-------------------------------
-- Fast Load into player.tab_merge_dim

-------------------------------
-- need update (conditional splitter)
-------------------------------
-- sends existing records to the update output

-------------------------------
-- update
-------------------------------
update player.tab_merge_dim
set player_id_active = ?, dws_timestamp = getdate()
where MERGE_KEY = ?