SELECT 
 DATEADD(HH,-8,StartTime) AS 'StartTime' 
,DATEADD(HH,-8,EndTime)  AS 'EndTime'
,[HostName]
,[ApplicationName]
,[DatabaseName]
,[SPID]
,TextData
,Duration
	  --,([Duration] / 1000) as Duration_Secs
,[Duration] / 60000 as Duration_Mins
,[Duration] / 3600000 as Duration_Hours
,Reads
,Writes
,CPU
,RowCounts

FROM [DBA].[dbo].[temp_trc]

WHERE TextData IS NOT NULL
  AND HostName NOT IN ('DWHDB01PR','ITD016TW')
  --AND DatabaseName = 'iQ-Gaming-repl'
  AND ApplicationName NOT LIKE 'SQLAgent%'
    AND ApplicationName NOT LIKE 'RdsAdminService%'
  AND ApplicationName NOT LIKE 'Microsoft SQL Server Management Studio%'
  --AND TextData LIKE '%iQC_Offers_Live_Repl%'

ORDER BY
 --Duration DESC
 [EndTime] desc
,[ApplicationName]
,[DatabaseName]
,[SPID]