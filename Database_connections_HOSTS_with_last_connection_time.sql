USE [DBA]
GO

EXEC GetDBconnections
GO

SELECT DISTINCT
hostname
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'

FROM DBActivity

GROUP BY
hostname

ORDER BY
hostname

GO