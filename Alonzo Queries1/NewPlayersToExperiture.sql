
--- Query Provided by Greg on 04/30
select count(*) 
from vdw.tableau.player_dim
where (player_last_trip_date >= dateadd(mm, -13, getdate()) or 
(player_last_trip_date >= dateadd(mm, -36, getdate())
       and player_isemailsend = 1)
       and player_account_number in (select player_account_number 
                                         from vDW.tableau.player_daily_fact 
                                         where gaming_date >= dateadd(mm, -36, getdate())
                                         group by player_account_number
                                         having sum(slot_theo_win + table_theo_win + other_theo_win) >100))
and player_isbanned = 0 
and player_address1 is not null 
AND player_zip is not null
and player_club_level not in ('GIFTCARD', 'INACTIVE')




--- UPDATES TO EXISTING
SELECT 
	  --[PLAYER_KEY]
      ---[player_id]
      [player_account_number]
      ,[player_first_name]
      ,[player_last_name]
      ,[player_display_name]
      ,[player_type]
      ,[player_club_level]
      ,[player_club_anniversary]
      ,[player_signup_date]
      ,[player_address1]
      ,[player_address2]
      ,[player_city]
      ,[player_state]
      ,[player_zip]
      ,[player_country]
      ,[player_email]
      ,[player_phone]
      ,[player_birthdate]
      ,[player_gender]
      ,[player_host]
      ,[player_host_coded_date]
      ,[player_first_trip_date]
      ,[player_last_trip_date]
      ,[player_age]
      ,[player_age_category]
      ,[player_gaming_type]
      ,[player_slot_type]
      ,[player_table_type]
      ,[player_isbanned]
      ,[player_isinactive]
      ,[player_isclubhold]
      ,[player_isnomail]
      ,[player_isreturnmail]
      ,[player_isemailsend]
      ,[player_frequency]
      ,[player_adt_category]
      ,[player_lifecycle]
      ,[player_point_bal]
      ,[player_stub_bal]
      ,[player_promo2_bal]
      ,[player_FPC_bal]
      ,[Player_Points_Bal_Custom] AS points_bal_club
      ,[behavior_trip]
      ,[player_geo_city]
      ,[player_geo_county]
      ,[player_geo_state]
      ,[player_geo_country]
      ,[player_geo_distance]
      ,[player_geo_distance_category]
      ,[player_geo_distance_subcategory]
      ,[player_geo_population]
      ,[player_geo_market]
      ,[relationship_length]
      ,[DateRangeStart_3monthLGD]
      ,[DateRangeEnd_3monthLGD]
      ,[playerfirstdate_3monthLGD]
      ,[playerlastdate_3monthLGD]
      ,[Slot_Theo_3monthLGD]
      ,[Table_Theo_3monthLGD]
      ,[Bingo_Theo_3monthLGD]
      ,[Total_Theo_3monthLGD]
      ,[worth_Gross_3monthLGD]
      ,[visits_3monthLGD]
      ,[FP_3monthLGD]
      ,[ADT_GrossFP_3monthLGD]
      ,[ADW_GrossFP_3monthLGD]
      ,[AMV_3monthLGD]
      ,[AMT_GrossFP_3monthLGD]
      ,[AMW_Gross_3monthLGD]
      ,[NetTheo_3monthLGD]
      ,[NetActualWin_3monthLGD]
      ,[ADT_NetFP_3monthLGD]
      ,[ADW_NetFP_3monthLGD]
      ,[ADP_3monthLGD]
      ,[AMT_NetFP_3monthLGD]
      ,[AMW_NetFP_3monthLGD]
      ,[AMP_3monthLGD]
      ,[ADW_NetFP_Category_3monthLGD]
      ,[AMW_NetFP_Category_3monthLGD]
      ,[PlayerType_3monthLGD]
      ,[SlotNetActualWin_3monthLGD]
      ,[TableNetActualWin_3monthLGD]
      ,[OtherNetActualWin_3monthLGD]
      ,[CompWorth_3monthLGD]
      ,[CompUsed_3monthLGD]
      ,[DateRangeStart_3month]
      ,[DateRangeEnd_3month]
      ,[playerfirstdate_3month]
      ,[playerlastdate_3month]
      ,[Slot_Theo_3month]
      ,[Table_Theo_3month]
      ,[Bingo_Theo_3month]
      ,[Total_Theo_3month]
      ,[worth_Gross_3month]
      ,[visits_3month]
      ,[FP_3month]
      ,[ADT_GrossFP_3month]
      ,[ADW_GrossFP_3month]
      ,[AMV_3month]
      ,[AMT_GrossFP_3month]
      ,[AMW_Gross_3month]
      ,[NetTheo_3month]
      ,[NetActualWin_3month]
      ,[ADT_NetFP_3month]
      ,[ADW_NetFP_3month]
      ,[ADP_3month]
      ,[AMT_NetFP_3month]
      ,[AMW_NetFP_3month]
      ,[AMP_3month]
      ,[ADW_NetFP_Category_3month]
      ,[AMW_NetFP_Category_3month]
      ,[PlayerType_3month]
  	  ,player_last_club_level as player_last_club_Level---lastClubLevel
	  ,'' as player_club_level_change_date---clublLevelChangeDate
	  ,player_comp_bal as player_comp_bal
	  ,'' as player_comp_bal_Exp7Days
	  ,'' as player_fpc_bal_Exp7Days
	  ,'' as player_fpc2_bal
	  ,'' as player_fpc2_bal_Exp7Days
	  ,rq.Points_To_Current_Requal_Upgrade_Tier as player_tierpoints_bal
	  ,rq.Current_Requal_Valid_Through_Date as player_tierExpiration
	  ,rq.Current_Requal_Message_YN as Current_Requal_Message_YN
	  ,rq.Current_Requal_Qualification_Period_Start_Date as Current_Requal_Qualification_Period_Start_Date
	  ,rq.Current_Requal_Qualification_Period_End_Date as Current_Requal_Qualification_Period_End_Date
	  ,rq.Current_Requal_Valid_Through_Date as Current_Requal_Valid_Through_Date
	  ,rq.Current_Requal_Tier as Current_Requal_Tier
	  ,rq.Current_Requal_Upgrade_Tier as Current_Requal_Upgrade_Tier
	  ,rq.Points_To_Current_Requal_Upgrade_Tier as Points_To_Current_Requal_Upgrade_Tier
	  ,rq.Next_Requal_Qualification_Period_Start_Date as Next_Requal_Qualification_Period_Start_Date
	  ,rq.Next_Requal_Qualification_Period_End_Date as Next_Requal_Qualification_Period_End_Date
	  ,rq.Next_Requal_Date as Next_Requal_Date
	  ,rq.Next_Requal_Tier as Next_Requal_Tier
	  ,rq.Next_Requal_Upgrade_Message_YN as Next_Requal_Upgrade_Message_YN
	  ,rq.Next_Requal_Upgrade_Tier as Next_Requal_Upgrade_Tier
	  ,rq.Points_To_Next_Requal_Upgrade_Tier as Points_To_Next_Requal_Upgrade_Tier
	  ,rq.Points_To_Next_Requal_Upgrade_Tier_Percentage as Points_To_Next_Requal_Upgrade_Tier_Percentage
	  ,rq.Next_Requal_Play_Through_Date as Next_Requal_Play_Through_Date

  FROM [vDW].[tableau].[player_dim] pd
  left join [RequalDB].[dbo].[MV_Requal_Meter_Data_Export] rq on pd.player_account_number = rq.Acct

  where (player_last_trip_date >= dateadd(mm, -13, getdate()) or 
(player_last_trip_date >= dateadd(mm, -36, getdate())
       and player_isemailsend = 1)
       and player_account_number in (select player_account_number 
                                         from vDW.tableau.player_daily_fact 
                                         where gaming_date >= dateadd(mm, -36, getdate())
                                         group by player_account_number
                                         having sum(slot_theo_win + table_theo_win + other_theo_win) >100))
and player_isbanned = 0 
and player_address1 is not null 
AND player_zip is not null
and player_club_level not in ('GIFTCARD', 'INACTIVE')



--- OLD WHERE CLAUSE
----where player_signup_date >= '01/01/2019' 
----	and player_isbanned = 0 
----	and player_isclubhold = 0
----	and ((player_zip is not null and len(player_zip)>0) or (player_email is not null and player_email<>'NO@VIEJAS.COM')) 













select count(*) from Campaign.dbo.ExPlayers
where PlayerAccount=21154577

order by DateCreated desc

--Drop Table #ExpExport


select player_club_level, count(*) from #ExpExport
group by player_club_level

Go

select player_club_level, count(*) from vdw.tableau.player_dim
group by player_club_level


select *  from vdw.tableau.player_dim
where player_club_level='PLATINUM' and player_account_number not in
(select player_account_number from #ExpExport)



