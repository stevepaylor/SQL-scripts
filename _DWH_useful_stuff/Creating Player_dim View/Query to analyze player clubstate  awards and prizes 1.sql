USE [iQ-Gaming] ;
GO

SELECT 
  D.player_id AS dim_player_id
, D.player_account_number AS dim_acct
, D.player_club_level AS dim_player_club_level
, D.player_last_club_level AS dim_player_last_club_level
, L.ClubLevelName AS cstate_ClubLevelName
, L.ClubStateExpiryDate  AS cstate_ClubStateExpiryDate
, D.player_club_level_change_date  AS dim_player_club_level_change_date
, A.PrizeId AS awd_PrizeId
, P.Prizecode AS prz_Prizecode
, P.PrizeName AS prz_PrizeName
, A.GamingDt AS awd_GamingDt
, A.PostDtm AS awd_PostDtm
, A.TripDt AS awd_TripDt
, A.CreatedDtm AS awd_CreatedDtm
, A.ModifiedDtm AS awd_ModifiedDtm
, L.AddedToRepl_TS AS cstate_AddedToRepl
, L.ModifiedInRepl_TS AS cstate_ModifiedInRepl
, D.dw_timestamp AS dim_dw_timestamp


FROM player.tab_player_dim D

JOIN [CMP_13-1].[tAwards] A
ON D.player_id = a.PlayerId

JOIN [CMP_13-1].[tPrize] P
ON A.PrizeId = P.PrizeId


JOIN REPL.iQC_tPlayer_ClubState_Repl L
ON A.PlayerId = L.PlayerId

WHERE D.player_id = '10472679'
  AND P.Prizecode = 'EvalSilver'


