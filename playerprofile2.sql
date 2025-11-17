USE CMP13
GO

DECLARE @acct as INT; 
SET @acct = 10006327;

select IsPictureTaken from CMP13.dbo.tplayer tp inner join CMP13.dbo.tplayercard tpc
on tp.playerid = tpc.playerid 
where acct = @acct


SELECT
  pls.Acct
, tgs.PlayerID
, wtl.OfferCategory
, CAST(REPLACE(wtl.OfferDescription1,',','') AS NVARCHAR(255)) AS OfferDescription1
, CAST(REPLACE(wtl.OfferDescription2,',','') AS NVARCHAR(255)) AS OfferDescription2
, CAST(REPLACE( wtl.OfferDescription3,',','') AS NVARCHAR(255)) AS OfferDescription3
, wtl.Valid_BeginDate
, wtl.Valid_EndDate
, wtl.BeginDate
, wtl.EndDate
,wtl.tagcode

FROM dbo.viewPlTags AS tgs WITH (NOLOCK)

INNER JOIN Website_Tag_List AS wtl WITH (NOLOCK) 
ON tgs.TagCode = wtl.TagCode 

INNER JOIN dbo.viewPlayersViejas AS pls WITH (NOLOCK) 
ON tgs.PlayerID = pls.PlayerID

WHERE GETDATE() BETWEEN wtl.BeginDate AND wtl.EndDate
and acct= @acct
and Valid_BeginDate<=getdate()+45
order by  Valid_BeginDate asc

--------------------------------------------------------------------------------- 

select acct, ta.Prizecode as Prizeid, gamingdt, ta.AuthAward, prizename
,Dateadd(dd, convert(int,AutoSettleAfterDays), gamingdt) as ExpirationDate,
tp.CompBal
 from viewAwardsViejas ta with(nolock)
inner join viewPlayersViejas tp with(nolock) on ta.playerid = tp.playerid
inner join viewPrizesViejas tpr with(nolock) on ta.PrizeCode = tpr.PrizeCode

where acct= @acct and isopenitem=1 
and gamingdt>='12/01/2018' and ta.PrizeCode not in ('CSHWDPR')

----------------------------------------------------------------------------------

select top 5 postdtm,gamingdt, (te.lastname + ', ' + te.firstname) as DeniedBy, Ref2 from viewAwardsViejas ta with(nolock)
inner join tplayercard tp with(nolock) on ta.playerid = tp.playerid
---inner join viewPrizesViejas tpr with(nolock) on ta.prizecode = tpr.PrizeCode
inner join temp te with(nolock) on ta.empid = te.empid

where acct= @acct and gamingdt> CONVERT(VARCHAR(10), GETDATE()-7, 101) and
 
(
ta.PrizeCode='COMPDenied'
)
order by gamingdt desc

----------------------------------------------------------------------------------

select top 10 LocnCode, MachStand, IsCardIN, tpc.ModifiedDtm,
CASE
	WHEN (IsCardin=1 or (DateDiff("mi",tpc.ModifiedDtm,getdate())<=120 and DateDiff("mi",tpc.ModifiedDtm,getdate())<>0))
	THEN 'TRUE'
	ELSE 'FALSE'
END	AS ActionLast2Hours,
CASE WHEN tl.DeptID = 11 AND rtrim(COALESCE (tl.MachStand, '')) 
                      <> '' THEN tl.MachStand ELSE LocnCode END AS LastAreaID,
DATEDIFF("mi", tpc.ModifiedDtm,GETUTCDATE()) 'NumberOfMinutes'

from tplayercard tpc inner join tLocn tl on tpc.LastLocnId = tl.LocnId
 LEFT OUTER JOIN dbo.tArea AS ae WITH (NOLOCK) ON ae.AreaID = tl.AreaID 
where acct = @acct

----------------------------------------------------------------------------------

