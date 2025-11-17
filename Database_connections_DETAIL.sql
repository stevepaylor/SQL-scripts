USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 logintime
,dbname 
,loginname 
,hostname

FROM DBActivity

WHERE hostname LIKE '%BCCS%'

ORDER BY
 logintime DESC
,dbname 
,loginname 
,hostname


GO