CREATE TABLE #prizes   
 (  
    gamingdt varchar(20),  
    [Hour] int,
    PrizeCount  int,  
    FPCCount  int
)  

select gamingdt, prizecode,  datepart("hh", DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM) ) as Hour, COUNT(*) as PrizesAwarded INTO #p from tAwards ta inner join
tprize tp on ta.prizeid = tp.PrizeID
where PrizeCode in ('P19EGA1ATT', 'P19EGA1F20') and gamingdt>='05/05/19'
group by gamingdt, datepart("hh", DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM) ), prizecode
order by  gamingdt ASC,  datepart("hh", DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM) ) ASC 
 
INSERT INTO #prizes(gamingdt,[Hour],PrizeCount,FPCCount)
SELECT gamingdt,[Hour],0,0 from #p

UPDATE a SET PrizeCount = b.PrizesAwarded FROM #prizes a INNER JOIN #p b on a.gamingdt = b.gamingdt and a.[Hour] = b.Hour
WHERE b.prizecode = 'P19EGA1ATT'

UPDATE a SET FPCCount = b.PrizesAwarded FROM #prizes a INNER JOIN #p b on a.gamingdt = b.gamingdt and a.[Hour] = b.Hour
WHERE b.prizecode = 'P19EGA1F20'

Select distinct gamingdt,[Hour],PrizeCount,FPCCount from #prizes order by gamingdt,[Hour]


DROP TABLE #prizes
Drop table #p


select top 100 * from viewAwardsViejas

select gamingdt, prizecode,  ta.POSTDTM, playerid from viewAwardsViejas ta 
where PrizeCode in ('P19EGA4ATT', 'P19EGA4F20') and gamingdt='2019-05-27'



go

select top 100 gamingdt, prizecode,  DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM), playerid from tAwards ta inner join
tprize tp on ta.prizeid = tp.PrizeID
where PrizeCode in ('P19EGA4ATT', 'P19EGA4F20') and gamingdt='2019-05-27'



select va.playerid, sum(basepts) as TotalPoints , acct, FirstName, LastName from viewAwardsViejas va inner join tplayercard tpc on va.PlayerID = tpc.PlayerId
inner join tplayer tp on tpc.playerid = tp.playerid
where postdtm between '2019-05-27 15:00:00.00' and '2019-05-27 20:30:00.00'
and va.playerid in
(
select playerid from tAwards ta inner join
tprize tp on ta.prizeid = tp.PrizeID
where PrizeCode in ('P19EGA4ATT', 'P19EGA4F20') and gamingdt='2019-05-27'
group by playerid
having count(*)=1
)
group by va.playerid, acct, FirstName, LastName
having sum(basepts)>0




