--NetTheo_3MonthLGD (Does not currently exist in MM)

--Old DWH calc = sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win) - sum(a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

--NetActualWin_3MonthLGD (Does not currently exist in MM)

--Old DWH calc = (sum(a.slot_actual_win + a.table_actual_win + a.other_actual_win) - sum(a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------

--SlotActualWin_3MonthLGD  (Does not currently exist in MM)

--Old DWH calc = (a.slot_actual_win - a.award_FPAwarded_Total)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TableNetActualWin_3MonthLGD  (Does not currently exist in MM)

--Old DWH calc = (a.table_actual_win - a.award_PromoChipsAwarded)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------

--OtherNetActualWin_3MonthLGD  (Does not currently exist in MM)

--Old DWH calc = (a.other_actual_win - a.award_CashAwarded_Bingo)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------

--ADP_3MonthLGD 

--Current calc in MM = case when gamingDays_3MonthLGD <> 0 then cast(dailyProfitability_3MonthLGD/gamingDays_3MonthLGD as money) else null end

--Here are the dailyworth and award calc in the sp_IQ_Marketing_Metrics_Update_EXT proc...


--       gamingDays_3MonthLGD = case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then gamingDays else 0 end

--       dailyProfitability_3MonthLGD = MME.dailyWorth_3MonthLGD - ((award_FPUsed_3MonthLGD - award_FPAwarded_ServiceRecovery_3MonthLGD - award_FPAwarded_PromoWinner_3MonthLGD ) 
--                                                              + (Award_Cash_Total_3MonthLGD - award_Cash_PromoWinner_3MonthLGD ) 
--                                                              + (award_PromoChipsUsed_Total_3MonthLGD - award_PromoChipUsed_ServiceRecovery_3MonthLGD - award_PromoChipUsed_PromoWinner_3MonthLGD )
--                                                              + (award_Comp_Total_NoHotel_3MonthLGD - award_Comp_ServiceRecovery_3MonthLGD - award_FB_Benefit_3MonthLGD - award_ FB_HostDine_3MonthLGD))

--                                                              dailyWorth_3MonthLGD =    case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) 
--                                                               and eomonth(LastTripDate) then dailyWorth else 0 end

--                                                                   dailyWorth is computed with this code in the sp_IQ_Marketing_Metrics_Update...

--                                                                     dailyWorth   (summed) =              (select max(daily_worth)
--                                                                     from (values (isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull( [BingoBuyin]*0.40,0)),
--                                                                     ((isnull(SlotWin,0)+isnull(TableWin,0)+isnull([BingoBuyin],0))*0.4)) as daily_worth(daily_worth))
--                                                                     ...
--                                            from [dbo].[v_IQC_Player_Daily_Totals_GameDay] a
--                                               inner join [iQ-Gaming].[dbo].[IQ_Calendar] b
--                                               on a.GamingDateID = b.DateID 
--                                               left join  [iQ-Gaming].[dbo].[IQC_Player_Points] c
--                                               on c.GamingDate = b.CalendarDate and a.Playerid = c.Playerid
--                                               and b.CalendarDate between ''' + cast(@beginningDate as nvarchar(10)) + ''' and ''' + cast(@baseLineDate as nvarchar(10)) + ''' 



--Calc in Old DWH = 
--sum(a.daily_worth - ((a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner) 
--                    + (a.award_CompsUsed_Other + a.award_CompsUsed_FB + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]))) / sum(gaming_days)


----------------------------------------------------------------------------------------------------------------------------------------------------

--Here's a query I started to get the award fields used in the old DWH calucations.  Nick got all of these from the player.tab_daily_fact...

USE [iQ-Gaming] ;
GO

SELECT TOP 1000
  f.player_id as fact_player_id
, CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE) as fact_GamingDate
, ISNULL(a.award_FPAwarded_PromoWinner, 0) as awd_award_FPAwarded_PromoWinner
, f.award_FPAwarded_PromoWinner as fact_award_FPAwarded_PromoWinner
, ISNULL(a.award_FPAwarded_Total, 0) as awd_award_FPAwarded_Total
, f.award_FPAwarded_Total as fact_award_FPAwarded_Total
-- colums are not available in v_IQC_Awards get from plaver.tab_daily_fact
, f.award_CompsUsed_Other  
, f.award_CompsUsed_FB
, f.award_PromoChipsAwarded
, f.award_CashAwarded_Bingo
, f.gaming_days

FROM player.tab_daily_fact f

JOIN dbo.v_IQC_Awards a
ON a.playerID = f.player_id
AND a.GamingDate = CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)

