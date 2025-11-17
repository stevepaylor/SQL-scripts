--SELECT top 100 [DATE_KEY]
--      ,[MACHINE_KEY]
--      ,[NAMED_ASSET_ID]
--      ,[GAMING_DATE]
--      ,[slot_number]
--      ,[slot_game_type]
--      ,[ASSET_NUMBER]
--      ,[LOCATION]
--      ,[SLOT_STATUS]
--      ,[DENOMINATION]
--      ,[GMU_DENOM]
--      ,[HOLD_PERCENTAGE]
--      ,[MULTI_GAME]
--      ,[MULTI_DENOM]
--      ,[VAR_HOLD_PCT]
--      ,[TYPE_DESC]
--      ,[GAME_TYPE]
--      ,[MAX_COIN_IN]
--      ,[USER_CUSTOM3]
--      ,[USER_CUSTOM5]
--      ,[USER_CUSTOM6]
--      ,[USER_CUSTOM7]
--      ,[USER_CUSTOM8]
--      ,[USER_CUSTOM9]
--      ,[Manufacture]
--      ,[ASST_AREA]
--      ,[ASST_SHORT_AREA]
--      ,[ACNF_ONLINE_DT]
--      ,[ACNT_OFFLINE_DT]
--      ,[ASST_SERIAL_NUMBER]
--      ,[SITE_ID]
--      ,[ZONE_LONG_NAME]
--      ,[BANK_LONG_NAME]
--      ,[MODL_PART_NUMBER]
--      ,[contract_desc]
--      ,[DRPD_COIN_IN]
--      ,[DRPD_COIN_OUT]
--      ,[DRPD_EFT_IN_NCSH]
--      ,[DRPD_EFT_OUT_NCSH]
--      ,[FREEPLAY]
--      ,[HAND_PAYS_AMT]
--      ,[TOTAL_DROP_AMT]
--      ,[ACTUAL_DROP_AMT]
--      ,[SLOT_NET_WIN_AMT]
--      ,[NET_SCALE_WIN_AMT]
--      ,[DRPD_COIN_IN_AMT]
--      ,[DRPD_FILLS_AMT]
--      ,[DAYS_ONLINE]
--      ,[DAYS_ONLINE_MTD]
--      ,[DAYS_ONLINE_LTD]
--      ,[DAYS_OFFLINE]
--      ,[GAMES_PLAYED]
--      ,[SumOfHourlyCoinIn]
--      ,[SumOfHourlyActualWin]
--      ,[SumOfHourlyTheoWin]
--      ,[PARTICIPATION_TYPE_CD]
--      ,[PARTICIPATION_CD]
--      ,[PARTICIPATION_DESC]
--      ,[LEASE_FEES]
--      ,[PARTICIPATION_FEES]
--      ,[TICKET_IN_AMT]
--      ,[TICKET_OUT_AMT]
--      ,[SOFT_COUNT_BILL_DROP]
--      ,[SOFT_COUNT_VOUCHER_DROP]
--      ,[Bets]
--      ,[Wins]
--      ,[Meter_Win_Expense]
--      ,[Meter_Win]
--      ,[Bill_Drop]
--      ,[Total_Drop]
--      ,[Progressive_Jackpot]
--      ,[Total_Hand_Pay]
--  FROM [vDW].[tableau].[slot_daily_perf_fact_online]
--  where Bank_LONG_NAME='AA' and gaming_date between '2020-02-01' and '2020-02-29' 
--  and SLOT_STATUS='ONLINE' and LOCATION='A-A-16'

  
  select  [Zone_LONG_NAME],[Bank_Long_Name], Slot_Number, Location,DENOMINATION, Asst_SERIAL_Number,[Hold_Percentage],
		Manufacture,
		MODL_PART_NUMBER ,
		Slot_Game_Type,
		TYPE_DESC,
		Contract_Desc,
		[PARTICIPATION_TYPE_CD]
  
  INTO #CurrentMachines
  from [vDW].[tableau].[slot_daily_perf_fact_online] tv1 where gaming_date='2020-02-29' and SLOT_STATUS='ONLINE'

  SELECT 
		[Zone_LONG_NAME] as Zone,
		[Bank_Long_Name] as Bank,
		Slot_Number,
		Location,
		DENOMINATION, 
		[Hold_Percentage] as [Theo HOLD],
		Asst_SERIAL_Number as [Serial_Number],
		Manufacture as [Manufacturer],
		'' as Model,
		---[MODL_PART_NUMBER] as Model,
		Slot_Game_Type as [Game_Type],
		'' as [Display_Type],
		TYPE_DESC as 'TYPE_DESC',
		Contract_Desc,
		[PARTICIPATION_TYPE_CD], 
        sum([DAYS_ONLINE]) as DOF,
		sum([Bets]) as [COIN In],
		cast((sum([Bets])/nullif(sum(Days_online),0)) as decimal(18,2)) as [COIN In Per Day],
		sum([Meter_Win]) as [Meter_Win],
		sum([SLOT_NET_WIN_AMT]) as [SLOT_NET_WIN_AMT],
		sum([LEASE_FEES]) as [LEASE_FEES],
		(sum([SLOT_NET_WIN_AMT]) - sum([LEASE_FEES])) as [Adjusted_Win],
	    CAST((sum([Meter_Win])/nullif(sum([Bets]*100),0)) as decimal(18,2)) as [Actual Hold],
		cast((SUM([Meter_Win])/nullif(sum([Days_online]),0)) as decimal(18,2)) as [WPU],
		max(Lease_FEES) as [Fee per Unit],
		cast((((SUM([Meter_Win])/nullif(sum([Days_online]),0))) - max(Lease_FEES) ) as decimal(18,2))   as [WPU Net Fee],
		sum([GAMES_PLAYED]) as [GAMES_PLAYED],
		CAST(sum([Bets])/nullif(sum([GAMES_PLAYED]),0) as decimal(18,2)) as [AVG_Bet],
		CAST(CAST(max([Hold_Percentage]) as decimal(18,2))*0.01*sum([Bets])/nullif(sum([DAYS_ONLINE]),0) as decimal(18,2)) as [Theo_Win_Per_Unit],
		CAST((CAST(sum([GAMES_PLAYED]) as decimal(18,2))/(8640*0.01*nullif(sum([Days_Online]),0))) as decimal(18,2))  as [Ocuppancy] 
  INTO #Machines2	
  FROM [vDW].[tableau].[slot_daily_perf_fact_online] tv
  where gaming_date between '2020-01-01' and '2020-02-29' 
  and SLOT_STATUS='ONLINE' 
  ---and    Days_Online > 0   and GAMES_PLAYED > 0
  ---and Bank_LONG_NAME='AA'  -- and LOCATION='A-A-16' and 
  and ASST_SERIAL_NUMBER  in 
  (
  select ASST_SERIAL_NUMBER  from [vDW].[tableau].[slot_daily_perf_fact_online] tv1 where gaming_date='2020-02-29' and SLOT_STATUS='ONLINE' and tv.HOLD_PERCENTAGE=tv1.HOLD_PERCENTAGE
  and tv.slot_number = tv1.slot_number
  )
  group by 
  [Zone_LONG_NAME],[Bank_Long_Name], Slot_Number, Location,DENOMINATION, Asst_SERIAL_Number,[Hold_Percentage],
		Manufacture,
		---MODL_PART_NUMBER ,
		Slot_Game_Type,
		TYPE_DESC,
		Contract_Desc,
		[PARTICIPATION_TYPE_CD]
  order by LOCATION asc


  ---select top 10 * from  #Machines2 where LOCATION='B-X-05'

  select m2.* from #Machines2	m2 inner join #CurrentMachines cm on m2.slot_number = cm.slot_number and m2.LOCATION = cm.LOCATION
  and m2.DENOMINATION = cm.DENOMINATION and m2.[Theo HOLD] = cm.HOLD_PERCENTAGE and m2.Serial_Number = cm.ASST_SERIAL_NUMBER and m2.Manufacturer = cm.Manufacture
  ---and m2.Model = cm.MODL_PART_NUMBER  
  and m2.TYPE_DESC = cm.TYPE_DESC ---and m2.LOCATION='B-X-05'
  order by m2.LOCATION

DROP TABLE  #Machines2
DROP TABLE  #CurrentMachines
---DROP TABLE  #Machine3




----select location, count(*) from #Machines2
----group by location
----having count(*)>1


------DROP TABLE  #Machines2
------DROP TABLE  #CurrentMachines

--select * from #CurrentMachines where LOCATION='A-A-05'
--GO
--select * from 
-- #Machines2 ---where meter_win<>slot_net_win_amt
--where location in ('A-A-05')
--   order by location

---- 29984
----40702

----  -- GO

select *   from [vDW].[tableau].[slot_daily_perf_fact_online] where  SLOT_STATUS='ONLINE' and LOCATION in ('V-C-20')
and  month(GAMING_DATE) in (02) and GAMING_DATE>'2020-01-01' 
order by date_key asc

select GAMING_DATE, slot_number, LOCATION, DENOMINATION, HOLD_PERCENTAGE, MODL_PART_NUMBER, TYPE_DESC   from [vDW].[tableau].[slot_daily_perf_fact_online] where  SLOT_STATUS='ONLINE' and LOCATION in ('V-C-20')
and  month(GAMING_DATE) in (02) and GAMING_DATE>'2020-01-01' 
order by date_key asc

--  Slot number, serial number, 