select top 10 acct, ta.Prizecode as Prizeid, PostDtm, (ta.BonusPromo1+ ta.AuthAward) as BonusPromo1, prizename, te.login, te.FirstName as EmpFirstName, te.LastName as EmpLastName from viewAwardsViejas ta with(nolock)
inner join viewPlayersViejas tp with(nolock) on ta.playerid = tp.playerid
inner join viewPrizesViejas tpr with(nolock) on ta.PrizeCode = tpr.PrizeCode
inner join temp te on ta.empid = te.empid
where acct=@acct and Trancode='AUTHPRMO'
and gamingdt>='11/01/2018' and ta.awardcode in ('P', 'V') ---ta.BonusPromo1<>0
order by TA.POSTDTM desc


----------------------------------------------------------------------------------

----DROP TABLE #playerprofile2X
select 
p.Acct,
p.playerid,
ISNULL(SUM(TheorWin), 0) Theo,
ISNULL(SUM(casinowin), 0) Win

into #playerprofile2X

from [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas p
left join [CMKTDB13CPR].[CMP13].dbo.viewAllRatingsViejasNoAwardsNoGMT r on r.PlayerID = p.PlayerId and r.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)

where p.Acct = @acct 

group by p.acct,
p.playerid

-----------------------------------------------
----DROP TABLE #playerprofile3
select 
p.Acct,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END TodayWorth,
SUM(CASE WHEN a.PrizeCode = 'CSHWDPR' THEN a.AwardUsed ELSE 0 END) + SUM(CASE WHEN a.PrizeCode <> 'CSHDEPCR' THEN (a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr) ELSE 0 END ) as award_FPAwarded_Total,
SUM(CASE WHEN a.PrizeCode like 'P[0-9][0-9]%' AND a.AwardCode = 'P' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as award_FPAwarded_PromoWinner,
SUM(CASE WHEN a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') and a.PrizeCode NOT IN ('MVPBuff', 'Opera1') THEN a.AwardUsed ELSE 0 END) as award_CompsUsed_FB,
SUM(CASE WHEN a.AwardCode NOT IN  ('F', 'R', 'P', 'C', 'V', 'M') AND (a.trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') or (a.TranCode = 'Authprmo' and a.AwardUsed >0)) THEN AwardUsed ELSE 0 END) as award_CompsUsed_Other,    
SUM(CASE WHEN a.AwardCode = 'V' THEN a.AwardUsed ELSE 0 END) as award_PromoChipsAwarded, 
SUM(CASE WHEN (left(a.PrizeCode,1) IN ('S', 'L') OR a.PrizeCode like '%Bng%')and a.AwardCode ='C' THEN a.AwardUsed ELSE 0 END) as award_CashAwarded_Bingo

into #playerprofile3

from #playerprofile2X p
left join [CMKTDB13CPR].[CMP13].dbo.viewAwardsViejas a on a.playerid = p.playerid and a.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101) 
where p.Acct = @acct 

group by p.acct,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END
-----------------------------------------------
select p1.reinvestmentTarget, p2.Theo, p2.Win, p3.*
--(p3.TodayWorth * p1.reinvestmentTarget) - p3.TodayAuthComp CompAvailToday,
--p3.TodayAuthComp / (CASE WHEN p3.TodayWorth = 0 THEN 1 ELSE p3.TodayWorth END) ReinvestToday

from #playerprofile1X p1
left join #playerprofile3 p3 on p1.player_account_number = p3.Acct
left join #playerprofile2X p2 on p1.player_account_number = p2.Acct


DROP TABLE #playerprofile1X
DROP TABLE #playerprofile2X
DROP TABLE #playerprofile3

----------------------------------------------------------------------------------



---Declare @acct varchar(10)
Declare @PlayerID int
--Set @acct='10303865'
---Set @acct='21269254'


Set @PlayerID= (select playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct)

SELECT  
awardused = (SELECT ISNULL(SUM(awardused), 0)
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

,bonuspromo1=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101)
and BonusPromo1 > 0
and awardcode = 'P'
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and av.playerid =@PlayerID
Group by av.playerid
)
