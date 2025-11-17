USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 dbname  
,loginname 
,hostname
,logintime

FROM DBActivity

WHERE dbname IN ('OperaData_Temp')
  --AND hostname = 'MRKTAP03PR'
  --AND loginname = 'cmpDW'
  AND datediff(DD,logintime,CURRENT_TIMESTAMP) < 1


order by
 dbname  
,loginname 
,hostname

GO