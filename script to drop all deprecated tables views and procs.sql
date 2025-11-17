DROP TABLE [deprecated].[OfferDetail]
GO



SELECT 'DROP TABLE deprecated.' + [name]
FROM sys.tables
where schema_id = 21

SELECT [name], *
FROM sys.schemas

DROP TABLE deprecated.tab_aggregate_3month_LGD_players ; 
GO ;
DROP TABLE deprecated.tab_aggregate_6month
DROP TABLE deprecated.tab_machine_dim
DROP TABLE deprecated.tab_daily_perf_fact
DROP TABLE deprecated.offer_removal
DROP TABLE deprecated.tab_general_dates
DROP TABLE deprecated.tab_merge_dim
DROP TABLE deprecated.tab_monthly_fact
DROP TABLE deprecated.IQC_Player_dbo
DROP TABLE deprecated.IQC_Player_Host
DROP TABLE deprecated.tab_datetime_tracker
DROP TABLE deprecated.tab_player_id_pull
DROP TABLE deprecated.JL_Test_CI
DROP TABLE deprecated.tab_aggregate_12month
DROP TABLE deprecated.tab_geo_dim
DROP TABLE deprecated.tab_award_fact
DROP TABLE deprecated.tab_offer_fact_redeem
DROP TABLE deprecated.tAwards_OLD
DROP TABLE deprecated.tab_offer_dim
DROP TABLE deprecated.tab_offer_fact
DROP TABLE deprecated.v_daily_fact_all_records
DROP TABLE deprecated.tab_aggregate_3month_SAVE
DROP TABLE deprecated.up_player_dim_maint
DROP TABLE deprecated.update_award_daily_fact
DROP TABLE deprecated.update_award_fact
DROP TABLE deprecated.tab_aggregate_3month
DROP TABLE deprecated.tab_aggregate_3month_LGD
DROP TABLE deprecated.T0910000000BEHDNUTEA3DQTC5I
DROP TABLE deprecated.tab_club_level_config

ALTER TABLE [deprecated].[IQC_Player_Host] SET ( SYSTEM_VERSIONING = OFF )
GO

SELECT 'DROP VIEW deprecated.' + [name]
FROM sys.views
where schema_id = 21

DROP VIEW deprecated.v_PlayerBalances
DROP VIEW deprecated.v_IQC_BUS_Player_Daily_Totals_AcctDay_old
DROP VIEW deprecated.v_IQC_Slot_CoinIn_Summary_PerDay
DROP VIEW deprecated.v_IQH_Hotel_Guests_PerDay
DROP VIEW deprecated.v_IQH_Hotel_Posting_PerDay
DROP VIEW deprecated.v_IQB_Transactions_PerDay
DROP VIEW deprecated.v_IQB_Transaction_Detail_PerDay
DROP VIEW deprecated.v_IQP_Sales
DROP VIEW deprecated.v_IQC_Player
DROP VIEW deprecated.v_agg_theo_days_by_type
DROP VIEW deprecated.v_ADT_category
DROP VIEW deprecated.v_agg_days_frequency
DROP VIEW deprecated.V_IQC_Player_Tiers
DROP VIEW deprecated.v_frequency
DROP VIEW deprecated.V_IQC_Player_Balances
DROP VIEW deprecated.v_iQC_Offers_Gaming
DROP VIEW deprecated.v_iqc_player_address
DROP VIEW deprecated.v_iQC_Offers_Live
DROP VIEW deprecated.[v_IQC_BUS_Player_Daily_Totals_AcctDay _PerDay]
DROP VIEW deprecated.[v_IQC_BUS_Player_Daily_Totals_GameDay _PerDay]
DROP VIEW deprecated.vw_IQH_Revenue_Postings_test2
DROP VIEW deprecated.v_IQC_Comps
DROP VIEW deprecated.v_relationship_length
DROP VIEW deprecated.v_PlayerOffers
DROP VIEW deprecated.v_IQC_Comps_GameDay
DROP VIEW deprecated.v_IQC_Player_Daily_Totals_GameDay
DROP VIEW deprecated.v_IQC_Comps1
DROP VIEW deprecated.v_age_category
DROP VIEW deprecated.v_iQC_tPlayer_ClubState
DROP VIEW deprecated.V_IQC_Player_TierPoints
DROP VIEW deprecated.vw_IQH_Revenue_Postings_test
DROP VIEW deprecated.V_iQC_Awards_by_month_Dev
DROP VIEW deprecated.V_iQC_Awards_by_month_20220106
DROP VIEW deprecated.V_iQC_Awards_by_month_Dev_20220106

SELECT 'DROP PROCEDURE deprecated.' + [name]
FROM sys.procedures
where schema_id = 21

