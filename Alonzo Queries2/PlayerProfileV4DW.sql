
Declare @acct varchar(10)
Declare @PlayerID int
--Set @acct='10303865'
Set @acct='20205694'

Set @PlayerID= (select playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct)

Select @PlayerID

 --   Month TO date

SELECT ---TOP 1000 [gaming_date]
      [player_id]
      ,[player_account_number]
      ,sum([slot_theo_win]) as slot_theo_win
      ,sum([slot_actual_win]) as slot_actual_win
      ,sum([table_theo_win]) as table_theo_win
      ,sum([table_actual_win]) as table_actual_win
      ,sum([other_theo_win]) as other_theo_win
      ,sum([other_actual_win]) as other_actual_win
      ,sum([award_Cash_activeNL]) as award_Cash_activeNL
      ,sum([award_Cash_Discrectionary]) as award_Cash_Discrectionary 
      ,sum([award_Cash_InactiveNL]) as award_Cash_InactiveNL
      ,sum([award_Cash_OuterMarketNL]) as award_Cash_OuterMarketNL
	  
	  ,sum([award_FreePlay_Used]) as award_FreePlay_Used
      ,sum([award_FPAwarded_ServiceRecovery]) as award_FPAwarded_ServiceRecovery
	  ,sum([award_FPAwarded_PromoWinner]) as award_FPAwarded_PromoWinner
  
      ,sum([award_PromoChipUsed_ActiveNL]) as award_PromoChipUsed_ActiveNL
	  ,sum([award_PromoChipUsed_INActiveNL]) as award_PromoChipUsed_INActiveNL
      ,sum([award_PromoChipUsed_OuterMarketNL]) as award_PromoChipUsed_OuterMarketNL
	  ,sum([award_PromoChipUsed_Supplemental]) as award_PromoChipUsed_Supplemental
	  ,sum([award_PromoChipUsed_BaccRebate]) as award_PromoChipUsed_BaccRebate
      ,sum([award_PromoChipUsed_Discrectionary]) as award_PromoChipUsed_Discrectionary
      
	  ,sum([award_Comp_Discrectionary]) as award_Comp_Discrectionary 
	  ,sum([award_FPAwarded_Discretionary]) as award_FPAwarded_Discretionary
      ,sum([award_SelfComp]) as award_SelfComp
  Into #PlayerProfile1
  FROM [vDW].[tableau].[player_daily_fact_PRIZE]
  where player_account_number = @acct
  and gaming_date   >= FORMAT (getdate(), 'MM/01/yyyy')  and gaming_date<=CONVERT(VARCHAR(10), GETDATE()-1, 101)
  group by player_id, player_account_number


  select 
  (slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
  (slot_actual_win + table_actual_win + other_theo_win) as TotalCasinoWin,
  (
  award_Cash_activeNL
  + award_Cash_InactiveNL
  + award_Cash_OuterMarketNL
  + award_Cash_Discrectionary
  + award_FreePlay_Used 
  - award_FPAwarded_ServiceRecovery
  - award_FPAwarded_PromoWinner
  + award_PromoChipUsed_ActiveNL
  + award_PromoChipUsed_INActiveNL
  + award_PromoChipUsed_OuterMarketNL
  + award_PromoChipUsed_Supplemental
  + award_PromoChipUsed_BaccRebate
  + award_PromoChipUsed_Discrectionary
  + award_SelfComp
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  ) as TotalComp

 INTO #PlayerProfile1Final
 from #PlayerProfile1


 -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 ------------------------------------   LAST 30 DAYS --------------------------------------------------------

SELECT ---TOP 1000 [gaming_date]
      [player_id]
      ,[player_account_number]
      ,sum([slot_theo_win]) as slot_theo_win
      ,sum([slot_actual_win]) as slot_actual_win
      ,sum([table_theo_win]) as table_theo_win
      ,sum([table_actual_win]) as table_actual_win
      ,sum([other_theo_win]) as other_theo_win
      ,sum([other_actual_win]) as other_actual_win
      ,sum([award_Cash_activeNL]) as award_Cash_activeNL
      ,sum([award_Cash_Discrectionary]) as award_Cash_Discrectionary 
      ,sum([award_Cash_InactiveNL]) as award_Cash_InactiveNL
      ,sum([award_Cash_OuterMarketNL]) as award_Cash_OuterMarketNL
	  
	  ,sum([award_FreePlay_Used]) as award_FreePlay_Used
      ,sum([award_FPAwarded_ServiceRecovery]) as award_FPAwarded_ServiceRecovery
	  ,sum([award_FPAwarded_PromoWinner]) as award_FPAwarded_PromoWinner
  
      ,sum([award_PromoChipUsed_ActiveNL]) as award_PromoChipUsed_ActiveNL
	  ,sum([award_PromoChipUsed_INActiveNL]) as award_PromoChipUsed_INActiveNL
      ,sum([award_PromoChipUsed_OuterMarketNL]) as award_PromoChipUsed_OuterMarketNL
	  ,sum([award_PromoChipUsed_Supplemental]) as award_PromoChipUsed_Supplemental
	  ,sum([award_PromoChipUsed_BaccRebate]) as award_PromoChipUsed_BaccRebate
      ,sum([award_PromoChipUsed_Discrectionary]) as award_PromoChipUsed_Discrectionary
      
	  ,sum([award_Comp_Discrectionary]) as award_Comp_Discrectionary 
	  ,sum([award_FPAwarded_Discretionary]) as award_FPAwarded_Discretionary
      ,sum([award_SelfComp]) as award_SelfComp
  Into #PlayerProfile2
  FROM [vDW].[tableau].[player_daily_fact_PRIZE]
  where player_account_number = @acct
  and gaming_date between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
  group by player_id, player_account_number


  select 
  (slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
  (slot_actual_win + table_actual_win + other_theo_win) as TotalCasinoWin,
  (
  award_Cash_activeNL
  + award_Cash_InactiveNL
  + award_Cash_OuterMarketNL
  + award_Cash_Discrectionary
  + award_FreePlay_Used 
  - award_FPAwarded_ServiceRecovery
  - award_FPAwarded_PromoWinner
  + award_PromoChipUsed_ActiveNL
  + award_PromoChipUsed_INActiveNL
  + award_PromoChipUsed_OuterMarketNL
  + award_PromoChipUsed_Supplemental
  + award_PromoChipUsed_BaccRebate
  + award_PromoChipUsed_Discrectionary
  + award_SelfComp
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  ) as TotalComp

 INTO #PlayerProfile2Final
 from #PlayerProfile2


  -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 ------------------------------------   YEAR TO DATE --------------------------------------------------------

SELECT ---TOP 1000 [gaming_date]
      [player_id]
      ,[player_account_number]
      ,sum([slot_theo_win]) as slot_theo_win
      ,sum([slot_actual_win]) as slot_actual_win
      ,sum([table_theo_win]) as table_theo_win
      ,sum([table_actual_win]) as table_actual_win
      ,sum([other_theo_win]) as other_theo_win
      ,sum([other_actual_win]) as other_actual_win
      ,sum([award_Cash_activeNL]) as award_Cash_activeNL
      ,sum([award_Cash_Discrectionary]) as award_Cash_Discrectionary 
      ,sum([award_Cash_InactiveNL]) as award_Cash_InactiveNL
      ,sum([award_Cash_OuterMarketNL]) as award_Cash_OuterMarketNL
	  
	  ,sum([award_FreePlay_Used]) as award_FreePlay_Used
      ,sum([award_FPAwarded_ServiceRecovery]) as award_FPAwarded_ServiceRecovery
	  ,sum([award_FPAwarded_PromoWinner]) as award_FPAwarded_PromoWinner
  
      ,sum([award_PromoChipUsed_ActiveNL]) as award_PromoChipUsed_ActiveNL
	  ,sum([award_PromoChipUsed_INActiveNL]) as award_PromoChipUsed_INActiveNL
      ,sum([award_PromoChipUsed_OuterMarketNL]) as award_PromoChipUsed_OuterMarketNL
	  ,sum([award_PromoChipUsed_Supplemental]) as award_PromoChipUsed_Supplemental
	  ,sum([award_PromoChipUsed_BaccRebate]) as award_PromoChipUsed_BaccRebate
      ,sum([award_PromoChipUsed_Discrectionary]) as award_PromoChipUsed_Discrectionary
      
	  ,sum([award_Comp_Discrectionary]) as award_Comp_Discrectionary 
	  ,sum([award_FPAwarded_Discretionary]) as award_FPAwarded_Discretionary
      ,sum([award_SelfComp]) as award_SelfComp
  Into #PlayerProfile3
  FROM [vDW].[tableau].[player_daily_fact_PRIZE]
  where player_account_number = @acct and 
  gaming_date between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
  group by player_id, player_account_number 


  select 
  (slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
  (slot_actual_win + table_actual_win + other_theo_win) as TotalCasinoWin,
  (
  award_Cash_activeNL
  + award_Cash_InactiveNL
  + award_Cash_OuterMarketNL
  + award_Cash_Discrectionary
  + award_FreePlay_Used 
  - award_FPAwarded_ServiceRecovery
  - award_FPAwarded_PromoWinner
  + award_PromoChipUsed_ActiveNL
  + award_PromoChipUsed_INActiveNL
  + award_PromoChipUsed_OuterMarketNL
  + award_PromoChipUsed_Supplemental
  + award_PromoChipUsed_BaccRebate
  + award_PromoChipUsed_Discrectionary
  + award_SelfComp
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  ) as TotalComp

 INTO #PlayerProfile3Final
 from #PlayerProfile3






---  CURRENT DAY
SELECT  
offersUsed = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101) 

and Awardused > 0
and (
       prizecode like 'L2[0-9][A-L]%'
       or prizecode like 'S2[0-9][A-L]%'
       or (awardcode = 'C'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite')) 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or prizecode = 'BaccReb10H' 
       or prizecode like 'NNC%'
       )

and acct=@acct
Group by acct)


,slot_theo_win=(
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
slot_actual_win=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
table_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
),

table_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid =685466--- @PlayerID
and isVoid=0
group by playerid
),



other_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

other_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
)

