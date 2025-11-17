USE [iQ-Gaming]
GO

/****** Object:  View [Tableau].[player_dim]    Script Date: 5/17/2024 11:23:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 
-- CREATE   VIEW [Tableau].[player_dim]
--AS

SELECT TOP 10000
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
	ISNULL(pd.player_host,'N/A') as player_host,
	pd.player_host_coded_date,
	pd.player_first_trip_date,
	pd.player_last_trip_date,
	--pd.player_age,
	CASE WHEN pd.[player_birthdate] IS NOT NULL THEN FLOOR(datediff(day,pd.[player_birthdate], DATEADD(dd,1, CAST(GETDATE() AS DATE)))/365.25) END AS player_age,
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
	pd.player_ismerge,
	pd.player_frequency,
	pd.player_adt_category,
	pd.player_lifecycle,
	pd.player_point_bal,
	pd.player_stub_bal,
	pd.player_promo2_bal,
	pd.player_FPC_bal,
	pd.points_bal_club															as player_points_bal_custom ,
	pd.player_comp_bal,
	pd.behavior_trip,
	geo.geo_city																as player_geo_city ,
	geo.geo_county																as player_geo_county ,
	geo.geo_state																as player_geo_state ,
	geo.geo_country																as player_geo_country ,
	geo.geo_distance															as player_geo_distance ,
	geo.geo_distance_category													as player_geo_distance_category ,
	geo.geo_distance_subcategory												as player_geo_distance_subcategory ,
	geo.geo_population															as player_geo_population ,
	geo.geo_market                                                              as player_geo_market ,
	CASE 
	  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) < 2 THEN 'New Member'
	  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 2 and 6 THEN '2 - 6 months'
	  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 7 and 12 THEN '6 – 12 months'
	  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 13 and 24 THEN '1 – 2 years'
	  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 25 and 60 THEN '2 – 5 years' 
	  WHEN DATEDIFF(MM, pd.player_signup_date, GETDATE()) BETWEEN 61 and 9999 THEN '5+ years' 
	END                                                                         as relationship_length ,
	CONVERT(DATE, CONVERT(CHAR(8), pd.DateRangeStart_LGD ))						as DateRangeStart_3monthLGD,
	CONVERT(DATE, CONVERT(CHAR(8), pd.DateRangeEnd_LGD ))						as DateRangeEnd_3monthLGD,
	CONVERT(DATE, CONVERT(CHAR(8), pd.playerfirstdate_LGD ))					as playerfirstdate_3monthLGD,
	CONVERT(DATE, CONVERT(CHAR(8), pd.playerlastdate_LGD ))						as playerlastdate_3monthLGD,
	isnull(pd.Slot_Theo_LGD, 0)	     											as Slot_Theo_3monthLGD ,
	isnull(pd.Table_Theo_LGD, 0)												as Table_Theo_3monthLGD ,
	isnull(pd.Bingo_Theo_LGD, 0)												as Bingo_Theo_3monthLGD ,
	isnull(pd.Total_Theo_LGD, 0)												as Total_Theo_3monthLGD ,
	isnull(pd.worth_Gross_LGD, 0)												as worth_Gross_3monthLGD ,
	isnull(pd.visits_LGD, 0)													as visits_3monthLGD ,
	isnull(pd.FP_LGD, 0)														as FP_3monthLGD ,
	isnull(pd.ADT_GrossFP_LGD, 0)												as ADT_GrossFP_3monthLGD ,
	isnull(pd.ADW_GrossFP_LGD, 0)												as ADW_GrossFP_3monthLGD ,
	isnull(pd.AMV_LGD, 0)								    					as AMV_3monthLGD ,
	isnull(pd.AMT_GrossFP_LGD, 0)												as AMT_GrossFP_3monthLGD ,
	isnull(pd.AMW_Gross_LGD, 0)													as AMW_Gross_3monthLGD ,
	isnull(pd.NetTheo_LGD, 0)													as NetTheo_3monthLGD ,
	isnull(pd.NetActualWin_LGD, 0)												as NetActualWin_3monthLGD ,
	isnull(pd.ADT_NetFP_LGD, 0)													as ADT_NetFP_3monthLGD ,
	isnull(pd.ADW_NetFP_LGD, 0)													as ADW_NetFP_3monthLGD ,
	isnull(pd.ADP_LGD, 0)														as ADP_3monthLGD ,
	isnull(pd.AMT_NetFP_LGD, 0)													as AMT_NetFP_3monthLGD ,
	isnull(pd.AMW_NetFP_LGD, 0)													as AMW_NetFP_3monthLGD ,
	isnull(pd.AMP_LGD, 0)														as AMP_3monthLGD ,
	isnull(pd.ADW_NetFP_Category, 'N/A')										as ADW_NetFP_Category_3monthLGD ,
	isnull(pd.AMW_NetFP_Category, 'N/A')										as AMW_NetFP_Category_3monthLGD ,
	isnull(pd.PlayerType_LGD, 'N/A')											as PlayerType_3monthLGD ,
	isnull(pd.SlotNetActualWin_LGD, 0)											as SlotNetActualWin_3monthLGD ,
	isnull(pd.TableNetActualWin_LGD, 0)											as TableNetActualWin_3monthLGD ,
	isnull(pd.OtherNetActualWin_LGD, 0)											as OtherNetActualWin_3monthLGD ,
	CASE 
	   WHEN isnull(pd.Total_Theo_LGD, 0) >= 
		(isnull(pd.SlotNetActualWin_LGD, 0) + isnull(pd.TableNetActualWin_LGD, 0)) 
	  THEN isnull(pd.Total_Theo_LGD, 0) 
	  ELSE isnull(pd.SlotNetActualWin_LGD, 0) + isnull(pd.TableNetActualWin_LGD, 0) 
	END																				as CompWorth_3monthLGD ,
	isnull(pd.compsUsed_LGD, 0)														as CompUsed_3monthLGD ,
	cast(convert(varchar(10), mtx.DateRangeStart_3month) as datetime)				as DateRangeStart_3month ,
	cast(convert(varchar(10), mtx.DateRangeEnd_3month) as datetime)					as DateRangeEnd_3month ,
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
	isnull(mtx.ADW_NetFP_Category_3month, 'N/A')									as ADW_NetFP_Category_3month ,
	isnull(mtx.AMW_NetFP_Category_3month, 'N/A')									as AMW_NetFP_Category_3month ,
	isnull(mtx.PlayerType_Last3Months, 'N/A')										as PlayerType_3month ,
	cast(convert(varchar(10), mtx.DateRangeStart_6month) as datetime)				as DateRangeStart_6month ,
	cast(convert(varchar(10), mtx.DateRangeEnd_6month) as datetime)		    		as DateRangeEnd_6month ,
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
	isnull(mtx.ADW_NetFP_Category_6month, 'N/A')									as ADW_NetFP_Category_6month ,
	isnull(mtx.AMW_NetFP_Category_6month, 'N/A')									as AMW_NetFP_Category_6month ,
	isnull(mtx.PlayerType_Last6Months, 'N/A')										as PlayerType_6month ,
	cast(convert(varchar(10), mtx.DateRangeStart_12month) as datetime)	    		as DateRangeStart_12month ,
	cast(convert(varchar(10), mtx.DateRangeEnd_12month) as datetime)			    as DateRangeEnd_12month ,
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
	isnull(mtx.ADW_NetFP_Category_12month, 'N/A')									as ADW_NetFP_Category_12month ,
	isnull(mtx.AMW_NetFP_Category_12month, 'N/A')									as AMW_NetFP_Category_12month ,
	isnull(mtx.PlayerType_Last12Months, 'N/A')										as PlayerType_12month,
	pd.CompReinvestHist,
	pd.CompReinvestHistNoHotel,
	Case when pd.ADP_LGD >= 1000 then '1.$1000+'
	   	 when pd.ADP_LGD >= 500 then '2.$500 - $999'
		 when pd.ADP_LGD >= 200 then '3.$200 - $499'
		 when pd.ADP_LGD >= 100 then '4.$100 - $199'
		 when pd.ADP_LGD >= 75 then '5.$75 - $99'
		 when pd.ADP_LGD >= 25 then '6.$25 - $74'
		 else '7.$0 - $24' end 
	AS ADP_Segment,
	case when pd.[AMV_LGD] >=10 then '10+'
	   	 when pd.[AMV_LGD] >=6 then '06-9.99'
		 when pd.[AMV_LGD] >=4 then '04-5.99'
		 when pd.[AMV_LGD] >=2 then '02-3.99'
		 else '01-1.99' end 
	AS TripSeg,
	case when mtx.tableTheo_last6Months > 0 then 'Yes' else 'No' end AS 'PlaysTables',
	case when 
		    CONVERT(DATE, CONVERT(CHAR(8), pd.playerlastdate_LGD )) >= DATEADD(month, -6, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) 
			and (geo.geo_distance <=150 or (geo.geo_distance is null and pd.player_state in ('CA','AZ'))) 
			or pd.player_club_level in ('Gold','Platinum','Infinity') 
		 then 'Active'
		 when CONVERT(DATE, CONVERT(CHAR(8), pd.playerlastdate_LGD )) >= DATEADD(month, -12, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) 
		    and (geo.geo_distance <=150 or (geo.geo_distance is null and pd.player_state in ('CA','AZ'))) 
			and (pd.player_isemailsend = 1 or (pd.player_isnomail = 0 and pd.player_isreturnmail = 0)) 
		 then 'Inactive'
		 when CONVERT(DATE, CONVERT(CHAR(8), pd.playerlastdate_LGD )) >= DATEADD(month, -12, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) 
		    and (geo.geo_distance between 150 and 1500) and (pd.player_isemailsend = 1 or (pd.player_isnomail = 0 and pd.player_isreturnmail = 0)) 
		 then 'OuterMarket'
	     else 'DNU' end 
	AS [Activity]
FROM player.tab_player_dim pd (nolock)
LEFT JOIN [VCR].tab_geo_dim geo (nolock) ON substring(pd.player_zip, 1, 5) = geo.geo_zip
LEFT JOIN [dbo].v_IQ_Marketing_Metrics mtx ON pd.player_id = mtx.PlayerID
WHERE pd.player_last_name not in ('*Table', 'giftcard')
AND pd.player_account_number <> 0
AND pd.player_type <> 'Viejas Gift Card'
AND pd.player_ismerge = 0

GO


