USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
  --cast(SERVERPROPERTY ('ServerName') as varchar(40)) as "SQL Server"
 dbname 
, hostname AS "From Host"
, loginname AS "Using Login"
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
,'TITLE31'
)

  and hostname NOT IN ('ITD008TW','ITD007TW','ITD013TW','IDERAP01PR','IDERAP02PR','ITD065TW','DBAMDB01UT')
  and loginname not in ('initialize','VIEJAS\iderasvc','VIEJAS\MomAction','VIEJAS\pnguyen','VIEJAS\spaylor')

--  and datediff(DD,logintime,CURRENT_TIMESTAMP) > 7  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

group by
  dbname 
, hostname
, loginname 

order by
  dbname 
, hostname
, loginname 
GO