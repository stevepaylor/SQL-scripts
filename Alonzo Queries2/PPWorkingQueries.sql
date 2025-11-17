


Declare @acct varchar(10)
Declare @PlayerID int
Set @acct='10022507'
Set @PlayerID= (select playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct)




SELECT  
offersUsed = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
---gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101) 
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)





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
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
slot_actual_win=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
table_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and playerid =@PlayerID
and isVoid=0
group by playerid
),



table_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and playerid = @PlayerID
and isVoid=0
group by playerid
),



other_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

other_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and playerid =@PlayerID
and isVoid=0
group by playerid
)

,serviceRecovery=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
---gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and BonusPromo1 > 0
and awardcode = 'P'
---and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'P2[0-9]_GT%'  or prizecode like 'SvcRcFP%')
and av.playerid =@PlayerID
Group by av.playerid)



, DiscretionayComp=(Select sum(awardused + bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
---gamingdt =CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
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
---gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
and IsVoid=0  and Trancode like 'CSH%'
and av.playerid =@PlayerID
Group by av.playerid
)
INTO #PlayerProfile3

Select * from #PlayerProfile3

DROP table #PlayerProfile3




Declare @acct varchar(10)
Declare @PlayerID int
Set @acct='10022507'
Set @PlayerID= (select playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct)


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
  Into #PlayerProfile4
  FROM [vDW].[tableau].[player_daily_fact_PRIZE]
  where player_account_number = @acct and 
  gaming_date between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
  group by player_id, player_account_number 

  select * from #PlayerProfile4



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

 select * from #PlayerProfile3Final


 
 DROP table #PlayerProfile2
 DROP table #PlayerProfile2Final
 DROP table #PlayerProfile3
 DROP table #PlayerProfile3Final


--- TO VALIDATE REVENUE
select 
sum(slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
sum(slot_actual_win + table_actual_win + other_actual_win) as TotalCasinoWin
from tableau.player_daily_fact
where player_account_number='10022507' and gaming_date>='2021-01-01 00:00:00.000'
group by player_account_number

GO 

select 
sum(slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
sum(slot_actual_win + table_actual_win + other_actual_win) as TotalCasinoWin
from tableau.player_daily_fact_PRIZE
where player_account_number='10022507' and gaming_date>='2021-01-01 00:00:00.000'
group by player_account_number




--  SPs to COMPARE


[dbo].[usp_PPGetPlayerDetailsV4] 10022507
GO
[dbo].[usp_PPGetPlayerDetailsV4CMP] 10022507




[dbo].[usp_PPGetPlayerDetailsV4] 10303865
GO
[dbo].[usp_PPGetPlayerDetailsV4CMP] 10303865



[dbo].[usp_PPGetPlayerDetailsV4] 10022507


