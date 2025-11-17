

----select top 100 * from tprize where prizecode like 'P19GGA%ATT'

select * into #TotalPlayers FROM
(
select Distinct va.PlayeriD from tAwards va inner join viewAllRatingsViejasNoAwardsNoGMT vrv on va.playerid=vrv.playerid
where va.GamingDt in ('2019-07-07','2019-07-08') and prizeid='10090162' and vrv.GamingDt in  ('2019-07-07','2019-07-08')

UNION ALL

select Distinct va.PlayeriD from tAwards va inner join viewAllRatingsViejasNoAwardsNoGMT vrv on va.playerid=vrv.playerid
where va.GamingDt in ('2019-07-14','2019-07-15') and prizeid='10090163' and vrv.GamingDt in  ('2019-07-14','2019-07-15')

UNION ALL

select Distinct va.PlayeriD from tAwards va inner join viewAllRatingsViejasNoAwardsNoGMT vrv on va.playerid=vrv.playerid
where va.GamingDt in ('2019-07-21','2019-07-22') and prizeid='10090164' and vrv.GamingDt in  ('2019-07-21','2019-07-22')


UNION ALL

select Distinct va.PlayeriD from tAwards va inner join viewAllRatingsViejasNoAwardsNoGMT vrv on va.playerid=vrv.playerid
where va.GamingDt in ('2019-07-28','2019-07-29') and prizeid='10090165' and vrv.GamingDt in  ('2019-07-28','2019-07-29')

) as TEMP


SELECT * INTO #hotseatplayer FROM

(
	select va.playerid, Acct, LastName, FirstName, ClubStatus, MachStand, replace(tl.LocnCode, 'VJC-V', '') as MachNum
	from viewAwardsViejas vA with(nolock)
	inner join viewPlayersViejas vpv with(nolock) on vA.PlayerID = vpv.Playerid
	inner join tLocn tl with(nolock) on vpv.LastLocnId = tl.LocnId
	where 
	GamingDt =  '07/29/2019' and postdtm between  DATEADD(mi,-30,GETDATE()) and getdate()
	and IsCardIn=1 		and ClubStatus in ('PLATINUM','MVP','GOLD','ELITE') and 
	isbanned=0 and vpv.IsInactive=0 and IsClubHold=0  
	and va.playerid in
	(
		Select Playerid from #TotalPlayers
		group by Playerid
		having count(*)>=4
	)
	group by acct,  firstName, LastName, Clubstatus, MachStand, replace(tl.LocnCode, 'VJC-V', ''), va.playerid
	having sum(vA.BasePts)>=1

	UNION ALL

	select vp.playerid, Acct, LastName, FirstName, ClubStatus,  AreaName as MachStand, LocnCode as MachNum from viewPlayersViejas vp with(nolock)
	inner join tTableRating tr with(nolock) on vp.PlayerId = tr.PlayerId
	inner join tlocn tl with(nolock) on tl.LocnID = tr.LocnId
	inner join tarea ta on tl.AreaId = ta.AreaId
	where IsOpenItem=1 and GamingDt='07/29/2019'
	and isbanned=0 and vp.IsInactive=0 and IsClubHold=0
	and len(acct)<=8
	and vp.playerid in
	(
		Select Playerid from #TotalPlayers
		group by Playerid
		having count(*)>=4
	)


	UNION  ALL

	select va.playerid, Acct, LastName, FirstName, ClubStatus, MachStand, replace(tl.LocnCode, 'VJC-V', '') as MachNum
	from viewAwardsViejas vA with(nolock)
	inner join viewPlayersViejas vpv with(nolock) on vA.PlayerID = vpv.Playerid
	inner join tLocn tl with(nolock) on vpv.LastLocnId = tl.LocnId
	where 
	GamingDt =  '07/29/2019' and postdtm between  DATEADD(mi,-30,GETDATE()) and getdate()
	and IsCardIn=1 		and ClubStatus in ('Bronze','SILVER')  and 
	isbanned=0 and vpv.IsInactive=0 and IsClubHold=0  
	and va.playerid in
	(
		Select Playerid from #TotalPlayers
		group by Playerid
		having count(*)>=4
	)
	group by acct,  firstName, LastName, Clubstatus, MachStand, replace(tl.LocnCode, 'VJC-V', ''), va.playerid
	having sum(vA.BasePts)>=10



) as temp

Select top 50 * from #hotseatplayer
order by NEWID() 


Drop Table #TotalPlayers
Drop Table  #hotseatplayer