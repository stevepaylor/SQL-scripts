SELECT 
  j.[name] as jobname
--, ISNULL(CASE j.[description] WHEN 'No description available.' THEN NULL ELSE j.[description] END,' ') as job_description
--, j.[date_created]
--, j.[date_modified] as date_last_modified
--, s.[database_name]
, s.[step_id] as 'Step#'
, s.[step_name] 
--, s.[subsystem]
--, '"' + RTRIM(s.[command]) + '"' as step_command

FROM [msdb].[dbo].[sysjobsteps] s
JOIN [msdb].[dbo].[sysjobs] j
ON s.[job_id] = j.[job_id]

 WHERE j.[enabled] = 1
   AND j.[name] NOT LIKE '%DBA%'
   AND j.[name] NOT LIKE '%DMS%'
   AND j.[name] NOT IN ('syspolicy_purge_history','Restart 3 CMP Traces After SQL Is Restarted','Restart Vcomp SP Traces After SQL Is Restarted') 
