select top 1000 * from tTranCode  where TranName like '%secu%'
where isaudit=1

select top 100 * from tAudit
where trancode in 
(select trancode from tTranCode  where TranName like '%secur%')

select top 100 * from tAudit
where EMPID=322
order by AuditId desc

order by shiftDT desc


order by auditID desc

select top 100 * from temp where login='11240'

