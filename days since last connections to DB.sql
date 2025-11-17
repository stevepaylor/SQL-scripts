USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 @@SERVERNAME 'Instance'
,dbname
,hostname
,loginname 

,MIN(datediff(hour,logintime,CURRENT_TIMESTAMP)) as 'Hours since last connection'

--INTO DBA.dbo.DBACCESS_Analysis_A

FROM DBActivity

--WHERE dbname LIKE'Key%' 
WHERE dbname not in ('DBA','master','msdb','tempdb','model','CMP13_0410') -- DON'T CARE ABOUT THESE
  and loginname not in ('VIEJAS\gMSA014$','NT SERVICE\SQLTELEMETRY','NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize',
  'NT AUTHORITY\NETWORK SERVICE','VIEJAS\hsimpson','VIEJAS\SQLService1','VIEJAS\momaction','VIEJAS\iderasvc01','VIEJAS\DDuck') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  and loginname NOT LIKE ('VIEJAS\%MSA%$')
  ----and loginname not in ('VIEJAS\NDabbara','VIEJAS\PNguyen','VIEJAS\spaylor','VIEJAS\Sysintellidba','DPA','VIEJAS\VImmanni','VIEJAS\QDang','VIEJAS\AlVizcarra') -- Apps Team access and DPA
  ----and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  ----and (hostname NOT IN ('ITD013TW','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  ----and hostname NOT IN ('ITD016TW','ITD065TW','DBAMDB01UT')
  ----and hostname NOT LIKE 'SDS%13%'
  and datediff(DD,logintime,CURRENT_TIMESTAMP) <= 10  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!
--  and dbname IN (SELECT [NAME] FROM SYS.databases)

group by
 dbname
,hostname
,loginname 


order by
 dbname
, MIN(datediff(hour,logintime,CURRENT_TIMESTAMP))
,hostname
,loginname 

GO