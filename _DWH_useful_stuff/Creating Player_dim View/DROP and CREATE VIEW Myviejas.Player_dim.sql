USE [iQ-Gaming]
GO

/****** Object:  View [myViejas].[player_dim]    Script Date: 8/24/2023 11:52:04 AM ******/
DROP VIEW [myViejas].[player_dim]
GO

/****** Object:  View [myViejas].[player_dim]    Script Date: 8/24/2023 11:52:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






/*
----playerfirstdate and playerlastdate are listed as firstplaydate_ and lastplaydate_


The net actual/theo would have to be a rollup from the awards table and marketing metrics table


----Visits would be the trips_

FP_ sections are under award_FPUsed_

----------Worth_Gross would be dailyworth_ section

*/

CREATE VIEW [myViejas].[player_dim]
AS
SELECT 
pd.PLAYER_KEY,
pd.player_id,
pd.player_account_number,
pd.player_first_name,
pd.player_last_name,
pd.player_display_name,
pd.player_type,
pd.player_club_level,
pd.player_club_anniversary,
pd.player_last_club_level,
pd.player_club_level_change_date,
pd.player_signup_date,
pd.player_address1,
pd.player_address2,
pd.player_city,
pd.player_state,
pd.player_zip,
pd.player_country,
pd.player_email,
pd.player_phone,
pd.player_birthdate,
pd.player_gender,
pd.player_host,
pd.player_host_coded_date,
pd.player_first_trip_date,
pd.player_last_trip_date,
pd.player_age,
pd.player_age_category,
pd.player_gaming_type,
pd.player_slot_type,
pd.player_table_type,
pd.player_isbanned,
pd.player_isinactive,
pd.player_isclubhold,
pd.player_isnomail,
pd.player_isreturnmail,
pd.player_isemailsend,
pd.player_iscall,
pd.player_issendtextmessage,
pd.player_frequency,
pd.player_adt_category,
pd.player_lifecycle,
pd.player_point_bal,
pd.player_stub_bal,
pd.player_promo2_bal,
pd.player_FPC_bal,
pd.points_bal_club																as player_points_bal_custom ,
pd.player_comp_bal ,
pd.behavior_trip ,

geo.geo_city																	as player_geo_city ,
geo.geo_county																	as player_geo_county ,
geo.geo_state																	as player_geo_state ,
geo.geo_country																	as player_geo_country ,
geo.geo_distance																as player_geo_distance ,
geo.geo_distance_category														as player_geo_distance_category ,
geo.geo_distance_subcategory													as player_geo_distance_subcategory ,
geo.geo_population																as player_geo_population ,
geo.geo_market                                                                  as player_geo_market ,

CASE 
  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) < 2 THEN 'New Member'
  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 2 and 6 THEN '2 - 6 months'
  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 7 and 12 THEN '6 – 12 months'
  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 13 and 24 THEN '1 – 2 years'
  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 25 and 60 THEN '2 – 5 years' 
  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 61 and 9999 THEN '5+ years' 
END                                                                             as relationship_length ,

cast(mtx.DateRangeStart_3MonthLGD as datetime)								    as DateRangeStart_3monthLGD ,
cast(mtx.DateRangeEnd_3MonthLGD as datetime)									as DateRangeEnd_3monthLGD ,
cast(mtx.firstPlayDate_3MonthLGD as datetime)	                 				as playerfirstdate_3monthLGD ,
cast(mtx.lastPlayDate_3MonthLGD as datetime)									as playerlastdate_3monthLGD ,

--isnull(CAST(mtx.slotTheo_3MonthLGD as money), 0)	     							as Slot_Theo_3monthLGD ,
isnull(mtx.slotTheo_3MonthLGD, 0)	     										as Slot_Theo_3monthLGD ,

