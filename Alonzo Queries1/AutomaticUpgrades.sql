declare @FromDate datetime, @GamingDt datetime, @EvaluationScheduleId int

--Set Values here before running query
Set @FromDate = '2018-11-01'
Set @GamingDt = '2018-11-07'
Set @EvaluationScheduleId = 10000005

SELECT c.Acct, p.PlayerId, a.OldClubState, a.NewClubState, a.TierPoints FROM
(SELECT x.PlayerId, SUM(tpts.GAMEPTS + tpts.BASEPTS) 'TierPoints',
h.OldClubState, h.NewClubState
FROM tAccumKey x (NOLOCK)
INNER JOIN tAccum1DayPts tpts (NOLOCK) ON tpts.AccumId = x.AccumId    
INNER JOIN tBucketGroup bg (NOLOCK) ON bg.BucketGroupId = tpts.BucketGroupId AND bg.BucketGroupTypeId = 4  
INNER JOIN tPlayerClubStateEvaluationHistory h (NOLOCK) on h.PlayerId = x.PlayerId
WHERE Accumulator = 'DP' AND   
LastGamingDt between @FromDate AND @GamingDt
AND h.EvaluationScheduleId = @EvaluationScheduleId and h.EvaluationResult <> 30
GROUP BY x.PlayerId,h.OldClubState, h.NewClubState ) a
JOIN tPlayer p on p.PlayerId = a.PlayerId
JOIN tPlayerCard c on c.PlayerId = a.PlayerId


---Delete from tEvaluationSchedule where EvaluationScheduleId=10001042

select min(createddtm), max(createddtm) from tPlayerClubStateEvaluationHistory where EvaluationScheduleId = 10001226

select * from tPlayerClubStateEvaluationHistory where EvaluationScheduleId >= 10001239
and playerid= (select playerid from tplayercard where acct=20881303)

select top 10 c.Acct, t.ErrorMessage, t.EvaluationScheduleId, t.CreatedDtm  from tPlayerClubStateEvaluationHistory t 
join tPlayerCard c on c.PlayerId = t.PlayerId 
where c.Acct = 20881303 
order by t.CreatedDtm desc 


select top 10 c.Acct, t.ErrorMessage, t.*  from tPlayerClubStateEvaluationHistory t 
join tPlayerCard c on c.PlayerId = t.PlayerId 
where c.Acct = 20881303 
order by t.CreatedDtm desc 

Select * from tEvaluationSchedule where evaluationscheduleid = 10001239 





--- Delete from tPlayerClubStateEvaluationHistory where EvaluationScheduleId=10001042


select EvaluationScheduleId, convert(varchar(10),QualifyingDate) , count(*) from tPlayerClubStateEvaluationHistory where convert(int, EvaluationScheduleId) >= 10001040
and QualifyingDate>='2021-09-01'
group by EvaluationScheduleId, convert(varchar(10),QualifyingDate)
order by EvaluationScheduleId desc


 
--- Each of the evaluations. If it is status of 80, means that the COMMMIT JOB already run. Status of 60 means waiting for COMMIT
select top 100 * from tEvaluationSchedule t (nolock) order by t.CreatedDtm desc



-- Filter by a schedule ID to get the players that the job recommended to upgrade
SELECT EvaluationScheduleId, pc.Acct, t.PlayerId, t.EvaluationCriteria, t.EvaluationResult, t.OldClubState, t.NewClubState
---, tpn.ref1
--,t.QualifyingDate, t.ExpiryDate  
FROM tPlayerClubStateEvaluationHistory   t (NOLOCK) 
join tPlayerCard pc (nolock) on t.PlayerId = pc.PlayerId
---left join tplayernote tpn on t.playerid = tpn.playerid
WHERE 
t.EvaluationScheduleId = 10001165 and t.EvaluationResult <> 30 ---and acct in (20494592,10078419,21242310)
---NewClubstate = 71 and t.EvaluationResult <> 30
---and ref1 like 'Automatic Club Modification%'

--- TO CHECK FOR INFINITY
and NEwClubState not in (52,62)

and OLdClubState in (52,62)





-- Filter by a schedule ID to get the players that the job recommended to upgrade
SELECT EvaluationScheduleId, pc.Acct, t.PlayerId, t.EvaluationCriteria, t.EvaluationResult, t.OldClubState, t.NewClubState, *
---, tpn.ref1
--,t.QualifyingDate, t.ExpiryDate  
FROM tPlayerClubStateEvaluationHistory   t (NOLOCK) 
join tPlayerCard pc (nolock) on t.PlayerId = pc.PlayerId
---left join tplayernote tpn on t.playerid = tpn.playerid
WHERE 
t.EvaluationScheduleId >= 10000796 and t.EvaluationResult <> 30 ---and acct in (20494592,10078419,21242310)
---NewClubstate = 71 and t.EvaluationResult <> 30
---and ref1 like 'Automatic Club Modification%'

---TO CHECK FOR INFINITY
and NEwClubState in (52)




---t.EvaluationResult <> 30 and OldClubState<>40
---and t.playerid=2956
order by EvaluationScheduleId desc

