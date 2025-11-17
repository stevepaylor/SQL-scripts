USE [iQ-Gaming] ;
GO

DROP TABLE IF EXISTS ##Compare_old_and_new_player_dim_views ;
GO

SELECT --TOP 10 
  '[iQ-Gaming].[Tableau].[player_dim]' as view_name
--, m.*
--, m.PLAYER_KEY
, m.player_id
--, m.player_account_number
--, m.player_first_name
--, m.player_last_name
--, m.player_display_name
--, m.player_type
--, m.player_club_level
--, m.player_club_anniversary
--, m.player_last_club_level
--, m.player_club_level_change_date
--, m.player_signup_date
--, m.player_address1
--, m.player_address2
--, m.player_city
--, m.player_state
--, m.player_zip
--, m.player_country
--, m.player_email
--, m.player_phone
--, m.player_birthdate
--, m.player_gender
--, m.player_host
--, m.player_host_coded_date
--, m.player_first_trip_date
--, m.player_last_trip_date
--, m.player_age
--, m.player_age_category
, m.player_gaming_type
, m.player_slot_type
, m.player_table_type
, m.player_isbanned
, m.player_isinactive
, m.player_isclubhold
, m.player_isnomail
, m.player_isreturnmail
, m.player_isemailsend
, m.player_iscall
, m.player_issendtextmessage
, m.player_frequency
, m.player_adt_category
, m.player_lifecycle
, m.player_point_bal
, m.player_stub_bal
, m.player_promo2_bal
, m.player_FPC_bal
, m.player_points_bal_custom
, m.player_comp_bal
, m.behavior_trip
, m.player_geo_city
, m.player_geo_county
, m.player_geo_state
, m.player_geo_country
, m.player_geo_distance
, m.player_geo_distance_category
, m.player_geo_distance_subcategory
, m.player_geo_population
, m.player_geo_market
, m.relationship_length
, m.DateRangeStart_3monthLGD
, m.DateRangeEnd_3monthLGD
, m.playerfirstdate_3monthLGD
, m.playerlastdate_3monthLGD
, m.Slot_Theo_3monthLGD
, m.Table_Theo_3monthLGD
, m.Bingo_Theo_3monthLGD
, m.Total_Theo_3monthLGD
, m.worth_Gross_3monthLGD
, m.visits_3monthLGD
, m.FP_3monthLGD
, m.ADT_GrossFP_3monthLGD
, m.ADW_GrossFP_3monthLGD
, m.AMV_3monthLGD
, m.AMT_GrossFP_3monthLGD
, m.AMW_Gross_3monthLGD
, m.NetTheo_3monthLGD
, m.NetActualWin_3monthLGD
, m.ADT_NetFP_3monthLGD
, m.ADW_NetFP_3monthLGD
, m.ADP_3monthLGD
, m.AMT_NetFP_3monthLGD
, m.AMW_NetFP_3monthLGD
, m.AMP_3monthLGD
, m.ADW_NetFP_Category_3monthLGD
, m.AMW_NetFP_Category_3monthLGD
, m.PlayerType_3monthLGD
, m.SlotNetActualWin_3monthLGD
, m.TableNetActualWin_3monthLGD
, m.OtherNetActualWin_3monthLGD
, m.CompWorth_3monthLGD
, m.CompUsed_3monthLGD
, m.DateRangeStart_3month
, m.DateRangeEnd_3month
, m.playerfirstdate_3month
, m.playerlastdate_3month
, m.Slot_Theo_3month
, m.Table_Theo_3month
, m.Bingo_Theo_3month
, m.Total_Theo_3month
, m.worth_Gross_3month
, m.visits_3month
, m.FP_3month
, m.ADT_GrossFP_3month
, m.ADW_GrossFP_3month
, m.AMV_3month
, m.AMT_GrossFP_3month
, m.AMW_Gross_3month
, m.NetTheo_3month
, m.NetActualWin_3month
, m.ADT_NetFP_3month
, m.ADW_NetFP_3month
, m.ADP_3month
, m.AMT_NetFP_3month
, m.AMW_NetFP_3month
, m.AMP_3month
, m.ADW_NetFP_Category_3month
, m.AMW_NetFP_Category_3month
, m.PlayerType_3month
, m.DateRangeStart_6month
, m.DateRangeEnd_6month
, m.playerfirstdate_6month
, m.playerlastdate_6month
, m.Slot_Theo_6month
, m.Table_Theo_6month
, m.Bingo_Theo_6month
, m.Total_Theo_6month
, m.worth_Gross_6month
, m.visits_6month
, m.FP_6month
, m.ADT_GrossFP_6month
, m.ADW_GrossFP_6month
, m.AMV_6month
, m.AMT_GrossFP_6month
, m.AMW_Gross_6month
, m.NetTheo_6month
, m.NetActualWin_6month
, m.ADT_NetFP_6month
, m.ADW_NetFP_6month
, m.ADP_6month
, m.AMT_NetFP_6month
, m.AMW_NetFP_6month
, m.AMP_6month
, m.ADW_NetFP_Category_6month
, m.AMW_NetFP_Category_6month
, m.PlayerType_6month
, m.DateRangeStart_12month
, m.DateRangeEnd_12month
, m.playerfirstdate_12month
, m.playerlastdate_12month
, m.Slot_Theo_12month
, m.Table_Theo_12month
, m.Bingo_Theo_12month
, m.Total_Theo_12month
, m.worth_Gross_12month
, m.visits_12month
, m.FP_12month
, m.ADT_GrossFP_12month
, m.ADW_GrossFP_12month
, m.AMV_12month
, m.AMT_GrossFP_12month
, m.AMW_Gross_12month
, m.NetTheo_12month
, m.NetActualWin_12month
, m.ADT_NetFP_12month
, m.ADW_NetFP_12month
, m.ADP_12month
, m.AMT_NetFP_12month
, m.AMW_NetFP_12month
, m.AMP_12month
, m.ADW_NetFP_Category_12month
, m.AMW_NetFP_Category_12month
, m.PlayerType_12month
, m.CompReinvestHist
, m.CompReinvestHistNoHotel

