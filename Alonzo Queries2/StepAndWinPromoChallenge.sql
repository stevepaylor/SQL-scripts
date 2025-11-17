select top 100 * from tAwards
where prizeid in
(
select prizeid from tprize where prizecode like 'S19FFA%'
)

select acct, sum(bonuspromo1)  as TotalPromo, Prizecode, sum(PrizeQty) as TotalPrizeQty
----INTO #PlayerAwards
from viewAwardsViejas va inner join tplayercard tpc on va.playerid = tpc.playerid

where GamingDt<='06/17/2019' and ---PrizeQty>1 and 
prizecode

-----='S19FFA1SNW' and GamingDt>='06/15/2019'

 in
(
select prizecode from tprize where prizecode like 'S19FFA%'
)
group by acct, Prizecode
---having count(*)>1


--- Awards by Day
select gamingdt, sum(bonuspromo1)  as TotalPromo
----INTO #PlayerAwards
from viewAwardsViejas va inner join tplayercard tpc on va.playerid = tpc.playerid

where GamingDt>='06/17/2019' and ---PrizeQty>1 and 
prizecode

-----='S19FFA1SNW' and GamingDt>='06/15/2019'

 in
(
select prizecode from tprize where prizecode like 'S19FFA%'
)
group by gamingdt






select sum(TotalPromo)  from #PlayerAwards where TotalPrizeQty<>1

select *, TotalPromo/TotalPrizeQty as PrizeAmount, TotalPromo-TotalPromo/TotalPrizeQty  from #PlayerAwards where acct=7420

select  sum(TotalPromo-TotalPromo/TotalPrizeQty)  from #PlayerAwards 

Select * from  #PlayerAwards 
order by TotalPromo desc


Drop table  #PlayerAwards