isnull(mtx.tableTheo_3MonthLGD, 0)											    as Table_Theo_3monthLGD ,
isnull(mtx.BingoTheo_3MonthLGD, 0)										    	as Bingo_Theo_3monthLGD ,
isnull(mtx.totalTheo_3MonthLGD, 0)												as Total_Theo_3monthLGD ,
isnull(mtx.dailyWorth_3MonthLGD, 0)												as worth_Gross_3monthLGD ,
isnull(mtx.trips_3MonthLGD, 0)													as visits_3monthLGD ,
isnull(mtx.award_FPUsed_3MonthLGD, 0)											as FP_3monthLGD ,
isnull(mtx.ADT_GrossFP_3MonthLGD, 0)											as ADT_GrossFP_3monthLGD ,
isnull(mtx.ADW_GrossFP_3MonthLGD, 0)											as ADW_GrossFP_3monthLGD ,
isnull(mtx.AMV_3MonthLGD, 0)								    				as AMV_3monthLGD ,
isnull(mtx.AMT_GrossFP_3MonthLGD, 0)											as AMT_GrossFP_3monthLGD ,
isnull(mtx.AMW_GrossFP_3MonthLGD, 0)											as AMW_Gross_3monthLGD ,
isnull((mtx.totalTheo_3MonthLGD - mtx.ADW_NetFP_3MonthLGD), 0)					as NetTheo_3monthLGD ,
isnull(mtx.actualWinLoss_3MonthLGD, 0)											as NetActualWin_3monthLGD ,
isnull(mtx.ADT_NetFP_3MonthLGD, 0)												as ADT_NetFP_3monthLGD ,
isnull(mtx.ADW_NetFP_3MonthLGD, 0)												as ADW_NetFP_3monthLGD ,
isnull(mtx.ADP_3MonthLGD, 0)													as ADP_3monthLGD ,
isnull(mtx.AMT_NetFP_3MonthLGD, 0)												as AMT_NetFP_3monthLGD ,
isnull(mtx.AMW_NetFP_3MonthLGD, 0)												as AMW_NetFP_3monthLGD ,
isnull(mtx.AMP_3MonthLGD, 0)												    as AMP_3monthLGD ,
isnull(mtx2.ADW_NetFP_Category_3monthLGD, 'N/A')							    as ADW_NetFP_Category_3monthLGD ,
isnull(mtx2.AMW_NetFP_Category_3monthLGD, 'N/A')								as AMW_NetFP_Category_3monthLGD ,
isnull(mtx.PlayerType_3MonthLGD, 'N/A')											as PlayerType_3monthLGD ,
isnull(mtx.slotActualWinLoss_3MonthLGD, 0)										as SlotNetActualWin_3monthLGD ,
isnull(mtx.tableActualWinLoss_3MonthLGD, 0)										as TableNetActualWin_3monthLGD ,
--isnull(????, 0)																as OtherNetActualWin_3monthLGD ,
NULL																			as OtherNetActualWin_3monthLGD , -- don't know the mappping

CASE 
   WHEN isnull(mtx.totalTheo_3MonthLGD, 0) >= 
	(isnull(mtx.slotActualWinLoss_3MonthLGD, 0) + isnull(mtx.tableActualWinLoss_3MonthLGD, 0)) 
  THEN isnull(mtx.totalTheo_3MonthLGD, 0) 
  ELSE isnull(mtx.slotActualWinLoss_3MonthLGD, 0) + isnull(mtx.tableActualWinLoss_3MonthLGD, 0) 
END																				as CompWorth_3monthLGD ,

