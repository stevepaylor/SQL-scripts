select 
CASE WHEN left(PrizeCode, 1) = 'L' THEN 'MonthlyOffer' 
WHEN left(PrizeCode, 1) = 'S' THEN 'Supplemental' 
WHEN left(PrizeCode, 3) = 'FPC' THEN 'ManualComp' 
WHEN left(PrizeCode, 1) = 'P' THEN 'PromoPrize' 
WHEN left(PrizeCode, 3) = 'svc' THEN 'ServiceRecovery' 
ELSE 'Other' END Prize,
count( Distinct playerid) players,
count(*) Redm,
sum(prizeqty) qty,
sum(BonusPromo1) FP

from tawards a inner join tprize tp on a.PrizeId = tp.PrizeId
----join viewPlayersViejas p on a.PlayerID=p.PlayerId

where --PrizeCode like 'p19Ff4%'
BonusPromo1 > 0
and GamingDt = convert(varchar(10), getdate() , 101)

group by CASE WHEN left(PrizeCode, 1) = 'L' THEN 'MonthlyOffer' 
WHEN left(PrizeCode, 1) = 'S' THEN 'Supplemental' 
WHEN left(PrizeCode, 3) = 'FPC' THEN 'ManualComp' 
WHEN left(PrizeCode, 1) = 'P' THEN 'PromoPrize' 
WHEN left(PrizeCode, 3) = 'svc' THEN 'ServiceRecovery' 
ELSE 'Other' END



select top 100 * from tawards



select Prizecode, playerid, PrizeQty, BonusPromo1
INTO #FPCTEMP
from viewAwardsViejas a
----join viewPlayersViejas p on a.PlayerID=p.PlayerId

where --PrizeCode like 'p19Ff4%'
BonusPromo1 > 0
--and GamingDt = convert(varchar(10), getdate() , 101)
and GamingDt = '07/22/2019'

group by CASE WHEN left(PrizeCode, 1) = 'L' THEN 'MonthlyOffer' 
WHEN left(PrizeCode, 1) = 'S' THEN 'Supplemental' 
WHEN left(PrizeCode, 3) = 'FPC' THEN 'ManualComp' 
WHEN left(PrizeCode, 1) = 'P' THEN 'PromoPrize' 
WHEN left(PrizeCode, 3) = 'svc' THEN 'ServiceRecovery' 
ELSE 'Other' END

Drop TABLE #FPCTEMP