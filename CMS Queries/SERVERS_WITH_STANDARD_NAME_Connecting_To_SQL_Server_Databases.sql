USE [DBA]
GO

SELECT 
 --cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
 'Server with standard name'
,hostname AS AppServer
,MAX(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
,ENVIRONMENT = REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2))

FROM DBActivity

WHERE hostname IS NOT NULL
  AND hostname NOT IN (' ','initialize')
  AND hostname <> SERVERPROPERTY ('ServerName')

-- SERVER WITH STANDARD NAME

  AND REVERSE(SUBSTRING(REVERSE(RTRIM(hostname)),1,2)) IN ('DV','PR','QA','UT')
   OR hostname LIKE '%DV.%'
   OR hostname LIKE '%PR.%' 
   OR hostname LIKE '%QA.%'  
   OR hostname LIKE '%UT.%'  
	   

GROUP BY
hostname

ORDER BY
 ENVIRONMENT
,hostname
GO