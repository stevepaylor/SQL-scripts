SELECT 
 MIN(DATEADD(HH,-8,StartTime)) AS 'Start Time' 
,MAX(DATEADD(HH,-8,EndTime))  AS 'End Time'
--,DATEDIFF(HOUR,MIN(StartTime),MAX(EndTime))
,[HostName]
,[ApplicationName]
,[SPID]
,sum([Duration]) as Duration
	  --,([Duration] / 1000) as Duration_Secs
,sum([Duration]) / 60000 as Duration_Mins
,sum([Duration]) / 3600000 as Duration_Hours
,sum([Reads]) as Reads
,sum([Writes]) as Writes
,sum([CPU]) as CPU
,sum([RowCounts]) as RowCounts

FROM [DBA].[dbo].[temp_trc]

WHERE TextData IS NOT NULL
  AND HostName = 'DWHDB01PR'

GROUP BY
 [HostName]
,[ApplicationName]
,[SPID]

ORDER BY
 --Duration_Mins DESC
 [End Time] desc
,[ApplicationName]
,[SPID]