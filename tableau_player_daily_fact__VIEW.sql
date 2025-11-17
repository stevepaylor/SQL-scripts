USE [vDW]
GO

/****** Object:  View [tableau].[player_daily_fact]    Script Date: 6/12/2023 3:53:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--CREATE view [tableau].[player_daily_fact]
--as
select
cast(convert(varchar(10), a.DATE_KEY) as datetime)	as gaming_date,
b.*,
c.player_type				as player_type_hist,
c.player_club_level			as player_club_level_hist,
c.player_zip				as player_zip_hist,
c.player_host				as player_host_hist,
c.player_age_category		as player_age_category_hist,
c.player_gaming_type		as player_gaming_type_hist,
c.player_slot_type			as player_slot_type_hist,
c.player_table_type			as player_table_type_hist,
c.player_frequency			as player_frequency_hist,
c.player_adt_category		as player_adt_category_hist,
c.player_lifecycle			as player_lifecycle_hist,
d.geo_city,
d.geo_county,
d.geo_state,
d.geo_country,
d.geo_distance,
d.geo_distance_category,
d.geo_distance_subcategory,
d.geo_population,
d.geo_market,
l2.relationship_length		as length_of_relationship_hist,
a.gaming_days,
a.slot_minutes_played,
a.slot_buyin_cash,
a.slot_buyin_credit,
a.slot_buyin_chips,
a.slot_buyin_promo,
a.slot_buyin_Ecredit,
a.slot_plays,
a.slot_total_bet,
a.slot_paid_out,
a.slot_theo_win,
a.slot_actual_win,
a.slot_jackpot_win,
a.table_minutes_played,
a.table_buyin_cash,
a.table_buyin_credit,
a.table_buyin_chips,
a.table_buyin_promo,
a.table_buyin_Ecredit,
a.table_plays,
a.table_total_bet,
a.table_paid_out,
a.table_theo_win,
a.table_actual_win,
a.other_minutes_played,
a.other_buyin_cash,
a.other_buyin_credit,
a.other_buyin_chips,
a.other_buyin_promo,
a.other_buyin_Ecredit,
a.other_plays,
a.other_total_bet,
a.other_paid_out,
a.other_theo_win,
a.other_actual_win,
a.daily_worth,
a.points_earned,
a.bonus_points_earned,
a.comps_earned,
a.comps_alt_earned,
a.offer_redeemed_total,
a.offer_redeemed_hotel,
a.offer_redeemed_event,
a.offer_redeemed_FPC,
a.offer_redeemed_other,
a.award_HotelReservations,
a.award_CompsUsed_Hotel_Finance,
a.award_CompsUsed_Hotel_Mktg,
a.award_CompsUsed_Hotel_Folio,
a.award_CompsUsed_FB,
a.award_CompsUsed_Other,
a.award_CompsUsed_Merchandise				as award_Promo_Merchanise,
a.award_CompsUsed_Total_Finance,
a.award_CompsUsed_Total_Mktg,
a.award_Benefits_FB,
a.award_FPAwarded_MonthlyOffer,
a.award_FPAwarded_Supplemental,
a.award_FPAwarded_PromoWinner,
a.award_FPAwarded_Other,
a.award_FPAwarded_Pts,
a.award_FPAwarded_NonPts,
a.award_FPAwarded_Total,
a.award_FreePlay_Used,
a.award_PromoChipsAwarded,
a.award_CashAwarded_Bingo,
a.award_CashAwarded_Promotional,
a.award_CashAwarded_Other,
a.award_PointsAwarded_Base,
a.award_PointsAwarded_Bonus,
a.award_PointsAwarded_Other,
a.award_PointsAwarded_Total,
a.award_PointsRedeemed,
a.award_PointsExpired,
a.award_PointsPurchased,
a.award_PointsUsed_POS,
a.days_since_last_trip,
a.CompReinvestHist							as CompReinvestHist_daily,
a.CompReinvestHistNoHotel					as CompReinvestHistNoHotel_daily
from player.tab_daily_fact a (nolock)
inner join tableau.player_dim b (nolock)
on a.PLAYER_KEY = b.PLAYER_KEY
left join player.tab_player_hist_dim c (nolock)
on a.PLAYER_HIST_KEY = c.PLAYER_HIST_KEY
left join player.tab_geo_dim d (nolock)
on a.GEO_KEY = d.GEO_KEY
left join player.v_relationship_length l2
on datediff(MM, b.player_signup_date, cast(convert(varchar(10), a.DATE_KEY) as datetime)) between l2.min_months and l2.max_months



GO


