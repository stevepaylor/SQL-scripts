
---Declare @acct  as Int
---Set @acct=10006768


select 
p.Acct,
p.playerid,
ISNULL(SUM(TheorWin), 0) Theo,
ISNULL(SUM(casinowin), 0) Win,
p.id1ExpireDT,
p.CompBal,
round(cast(p.PtsBal as float)/1000,2) as  PtsBal

into #playerprofile2

from [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas p
left join [CMKTDB13CPR].[CMP13].dbo.viewAllRatingsViejasNoAwardsNoGMT r on r.PlayerID = p.PlayerId and r.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)

---in ('07/16/2020', '07/15/2020', '07/14/2020')



where p.Acct = @acct 

group by p.acct,
p.playerid, p.id1ExpireDT, p.CompBal, p.PtsBal



select 
p.Acct,
p.id1ExpireDT,
p.CompBal,
p.PtsBal,
---(CASE WHEN Theo >= Win THEN Theo ELSE WIN END)  CompWorthTodayTotal,
WIN as CompWorthTodayTotal,
SUM(CASE WHEN a.PrizeCode = 'CSHWDPR' THEN a.AwardUsed ELSE 0 END) + SUM(CASE WHEN a.PrizeCode <> 'CSHDEPCR' THEN (a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr) ELSE 0 END ) as award_FPAwarded_Total,
SUM(CASE WHEN a.PrizeCode like 'P[0-9][0-9]%' AND a.AwardCode = 'P' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as award_FPAwarded_PromoWinner,
SUM(CASE WHEN a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') and a.PrizeCode NOT IN ('MVPBuff', 'Opera1') THEN a.AwardUsed ELSE 0 END) as award_CompsUsed_FB,
SUM(CASE WHEN a.AwardCode NOT IN  ('F', 'R', 'P', 'C', 'V', 'M') AND (a.trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') or (a.TranCode = 'Authprmo' and a.AwardUsed >0)) THEN AwardUsed ELSE 0 END) as award_CompsUsed_Other,    
SUM(CASE WHEN a.AwardCode = 'V' THEN a.AwardUsed ELSE 0 END) as award_PromoChipsAwarded, 
SUM(CASE WHEN (left(a.PrizeCode,1) IN ('S', 'L') OR a.PrizeCode like '%Bng%')and a.AwardCode ='C' THEN a.AwardUsed ELSE 0 END) as [award_CashAwarded_Bingo], 
SUM(CASE WHEN a.AwardCode = 'M' AND a.prizecode  like 'P%' AND  trancode IN ('SETLCOMP', 'SETLMGMT', 'AUTHPRMO') THEN a.awardUsed ELSE 0 END) as [award_Promo_Merchanise]

into #playerprofile3

from #playerprofile2 p
left join [CMKTDB13CPR].[CMP13].dbo.viewAwardsViejas a on a.playerid = p.playerid and a.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101) 
where p.Acct = @acct 

group by p.acct,p.id1ExpireDT,p.CompBal, Win, p.ptsbal


---CASE WHEN Theo >= Win THEN Theo ELSE WIN END


select *, (([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo] + [award_Promo_Merchanise]) CompUsedToday,
(
SELECT
isnull(sum(o.offer_amount),0) 
FROM [CMKTDB13CPR].[CMP13].dbo.viewPlTags AS tgs WITH (NOLOCK)
INNER JOIN [CMKTDB13CPR].[CMP13].dbo.Website_Tag_List AS wtl WITH (NOLOCK) 
ON tgs.TagCode = wtl.TagCode 
INNER JOIN [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas AS pls WITH (NOLOCK) 
ON tgs.PlayerID = pls.PlayerID
left join [vDW].[player].tab_offer_dim o (nolock) on  UPPER(rtrim(ltrim(wtl.tagcode)))= UPPER(rtrim(ltrim(o.offer_code)))
WHERE GETDATE() BETWEEN wtl.BeginDate AND wtl.EndDate
and acct=@acct
and Valid_BeginDate<=getdate()+45
and CONVERT(VARCHAR(10), GETDATE(), 101) between Valid_BeginDate and Valid_EndDate
and OfferCategory='FPC'
) as Offers

into #playerprofile4
from #playerprofile3

select *,
(CompWorthTodayTotal*0.1 - CompUsedToday - Offers - PTsBal) as AvailableToOffer
from #playerprofile4

Drop Table #playerprofile2
Drop Table #playerprofile3
Drop Table #playerprofile4 