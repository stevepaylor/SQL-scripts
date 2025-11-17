SELECT	 [JobName] = [jobs].[name]
		,[Category] = [categories].[name]
		,[Owner] = SUSER_SNAME([jobs].[owner_sid])
		,[Enabled] = CASE [jobs].[enabled] WHEN 1 THEN 'Yes' ELSE 'No' END
		,[Description] = [jobs].[description]
		
FROM	 [msdb].[dbo].[sysjobs] AS [jobs] WITh(NOLOCK) 
		 INNER JOIN [msdb].[dbo].[syscategories] [categories] WITh(NOLOCK) 
				 ON [jobs].[category_id] = [categories].[category_id] 
		 LEFT OUTER JOIN 
					(	SELECT	 [job_id], [AvgDuration] = (SUM((([run_duration] / 10000 * 3600) + 
																(([run_duration] % 10000) / 100 * 60) + 
																 ([run_duration] % 10000) % 100)) * 1.0) / COUNT([job_id])
						FROM	 [msdb].[dbo].[sysjobhistory] WITh(NOLOCK)
						WHERE	 [step_id] = 0 
						GROUP BY [job_id]
					 ) AS [jobhistory] 
				 ON [jobhistory].[job_id] = [jobs].[job_id]

--WHERE [jobs].[name] NOT LIKE 'DBA%'
--  AND [jobs].[name] NOT LIKE 'syspolicy_purge_history';

--WHERE owner_sid <> 0x01
GO

--UPDATE [msdb].[dbo].[sysjobs] 
--SET [owner_sid] = 0x01
--WHERE [owner_sid] <> 0x01