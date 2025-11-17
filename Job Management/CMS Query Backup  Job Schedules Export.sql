USE msdb
GO 

SELECT 
  @@SERVERNAME AS Instance_Name
  , JOB.job_id AS Job_Id
  , JOB.name AS Job_Name
  , Job_Status =
    CASE
		WHEN JOB.enabled = 1 THEN 'Enable'
        ELSE 'Disable'
    END            
  , JOB.description AS Job_Description
  , SCH.schedule_id AS Schedule_Id
 
FROM msdb.dbo.sysjobs JOB

LEFT JOIN dbo.sysjobschedules JS
  ON JOB.job_id = JS.job_id

LEFT JOIN dbo.sysschedules SCH
  ON JS.schedule_id = SCH.schedule_id 

--WHERE JOB.enabled = 1
--  AND SCH.enabled = 1
  --AND JOB.name LIKE 'DBA - BACKUP%'

ORDER BY 
JOB.job_id

/***************************************
Schedules
***************************************/

SELECT 
  @@SERVERNAME AS Instance_Name
  , SCH.schedule_id AS Schedule_Id
  , SCH.name AS Schedule_Name
  , Schedule_Status =
	CASE
		WHEN SCH.enabled = 1 THEN 'Enable'
        WHEN SCH.enabled = 0 THEN 'Disable'
        ELSE 'Not Schedule'
	END
--, SCH.active_start_date
--, SCH.active_end_date
  , SCH.active_start_time AS 'Schedule_Start_Time'
  --, SCH.active_end_time
  , JOB.job_id AS Job_Id

FROM msdb.dbo.sysjobs JOB

LEFT JOIN dbo.sysjobschedules JS
  ON JOB.job_id = JS.job_id

LEFT JOIN dbo.sysschedules SCH
  ON JS.schedule_id = SCH.schedule_id 

--WHERE JOB.enabled = 1
--  AND SCH.enabled = 1
--  --AND JOB.name LIKE 'DBA - BACKUP%'

ORDER BY 
SCH.schedule_id