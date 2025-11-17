USE [DBA]
GO

exec GetDBconnections
GO

SELECT 
 cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
,dbname 
,loginname 
,hostname
,logintime
,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last login' 

FROM DBActivity

WHERE dbname not in ('master','msdb','tempdb','DBA','model') -- DON'T CARE ABOUT THESE
--WHERE loginname not in ('VIEJAS\spaylor') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
--  and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  
  --and datediff(DD,logintime,CURRENT_TIMESTAMP) > 7  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

  AND loginname NOT IN ('Initialize','VIEJAS\spaylor','VIEJAS\hsimpson')

ORDER BY
 --datediff(DD,logintime,CURRENT_TIMESTAMP)
 dbname 
,loginname 
,hostname
,logintime desc

GO