-- Number of upgrades per run
select count(*) from tPlayerClubStateEvaluationHistory t
WHERE 
t.EvaluationScheduleId = 10000609 and t.EvaluationResult <> 30


---Delete  from  tEvaluationSchedule where EvaluationScheduleId>=10000673

select * from tPlayerClubStateEvaluationHistory where EvaluationScheduleId=10000609


----Delete  from tPlayerClubStateEvaluationHistory where EvaluationScheduleId>=10000673

GO 
-- Number of upgrades per run
select count(*), t.EvaluationScheduleId, t.NewClubState from tPlayerClubStateEvaluationHistory t
WHERE 
t.EvaluationScheduleId > 10000065 and t.EvaluationResult <> 30
group by t.EvaluationScheduleId,  t.NewClubState
having count(*)>2
order by t.EvaluationScheduleId asc




select top 100 * from tplayernote

--delete from tEvaluationSchedule where EvaluationScheduleId='10000609'


-- Filter by a schedule ID to get the players that the job recommended to upgrade
SELECT pc.Acct, t.PlayerId, t.EvaluationCriteria, t.EvaluationResult, t.OldClubState, t.NewClubState
--,t.QualifyingDate, t.ExpiryDate  
FROM tPlayerClubStateEvaluationHistory   t (NOLOCK) 
join tPlayerCard pc (nolock) on t.PlayerId = pc.PlayerId
WHERE t.EvaluationScheduleId = 10000012
and t.EvaluationResult <> 30
order by t.OldClubState, t.PlayerId



-- Upgraded counts
SELECT top 5 tes.EvaluationScheduleId, tes.Status, Gamingdt, count(*) as UpgradedPlayers
from tEvaluationSchedule tes inner join tPlayerClubStateEvaluationHistory tceh on tes.EvaluationScheduleId = tceh.EvaluationScheduleId
where tceh.EvaluationResult <> 30
group by  tes.EvaluationScheduleId, tes.Status, Gamingdt
order by tes.EvaluationScheduleId desc

select
tes.status,
gamingdt, 
t.EvaluationScheduleId, pc.Acct, t.PlayerId, FirstName, LastName, ClubStatus, t.EvaluationCriteria, t.EvaluationResult,
CASE WHEN t.OldClubState=40 then 'BRONZE'
	 WHEN t.OldClubState=51 then 'SILVER'
	 WHEN t.OldClubState=61 then 'GOLD'
	 WHEN t.OldClubState=71 then 'PLATINUM'
	 ELSE cast(t.OldClubState as varchar) END as OldClubstate,

CASE WHEN t.NewClubState=40 then 'BRONZE'
	 WHEN t.NewClubState=51 then 'SILVER'
	 WHEN t.NewClubState=61 then 'GOLD'
	 WHEN t.NewClubState=71 then 'PLATINUM'
	 ELSE cast(t.NewClubState as varchar) END as NewClubstate
FROM tPlayerClubStateEvaluationHistory   t (NOLOCK) 
inner join tEvaluationSchedule tes on t.EvaluationScheduleId = tes.EvaluationScheduleId
inner join viewPlayersVIejas pc (nolock) on t.PlayerId = pc.PlayerId
WHERE t.EvaluationScheduleId in (select top 5 EvaluationScheduleId from tEvaluationSchedule order by EvaluationScheduleId desc)
and t.EvaluationResult <> 30
order by EvaluationScheduleId desc


select top 10 * from tPlayerClubStateEvaluationHistory

select top 10 * from tplayer
select top 100 * from tPlayerType


select top 100 *  from tPlayerPoints
where playerid=10748465 and gamingdt>='07/01/20'



-- To check for Bronze
select va.playerid, sum(basepts) as TotalPoints , acct, Clubstatus, vpv.IsBanned from tPlayerPoints va inner join viewPlayersViejas vpv on va.playerid = vpv.playerid
inner join tplayer tpt on vpv.PlayerId=tpt.playerid

where gamingdt>='07/01/20' And Clubstatus='Bronze' and vpv.IsBanned=0 and BucketGroupId<>1
and tpt.PlayerTypeId<>3
group by va.playerid, acct, Clubstatus, vpv.IsBanned
having sum(basepts)>20000
order by sum(basepts) desc



-- To check for SILVER
select va.playerid, sum(basepts) as TotalPoints , acct, Clubstatus, vpv.IsBanned from tPlayerPoints va inner join viewPlayersViejas vpv on va.playerid = vpv.playerid
inner join tplayer tpt on vpv.PlayerId=tpt.playerid

where gamingdt>='07/01/20' And Clubstatus in ('SILVER') and vpv.IsBanned=0 and BucketGroupId<>1
and tpt.PlayerTypeId not in (3)
group by va.playerid, acct, Clubstatus, vpv.IsBanned
having sum(basepts)>100000
order by sum(basepts) desc