isnull(mtx.compsUsed_3MonthLGD, 0)												as CompUsed_3monthLGD ,
cast(convert(varchar(10), mtx2.DateRangeStart_3month) as datetime)				as DateRangeStart_3month ,
cast(convert(varchar(10), mtx2.DateRangeEnd_3month) as datetime)				as DateRangeEnd_3month ,
cast(convert(varchar(10), mtx.firstPlayDate_last3Months) as datetime) 			as playerfirstdate_3month ,
cast(convert(varchar(10), mtx.lastPlayDate_last3Months) as datetime)			as playerlastdate_3month ,
isnull(mtx.slotTheo_last3Months, 0)												as Slot_Theo_3month ,
isnull(mtx.tableTheo_last3Months, 0)							    			as Table_Theo_3month ,
isnull(mtx.BingoTheo_last3Months, 0)							     			as Bingo_Theo_3month ,
isnull(mtx.totalTheo_last3Months, 0)			    							as Total_Theo_3month ,
isnull(mtx.dailyWorth_last3Months, 0)											as worth_Gross_3month ,
isnull(mtx.trips_last3Months, 0)												as visits_3month ,
isnull(mtx.award_FPUsed_last3Months, 0)											as FP_3month ,
isnull(mtx.ADT_GrossFP_last3Months, 0)											as ADT_GrossFP_3month ,
isnull(mtx.ADW_GrossFP_last3Months, 0)											as ADW_GrossFP_3month ,
isnull(mtx.AMV_Last3Months, 0)													as AMV_3month ,
isnull(mtx.AMT_GrossFP_last3Months, 0)											as AMT_GrossFP_3month ,
isnull(mtx.AMW_GrossFP_last3Months, 0)											as AMW_Gross_3month ,
isnull(mtx.totalTheo_last3Months, 0) - isnull(mtx.ADW_NetFP_last3Months, 0)		as NetTheo_3month ,
isnull(mtx.actualWinLoss_last3Months, 0)							    		as NetActualWin_3month ,
isnull(mtx.ADT_NetFP_last3Months, 0)											as ADT_NetFP_3month ,
isnull(mtx.ADW_NetFP_last3Months, 0)											as ADW_NetFP_3month ,
isnull(mtx.ADP_last3Months, 0)													as ADP_3month ,
isnull(mtx.AMT_NetFP_last3Months, 0)											as AMT_NetFP_3month ,
isnull(mtx.AMW_NetFP_last3Months, 0)									     	as AMW_NetFP_3month ,
isnull(mtx.AMP_last3Months, 0)													as AMP_3month ,
isnull(mtx2.ADW_NetFP_Category_3month, 'N/A')									as ADW_NetFP_Category_3month ,
isnull(mtx2.AMW_NetFP_Category_3month, 'N/A')									as AMW_NetFP_Category_3month ,
isnull(mtx.PlayerType_Last3Months, 'N/A')										as PlayerType_3month ,
cast(convert(varchar(10), mtx2.DateRangeStart_6month) as datetime)				as DateRangeStart_6month ,
cast(convert(varchar(10), mtx2.DateRangeEnd_6month) as datetime)		    	as DateRangeEnd_6month ,
cast(convert(varchar(10), mtx.firstPlayDate_last6Months) as datetime)			as playerfirstdate_6month ,
cast(convert(varchar(10), mtx.lastPlayDate_last6Months) as datetime)			as playerlastdate_6month ,
isnull(mtx.slotTheo_last6Months, 0)												as Slot_Theo_6month ,
isnull(mtx.tableTheo_last6Months, 0)											as Table_Theo_6month ,
isnull(mtx.BingoTheo_last6Months, 0)											as Bingo_Theo_6month ,
isnull(mtx.totalTheo_last6Months, 0)                                       	    as Total_Theo_6month ,
isnull(mtx.dailyWorth_last6Months, 0)											as worth_Gross_6month ,
isnull(mtx.trips_last6Months, 0)												as visits_6month ,
isnull(mtx.award_FPUsed_last6Months, 0)											as FP_6month ,
isnull(mtx.ADT_GrossFP_last6Months, 0)											as ADT_GrossFP_6month ,
isnull(mtx.ADW_GrossFP_last6Months, 0)											as ADW_GrossFP_6month ,
isnull(mtx.AMV_Last6Months, 0)													as AMV_6month ,
isnull(mtx.AMT_GrossFP_last6Months, 0)											as AMT_GrossFP_6month ,
isnull(mtx.AMW_GrossFP_last6Months, 0)											as AMW_Gross_6month ,
isnull(mtx.totalTheo_last6Months, 0) - isnull(mtx.ADW_NetFP_last6Months, 0)		as NetTheo_6month ,
isnull(mtx.actualWinLoss_last6Months, 0)										as NetActualWin_6month ,
isnull(mtx.ADT_NetFP_last6Months, 0)											as ADT_NetFP_6month ,
isnull(mtx.ADW_NetFP_last6Months, 0)									    	as ADW_NetFP_6month ,
isnull(mtx.ADP_last6Months, 0)													as ADP_6month ,
isnull(mtx.AMT_NetFP_last6Months, 0)											as AMT_NetFP_6month ,
isnull(mtx.AMW_NetFP_last6Months, 0)											as AMW_NetFP_6month ,
isnull(mtx.AMP_last6Months, 0)													as AMP_6month ,
isnull(mtx2.ADW_NetFP_Category_6month, 'N/A')									as ADW_NetFP_Category_6month ,
isnull(mtx2.AMW_NetFP_Category_6month, 'N/A')									as AMW_NetFP_Category_6month ,
isnull(mtx.PlayerType_Last6Months, 'N/A')										as PlayerType_6month ,
cast(convert(varchar(10), mtx2.DateRangeStart_12month) as datetime)	    		as DateRangeStart_12month ,
cast(convert(varchar(10), mtx2.DateRangeEnd_12month) as datetime)			    as DateRangeEnd_12month ,
cast(convert(varchar(10), mtx.firstPlayDate_last12Months) as datetime)			as playerfirstdate_12month ,
cast(convert(varchar(10), mtx.lastPlayDate_last12Months) as datetime)			as playerlastdate_12month ,
isnull(mtx.slotTheo_last12Months, 0)											as Slot_Theo_12month ,
isnull(mtx.tableTheo_last12Months, 0)											as Table_Theo_12month ,
isnull(mtx.BingoTheo_last12Months, 0)											as Bingo_Theo_12month ,
isnull(mtx.totalTheo_last12Months, 0)                                     	    as Total_Theo_12month ,
isnull(mtx.dailyWorth_last12Months, 0)											as worth_Gross_12month ,
isnull(mtx.trips_last12Months, 0)												as visits_12month ,
isnull(mtx.award_FPUsed_last12Months, 0)										as FP_12month ,
isnull(mtx.ADT_GrossFP_last12Months, 0)											as ADT_GrossFP_12month ,
isnull(mtx.ADW_GrossFP_last12Months, 0)											as ADW_GrossFP_12month ,
isnull(mtx.AMV_Last12Months, 0)													as AMV_12month ,
isnull(mtx.AMT_GrossFP_last12Months, 0)											as AMT_GrossFP_12month ,
isnull(mtx.AMW_GrossFP_last12Months, 0)											as AMW_Gross_12month ,
isnull(mtx.totalTheo_last12Months, 0) - isnull(mtx.ADW_NetFP_last12Months, 0)	as NetTheo_12month ,
isnull(mtx.actualWinLoss_last12Months, 0)										as NetActualWin_12month ,
isnull(mtx.ADT_NetFP_last12Months, 0)											as ADT_NetFP_12month ,
isnull(mtx.ADW_NetFP_last12Months, 0)						    				as ADW_NetFP_12month ,
isnull(mtx.ADP_last12Months, 0)													as ADP_12month ,
isnull(mtx.AMT_NetFP_last12Months, 0)											as AMT_NetFP_12month ,
isnull(mtx.AMW_NetFP_last12Months, 0)											as AMW_NetFP_12month ,
isnull(mtx.AMP_last12Months, 0)													as AMP_12month ,
isnull(mtx2.ADW_NetFP_Category_12month, 'N/A')									as ADW_NetFP_Category_12month ,
isnull(mtx2.AMW_NetFP_Category_12month, 'N/A')									as AMW_NetFP_Category_12month ,
isnull(mtx.PlayerType_Last12Months, 'N/A')										as PlayerType_12month ,
pd.CompReinvestHist                                                             as CompReinvestHist,
pd.CompReinvestHistNoHotel                                                      as CompReinvestHistNoHotel

FROM player.tab_player_dim pd (nolock)

--LEFT JOIN player.tab_geo_dim d (nolock)
LEFT JOIN VCR.tab_geo_dim geo (nolock)
ON substring(pd.player_zip, 1, 5) = geo.geo_zip

LEFT JOIN v_IQ_Marketing_Metrics mtx
ON pd.player_id = mtx.PlayerID

LEFT JOIN v_IQ_Marketing_Metrics_EXT mtx2
ON pd.player_id = mtx2.PlayerID

WHERE pd.player_last_name not in ('*Table', 'giftcard')
AND pd.player_account_number <> 0
AND pd.player_type <> 'Viejas Gift Card'
GO


