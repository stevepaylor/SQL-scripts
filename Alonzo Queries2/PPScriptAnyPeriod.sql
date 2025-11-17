
DECLARE	@err_string	NVARCHAR ( 4000 )
Declare @PlayerID int, @PLAYER_KEY int

--debug
Declare @acct varchar(10)
Set @acct='12214004'

Declare @Lookback int
Set @Lookback = 365



select @PlayerID= playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct
select @PLAYER_KEY = PLAYER_KEY from player.tab_player_dim where player_id = @PlayerID

--added temp table to store all records for this player
select [player_id], [player_account_number], [gaming_date], [slot_theo_win], [slot_actual_win], [table_theo_win], [table_actual_win], [other_theo_win], [other_actual_win], 
[award_Cash_activeNL], [award_Cash_Discrectionary], [award_Cash_InactiveNL], [award_Cash_OuterMarketNL], [award_FreePlay_Used], [award_FPAwarded_ServiceRecovery],
[award_FPAwarded_PromoWinner], [award_PromoChipUsed_ActiveNL], [award_PromoChipUsed_INActiveNL], [award_PromoChipUsed_OuterMarketNL], [award_PromoChipUsed_Supplemental],
[award_PromoChipUsed_BaccRebate], [award_PromoChipUsed_Discrectionary], [award_Comp_Discrectionary], [award_FPAwarded_Discretionary], [award_SelfComp],[award_Cash_Supplemental]
into #daily_fact
FROM [vDW].[tableau].[player_daily_fact_PRIZE]
where PLAYER_KEY = @PLAYER_KEY


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
	  ,sum([award_Cash_Supplemental]) as award_Cash_Supplemental
	  
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
  FROM #daily_fact
  where player_account_number = @acct
  and gaming_date between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
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
  + award_Cash_Supplemental
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  ) as TotalComp

 INTO #PlayerProfile2Final
 from #PlayerProfile2

 select * from #PlayerProfile2Final

 
 
 
 ------  CMP

 
 ---  30 DAYS  CMP
SELECT  
offersUsed = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
---gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101) 
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)


and Awardused > 0 and isvoid = 0
and (
       ---prizecode like 'L2[0-9][A-L]%'
       ---or prizecode like 'S2[0-9][A-L]%'
	   (prizecode like 'L2[0-9][A-L]%' and awardcode in ('V','C'))
       or (prizecode like 'S2[0-9][A-L]%' and awardcode in ('V','C'))
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
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
slot_actual_win=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
table_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
),



table_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),



other_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

other_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
---GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
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
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and BonusPromo1 > 0
and awardcode = 'P'
and isvoid = 0
---and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'P2[0-9]_GT%' or prizecode like 'SvcRcFP%' or prizecode='Email10')
and av.playerid =@PlayerID
Group by av.playerid)



, DiscretionayComp=(Select sum(awardused + bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
---gamingdt =CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
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
	   or (av.prizecode = 'BaccReb10H' and av.Awardused > 0)
)
and av.playerid =@PlayerID
Group by acct)

,fpcUsed=(Select sum(promocredit)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
---gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101)
gamingdt  between CONVERT(VARCHAR(10), GETDATE()-@Lookback, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and IsVoid=0  and Trancode like 'CSH%'
and av.playerid =@PlayerID
Group by av.playerid
)
INTO #PlayerProfile1

  select 
  (isnull(slot_theo_win,0) + isnull(table_theo_win,0) + isnull(other_theo_win,0)) as TotalTheoWin,

  (isnull(slot_actual_win,0) + isnull(table_actual_win,0) + isnull(other_theo_win,0)) as TotalCasinoWin,
  (
  isnull(offersUsed,0) - isnull(serviceRecovery,0) + isnull(fpcUsed,0)
  ) as TotalExpense,

  (
  isnull(DiscretionayComp,0)
  ) as TotalComp

 INTO #PlayerProfile1Final
 from #PlayerProfile1


 SELECT * FROM #PlayerProfile1Final


 DROP TABLE #PlayerProfile1Final
 DROP TABLE #PlayerProfile1
 DROP TABLE #PlayerProfile2Final
 DROP TABLE #PlayerProfile2
 DROP TABLE #daily_fact



