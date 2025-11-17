USE [iQ-Gaming] ;
GO

SELECT DISTINCT
  D.player_id AS dim_player_id
, D.player_account_number AS dim_acct
, P.ClubState tPlayer_ClubState
, CL.ClubLevelName tPlayer_ClubLevelName_lookedup
, D.player_club_level AS dim_player_club_level
, D.player_last_club_level AS dim_player_last_club_level
, L.ClubLevelName AS cstate_ClubLevelName
, D.player_club_level_change_date  AS dim_player_club_level_change_date

FROM player.tab_player_dim D (nolock)

JOIN [CMP_13-1].[tPlayer] P (nolock)
ON D.Player_Id = P.PlayerId

JOIN [CMP_13-1].[tClubLevels] CL (nolock)
ON P.ClubState = CL.ClubState

JOIN REPL.iQC_tPlayer_ClubState_Repl L (nolock)
ON D.Player_Id = L.PlayerId

--WHERE D.player_club_level <> CL.ClubLevelName

WHERE D.player_id = '10472679'
