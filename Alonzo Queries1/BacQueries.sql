
SELECT  
       vp.acct, 
       vp.FirstName, 
       vp.LastName,
       sum(tr.bet) as BetTotal,
       sum(tr.plays) as ratingPeriodPlays, 
	   sum(tr.ratingPeriodMinutes) as ratingPeriodMinutes,
	   sum(tr.bet)/sum(tr.plays) as AverageBet,
	   floor((sum(tr.ratingPeriodMinutes)/600)) as NumberAwards,
	   (floor((sum(tr.ratingPeriodMinutes)/600)) * sum(tr.bet)/sum(tr.plays)) as TotalAward

INTO #PlayerRating1
FROM 
       tTableRating tr INNER JOIN viewPlayersViejas vp ON tr.PlayerId = vp.PlayerId
WHERE tr.gameid in (2,10000505) and tr.IsVoid=0 and tr.IsOpenItem=0
and GamingDt between '12/27/2021' and '01/02/2022'
and tr.playerid in 
(
select playerid from tPlayerGroup tpg inner join tgroup tg on tpg.GroupId = tg.GroupId
where tpg.groupid=10000004 and tpg.IsInactive=0
)
group by  vp.acct, vp.FirstName, vp.LastName
having sum(tr.ratingPeriodMinutes)>=600

SELECT *, CEILING(TotalAward/25)*25 as Roundedto25
from #PlayerRating1

DROP Table  #PlayerRating1






SELECT  
       vp.acct, 
       vp.FirstName, 
       vp.LastName,
       sum(tr.bet) as BetTotal,
       sum(tr.plays) as ratingPeriodPlays, 
	   sum(tr.ratingPeriodMinutes) as ratingPeriodMinutes,
	   sum(tr.bet)/sum(tr.plays) as AverageBet,
	   floor((sum(tr.ratingPeriodMinutes)/600)) as NumberAwards,
	   (floor((sum(tr.ratingPeriodMinutes)/600)) * sum(tr.bet)/sum(tr.plays)) as TotalAward

INTO #PlayerRating1
FROM 
       tTableRating tr INNER JOIN viewPlayersViejas vp ON tr.PlayerId = vp.PlayerId
WHERE tr.gameid in (2,10000505) and tr.IsVoid=0 and tr.IsOpenItem=0
and GamingDt between '01/03/2022' and '01/09/2022'
and tr.playerid in 
(
select playerid from tPlayerGroup tpg inner join tgroup tg on tpg.GroupId = tg.GroupId
where tpg.groupid=10000004 and tpg.IsInactive=0
)
group by  vp.acct, vp.FirstName, vp.LastName
having sum(tr.ratingPeriodMinutes)>=600

SELECT *, CEILING(TotalAward/25)*25 as Roundedto25
from #PlayerRating1

DROP Table  #PlayerRating1



--select playerid from tPlayerGroup tpg inner join tgroup tg on tpg.GroupId = tg.GroupId
--where tpg.groupid=10000004 and tpg.IsInactive=0

---select top 100 * from tGame where GameId in (2,10000505)




---DECLARE @Acct INT = 20061967
---DECLARE @dt smalldatetime= '2017-0-01'
DECLARE @running_sum INT, @temp INT
DECLARE @running_sum2 INT, @temp2 INT

SELECT  
       tr.TranID,
       tr.bet, 
       tr.RatingPeriodMinutes as ratingPeriodMinutes, 
	   tr.Plays as ratingPeriodPlays,
       0 AS RunningTotal,
	   0 AS RunningTotalPlays,
       0 AS gamelevel,
       0 AS gamingdays,
       vp.acct, 
       vp.FirstName, 
       vp.LastName, 
       tr.GamingDt 
INTO #PlayerRating
FROM 
       tTableRating tr INNER JOIN viewPlayersViejas vp ON tr.PlayerId = vp.PlayerId
WHERE tr.gameid in (2,10000505) and tr.IsVoid=0 and tr.IsOpenItem=0
       AND  acct=@Acct
and tranID>=@TranID
ORDER BY tr.TranID ASC