--INTO ##Compare_old_and_new_player_dim_views

FROM [iQ-Gaming].[Tableau].[player_dim] as m

INNER JOIN MSBIDB02DV.VDW.tableau.player_dim t
ON m.player_id = t.player_id

WHERE t.player_gaming_type IS NOT NULL
   OR m.player_gaming_type IS NOT NULL
   --AND
   --(t.player_club_level_change_date IS NOT NULL
   -- OR m.player_club_level_change_date IS NOT NULL)

UNION ALL

SELECT --TOP 10 
  'MSBIDB02DV.vDW.tableau.player_dim' as view_name
--, t.*
--, t.PLAYER_KEY
, t.player_id
--, t.player_account_number
--, t.player_first_name
--, t.player_last_name
--, t.player_display_name
--, t.player_type
--, t.player_club_level
--, t.player_club_anniversary
--, t.player_last_club_level
--, t.player_club_level_change_date
--, t.player_signup_date
--, t.player_address1
--, t.player_address2
--, t.player_city
--, t.player_state
--, t.player_zip
--, t.player_country
--, t.player_email
--, t.player_phone
--, t.player_birthdate
--, t.player_gender
--, t.player_host
--, t.player_host_coded_date
--, t.player_first_trip_date
--, t.player_last_trip_date
--, t.player_age
--, t.player_age_category
, t.player_gaming_type
, t.player_slot_type
, t.player_table_type
, t.player_isbanned
, t.player_isinactive
, t.player_isclubhold
, t.player_isnomail
, t.player_isreturnmail
, t.player_isemailsend
, t.player_iscall
, t.player_issendtextmessage
, t.player_frequency
, t.player_adt_category
, t.player_lifecycle
, t.player_point_bal
, t.player_stub_bal
, t.player_promo2_bal
, t.player_FPC_bal
, t.player_points_bal_custom
, t.player_comp_bal
, t.behavior_trip
, t.player_geo_city
, t.player_geo_county
, t.player_geo_state
, t.player_geo_country
, t.player_geo_distance
, t.player_geo_distance_category
, t.player_geo_distance_subcategory
, t.player_geo_population
, t.player_geo_market
, t.relationship_length
, t.DateRangeStart_3monthLGD
, t.DateRangeEnd_3monthLGD
, t.playerfirstdate_3monthLGD
, t.playerlastdate_3monthLGD
, t.Slot_Theo_3monthLGD
, t.Table_Theo_3monthLGD
, t.Bingo_Theo_3monthLGD
, t.Total_Theo_3monthLGD
, t.worth_Gross_3monthLGD
, t.visits_3monthLGD
, t.FP_3monthLGD
, t.ADT_GrossFP_3monthLGD
, t.ADW_GrossFP_3monthLGD
, t.AMV_3monthLGD
, t.AMT_GrossFP_3monthLGD
, t.AMW_Gross_3monthLGD
, t.NetTheo_3monthLGD
, t.NetActualWin_3monthLGD
, t.ADT_NetFP_3monthLGD
, t.ADW_NetFP_3monthLGD
, t.ADP_3monthLGD
, t.AMT_NetFP_3monthLGD
, t.AMW_NetFP_3monthLGD
, t.AMP_3monthLGD
, t.ADW_NetFP_Category_3monthLGD
, t.AMW_NetFP_Category_3monthLGD
, t.PlayerType_3monthLGD
, t.SlotNetActualWin_3monthLGD
, t.TableNetActualWin_3monthLGD
, t.OtherNetActualWin_3monthLGD
, t.CompWorth_3monthLGD
, t.CompUsed_3monthLGD
, t.DateRangeStart_3month
, t.DateRangeEnd_3month
, t.playerfirstdate_3month
, t.playerlastdate_3month
, t.Slot_Theo_3month
, t.Table_Theo_3month
, t.Bingo_Theo_3month
, t.Total_Theo_3month
, t.worth_Gross_3month
, t.visits_3month
, t.FP_3month
, t.ADT_GrossFP_3month
, t.ADW_GrossFP_3month
, t.AMV_3month
, t.AMT_GrossFP_3month
, t.AMW_Gross_3month
, t.NetTheo_3month
, t.NetActualWin_3month
, t.ADT_NetFP_3month
, t.ADW_NetFP_3month
, t.ADP_3month
, t.AMT_NetFP_3month
, t.AMW_NetFP_3month
, t.AMP_3month
, t.ADW_NetFP_Category_3month
, t.AMW_NetFP_Category_3month
, t.PlayerType_3month
, t.DateRangeStart_6month
, t.DateRangeEnd_6month
, t.playerfirstdate_6month
, t.playerlastdate_6month
, t.Slot_Theo_6month
, t.Table_Theo_6month
, t.Bingo_Theo_6month
, t.Total_Theo_6month
, t.worth_Gross_6month
, t.visits_6month
, t.FP_6month
, t.ADT_GrossFP_6month
, t.ADW_GrossFP_6month
, t.AMV_6month
, t.AMT_GrossFP_6month
, t.AMW_Gross_6month
, t.NetTheo_6month
, t.NetActualWin_6month
, t.ADT_NetFP_6month
, t.ADW_NetFP_6month
, t.ADP_6month
, t.AMT_NetFP_6month
, t.AMW_NetFP_6month
, t.AMP_6month
, t.ADW_NetFP_Category_6month
, t.AMW_NetFP_Category_6month
, t.PlayerType_6month
, t.DateRangeStart_12month
, t.DateRangeEnd_12month
, t.playerfirstdate_12month
, t.playerlastdate_12month
, t.Slot_Theo_12month
, t.Table_Theo_12month
, t.Bingo_Theo_12month
, t.Total_Theo_12month
, t.worth_Gross_12month
, t.visits_12month
, t.FP_12month
, t.ADT_GrossFP_12month
, t.ADW_GrossFP_12month
, t.AMV_12month
, t.AMT_GrossFP_12month
, t.AMW_Gross_12month
, t.NetTheo_12month
, t.NetActualWin_12month
, t.ADT_NetFP_12month
, t.ADW_NetFP_12month
, t.ADP_12month
, t.AMT_NetFP_12month
, t.AMW_NetFP_12month
, t.AMP_12month
, t.ADW_NetFP_Category_12month
, t.AMW_NetFP_Category_12month
, t.PlayerType_12month
, t.CompReinvestHist
, t.CompReinvestHistNoHotel

FROM MSBIDB02DV.vDW.tableau.player_dim t

JOIN myviejas.player_dim m
ON t.player_id = m.player_id 

WHERE (m.player_gaming_type IS NOT NULL AND m.player_gaming_type <> ' ')
   OR (t.player_gaming_type IS NOT NULL AND t.player_gaming_type <> ' ')

ORDER BY 
  player_id ;
--, m.player_id ;

GO

SELECT DISTINCT  TOP 100 *
FROM ##Compare_old_and_new_player_dim_views

WHERE (m.player_gaming_type IS NOT NULL AND m.player_gaming_type <> ' ')
   OR (t.player_gaming_type IS NOT NULL AND t.player_gaming_type <> ' ')

ORDER BY
  player_id desc
, view_name desc


