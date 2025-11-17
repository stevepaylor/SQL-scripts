
Declare @acct varchar(10)
Set @acct='20783809'


SELECT c.reinvestment reinvestmentTarget, player_account_number
into #playerprofile1

from tableau.player_dim pd
JOIN CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth
where player_account_number=@acct



-----------------------------------------------
----DROP TABLE #playerprofile2
select 
p.Acct,
p.playerid,
ISNULL(SUM(TheorWin), 0) Theo,
ISNULL(SUM(casinowin), 0) Win

into #playerprofile2

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

from #playerprofile2 p
left join [CMKTDB13CPR].[CMP13].dbo.viewAwardsViejas a on a.playerid = p.playerid and a.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101) 
where p.Acct = @acct 

group by p.acct,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END
-----------------------------------------------
select p1.reinvestmentTarget, p2.Theo, p2.Win, p3.*
--(p3.TodayWorth * p1.reinvestmentTarget) - p3.TodayAuthComp CompAvailToday,
--p3.TodayAuthComp / (CASE WHEN p3.TodayWorth = 0 THEN 1 ELSE p3.TodayWorth END) ReinvestToday

from #playerprofile1 p1
left join #playerprofile3 p3 on p1.player_account_number = p3.Acct
left join #playerprofile2 p2 on p1.player_account_number = p2.Acct


DROP TABLE #playerprofile1
DROP TABLE #playerprofile2
DROP TABLE #playerprofile3


