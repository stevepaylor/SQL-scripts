select Acct, len(Acct), ascii(SUBSTRING(Acct,9,1)) 
from CMKTDB13CPR.CMP13.dbo.tAudit 
where AuditID = 175268020

select REPLACE(Acct, char(9), ' '), len(REPLACE(Acct, char(9), ' ')), ascii(SUBSTRING(REPLACE(Acct, char(9), ' '),9,1)) 
from CMKTDB13CPR.CMP13.dbo.tAudit 
where AuditID = 175268020

Select 
  DBA.dbo.CleanAndTrimString(Acct)
, LEN(Acct)
, LEN(DBA.dbo.CleanAndTrimString(Acct))
from CMKTDB13CPR.CMP13.dbo.tAudit 
where AuditID = 175268020
