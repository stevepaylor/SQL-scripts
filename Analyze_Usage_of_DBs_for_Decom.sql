USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
, dbname 
, loginname 
, hostname
, datediff(DAY,logintime,CURRENT_TIMESTAMP) as 'Days since last connection'

INTO #TMP1

FROM DBActivity

WHERE dbname not in ('DBA','master','msdb','tempdb','model','AAGtestdb') -- DON'T CARE ABOUT THESE
  and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','VIEJAS\dduck') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  and hostname NOT IN ('IDERAP01PR','IDERAP02PR','DBAMDB01UT') -- MONITORING SERVERS DON'T COUNT

order by
  [Server]
, dbname
, [Days since last connection]
, loginname 
, hostname

GO

SELECT 
  [Server]
, dbname
, hostname
, loginname
, MIN([Days since last connection]) as "Days Since Last Connection"

FROM #TMP1

group by
  [Server]
, dbname
, hostname
, loginname 


order by
  [Server]
, dbname
, hostname
, loginname 

GO

DROP TABLE #TMP1
GO