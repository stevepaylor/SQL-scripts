--USE [DBA]
--GO

--exec GetDBconnections
--GO

--SELECT DISTINCT
-- dbname  
--,loginname 
--,hostname
--,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'

--FROM DBActivity

--WHERE dbname not in ('DBA','master','msdb','tempdb','model','CMKTDB_ARCHIVE','CMP13_0410','CMKTDB_ARCHIVE_OLD','Viejas_Custom_Processes',
--'_Dev_ShoppingPortal','distribution','Love_Test','TraceOutput','SDSVJPRD_0410','SDSMainDistribution') -- DON'T CARE ABOUT THESE

--AND loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','VIEJAS\spaylor','VIEJAS\PNguyen','VIEJAS\QDang','DPA',
--'VIEJAS\Slewis','VIEJAS\RWA2','VIEJAS\MSpellman','VIEJAS\erevak','VIEJAS\jgiolitto','VIEJAS\SMarshall','VIEJAS\JLayno') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE

--AND hostname NOT IN ('DBAMDB01PR','ITD016TW','BTJUMP01','BTJUMP02')

--AND hostname NOT LIKE 'MKT%'
--AND hostname NOT LIKE 'SFC%'

--AND datediff(DD,logintime,CURRENT_TIMESTAMP) <= 365  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

--AND hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE

--group by
-- dbname  
--,hostname
--,loginname 

--order by
-- dbname  
--,hostname
--,loginname
--,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP))
--GO

------------------------------------------------------------------------------------------------------------
--USE [DBA]
--GO

--exec GetDBconnections
--GO

--SELECT DISTINCT
-- dbname  
--,loginname 
--,hostname
--,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'

--FROM DBActivity

--WHERE dbname not in ('DBA','master','msdb','tempdb','model','CMKTDB_ARCHIVE','CMP13_0410','CMKTDB_ARCHIVE_OLD','Viejas_Custom_Processes',
--'_Dev_ShoppingPortal','distribution','Love_Test','TraceOutput','SDSVJPRD_0410','') -- DON'T CARE ABOUT THESE

--AND hostname = SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE

--AND loginname not in ('initialize','VIEJAS\spaylor','VIEJAS\PNguyen','VIEJAS\QDang','DPA',
--'VIEJAS\Slewis','VIEJAS\RWA2','VIEJAS\MSpellman','VIEJAS\erevak','VIEJAS\jgiolitto','VIEJAS\SMarshall','VIEJAS\JLayno') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE

----AND loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','VIEJAS\spaylor','VIEJAS\PNguyen','VIEJAS\QDang','DPA',
----'VIEJAS\Slewis','VIEJAS\RWA2','VIEJAS\MSpellman','VIEJAS\erevak','VIEJAS\jgiolitto','VIEJAS\SMarshall','VIEJAS\JLayno') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE

----AND hostname NOT IN ('DBAMDB01PR','ITD016TW','BTJUMP01')

----AND hostname NOT LIKE 'MKT%'

--AND datediff(DD,logintime,CURRENT_TIMESTAMP) <= 365  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

--group by
-- dbname  
--,hostname
--,loginname 

--order by
-- dbname  
--,hostname
--,loginname
--,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP))
--GO

------------------------------------------------------------------------------------------------------------------------------

SELECT 
  [name] as 'Job Name'
, CASE  WHEN [description] IS NULL THEN CAST(' ' as varchar(1000)) 
		WHEN [description] = 'No description available.' THEN CAST(' ' as varchar(100)) 
		ELSE [description] END as 'Description'
, CASE enabled WHEN 1 THEN ' ' ELSE 'disabled' END as 'Enabled?'
FROM msdb.dbo.sysjobs

WHERE [name] NOT LIKE '%DBA%'
  AND [name] NOT LIKE 'DBMR%'
  AND [name] NOT LIKE 'DMS%'

ORDER BY
  enabled desc
, [name]