UPDATE      #PlayerRating
SET         @temp = RunningTotal = COALESCE(@running_sum, 0) + ratingPEriodMinutes
            , @running_sum = CASE WHEN @temp < 600 THEN @temp ELSE 0 END
OPTION      (FORCE ORDER)

SELECT 
       ROW_NUMBER() OVER (ORDER BY TranID) AS RowNo,
    TranID 
       INTO #Prizelevels
FROM #PlayerRating where RunningTotal > 600


UPDATE pr SET pr.gamelevel = p.RowNo
FROM #PlayerRating pr INNER JOIN  #Prizelevels p on p.TranID = pr.TranID


DECLARE @i int = 0

WHILE @i <= (SELECT Max(gamelevel) FROM #PlayerRating)
BEGIN
       UPDATE #PlayerRating SET gamelevel = @i WHERE TranID < (Select TranID FROM #Prizelevels WHERE RowNo = @i) and gamelevel = 0
       SET @i =  @i + 1
       --PRINT @i
       CONTINUE
END

UPDATE #PlayerRating SET gamelevel = (SELECT Max(gamelevel) + 1  FROM #PlayerRating) WHERE gamelevel = 0

DECLARE @gamelevel int = 0
WHILE @gamelevel <= (SELECT Max(gamelevel) FROM #PlayerRating)
BEGIN
       DECLARE @mindt date, @maxdt date
       SELECT @mindt = GamingDt from #PlayerRating where TranID = (Select min(tranid) from #PlayerRating where gamelevel = @gamelevel)
       SELECT @maxdt = GamingDt from #PlayerRating where TranID = (Select max(tranid) from #PlayerRating where gamelevel = @gamelevel)
       UPDATE #PlayerRating SET gamingdays = DATEDIFF(day,@mindt,@maxdt) where gamelevel = @gamelevel
       SET @gamelevel =  @gamelevel + 1
       PRINT @gamelevel
       CONTINUE
END



Select * from #PlayerRating



DROP TABLE #PlayerRating
DROP TABLE #Prizelevels


select  top 1 GamingDt, TranId, PrizeCode, NetComp, IsOpenItem, te.FirstName, te.LastName, te.Login, va.TranCode, AuthAward, AwardUsed, Ref2 from viewAwardsViejas va
inner join temp te on va.AuthEmpID = te.EmpId
inner join viewPlayersViejas vp on va.PlayerID = vp.PlayerId
where acct=10029955 and PrizeCode ='BaccReb10H' and Trancode='AUTHPRMO'
order by GamingDt desc



select '0' as tranID, '0' as LabelID
UNION
select  tranid, convert(varchar(50),tranID) + ' - '  + DateName(weekday,gamingdt) + ' - ' + convert(varchar(10),gamingdt,101) as LabelID from tTableRating tr inner join viewPlayersViejas vp on tr.PlayerId = vp.PlayerId
where gameid in (2,10000505) and IsVoid=0 and IsOpenItem=0
and GamingDt>=getdate()-14 and acct=10029955
order by TranID asc


select Acct, vp.FirstName, vp.LastName, ClubStatus, te.FirstName as HostFirstName, te.LastName as HostLastName, GroupId from viewPlayersViejas vp
left join temp te on vp.HostEmpID = te.EmpId
left join  tPlayerGroup tpg  on tpg.playerid = vp.PlayerId and  tpg.groupid=10000004 and tpg.IsInactive=0
WHERE ACCT=10029955

select playerid from tPlayerGroup tpg inner join tgroup tg on tpg.GroupId = tg.GroupId
where tpg.groupid=10000004 and tpg.IsInactive=0

select Playerid, GamingdDT, count(*) from viewAwardsViejas
where-- playerid=(select playerid from tplayercard where acct=21255022)
and TranCode='ADJPRMO'


select Playerid, GamingDT, count(*) from viewAwardsViejas
where
TranCode='ADJPRMO' and GamingDt>'01/01/2022'
group by playerid, GamingDT
having count(*)>1
order by GamingDt asc
