

---------  COUNTING POINTS
-- if the gameid=37, I want to divide the points by 5 before I sum them
select top 10 ROW_NUMBER() OVER (ORDER BY sum(BasePts) DESC) as POS, ClubStatus, FirstName + ' ' + left(LastName,1) as DisplayName,
sum(BasePts) as TotalPoints
from tawards va
Left Join tPlayerPoints pp (Nolock) on va.TranId = pp.TranId and pp.BucketGroupId=1
inner join viewplayersviejas tpc on va.playerid = tpc.playerid
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), va.POSTDTM) between '2020-06-07 02:00:00.00' and '2020-06-13 23:59:59.00'
and gameid not in (3) and ClubStatus='PLATINUM'
group by ClubStatus, FirstName, LastName---, GameID
---order by sum(BasePts) desc 

UNION ALL

select top 10 ROW_NUMBER() OVER (ORDER BY sum(BasePts) DESC) as POS, ClubStatus, FirstName + ' ' + left(LastName,1) as DisplayName,
sum(BasePts) as TotalPoints
from tawards va
Left Join tPlayerPoints pp (Nolock) on va.TranId = pp.TranId and pp.BucketGroupId=1
inner join viewplayersviejas tpc on va.playerid = tpc.playerid
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), va.POSTDTM) between '2020-06-07 02:00:00.00' and '2020-06-13 23:59:59.00'
and gameid not in (3) and ClubStatus='GOLD'
group by ClubStatus, FirstName, LastName---, GameID
---order by sum(BasePts) desc 


---------  COUNTING POINTS
-- if the gameid=37, I want to divide the points by 5 before I sum them
select top 10 ROW_NUMBER() OVER (ORDER BY sum(BasePts) DESC) as POS, ClubStatus, FirstName + ' ' + left(LastName,1) as DisplayName,
sum(BasePts) as TotalPoints
from tawards va
Left Join tPlayerPoints pp (Nolock) on va.TranId = pp.TranId and pp.BucketGroupId=1
inner join viewplayersviejas tpc on va.playerid = tpc.playerid
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), va.POSTDTM) between '2020-06-07 02:00:00.00' and '2020-06-13 23:59:59.00'
and gameid not in (3) and ClubStatus='PLATINUM'
group by ClubStatus, FirstName, LastName---, GameID
---order by sum(BasePts) desc 

UNION ALL

select top 10 ROW_NUMBER() OVER (ORDER BY sum(BasePts) DESC) as POS, ClubStatus, FirstName + ' ' + left(LastName,1) as DisplayName,
sum(BasePts) as TotalPoints
from tawards va
Left Join tPlayerPoints pp (Nolock) on va.TranId = pp.TranId and pp.BucketGroupId=1
inner join viewplayersviejas tpc on va.playerid = tpc.playerid
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), va.POSTDTM) between '2020-06-07 02:00:00.00' and '2020-06-13 23:59:59.00'
and gameid not in (3) and ClubStatus='GOLD'
group by ClubStatus, FirstName, LastName---, GameID
---order by sum(BasePts) desc 
------------------------------------


--- COUNTING TICKETS
select top 10 ROW_NUMBER() OVER (ORDER BY sum(tpsb.stubsbal) DESC) as POS, ClubStatus, FirstName + ' ' + left(LastName,1) as DisplayName, sum(tpsb.stubsbal) as TotalPoints 
---,BucketGroupId, acct
from viewPlayersViejas vp
inner join tPlayerStubBal tpsb on vp.PlayerId = tpsb.PlayerId
where isBanned=0 and 
LastName<>'PROMOTION' and len(acct)<=8 
and ClubStatus ='PLATINUM'
and BucketGroupId=10000106
group by BucketGroupId,acct,ClubStatus, FirstName, LastName
---order by sum(tpsb.stubsbal) desc

UNION ALL

select top 10 ROW_NUMBER() OVER (ORDER BY sum(tpsb.stubsbal) DESC) as POS, ClubStatus, FirstName + ' ' + left(LastName,1) as DisplayName, sum(tpsb.stubsbal) as TotalPoints 
---,BucketGroupId, acct
from viewPlayersViejas vp
inner join tPlayerStubBal tpsb on vp.PlayerId = tpsb.PlayerId
where isBanned=0 and 
LastName<>'PROMOTION' and len(acct)<=8 
and ClubStatus ='GOLD'
and BucketGroupId=10000106
group by BucketGroupId,acct,ClubStatus, FirstName, LastName
---order by sum(tpsb.stubsbal) desc



---

--- FOR DRAWING  PLATINUM

SELECT * INTO #t3 FROM
(
select ROW_NUMBER() OVER (ORDER BY sum(tpsb.stubsbal) DESC) as POS, Acct, ClubStatus, FirstName, LastName, sum(tpsb.stubsbal) as TotalPoints 
---,BucketGroupId, acct
from viewPlayersViejas vp
inner join tPlayerStubBal tpsb on vp.PlayerId = tpsb.PlayerId
where isBanned=0 and 
LastName<>'PROMOTION' and len(acct)<=8 
and ClubStatus ='PLATINUM'
and BucketGroupId=10000106
group by BucketGroupId,acct,ClubStatus, FirstName, LastName
having  sum(tpsb.stubsbal)>=10000

) AS temp

--Select top 5 PERCENT * from #t order by NEWID()

---Select top 8 *, 'Top8' as Section from #t3 where POS<=8
---UNION  
Select top 3 *, 'RandomWinner' as Section into #t4 from #t3  where POS>8 order by NEWID() 

Select top 8 *, 'Top8' as Section from #t3 where POS<=8
UNION ALL
Select * from  #t4


DROP Table #T3 
DROP Table #T4




SELECT * INTO #t5 FROM
(
select ROW_NUMBER() OVER (ORDER BY sum(tpsb.stubsbal) DESC) as POS, Acct, ClubStatus, FirstName, LastName, sum(tpsb.stubsbal) as TotalPoints 
---,BucketGroupId, acct
from viewPlayersViejas vp
inner join tPlayerStubBal tpsb on vp.PlayerId = tpsb.PlayerId
where isBanned=0 and 
LastName<>'PROMOTION' and len(acct)<=8 
and ClubStatus ='GOLD'
and BucketGroupId=10000106
group by BucketGroupId,acct,ClubStatus, FirstName, LastName
having  sum(tpsb.stubsbal)>=7500

) AS temp

Select top 3 *, 'RandomWinner' as Section into #t6 from #t5  where POS>8 order by NEWID() 

Select top 8 *, 'Top8' as Section from #t5 where POS<=8
UNION ALL
Select * from  #t6


DROP Table #T5 
DROP Table #T6


