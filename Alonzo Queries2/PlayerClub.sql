select login, te.lastName, count(*) from viewPlayersViejas vp inner join temp te on vp.HostEmpID = te.empid
where te.lastname like '%lead%'
group by login, te.lastName


select NodeName, TranCode, shiftdt, count(*) from tAudit
where ShiftDt>= '05/01/2019' and NodeName like 'PC%'
group by NodeName, TranCode, ShiftDt


select TranCode, shiftdt, count(*) from tAudit ta inner join tTranCode tc
on ta.TranCode = tc.TranCode
where ShiftDt>= '05/01/2019' and NodeName like 'PC%'
group by TranCode, ShiftDt
order by shiftdt asc, trancode


select ta.TranCode, shiftdt, count(*), TranName from tAudit ta inner join tTranCode tc on ta.TranCode = tc.TranCode
where ShiftDt>= '05/01/2019' and NodeName like 'PC%'
and ta.trancode<>'PLDATA'
group by ta.TranCode, ShiftDt, TranName
order by shiftdt asc, ta.trancode


select top 100 * from tAudit
where ShiftDt= '05/01/2019' and NodeName like 'PC%' and Trancode='PLCARD'
group by NodeName, TranCode, ShiftDt


select tPA1.EmailAddress, acct,  pl.PlayerId, pl.LastName as PlayerLastName, pl.FirstName as PlayerFirstName, DisplayName, 
DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), SetupDtm) as SetupDTM
, SetupEmpId, te.Login, te.FirstName, te.LastName, Position from tPlayer pl
LEFT JOIN	dbo.tPlayerEmail tPA1 (NOLOCK) ON tPA1.PlayerId = pl.PlayerId 
			AND tPA1.ContactTypeId=1
inner join tEmp te on pl.SetupEmpId = te.EmpId
inner join tPlayerCard tpc on pl.PlayerId = tpc.PlayerId
Where convert(varchar,DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), SetupDtm) ,101) =@Date and (DisplayName<>'VIEJAS CASINO GUEST' and pl.LastName<>'Unidentified Player' and pl.FirstName<>'VIEJAS CASINO' and pl.LastName<>'GIFTCARD_TM'   and pl.LastName <> '/USA')
and len(acct)<=8