

---SELECT FORMAT (getdate(), 'MM/01/yyyy') as date
---SELECT CONVERT(VARCHAR(10), GETDATE(), 101) 

-----------------------

Declare @acct varchar(10)
Declare @PlayerID int
--Set @acct='10303865'
Set @acct='10073861'




Set @PlayerID= (select playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct)

---select @PlayerID


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


,SlotTheoWin=(
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
SlotCasinoWin=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
TableTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
),



TableCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),



OtherTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

OtherCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
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



, DiscretionayComp=(Select sum(awardused)
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
INTO #PlayerProfile1


---  MONTH TO DATE
SELECT  
offersUsed = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt >= FORMAT (getdate(), 'MM/01/yyyy')  and gamingdt<=CONVERT(VARCHAR(10), GETDATE()-1, 101)

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


,SlotTheoWin=(
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
--gamingdt between FORMAT (getdate(), 'MM/01/yyyy')  and CONVERT(VARCHAR(10), GETDATE()-1, 101)
---gamingdt between '2021-06-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)

and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
SlotCasinoWin=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
TableTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
),



TableCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),



OtherTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

OtherCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
)

,serviceRecovery=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
and BonusPromo1 > 0
and awardcode = 'P'
and isVoid=0
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and av.playerid =@PlayerID
Group by av.playerid)



, DiscretionayComp=(Select sum(awardused)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
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
gamingdt >= FORMAT (getdate(), 'yyyy-MM-01') and  gamingdt<= CONVERT(VARCHAR(10), GETDATE()-1, 101)
and IsVoid=0  and Trancode like 'CSH%'
and av.playerid =@PlayerID
Group by av.playerid
)
INTO #PlayerProfile2


------   30 DAYS
SELECT  
offersUsed = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)

and Awardused > 0
and (
       prizecode like 'L2[0-9][A-L]%'
       or prizecode like 'S2[0-9][A-L]%'
       or (awardcode = 'C'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite')) 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or prizecode = 'BaccReb10H' 
       or prizecode like 'NNC%'
       )
and isVoid=0
and acct=@acct
Group by acct)


,SlotTheoWin=(
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
SlotCasinoWin=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
TableTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
),



TableCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),



OtherTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

OtherCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
)

,serviceRecovery=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and BonusPromo1 > 0
and awardcode = 'P'
and isVoid=0
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and av.playerid =@PlayerID
Group by av.playerid)



, DiscretionayComp=(Select sum(awardused)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
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
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and IsVoid=0  and Trancode like 'CSH%'
and av.playerid =@PlayerID
Group by av.playerid
)
INTO #PlayerProfile3



---   YEAR TO DATE

SELECT  
offersUsed = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt >='2021-01-01'

and Awardused > 0
and (
       prizecode like 'L2[0-9][A-L]%'
       or prizecode like 'S2[0-9][A-L]%'
       or (awardcode = 'C'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite')) 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or prizecode = 'BaccReb10H' 
       or prizecode like 'NNC%'
       )
and isVoid=0
and acct=@acct
Group by acct)


,SlotTheoWin=(
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
SlotCasinoWin=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
TableTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
),



TableCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),



OtherTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

OtherCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
)

,serviceRecovery=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and BonusPromo1 > 0
and awardcode = 'P'
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and av.playerid =@PlayerID
Group by av.playerid)



, DiscretionayComp=(Select sum(awardused)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
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
gamingdt  between '2021-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and IsVoid=0  and Trancode like 'CSH%'
and av.playerid =@PlayerID
Group by av.playerid
)
INTO #PlayerProfile4


select '5' as HistOrder, 
'Todays' as HistPeriod, * from #PlayerProfile1
UNION ALL 
select  '4' as HistOrder, 
'MTD' as HistPeriod,* from #PlayerProfile2
UNION ALL 
select  '3' as HistOrder, 
'30 Days' as HistPeriod, * from #PlayerProfile3
UNION ALL 
select '2' as HistOrder, 
'YTD' as HistPeriod,* from #PlayerProfile4

Drop TABLE #PlayerProfile1
Drop TABLE #PlayerProfile2
Drop TABLE #PlayerProfile3
Drop TABLE #PlayerProfile4


 --[dbo].[usp_PPGetPlayerDetailsV4] '10006327'

 --[dbo].[usp_PPGetPlayerDetails] '10178851'

 ---[dbo].[usp_PPGetPlayerDetailsV4CMP] 10022507