ORDER BY
  f.player_id
, CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)

--UNION ALL

SELECT TOP 1000
  a.playerID as awd_PlayerID
, f.player_id as fact_player_id
, a.GamingDate as awd_GamingDate
, CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE) as fact_GamingDate
, SUM(ISNULL(a.award_FPAwarded_PromoWinner, 0)) as awd_award_FPAwarded_PromoWinner
, SUM(f.award_FPAwarded_PromoWinner) as fact_award_FPAwarded_PromoWinner
, SUM(ISNULL(a.award_FPAwarded_Total, 0)) as awd_award_FPAwarded_Total
, SUM(f.award_FPAwarded_Total) as fact_award_FPAwarded_Total
 -- colums are not available in v_IQC_Awards get from plaver.tab_daily_fact
, SUM(f.award_CompsUsed_Other) as fact_award_CompsUsed_Other
, SUM(f.award_CompsUsed_FB) as fact_award_CompsUsed_FB
, SUM(f.award_PromoChipsAwarded) as fact_award_PromoChipsAwarded
, SUM(f.award_CashAwarded_Bingo) as fact_award_CashAwarded_Bingo
, SUM(f.gaming_days) as fact_gaming_days

FROM player.tab_daily_fact f

JOIN dbo.v_IQC_Awards a
ON a.playerID = f.player_id
AND a.GamingDate = CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)

--WHERE ISNULL(a.award_FPAwarded_PromoWinner, 0) <> f.award_FPAwarded_PromoWinner
--WHERE a.playerID IS NOT NULL
--WHERE f.player_id IS NOT NULL

GROUP BY
  a.playerID
, f.player_id
, a.GamingDate
, CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)

ORDER BY
  a.playerID
, f.player_id
, a.GamingDate
, CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)




--, RecordKey
--, Award_BingoCash_ActiveNL
--, Award_BingoCash_InactiveNL
--, Award_BingoCash_OuterMarketNL
--, Award_BingoCash_Supplemental
--, Award_Cash_PromoWinner
--, Award_Cash_CashBack
--, Award_Cash_Discretionary
--, Award_Cash_FPConversion
--, Award_Cash_Supplemental
--, Award_Cash_Other
--, Award_Cash_Total
--, Cash_NumberAwards
--, award_PromoChipUsed_ActiveNL
--, award_PromoChipUsed_BaccRebate
--, award_PromoChipUsed_Discretionary
--, award_PromoChipUsed_FPConversion
--, award_PromoChipUsed_INActiveNL
--, award_PromoChipUsed_OuterMarketNL
--, award_PromoChipUsed_PromoWinner
--, award_PromoChipUsed_PTConversion
--, award_PromoChipUsed_ServiceRecovery
--, award_PromoChipUsed_Supplemental
--, award_PromoChipUsed_Other
--, Award_PromoChipsUsed_Total
--, PromoChips_NumberAwards
--, award_Comp_Discretionary
--, award_Comp_GolfBenefit
--, award_Comp_ServiceRecovery
--, award_Comp_Total_NoHotel
--, award_Comp_Total_Other_Comp
--, Comp_NumberAwards
--, award_FB_Benefit
--, award_FB_Bus
--, award_FB_Discretionary
--, award_FB_Marketing
--, award_FB_OffProperty
--, award_FB_HostDine
--, award_FB_PromoWinner
--, award_FB_ServiceRecovery
--, Award_FB_Cash_Other
--, award_FB_Total
--, FB_NumberAwards
--, award_FPAwarded_ActiveNL
--, award_FPAwarded_InactiveNL
--, award_FPAwarded_OuterMarketNL
--, award_FPAwarded_Supplemental
--, award_FPAwarded_Bus
--, award_FPAwarded_Discretionary
--, award_FPAwarded_HotelBooking
--, award_FPAwarded_ServiceRecovery
--, award_FPAwarded_Other
--, FP_NumberAwards
--, award_FPused
--, award_Ent_Marketing
--, award_Merchandise_PromoWinner
--, award_Merchandise_Marketing
--, Misc_NumberAwards
--, ModifiedDate
--, CasinoCode
--, ManualUpdate
--, SourceSystem
--, LoadDTTM
--, award_BingoCash_Discretionary
--, award_PromoChipUsed_FPBus
--, Award_CompsUsed_Hotel_Finance
--, Award_CompsUsed_Hotel_MKTG
--, BasePoints
--, BonusPoints
--, GamePoints
--, PointsEarned
--, ExpUsed_NoHotel