-- To check for SILVER
select top 20 va.playerid, sum(basepts) as TotalPoints , acct, Clubstatus from viewawardsviejas va inner join viewplayersviejas vpv on va.playerid = vpv.playerid
where gamingdt>='07/01/20' And Clubstatus ='Bronze' and IsBanned=0
group by va.playerid, acct, Clubstatus
having sum(basepts)>60000
order by sum(basepts) desc

-- To check for GOLD
select top 20 va.playerid, sum(basepts) as TotalPoints , acct, Clubstatus from viewawardsviejas va inner join viewplayersviejas vpv on va.playerid = vpv.playerid
where gamingdt>='07/01/20' And Clubstatus='GOLD'
group by va.playerid, acct, Clubstatus
having sum(basepts)>200000
order by sum(basepts) desc


-- To check for PLATINUM
select  va.playerid, sum(basepts) as TotalPoints , acct, Clubstatus from viewawardsviejas va inner join viewplayersviejas vpv on va.playerid = vpv.playerid
where gamingdt>='07/01/20' And Clubstatus<>'PLATINUM'
group by va.playerid, acct, Clubstatus
having sum(basepts)>500000
order by sum(basepts) desc



-- To check for INFINITY
select  va.playerid, sum(basepts) as TotalPoints , acct, Clubstatus from viewawardsviejas va inner join viewplayersviejas vpv on va.playerid = vpv.playerid
where gamingdt>='01/01/21' And Clubstatus<>'INFINITY'
group by va.playerid, acct, Clubstatus
having sum(basepts)>900000
order by sum(basepts) desc


-- To check for HEROES
select  va.playerid, sum(basepts) as TotalPoints , acct, Clubstatus from viewawardsviejas va inner join viewplayersviejas vpv on va.playerid = vpv.playerid
where gamingdt>='01/01/21' And Clubstatus='HEROES'
group by va.playerid, acct, Clubstatus
having sum(basepts)>60000
order by sum(basepts) desc

-- CLUB LEVELS 

SELECT acct, firstname, lastName, SUM(BasePts) AS TotalTierPoints, ClubStatus
FROM [tAccumKey] AK with (nolock) 
JOIN [tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and '20210531'
and ClubStatus in ('BRONZE','HEROES') and BucketGroupTypeId = 4  and IsBanned=0 and IsClubHold=0
group by acct,firstname, lastName, ClubStatus
having SUM(BasePts)>=20000

UNION

SELECT acct, firstname, lastName, SUM(BasePts) AS TotalTierPoints, ClubStatus
FROM [tAccumKey] AK with (nolock) 
JOIN [tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and '20210531'
and ClubStatus in ('SILVER', 'TRIBAL_GOLD') and BucketGroupTypeId = 4  and IsBanned=0 and IsClubHold=0
group by acct,firstname, lastName, ClubStatus
having SUM(BasePts)>=100000

UNION

SELECT acct, firstname, lastName, SUM(BasePts) AS TotalTierPoints, ClubStatus
FROM [tAccumKey] AK with (nolock) 
JOIN [tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and '20210531' and BucketGroupTypeId = 4  and IsBanned=0 and IsClubHold=0
and ClubStatus='GOLD' 
group by acct,firstname, lastName, ClubStatus
having SUM(BasePts)>500000

UNION

SELECT acct, firstname, lastName, SUM(BasePts) AS TotalTierPoints, ClubStatus
FROM [tAccumKey] AK with (nolock) 
JOIN [tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and '20210531' and BucketGroupTypeId = 4  and IsBanned=0 and IsClubHold=0
and ClubStatus='PLATINUM' 
group by acct,firstname, lastName, ClubStatus
having SUM(BasePts)>900000







AND acct = 20650684 and BucketGroupTypeId = 4 










select top 200 * from tplayercard where 
acct in (12179210, 20104527, 12352388)
iscardin=1 and modifieddtm<'2018-11-12 09:02:11.08 +00:00'
order by modifieddtm asc

--Update tplayercard set iscardin=0
where acct in (12179210, 20104527, 12352388)

select top 10 * from viewMyViejasRequal





SELECT count(*)
--,t.QualifyingDate, t.ExpiryDate  
FROM tPlayerClubStateEvaluationHistory   t (NOLOCK) 
join tPlayerCard pc (nolock) on t.PlayerId = pc.PlayerId
WHERE t.EvaluationScheduleId = 10000006
---and t.EvaluationResult <> 30


select top 10 * from tplayer

SELECT pc.Acct, t.PlayerId, t.EvaluationCriteria, t.EvaluationResult, t.OldClubState, t.NewClubState
--,t.QualifyingDate, t.ExpiryDate  
FROM tPlayerClubStateEvaluationHistory   t (NOLOCK) 
join tPlayerCard pc (nolock) on t.PlayerId = pc.PlayerId
WHERE t.EvaluationScheduleId = 10000005
and t.EvaluationResult <> 30
order by t.OldClubState, t.PlayerId

 update tEvaluationSchedule set Status=80 where EvaluationScheduleID=10000006


 --- TO GET COUNTS ON NOTES
Select GamingDt, Count(*) from tplayernote where ref1 like '%Automatic Club Modification%'
group by GamingDt
order by GamingDt asc


