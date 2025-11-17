DECLARE @apr_start_date AS datetime  = '2019-01-01'
DECLARE @end_date AS datetime = '2019-12-31'

SELECT 

       CONVERT(date, gaming_date) AS gaming_date,
       player_id AS player_id,
       CONVERT(nvarchar(50), player_account_number) AS player_account,
       slot_actual_win + table_actual_win + other_actual_win AS actual_win_total,
       slot_actual_win AS actual_win_slots,
       table_actual_win AS actual_win_table,
       other_actual_win AS actual_win_other,
       slot_theo_win + table_theo_win + other_theo_win AS theo_win_total,
       slot_theo_win AS theo_win_slots,
       table_theo_win AS theo_win_table,
       other_theo_win AS theo_win_other,
       CASE WHEN (slot_theo_win + table_theo_win + other_theo_win) = 0
       THEN 0
       ELSE 1
       END AS theo_trip,
       award_CompsUsed_Hotel_Mktg AS hotel_comp_used,
       award_CompsUsed_FB AS fb_comp_used,
       award_Benefits_FB AS food_vouchers_used,
       award_CompsUsed_Other AS other_comp_used,
       award_CompsUsed_Hotel_Mktg + award_CompsUsed_FB + award_CompsUsed_Other AS total_comps_used,
       award_FPAwarded_NonPts AS slot_fpc_awarded,
       award_PromoChipsAwarded AS tg_fpc_awarded,
       award_CashAwarded_Bingo AS bingo_fpc_awarded,
       award_FPAwarded_NonPts + award_PromoChipsAwarded + award_CashAwarded_Bingo AS total_fpc_awarded

--INTO #all_player_ratings

FROM [MSBIDB02DV].vDW.tableau.player_daily_fact

WHERE

       CONVERT(date, gaming_date) BETWEEN @apr_start_date AND @end_date
       AND ((slot_theo_win + table_theo_win + other_theo_win) <> 0
       OR award_CompsUsed_Hotel_Mktg <> 0
       OR award_CompsUsed_FB <> 0
       OR award_CompsUsed_Other <> 0
       OR award_FPAwarded_NonPts <> 0
       OR award_PromoChipsAwarded <> 0
       OR award_CashAwarded_Bingo <> 0
       OR award_Benefits_FB <> 0);

--SELECT

--       GamingDt AS gaming_date,
--       EmpId AS emp_id,
--       player_id AS player_id,
--       PrizeCode AS prize_code,
--       PrizeName AS prize_name,
--       award_CompsUsed_Hotel_Mktg AS hotel_comp_used,
--       award_CompsUsed_FB AS fb_comp_used,
--       award_CompsUsed_Other AS other_comp_used,
--       award_FPAwarded_NonPts AS slot_fpc_awarded,
--       award_PromoChipsAwarded AS tg_fpc_awarded,
--       award_CashAwarded_Bingo AS bingo_fpc_awarded

--INTO #awards_by_prize_code

--FROM [MSBIDB02DV].vDW.player.tab_award_fact