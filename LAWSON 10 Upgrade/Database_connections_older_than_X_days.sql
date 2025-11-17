USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 dbname 
,loginname 
,hostname
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'

FROM DBActivity

WHERE dbname not in ('DBA','master','msdb','tempdb','model','TestAAG') -- DON'T CARE ABOUT THESE
  and datediff(DD,logintime,CURRENT_TIMESTAMP) < 5  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

group by
 dbname 
,loginname 
,hostname

order by
 dbname 
,loginname 
,hostname

GO