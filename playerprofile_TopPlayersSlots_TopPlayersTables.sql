-- TopPlayersSlots
SELECT  TOP 10
	P.LastName,P.FirstName,P.Acct, P.HostEmpID, P.ClubStatus, te.LastName as HostLastName, te.FirstName as HostFirstName,
	sum(A.Bet)  as 'Bet',
	sum(A.CasinoWin) as 'CasinoWin',
	sum(A.PaidOut) as 'PaidOut',
	sum(A.Jackpot) as 'Jackpot',
	sum(A.TheorWin) as 'TheorWin',
	sum(A.RatingPeriodMinutes) as 'TotalMinutes',
	DeptCode,
	tpc.iscardin,
	CASE WHEN lo.DeptID = 11 AND rtrim(COALESCE (lo.MachStand, '')) 
                      <> '' THEN lo.MachStand ELSE ae.AreaCode END AS LastAreaID
FROM
	viewAllRatingsViejasNoAwards A
	inner join viewplayersViejas p on A.playerid = p.playerid
	left join temp te on P.HostEmpid = te.empid
	inner join tPlayerCasino tpc on p.PlayerId = tpc.PlayerId
	LEFT OUTER JOIN dbo.tLocn AS lo WITH (NOLOCK) ON lo.LocnID = p.LastLocnID
	LEFT OUTER JOIN dbo.tArea AS ae WITH (NOLOCK) ON ae.AreaID = lo.AreaID 
WHERE 	A.deptID=11
	and GamingDT=  @ToDate
Group By P.Acct, P.LastName,P.FirstName,P.Acct,P.HostEmpID, P.ClubStatus, te.LastName,te.FirstName, tpc.iscardin, lo.DeptID, lo.MachStand, ae.AreaCode, DeptCode 
order by sum(A.CasinoWin) desc

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT  TOP 10
	P.LastName,P.FirstName,P.Acct, P.HostEmpID, P.ClubStatus, te.LastName as HostLastName, te.FirstName as HostFirstName,
	sum(A.Bet)  as 'Bet',
	sum(A.CasinoWin) as 'CasinoWin',
	sum(A.PaidOut) as 'PaidOut',
	sum(A.Jackpot) as 'Jackpot',
	sum(A.TheorWin) as 'TheorWin',
	sum(A.RatingPeriodMinutes) as 'TotalMinutes',
	DeptCode,
	tpc.iscardin,
	CASE WHEN lo.DeptID = 11 AND rtrim(COALESCE (lo.MachStand, '')) 
                      <> '' THEN lo.MachStand ELSE ae.AreaCode END AS LastAreaID
FROM
	viewAllRatingsViejasNoAwards A
	inner join viewplayersViejas p on A.playerid = p.playerid
	left join temp te on P.HostEmpid = te.empid
	inner join tPlayerCasino tpc on p.PlayerId = tpc.PlayerId
	LEFT OUTER JOIN dbo.tLocn AS lo WITH (NOLOCK) ON lo.LocnID = p.LastLocnID
	LEFT OUTER JOIN dbo.tArea AS ae WITH (NOLOCK) ON ae.AreaID = lo.AreaID 
WHERE 	A.deptID=11
	and GamingDT=  @ToDate
Group By P.Acct, P.LastName,P.FirstName,P.Acct,P.HostEmpID, P.ClubStatus, te.LastName,te.FirstName, tpc.iscardin, lo.DeptID, lo.MachStand, ae.AreaCode, DeptCode 
order by sum(A.CasinoWin) asc

----------------------------------------------------------------------------------------------------------------------------------------

Create Table #Days (datelist smalldatetime)
declare @i  int
select @i = 0
while @i < 31
begin
	insert into #days select dateadd(day, -1*@i, getdate())
	select @i = @i +1
end

select convert(char(10), datelist, 101) as DateList from #Days
drop table #days




-- TopPlayersTable

