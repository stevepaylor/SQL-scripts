select va.prizecode, prizename, GamingDt, te.Login as HostEmpID, te.FirstName as HostFirstName, te.LastName as HostLastName, acct, vpv.FirstName, vpv.LastName, ClubStatus, IsVoid, PrizeQty
from viewAwardsViejas va inner join tprize tp on va.PrizeCode = tp.PrizeCode
inner join tPrizeEffectiveDtValidDt tpc on tp.PrizeId = tpc.PrizeID
inner join viewPlayersViejas vpv on va.playerid = vpv.playerid
left join temp te on te.empid = vpv.HostEmpID
where va.prizecode like '%_20%RSV%' 
and PostDtm>=getdate()-45 and isvoid=0
and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ValidThroughDtm) >= GETDATE()
order by PrizeName desc



select prizename, HostEmpID, te.LastName as HostLastName, Count(*) as TotalRSVP, sum(Prizeqty) as TotalRSVPQty
from viewAwardsViejas va inner join tprize tp on va.PrizeCode = tp.PrizeCode
inner join tPrizeEffectiveDtValidDt tpc on tp.PrizeId = tpc.PrizeID
inner join viewPlayersViejas vpv on va.playerid = vpv.playerid
left join temp te on te.empid = vpv.HostEmpID
where va.prizecode like '%_20%RSV%' 
and PostDtm>=getdate()-45  and isvoid=0
and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ValidThroughDtm) >= GETDATE()
group by prizename, HostEmpID, te.LastName
order by PrizeName


order by PrizeName desc




select top 100 * from tPrizeEffectiveDtValidDt tpc inner join tprize tp on tpc.prizeid = tp.PrizeId
where prizecode='P20AB5_RSV'

select top 100 * from tprize where prizecode='P20AB5_RSV'

select top 100 * from tprizeconfig order by ConfigId desc

 where ValidTo>='2020-01-25 11:59:00.00 +00:00'

select top 100 * from tprize where PrizeID='10000639'

