USE [DBA]
GO

--------------------------------------------------------------------------------------------------
-- WORKSTATION
--------------------------------------------------------------------------------------------------
SELECT 
 CAST('Workstation' AS VARCHAR(30)) 'Client Type'
--,cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
,hostname AS AppServer
,MAX(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
,ENVIRONMENT = REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2))

FROM DBActivity

WHERE hostname IS NOT NULL
  AND hostname NOT IN (' ','initialize')
  AND hostname <> SERVERPROPERTY ('ServerName')
  AND hostname NOT LIKE '%DV.%'
  AND hostname NOT LIKE '%PR.%'
  AND hostname NOT LIKE '%QA.%'
  AND hostname NOT LIKE '%UT.%'
  AND REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2)) NOT IN ('DV','PR','QA','UT')
  AND hostname NOT IN ('DBAMDB01dv_NEW','FRX01','FRXDB01','FRXDBTEST01','GCITRAK2012','TEKTON')
  OR hostname LIKE '%SW' 
  OR hostname LIKE '%TW' 
  OR hostname LIKE '%SL'
  OR hostname LIKE '%W7'
  OR hostname LIKE '%XP'
  OR hostname LIKE '%XW'
  OR hostname LIKE '%7L'
  OR hostname LIKE '%EL'
  OR hostname LIKE 'ITD%'
  OR hostname LIKE 'BGCAGE0%'                                                                                                                          

GROUP BY
hostname

ORDER BY
hostname

GO

--------------------------------------------------------------------------------------------------
-- SERVER WITH STANDARD NAME
--------------------------------------------------------------------------------------------------

SELECT 
 CAST('Server with standard name' AS VARCHAR(30)) 'Client Type'
--,cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
,hostname AS AppServer
,MAX(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
,ENVIRONMENT = REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2))

FROM DBActivity

WHERE hostname IS NOT NULL
  AND hostname NOT IN (' ','initialize')
  AND hostname <> SERVERPROPERTY ('ServerName')
  AND hostname NOT LIKE 'ITD%'
  AND (REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2)) IN ('DV','PR','QA','UT')
   OR hostname LIKE '%DV.%'
   OR hostname LIKE '%PR.%' 
   OR hostname LIKE '%QA.%'  
   OR hostname LIKE '%UT.%')  
	   

GROUP BY
hostname

ORDER BY
hostname

GO

--------------------------------------------------------------------------------------------------
-- NON-STANDARD CLIENT TYPE
--------------------------------------------------------------------------------------------------

SELECT 
 CAST('Non-standard client type' AS VARCHAR(30)) 'Client Type'
--,cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
,hostname AS AppServer
,MAX(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
,ENVIRONMENT = REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2))

FROM DBActivity

WHERE hostname IS NOT NULL
  AND hostname NOT IN (' ','initialize')
  AND hostname <> SERVERPROPERTY ('ServerName')
  AND REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2)) NOT IN ('DV','PR','QA','UT')
  AND hostname NOT LIKE '%DV.%'
  AND hostname NOT LIKE '%PR.%'
  AND hostname NOT LIKE '%QA.%'
  AND hostname NOT LIKE '%UT.%'
  AND hostname NOT LIKE '%SW' 
  AND hostname NOT LIKE '%TW' 
  AND hostname NOT LIKE '%EW'
  AND hostname NOT LIKE '%SL'
  AND hostname NOT LIKE '%W7'
  AND hostname NOT LIKE '%XP'
  AND hostname NOT LIKE '%XW'
  AND hostname NOT LIKE '%7L'
  AND hostname NOT LIKE '%EL'
  AND hostname NOT LIKE 'ITD%' 
  AND hostname NOT LIKE 'BGCAGE0%'
   OR (hostname IN ('DBAMDB01dv_NEW','FRX01','FRXDB01','FRXDBTEST01','GCITRAK2012')
       AND hostname <> SERVERPROPERTY ('ServerName'))   	   

GROUP BY
hostname

ORDER BY
hostname

GO


--------------------------------------------------------------------------------------------------
-- ALL
--------------------------------------------------------------------------------------------------
SELECT 
 CAST('All clients' AS VARCHAR(30)) 'Client Type'
--,cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
,hostname AS AppServer
,MAX(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
,ENVIRONMENT = REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2))

FROM DBActivity

WHERE hostname IS NOT NULL
  AND hostname NOT IN (' ','initialize')
  AND hostname <> SERVERPROPERTY ('ServerName')

GROUP BY
hostname

ORDER BY
hostname

GO