
select top 10000 player_id, player_account_number, player_first_name, player_last_name, player_club_level,  ADP_3monthLGD,
0 as 'Number of Touches', 'Host Name' as 'Host Name'
into #HostablePlayers
from [tableau].[player_dim]
where  Player_host='N/A' and 
(player_club_level in ('GOLD', 'PLATINUM') or ADP_3monthLGD>=300)
and 
player_last_trip_date>=convert(nvarchar(10),getdate()-26, 101) 

-- DROP table #HostablePlayers

 --DROP table #TotalCounts


select playerid, empid, LastName, sum(TotalCount) as TotalCountFinal
into #TotalCounts
from
(
select tpn.playerid, tpn.empid, LastName, count(*) as TotalCount from CMKTDB13CPR.CMP13.dbo.tplayernote tpn inner join CMKTDB13CPR.CMP13.dbo.temp te on tpn.empid= te.empid
where gamingDT>=convert(nvarchar(10),getdate()-365, 101) and te.ishost=1 and Ref1 not like 'Club Modification%' and 
tpn.playerid in (select player_id from  #HostablePlayers)
group by tpn.playerid, tpn.empid, LastName

union all

Select tpn.playerid, tpn.empid, LastName, count(*) as TotalCount from CMKTDB13CPR.CMP13.dbo.viewawardsViejas tpn inner join CMKTDB13CPR.CMP13.dbo.temp te on tpn.empid= te.empid
where gamingDT>=convert(nvarchar(10),getdate()-365, 101) and te.ishost=1  and prizecode not LIKE 'C%'
and tpn.playerid in (select player_id from  #HostablePlayers)
group by tpn.playerid, tpn.empid, LastName
) t
group by playerid, empid, LastName

----select * from #TotalCounts a where a.ID = (Select max(TotalCountFinal) as ID FROM #TotalCounts b WHERE a.playerid = b.playerid) and a.playerid=3473

---select playerid, EMPID, LastName, TotalCountFinal from #TotalCounts a where TotalCountFinal = (Select top 1 max(TotalCountFinal) from #TotalCounts b where a.playerid = b.playerid) order by 1 


select * INTO #TotalCountsFinal from #TotalCounts a where TotalCountFinal = (Select top 1 max(TotalCountFinal) from #TotalCounts b where a.playerid = b.playerid) order by 1

UPDATE a SET a.[Number Of Touches]=b.TotalCountFinal, a.[HOST NAME] = b.LastName from #HostablePlayers a INNER JOIN #TotalCountsFinal b on a.player_id = b.playerid 
 
select player_id, player_account_number, player_first_name, player_last_name, player_club_level,
ADP_3monthLGD, [Number of Touches], [Host Name]
from  #HostablePlayers


DROP table #HostablePlayers
DROP table #TotalCounts
DROP table #TotalCountsFinal
