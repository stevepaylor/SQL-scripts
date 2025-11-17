
select TotalPoints, acct
into #TotalbyClub
from
(
select sum(BasePts) as TotalPoints, acct from viewAccum1Day va
inner join viewPlayersViejas tp 
on va.PlayerID = tp.PlayerId
where BucketGroupId=1 and LastGamingDt>='2021-05-23 00:00:00.000'
and ClubStatus='INFINITY'
and gameid not in (37,3)
group by acct

UNION ALL

select sum(BasePts) as TotalPoints, acct from viewAccum1Day va
inner join viewPlayersViejas tp 
on va.PlayerID = tp.PlayerId
where BucketGroupId=1 and LastGamingDt>='2021-05-23 00:00:00.000'
and ClubStatus='INFINITY'
and gameid=37
group by acct
) a


select top 10 Sum(TotalPoints) as TotalEntries, acct from  #TotalbyClub
group by acct
order by Sum(TotalPoints) desc


Drop  Table #TotalbyClub

---order by sum(BasePts) desc





select top 10 acct, 
(
(select sum(BasePts) from viewAccum1Day va where BucketGroupId=1 and LastGamingDt>='2021-05-23 00:00:00.000' and gameid<>37 and tp.playerid = va.playerid ) +
(select sum(BasePts)/5 from viewAccum1Day va where BucketGroupId=1 and LastGamingDt>='2021-05-23 00:00:00.000' and gameid=37 and tp.playerid = va.playerid ) 
)
As TotalEntries
from viewPlayersViejas tp 
where ClubStatus='INFINITY'
order by 2



-- 358257

select top 100 * from viewPlayersViejas

select top 100 * from viewAccum1Day

select top 100 * from tgame  --   VPK1  37