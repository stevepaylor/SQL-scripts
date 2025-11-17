
Declare @Dept varchar(10)
Declare @ToDate varchar(10)
Declare @Host varchar(10)


set @Dept=''
set


SELECT  TOP 50
	P.LastName,P.FirstName,P.Acct, P.HostEmpID, P.ClubStatus, te.LastName as HostLastName, te.FirstName as HostFirstName,
	sum(A.Bet)  as 'Bet',
	sum(A.CasinoWin) as 'CasinoWin',
	sum(A.PaidOut) as 'PaidOut',
	sum(A.Jackpot) as 'Jackpot',
	sum(A.TheorWin) as 'TheorWin',
	sum(A.RatingPeriodMinutes) as 'TotalMinutes',
	DeptCode
FROM
	viewAllRatingsViejasNoAwards A
	inner join viewplayersViejas p on A.playerid = p.playerid
	left join temp te on P.HostEmpid = te.empid
WHERE 	deptID LIKE  '%' + @Dept + '%' 
	and GamingDT=  @ToDate
	AND (P.HostEmpID LIKE '%' + @Host + '%')	
Group By P.Acct, P.LastName,P.FirstName,P.Acct,P.HostEmpID, P.ClubStatus, te.LastName,te.FirstName, DeptCode order by sum(A.CasinoWin) desc