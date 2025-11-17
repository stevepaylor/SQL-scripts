SELECT [Table]
      ,[Schema]
      ,[Database]
      ,[Server]
      ,[QueryGroup]
      ,[InactiveFlag]
      ,[WhereClause]
      ,[Comments]
      ,[ModifiedDTTM]
      ,[ModifiedBy]
      ,[MinMaxField1]
      ,[MinMaxField2]
      ,[CountDistinctField1]
      ,[CountDistinctField2]
 FROM [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]



WHERE [Table] LIKE ''
--WHERE [Table] LIKE 'Website_Tag_List'
--WHERE [Table] LIKE 'tab_table_dim'
--WHERE [Table] LIKE 'tab_rating_fact'
--WHERE [Table] LIKE 'tab_player_id_pull'
--WHERE [Table] LIKE 'tab_player_hist_dim'
--WHERE [Table] LIKE 'tab_player_dim'
--WHERE [Table] LIKE 'tab_offer_fact_redeem'
--WHERE [Table] LIKE 'tab_offer_fact'
--WHERE [Table] LIKE 'tab_offer_dim'
--WHERE [Table] LIKE 'tab_monthly_fact'
--WHERE [Table] LIKE 'tab_merge_dim'
--WHERE [Table] LIKE 'tab_machine_dim'
--WHERE [Table] LIKE 'tab_geo_dim'
--WHERE [Table] LIKE 'tab_general_dates'
--WHERE [Table] LIKE 'tab_datetime_tracker'
--WHERE [Table] LIKE 'tab_daily_fact'
--WHERE [Table] LIKE 'tab_award_fact'
--WHERE [Table] LIKE 'tab_award_daily_fact'
--WHERE [Table] LIKE 'tab_aggregate_%'
--WHERE [Table] LIKE 'NAME_RESERVATION'
--WHERE [Table] LIKE 'HotelCompRate'


--UPDATE [SystemMaintDB].[dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2]
--SET 
--  [MinMaxField1] = 'TagCode'
--, [MinMaxField2] = 'Valid_BeginDate'
--, [CountDistinctField1] = 'OfferDescription1'
--, [CountDistinctField2] = 'OfferCategory'

-- WHERE [Table] LIKE 'Website_Tag_List'

	  
--WHERE [Table] IN
--  (
------'HotelCompRate'
------,'NAME_RESERVATION'
------,'tab_aggregate_12month'
------,'tab_aggregate_3month'
------,'tab_aggregate_3month_LGD'
------,'tab_aggregate_3month_LGD_players'
------,'tab_aggregate_6month'
------,'tab_award_daily_fact'
------,'tab_award_fact'
------,'tab_club_history'   --- CAN'T FIND THIS TABLE ANYWHERE
------,'tab_club_level_config'
------,'tab_daily_fact'
------,'tab_datetime_tracker'
------,'tab_general_dates'
------,'tab_geo_dim'
------,'tab_merge_dim'
------,'tab_monthly_fact'
------,'tab_offer_dim'
------,'tab_offer_fact'
------,'tab_offer_fact_redeem'
------,'tab_player_dim'
------,'tab_player_hist_dim'
------,'tab_player_id_pull'
------,'tab_rating_fact'
------,'tab_table_dim'
--,'Website_Tag_List'

--,'tAccum1DayPts'
--,'tAccumKey'
--,'tArea'
--,'tAwards'
--,'tDenom'
--,'tDept'
--,'tEmp'
--,'tGame'
--,'tGroup'
--,'tLocn'
--,'tPlayer'
--,'tPlayerAddress'
--,'tPlayerAttributeDtl'
--,'tPlayerCard'
--,'tPlayerCasino'
--,'tPlayerCasinoHost'
--,'tPlayerComps'
--,'tPlayerEmail'
--,'tPlayerPhone'
--,'tPlayerPointBal'
--,'tPlayerPoints'
--,'tPlayerPromo1'
--,'tPlayerPromo1Bal'
--,'tPlayerPromo2Bal'
--,'tPlayerStubBal'
--,'tPlayerTag'
--,'tPrize'
--,'tRetired'
--,'tSlotRating'
--,'tSportsRating'
--,'tState'
--,'tTableRating'
--,'tTag'
--,'tTranCode'

--,'v_ADT_category'
--,'v_age_category'
--,'v_agg_days_frequency'
--,'v_agg_theo_days_by_type'
--,'v_frequency'
--,'viewPlayersViejas'
--,'Website_Tag_List'
--)