,serviceRecovery=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101)
and BonusPromo1 > 0
and awardcode = 'P'
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and av.playerid =@PlayerID
Group by av.playerid)



, DiscretionayComp=(Select sum(awardused + bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt =CONVERT(VARCHAR(10), GETDATE(), 101)
and isvoid = 0
and (
       ((prizecode like 'FPCComp%' or prizecode = 'ECash-FPC') and BonusPromo1 > 0) 
       or (awardcode = 'c'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite') and awardused > '0') 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or (av.prizecode in ('MangmtComp','VocGftComp','Cigarettes') and av.awardcode in ('o') and awardused > '0') 
       or (av.prizecode in ('CSpa', 'Spa') and av.awardcode in ('I','B') and awardused > '0') 
       or (av.prizecode in ('OffSiteTks','OnsiteTxs') and av.awardcode in ('E','3') and awardused > '0') 
       or (av.prizecode in ('HostComp','Off_Event','Onst30All','Onst7All','Onst7Buff','Onst7F&B') and av.awardcode = 'F' and awardused > '0') 
       or (av.prizecode = 'CompOffer' and awardused > '0')
       or (av.prizecode = 'Golf'and awardused > '0')
       or (av.prizecode in ('Cigarettes', 'CSpa', 'Onst30Rtl', 'Onst7Rtl') and av.awardcode = 'M'and av.Awardused > 0)
       or (av.prizecode like 'NNC%' and av.Awardused > 0)
)
and av.playerid =@PlayerID
Group by acct)

,fpcUsed=(Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101)
and IsVoid=0  and Trancode like 'CSH%'
and av.playerid =@PlayerID
Group by av.playerid
)
INTO #PlayerProfile0




select * from #PlayerProfile0


  select 
  (isnull(slot_theo_win,0) + isnull(table_theo_win,0) + isnull(other_theo_win,0)) as TotalTheoWin,

  (isnull(slot_actual_win,0) + isnull(table_actual_win,0) + isnull(other_theo_win,0)) as TotalCasinoWin,
  (
  isnull(offersUsed,0) - isnull(serviceRecovery,0) + isnull(fpcUsed,0)
  ) as TotalExpense,

  (
  isnull(DiscretionayComp,0)
  ) as TotalComp

 INTO #PlayerProfile0Final
 from #PlayerProfile0


select '5' as HistOrder, 
'1 - Todays' as HistPeriod, * from #PlayerProfile0Final
UNION ALL 
select  '4' as HistOrder, 
'2 - MTD' as HistPeriod,* from #PlayerProfile1Final
UNION ALL 
select  '3' as HistOrder, 
'3 - 30 Days' as HistPeriod, * from #PlayerProfile2Final
UNION ALL 
select '2' as HistOrder, 
'4 - YTD' as HistPeriod,* from #PlayerProfile3Final


---DROP TABLE #PlayerProfile0
DROP TABLE #PlayerProfile0
DROP TABLE #PlayerProfile0Final
DROP TABLE #PlayerProfile1
DROP TABLE #PlayerProfile1Final
DROP TABLE #PlayerProfile2
DROP TABLE #PlayerProfile2Final
DROP TABLE #PlayerProfile3
DROP TABLE #PlayerProfile3Final



---[dbo].[usp_PPGetPlayerDetailsV4] 20754985








