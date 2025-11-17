USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
  --cast(SERVERPROPERTY ('ServerName') as varchar(40)) as "SQL Server"
  hostname AS "From Host"
--, dbname 
--, loginname AS "Using Login"
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
--, MIN(datediff(HOUR,logintime,CURRENT_TIMESTAMP)) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity
WHERE dbname not in ('DBA','master','msdb','tempdb','model','AAGtestdb') -- DON'T CARE ABOUT THESE
  and dbname in (
 'CASH_VARIANCE'
,'COMMON_SECURITY'
,'FLOORVIZ'
,'GUEST_MOBILE'
,'ICBWebReports'
,'SLOT_PARTICIPATION'
,'SLOT_SERVICE'
)

  and hostname NOT IN ('ITD008TW','ITD007TW','ITD013TW','IDERAP01PR','IDERAP02PR','ITD065TW','DBAMDB01UT','CASIVC07PR','CASIDB14PR','CASIDB10PR')
  AND hostname NOT LIKE 'APPSWB%'
  and loginname not in ('initialize','VIEJAS\iderasvc','VIEJAS\MomAction','VIEJAS\pnguyen','VIEJAS\spaylor')

  and datediff(DD,logintime,CURRENT_TIMESTAMP) < 31  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

group by
  hostname
--, dbname 

order by
  hostname
--, dbname 

GO