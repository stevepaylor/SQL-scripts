SELECT [job_id]
, j.[name] as jobname
, ISNULL(CASE j.[description] WHEN 'No description available.' THEN NULL ELSE j.[description] END,' ')
, j.[date_created]
, j.[date_modified] as date_last_modified

  FROM [msdb].[dbo].[sysjobs] j

 WHERE j.[enabled] = 1
   AND j.[name] NOT LIKE 'DBA%'
   AND j.[name] <> 'syspolicy_purge_history'
 