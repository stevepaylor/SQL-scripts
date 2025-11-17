select top 100 * from tAccum1DayPts
where BucketGroupId=1 and Periodbegindtm='2020-03-01 00:00:00.000'
order by 1 desc


select Acct, LastName, FirstName, ClubStatus, sum(va.BasePts) as TotalPoints
		from viewAwardsViejas vA with(nolock)
		inner join viewPlayersViejas vpv with(nolock) on vA.PlayerID = vpv.Playerid
		where 
		GamingDt = '03/19/2020'
		and vpv.acct='10080276'
		group by acct,  firstName, LastName, Clubstatus


select Acct, LastName, FirstName, ClubStatus, 
(select sum(BasePts) from tPlayerPoints ta inner join tplayercard tpc on ta.playerid = tpc.playerid where acct=10080276 and GamingDt='03/19/2020' and ta.BucketGroupId=1) as TotatPoints
from viewPlayersViejas  vpv
where 
acct='10080276'