SELECT  TOP 10
	P.LastName,P.FirstName,P.Acct, P.HostEmpID, P.ClubStatus, te.LastName as HostLastName, te.FirstName as HostFirstName,
	sum(A.BuyIn)  as 'Bet',
	sum(A.CasinoWin) as 'CasinoWin',
	sum(A.PaidOut) as 'PaidOut',
	sum(A.Jackpot) as 'Jackpot',
	sum(A.TheorWin) as 'TheorWin',
	sum(A.RatingPeriodMinutes) as 'TotalMinutes',
	DeptCode,
	tpc.iscardin,
	a.IsOpenItem,
	---CASE WHEN lo.DeptID=13 AND rtrim(COALESCE (lo.MachStand, '')) 
                ---      <> '' THEN lo.MachStand ELSE lo.LocnCode END AS LastAreaID

		CASE WHEN lo.DeptID = 11 AND rtrim(COALESCE (lo.MachStand, '')) 
                      <> '' THEN lo.MachStand ELSE lo.LocnCode END AS LastAreaID

FROM
	viewAllRatingsViejasNoAwards A
	inner join viewplayersViejas p on A.playerid = p.playerid
	left join temp te on P.HostEmpid = te.empid
	inner join tPlayerCasino tpc on p.PlayerId = tpc.PlayerId
	LEFT OUTER JOIN dbo.tLocn AS lo WITH (NOLOCK) ON lo.LocnID = p.LastLocnID
	LEFT OUTER JOIN dbo.tArea AS ae WITH (NOLOCK) ON ae.AreaID = lo.AreaID 
WHERE 	A.deptID=13
	and GamingDT=  @ToDate
Group By P.Acct, P.LastName,P.FirstName,P.Acct,P.HostEmpID, P.ClubStatus, te.LastName,te.FirstName, tpc.iscardin,a.IsOpenItem, lo.DeptID, lo.MachStand
, lo.LocnCode, DeptCode, ae.AreaCode 
order by sum(A.CasinoWin) desc

-------------------------------------------------------------------------------------------------------------------------------

SELECT  TOP 10
	P.LastName,P.FirstName,P.Acct, P.HostEmpID, P.ClubStatus, te.LastName as HostLastName, te.FirstName as HostFirstName,
	sum(A.Buyin)  as 'Bet',
	sum(A.CasinoWin) as 'CasinoWin',
	sum(A.PaidOut) as 'PaidOut',
	sum(A.Jackpot) as 'Jackpot',
	sum(A.TheorWin) as 'TheorWin',
	sum(A.RatingPeriodMinutes) as 'TotalMinutes',
	DeptCode,
	tpc.iscardin,
	a.IsOpenItem,
	----CASE WHEN lo.DeptID  in (1, 13) AND rtrim(COALESCE (lo.MachStand, '')) 
                 ----     <> '' THEN lo.MachStand ELSE  lo.LocnCode END AS LastAreaID

	CASE WHEN lo.DeptID = 11 AND rtrim(COALESCE (lo.MachStand, '')) 
                      <> '' THEN lo.MachStand ELSE lo.LocnCode END AS LastAreaID

FROM
	viewAllRatingsViejasNoAwards A
	inner join viewplayersViejas p on A.playerid = p.playerid
	left join temp te on P.HostEmpid = te.empid
	inner join tPlayerCasino tpc on p.PlayerId = tpc.PlayerId
	LEFT OUTER JOIN dbo.tLocn AS lo WITH (NOLOCK) ON lo.LocnID = p.LastLocnID
	LEFT OUTER JOIN dbo.tArea AS ae WITH (NOLOCK) ON ae.AreaID = lo.AreaID 
WHERE 	A.deptID in (1, 13)
	and GamingDT=  @ToDate
Group By P.Acct, P.LastName,P.FirstName,P.Acct,P.HostEmpID, P.ClubStatus, te.LastName,te.FirstName, tpc.iscardin,a.IsOpenItem, lo.DeptID, lo.MachStand
,  lo.LocnCode, DeptCode, ae.AreaCode 
order by sum(A.CasinoWin) asc

-----------------------------------------------------------------------------------------------------------------

Create Table #Days (datelist smalldatetime)
declare @i  int
select @i = 0
while @i < 31
begin
	insert into #days select dateadd(day, -1*@i, getdate())
	select @i = @i +1
end

select convert(char(10), datelist, 101) as DateList from #Days
drop table #days