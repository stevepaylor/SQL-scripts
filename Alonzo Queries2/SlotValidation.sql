/****** Script for SelectTopNRows command from SSMS  ******/
---5967 total
---2253

select top 20000 RecordTermDate,user_custom9, *
FROM [iQ-Gaming].[dbo].[IQC_Slot_Machines] s
where AssetNumber=41340 
order by s.RecordTermDate asc


SELECT *
  FROM [iQ-Gaming].[dbo].[IQC_Slot_Accounting]
  where [GamingDate]='2022-02-07' and LocationID<>'W/H' and AssetNumber=29868

SELECT top 10  *
  FROM [iQ-Gaming].[dbo].[IQC_Slot_Accounting_EXT] 
    where [GamingDate]='2022-02-07' and AssetNumber=29868

SELECT *
  FROM [iQ-Gaming].[dbo].[v_IQC_Slot_Accounting]
  where [GamingDate]='2022-02-07' and LocationID<>'W/H' and AssetNumber=29868
  GO

  --28818
  SELECT *
  FROM [iQ-Gaming].[dbo].V_IQC_Slot_CoinIn_Summary
  where [GamingDate]='2022-02-07' and LocationID<>'W/H' and AssetNumber=29868
  order by LocationID asc
  GO



---5977
---2264
SELECT *
  FROM MSBIDB02dv.[vDW].[tableau].[slot_daily_perf_fact]
  where gaming_date='2022-02-07' and slot_number=28818
  order by ACNF_LOCATION asc


   SELECT *
  FROM [iQ-Gaming].[dbo].V_IQC_Slot_CoinIn_Summary
  where [GamingDate]='2022-02-21' and LocationID<>'W/H' ---and Zone<>'T'
and AssetNumber in 
(	 
SELECT slot_number
  FROM MSBIDB02dv.[vDW].[tableau].[slot_daily_perf_fact]
  where gaming_date='2022-02-21' and ACNF_LOCATION<>'W/H' and  ACNF_LOCATION not like 'T%'
)


SELECT * 
  FROM MSBIDB02dv.[vDW].[tableau].[slot_daily_perf_fact]
  where gaming_date='2022-02-21' and ACNF_LOCATION<>'W/H' and  ACNF_LOCATION not like 'T%' and ACST_SHORT_NAME='ONLINE'

and  slot_number not in 
(	 

   SELECT AssetNumber
  FROM [iQ-Gaming].[dbo].V_IQC_Slot_CoinIn_Summary
  where [GamingDate]='2022-02-21' and LocationID<>'W/H' ---and Zone<>'T'
)




   SELECT count(*), AssetNumber
  FROM [iQ-Gaming].[dbo].V_IQC_Slot_CoinIn_Summary
  where [GamingDate]='2022-02-21' and LocationID<>'W/H' ---and Zone<>'T'
  group by AssetNumber
  having  count(*)>1

  
   SELECT count(*), AssetNumber, [GamingDate]
  FROM [iQ-Gaming].[dbo].V_IQC_Slot_CoinIn_Summary
  where [GamingDate]>'2022-02-21' and LocationID<>'W/H' ---and Zone<>'T'
  group by AssetNumber,[GamingDate]
  having  count(*)>1

  29868

  -- 28818

select top 10 * from casi23LS08pr.slot_participation.[dbo].[PARTICIPATION_FEES]
where participation_cd='ROULETTE'



       CASE WHEN [pf].[CALCULATION_TYPE_ID] = 1 AND [pf].[PARTICIPATION_TYPE_CD] = 'PART' THEN [pf].[PART_FIX_AMT] 
              WHEN [pf].[CALCULATION_TYPE_ID] = 2 AND [pf].[PARTICIPATION_TYPE_CD] = 'PART' THEN IIF([pf].[WIN_MINIMUM_AMT]=0 AND [pf].[WIN_MAXIMUM_AMT]=0, [pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT], IIF([pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT] > [pf].[WIN_MAXIMUM_AMT], [pf].[WIN_MAXIMUM_AMT], IIF([pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT] < [pf].[WIN_MINIMUM_AMT],[pf].[WIN_MINIMUM_AMT],0) ) ) 
              WHEN [pf].[CALCULATION_TYPE_ID] = 4 AND [pf].[PARTICIPATION_TYPE_CD] = 'PART' THEN [pf].[COIN_IN_PCT]/100 * [a].[DRPD_COIN_IN_AMT] 
              ELSE [a].[PARTICIPATION_FEES] 
       END [PARTICIPATION_FEES], 


	   THEN IIF([pf].[WIN_MINIMUM_AMT]=0 AND [pf].[WIN_MAXIMUM_AMT]=0, [pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT], IIF([pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT] > [pf].[WIN_MAXIMUM_AMT], [pf].[WIN_MAXIMUM_AMT], IIF([pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT] < [pf].[WIN_MINIMUM_AMT],[pf].[WIN_MINIMUM_AMT],0) ) ) 


select top 100 [WIN_MINIMUM_AMT],* from msbidb02dv.vdw.[tableau].[slot_daily_flash_fact]
where slot_number=41340 and gaming_date='2022-02-06'


