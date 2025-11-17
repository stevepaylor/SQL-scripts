 select 
 
 Acct, 
 gamingdt, 
 ---PostDTM, 
 DeptCode, 
 GameCode, 
 RatingID, 
 DenomID, 
 DocumentNo,
 ---CashBuyIn,
---CreditBuyIn,
---ChipBuyIn ,
---PromoBuyIn,
---ECreditBuyIn,
---BuyIn,
---Bet,
---PaidOut,
Jackpot ,
---Plays ,
---IsOpenItem,
---RatingPeriodMinutes,
---CalculatedCasinoWin ,
---ObservedCasinoWin , 
CasinoWin,
TheorWin , 		
---WalkedWith, --Set to 0 for slot rating	
DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), RatingStartDtm) 'RatingStartDtm',
DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), RatingEndDtm) 'RatingEndDtm'
---Ref1,
---Ref2, 
---GETDATE() as AccountingDate
from [CMKTDB13CPR].[CMP13].dbo.viewAllRatingsViejasNoAwardsNoGMT tr inner join [CMKTDB13CPR].[CMP13].dbo.tplayercard tpc
 on tr.playerid = tpc.playerid

---where gamingDT between '01/01/2019' and '06/30/2019'
where gamingDT between '01/01/2019' and '08/11/2019'

and acct in (
12450564,
20807271,
12161616,
20911096,
12151739,
21123495
)




/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [gaming_date]
      ,[PLAYER_KEY]
      ,[player_id]
      ,[player_account_number]
      ,[player_type_hist]
      ,[player_club_level_hist]
      ,[player_zip_hist]
      ,[player_host_hist]
      --,[player_age_category_hist]
      --,[player_gaming_type_hist]
      --,[player_slot_type_hist]
      --,[player_table_type_hist]
      --,[player_frequency_hist]
      --,[player_adt_category_hist]
      --,[player_lifecycle_hist]
      --,[length_of_relationship_hist]
      --,[gaming_days]
      --,[slot_minutes_played]
      --,[slot_buyin_cash]
      --,[slot_buyin_credit]
      --,[slot_buyin_chips]
      --,[slot_buyin_promo]
      --,[slot_buyin_Ecredit]
      --,[slot_plays]
      --,[slot_total_bet]
      --,[slot_paid_out]
      --,[slot_theo_win]
      --,[slot_actual_win]
      --,[slot_jackpot_win]
      --,[table_minutes_played]
      --,[table_buyin_cash]
      --,[table_buyin_credit]
      --,[table_buyin_chips]
      --,[table_buyin_promo]
      --,[table_buyin_Ecredit]
      --,[table_plays]
      --,[table_total_bet]
      --,[table_paid_out]
      --,[table_theo_win]
      --,[table_actual_win]
      --,[other_minutes_played]
      --,[other_buyin_cash]
      --,[other_buyin_credit]
      --,[other_buyin_chips]
      --,[other_buyin_promo]
      --,[other_buyin_Ecredit]
      --,[other_plays]
      --,[other_total_bet]
      --,[other_paid_out]
      --,[other_theo_win]
      --,[other_actual_win]
      --,[daily_worth]
      ,[points_earned]
      ,[bonus_points_earned]
      ,[comps_earned]
      ,[comps_alt_earned]
      ,[offer_redeemed_total]
      ,[offer_redeemed_hotel]
      ,[offer_redeemed_event]
      ,[offer_redeemed_FPC]
      ,[offer_redeemed_other]
      ,[award_HotelReservations]
      ,[award_CompsUsed_Hotel_Finance]
      ,[award_CompsUsed_Hotel_Mktg]
      ,[award_CompsUsed_Hotel_Folio]
      ,[award_CompsUsed_FB]
      ,[award_CompsUsed_Other]
      ,[award_Promo_Merchanise]
      ,[award_CompsUsed_Total_Finance]
      ,[award_CompsUsed_Total_Mktg]
      ,[award_Benefits_FB]
      ,[award_FPAwarded_MonthlyOffer]
      ,[award_FPAwarded_Supplemental]
      ,[award_FPAwarded_PromoWinner]
      ,[award_FPAwarded_Other]
      ,[award_FPAwarded_Pts]
      ,[award_FPAwarded_NonPts]
      ,[award_FPAwarded_Total]
      ,[award_FreePlay_Used]
      ,[award_PromoChipsAwarded]
      ,[award_CashAwarded_Bingo]
      ,[award_CashAwarded_Promotional]
      ,[award_CashAwarded_Other]
      ,[award_PointsAwarded_Base]
      ,[award_PointsAwarded_Bonus]
      ,[award_PointsAwarded_Other]
      ,[award_PointsAwarded_Total]
      ,[award_PointsRedeemed]
      ,[award_PointsExpired]
      ,[award_PointsPurchased]
      ,[award_PointsUsed_POS]
      ---,[days_since_last_trip]
  FROM [vDW].[tableau].[player_daily_fact]
  
---where gaming_date between '01/01/2019' and '06/30/2019'
where gaming_date between '01/01/2019' and '08/11/2019'

and player_account_number in (
12450564,
20807271,
12161616,
20911096,
12151739,
21123495
)