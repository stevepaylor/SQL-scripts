UPDATE [Job_Tracking].[dbo].[Disabled_Job_Tracking_Centralized]
SET [AllowDisabledSetBy] = NULL

--WHERE [AllowDisabledSetBy] = 'Unknown'
WHERE [AllowDisabled] = 'N'
  --AND JobName NOT LIKE 'DBA%'