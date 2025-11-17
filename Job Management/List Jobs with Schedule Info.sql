USE msdb
GO 
SELECT Job.name        AS JobName,
       CASE
         WHEN Job.enabled = 1 THEN 'Enable'
         ELSE 'Disable'
       END             AS Job_Status,
       JOB.description AS Job_Description,
       SCH.name        AS Schedule_Name,
       CASE
         WHEN SCH.enabled = 1 THEN 'Enable'
         WHEN SCH.enabled = 0 THEN 'Disable'
         ELSE 'Not Schedule'
       END             AS Schedule_Status,
       --SCH.active_start_date,
       --SCH.active_end_date,
       SCH.active_start_time AS Schedule_Start_Time
       --SCH.active_end_time
 FROM   dbo.sysjobs JOB
      LEFT JOIN dbo.sysjobschedules JS
               ON Job.job_id = JS.job_id
       LEFT JOIN dbo.sysschedules SCH
               ON JS.schedule_id = SCH.schedule_id 

WHERE Job.enabled = 1
  --AND SCH.enabled = 1
  AND (Job.name LIKE '%DIFF%' OR Job.name LIKE '%FULL%' OR Job.name LIKE '%INCR%')

ORDER BY 
  SCH.active_start_time
, SCH.name