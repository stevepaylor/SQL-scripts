select gamingdt, playerid, prizecode
into #AwardedPlayers
from cmktdb13cpr.cmp13.dbo.viewAwardsViejas
where prizecode in ('N19NBuffet' , 'N19NM_20DC') and Trancode not in ('AUTHMGMT') and gamingdt>='2019-10-01' and isvoid=0

select pdf.gaming_date as TripDate,  ap.gamingdt as AwardRedeemedDate, player_signup_date, prizecode, player_account_number, player_first_name, player_last_name, player_birthdate, player_address1, player_address2, player_city, player_state, player_zip,
player_phone, player_email, slot_total_bet, slot_theo_win , slot_actual_win ,
table_total_bet, table_theo_win , table_actual_win ,
slot_actual_win + table_actual_win as Total_Actual_Win, slot_theo_win+  table_theo_win as Total_Theo_Win,
award_CompsUsed_FB , award_FPAwarded_NonPts , 
award_PointsRedeemed*0.001 as award_PointsRedeemed ,
award_CompsUsed_Hotel_Mktg,
award_CompsUsed_FB + award_FPAwarded_NonPts + award_PointsRedeemed*0.001 + award_CompsUsed_Hotel_Mktg as Total_Reinvestment,
(slot_actual_win + table_actual_win) - (award_CompsUsed_FB + award_FPAwarded_NonPts + award_PointsRedeemed*0.001 + award_CompsUsed_Hotel_Mktg) as NetActualWin,
(slot_Theo_win + table_theo_win ) - (award_CompsUsed_FB + award_FPAwarded_NonPts + award_PointsRedeemed*0.001 + award_CompsUsed_Hotel_Mktg) as NetTheoWin

from [tableau].[player_daily_fact] pdf inner join #AwardedPlayers ap on pdf.player_id = ap.playerid
where gaming_date>='2019-10-01 00:00:00.000' 
order by gamingdt asc


---- To Get Counts by Prize and Gaming Date
--select gamingdt, prizecode, count(*)
--from #AwardedPlayers
--group by gamingdt, prizecode
--order by gamingdt asc, prizecode

DROP TABLE #AwardedPlayers