DROP PROCEDURE deprecated.sp_IQC_Rebuild_Player_Daily_Totals_GameDay_TripNumber
DROP PROCEDURE deprecated.sp_Push_IQC_Offers_live
DROP PROCEDURE deprecated.sp_Update_IQC_Player_ID
DROP PROCEDURE deprecated.sp_Update_IQC_Player_Trips_AcctDay
DROP PROCEDURE deprecated.sp_Update_IQC_Player_Trips_GameDay
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_ID
DROP PROCEDURE deprecated.[sp_Opera_Update_IQH_Hotel_Guests_05/09/2022]
DROP PROCEDURE deprecated.sp_IG_Business_Custom_Update_Tender_PlayerID
DROP PROCEDURE deprecated.sp_Extract_Awards_Data2
DROP PROCEDURE deprecated.usp_NAME_RESERVATIONS_DELTA_UPSERT
DROP PROCEDURE deprecated.usp_NAME_RESERVATIONS_DELTA_UPSERT_2
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_PointsBal
DROP PROCEDURE deprecated.[sp_Opera_Update_IQH_Hotel_Guests_05/10/2022]
DROP PROCEDURE deprecated.sp_SDS_Update_IQC_Slot_Accounting_20220627
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20211215
DROP PROCEDURE deprecated.usp_Snapshot_Refresh_RESERVATIONS
DROP PROCEDURE deprecated.sp_Extract_Slot_Rating_Data_20220511
DROP PROCEDURE deprecated.sp_Extract_Slot_Accounting_Data_20220126
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Offers_Live
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20211207
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Comp_Dimensions
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Comps
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player
DROP PROCEDURE deprecated.proc_general_dates_update
DROP PROCEDURE deprecated.sp_Extract_Table_Rating_Data_20220511
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Address
DROP PROCEDURE deprecated.sp_Opera_Update_IQH_Hotel_Guests_20220608
DROP PROCEDURE deprecated.sp_Extract_Sports_Rating_Data_20220511
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Host
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Ratings
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Ratings_EXT
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Offer_Detail
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Players_Club
DROP PROCEDURE deprecated.sp_SDS_Update_IQC_Slot_Accounting_20220126
DROP PROCEDURE deprecated.proc_etl_tab_award_fact_read_old
DROP PROCEDURE deprecated.[sp_Opera_Update_IQH_Hotel_Posting_2022/02/18]
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Offer_History
DROP PROCEDURE deprecated.[sp_Opera_Update_IQH_Hotel_Guests_2022/02/18]
DROP PROCEDURE deprecated.[sp_Opera_Update_IQH_Hotel_Posting_EXT_2022/02/18]
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20220117
DROP PROCEDURE deprecated.proc_comparison_daily_fact_nick
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Tier_Match
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Comps_EXT
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_DEVWITHREVISIONS_MANUAL
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Awards_Dev_MANUAL
DROP PROCEDURE deprecated.usp_Add_Delta_To_FINANCIAL_TRANSACTIONS
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20220104
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20220208
DROP PROCEDURE deprecated.sp_iQC_tPlayer_ClubState_Delta_Load
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Groups
DROP PROCEDURE deprecated.usp_Add_Delta_To_OBI_RESERVATION_STAT_DAILY
DROP PROCEDURE deprecated.usp_Refresh_RESERVATIONS
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_DEVWITHREVISIONS_20220115
DROP PROCEDURE deprecated.sp_IG_Business_Update_Discounts_Renamed
DROP PROCEDURE deprecated.usp_Refresh_ROOM_CATEGORY_TEMPLATE
DROP PROCEDURE deprecated.sp_Opera_Update_IQH_Hotel_Guests_20220212
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Points
DROP PROCEDURE deprecated.sp_MERGE_iQC_Offers_Live_to_REPL_Table
DROP PROCEDURE deprecated.proc_etl_award_fact_PRIZE_BC_C
DROP PROCEDURE deprecated.proc_etl_award_fact_PRIZE_FB_I
DROP PROCEDURE deprecated.proc_etl_award_fact_PRIZE_FP_P
DROP PROCEDURE deprecated.proc_etl_award_fact_PRIZE_PC_V
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_Dev
DROP PROCEDURE deprecated.proc_etl_tab_award_fact_read
DROP PROCEDURE deprecated.proc_etl_tab_monthly_fact_read
DROP PROCEDURE deprecated.proc_maint_award_to_daily_fact
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Awards_Dev
DROP PROCEDURE deprecated.proc_maint_offer_to_daily_fact
DROP PROCEDURE deprecated.proc_maint_rating_to_daily_fact
DROP PROCEDURE deprecated.proc_update_tab_rating_fact_MACHINE_KEY
DROP PROCEDURE deprecated.proc_comparison_daily_fact
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Player_Ticketstubs
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_DEVWITHREVISIONS
DROP PROCEDURE deprecated.sp_Opera_Update_IQH_Hotel_Posting_20222601
DROP PROCEDURE deprecated.sp_Push_IQC_Player
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20211109
DROP PROCEDURE deprecated.sp_CMP_Update_IQC_Awards
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_New
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20220105
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20220124
DROP PROCEDURE deprecated.sp_CMP_Extract_IQC_Awards_To_delete
DROP PROCEDURE deprecated.sp_IQ_Marketing_Metrics_Update
DROP PROCEDURE deprecated.sp_Push_IQC_Player_Balances
DROP PROCEDURE deprecated.sp_IQ_Marketing_Metrics_Update_EXT
DROP PROCEDURE deprecated.sp_Push_IQC_Player_Address
DROP PROCEDURE deprecated.sp_IQC_Player_Daily_Totals_AcctDay_Update
DROP PROCEDURE deprecated.sp_Extract_Awards_Data_20220107
DROP PROCEDURE deprecated.sp_IQC_Player_Daily_Totals_AcctDay_Update_EXT
DROP PROCEDURE deprecated.sp_IQC_Player_Daily_Totals_GameDay_Update
DROP PROCEDURE deprecated.sp_IQC_Player_Daily_Totals_GameDay_Update_EXT
DROP PROCEDURE deprecated.sp_IQC_Player_Trips_AcctDay_Update
DROP PROCEDURE deprecated.sp_IQC_Player_Trips_GameDay_Update
DROP PROCEDURE deprecated.sp_IQC_Rebuild_Player_Daily_Totals_AcctDay_TripNumber