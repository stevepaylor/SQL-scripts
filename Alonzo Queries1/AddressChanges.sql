-- Change on Addresses
select top 1000 NodeName, TranCode, ShiftDt, ta.PostDtm, Acct, DataName, DataValue, Login, FirstName, LastName from tAudit ta inner join tAuditDtl tad on ta.AuditId = tad.AuditId
inner join temp te on ta.EmpId = te.EmpId
where Login='11240' and Trancode='PLDATA'
order by ta.AuditID desc

-- Change on Birthday
select top 1000 NodeName, TranCode, ShiftDt, ta.PostDtm, Acct, DataName, DataValue, Login, FirstName, LastName from tAudit ta inner join tAuditDtl tad on ta.AuditId = tad.AuditId
inner join temp te on ta.EmpId = te.EmpId
where Login='11240' and Trancode='PLDATA' and dataName in ('BirthDt','BirthDtOld')
order by ta.AuditID desc