SELECT *
  FROM [CASI23LS08PR].[SLOT_PARTICIPATION].[dbo].[PARTICIPATION_FEES]
  where participation_CD='VGT Class II'          


     --    CASE WHEN [pf].[CALCULATION_TYPE_ID] = 1 AND [pf].[PARTICIPATION_TYPE_CD] = 'PART' THEN [pf].[PART_FIX_AMT] 
     --         WHEN [pf].[CALCULATION_TYPE_ID] = 2 AND [pf].[PARTICIPATION_TYPE_CD] = 'PART' 
			  
			  --THEN IIF([pf].[WIN_MINIMUM_AMT]=0 AND [pf].[WIN_MAXIMUM_AMT]=0, [pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT], IIF([pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT] > [pf].[WIN_MAXIMUM_AMT], [pf].[WIN_MAXIMUM_AMT], IIF([pf].[WIN_PCT]/100 * [a].[NET_SCALE_WIN_AMT] < [pf].[WIN_MINIMUM_AMT],[pf].[WIN_MINIMUM_AMT],0) ) ) 
              
			  --WHEN [pf].[CALCULATION_TYPE_ID] = 4 AND [pf].[PARTICIPATION_TYPE_CD] = 'PART' THEN [pf].[COIN_IN_PCT]/100 * [a].[DRPD_COIN_IN_AMT] 
     --         ELSE [a].[PARTICIPATION_FEES] 
     --  END [PARTICIPATION_FEES], 

SELECT top 10  NET_SCALE_WIN_AMT, *
  FROM [MSBIDB02DV].[vDW].[slot].[tab_daily_perf_fact]
  where slot_number=30980 and gaming_date='2022-03-03'

GO

select top 100 * from IQC_Slot_Accounting
where assetNumber=41340 and gamingdate='2022-02-06'
Go
select top 100 * from IQC_Slot_Accounting_EXT
where assetNumber=41340 and gamingdate='2022-02-06'



SELECT top 1000000  td.NET_SCALE_WIN_AMT,tdqlx.NET_SCALE_WIN_AMT, dispute_slip, *
  FROM [MSBIDB02DV].[vDW].[slot].[tab_daily_perf_fact] td inner join IQC_Slot_Accounting_EXT tdqlx
  on td.slot_number=tdqlx.AssetNumber and td.gaming_date = tdqlx.GamingDate
  --where slot_number=41340 and gaming_date='2022-02-06'
  where gaming_date>='2022-01-01'
  and td.NET_SCALE_WIN_AMT<>tdqlx.NET_SCALE_WIN_AMT


  
SELECT top 1000000  td.NET_SCALE_WIN_AMT,tdqlx.NET_SCALE_WIN_AMT, ( td.NET_SCALE_WIN_AMT -tdqlx.NET_SCALE_WIN_AMT) as [DIFFERENCE],  dispute_slip, *
  FROM [MSBIDB02DV].[vDW].[slot].[tab_daily_perf_fact] td inner join IQC_Slot_Accounting_EXT tdqlx
  on td.slot_number=tdqlx.AssetNumber and td.gaming_date = tdqlx.GamingDate
  --where slot_number=41340 and gaming_date='2022-02-06'
  where gaming_date>='2022-01-01'--- and  gaming_date<='2022-02-28'
 ---and td.NET_SCALE_WIN_AMT<>(tdqlx.NET_SCALE_WIN_AMT + dispute_slip )
 and td.NET_SCALE_WIN_AMT<>(tdqlx.NET_SCALE_WIN_AMT )


 select sum(participation_fees) from V_IQC_Slot_CoinIn_Summary
 where GamingDate='2022-03-03 00:00:00.000'

 20811

 select sum(lease_fees) as lease_fees, sum(participation_fees) as participation_fees, count(*) from [MSBIDB02DV].[vDW].tableau.slot_daily_perf_fact
 where gaming_date='2022-03-03' and acst_short_name<>'OFFLINE' and BANK_LONG_NAME<>'TC'

  select * from [MSBIDB02DV].[vDW].[slot].[tab_daily_perf_fact]
 where gaming_date='2022-03-03'

   select * from [MSBIDB02DV].[vDW].tableau.slot_daily_perf_fact
 where gaming_date='2022-03-03' and acst_short_name<>'OFFLINE' and BANK_LONG_NAME<>'TC'

    select * from [MSBIDB02DV].[vDW].tableau.slot_daily_perf_fact
 where gaming_date='2022-03-03' and slot_number='30986'
 --- -264.11

  select top 100 *  from V_IQC_Slot_CoinIn_Summary
 where GamingDate='2022-03-03 00:00:00.000' and AssetNumber='30986'


 VGT CLASS II

 
  select top 1000 *   from [CASI23LS08PR].[SLOT_PARTICIPATION].[dbo].[PARTICIPATION_FEES]
  where 
  participation_cd
  not in
  (
  select Distinct user_custom5 from [MSBIDB02DV].[vDW].tableau.slot_daily_perf_fact
  where gaming_date>='2022-01-01'--- and acst_short_name<>'OFFLINE' and BANK_LONG_NAME<>'TC'
  )
  and participation_cd


