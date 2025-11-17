select acct, sum(BasePts) as TotalPoints from tplayerpoints tpp right join viewplayersviejas vpv  ---2017
on tpp.playerid = vpv.playerid
where BucketGroupId<>1 and ClubStatus='Platinum'
and GamingDt>='06/01/2019'
group by acct


select acct, sum(BasePts) as TotalPoints from tplayerpoints tpp right join tplayercard vpv  ---2017
on tpp.playerid = vpv.playerid
where BucketGroupId<>1 ---and ClubStatus='Platinum'
and GamingDt>='06/01/2019'
group by acct



select playerid, sum(BasePts) as TotalPoints from tplayerpoints tpp
where BucketGroupId<>1 ---and ClubStatus='Platinum'
and GamingDt>='06/01/2019' and playerid in
(
select playerid from viewplayersviejas
where ClubStatus='Platinum'
)
group by playerid
having sum(BasePts) >600000


select vpv.playerid, sum(BasePts) as totalPoints 
INTO #PlayerIDReq
from viewplayersviejas vpv left join tplayerpoints tpp
on vpv.playerid = tpp.playerid

where BucketGroupId<>1 and ClubStatus='Platinum'
and GamingDt>='06/01/2019'
group by vpv.playerid


select acct from viewplayersviejas
where ClubStatus='Platinum' and playerid not in
(select playerid from #PlayerIDReq)


---select top 10 * from tplayerpoints


select ClubStatus, count(*) from viewplayersviejas
group by ClubStatus

---where ClubStatus='Platinum'



---OPTION 1
select vp.playerid, p.Points from viewplayersviejas vp LEFT JOIN (SELECT playerid, sum(BasePts) AS Points FROM tplayerpoints WHERE BucketGroupId<>1 and GamingDt>='05/01/2019' group by playerid ) p
ON vp.PlayerId = p.PlayerId
where vp.ClubStatus='Platinum'

----OPTION 2
select vp.playerid, 
CASE WHEN p.Points > 0 THEN p.Points ELSE 0 END AS Points 
INTO #RequalData1
from viewplayersviejas vp LEFT JOIN 
(SELECT playerid, sum(BasePts) AS Points FROM tplayerpoints WHERE BucketGroupId<>1 and GamingDt>='05/01/2019' group by playerid ) p
ON vp.PlayerId = p.PlayerId
where vp.ClubStatus='Platinum'

---339
select * from #RequalData1
where points=0

---817
select * from #RequalData1
where points>=500000





---OPTION 3

CREATE TABLE #PlatinumPlayerPoints(PlayerID int, Points int default 0)

INSERT INTO #PlatinumPlayerPoints
select playerid, 0 from viewplayersviejas where ClubStatus='Platinum'

UPDATE pp SET Points = p.points FROM (SELECT playerid, sum(BasePts) AS Points FROM tplayerpoints WHERE BucketGroupId<>1 and GamingDt>='06/01/2019' group by playerid ) p 
INNER JOIN #PlatinumPlayerPoints pp on pp.PlayerID = p.PlayerId

Select * from #PlatinumPlayerPoints
