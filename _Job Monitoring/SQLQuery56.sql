INSERT INTO [Job_Tracking].[dbo].[Invalid_Disabled_Jobs_Alert]
SELECT 
  [InstanceName]
, [JobName]
, [Enabled]
, [LastChangedDTM]
, [LastCheckedDTM]
, [AllowDisabled]
, [AllowDisabledSetDTM]
, [AllowDisabledSetBy]

--INTO [Job_Tracking].[dbo].[Invalid_Disabled_Jobs_Alert]

FROM [Job_Tracking].[dbo].[Disabled_Job_Tracking_Centralized]

WHERE [Enabled] <> 1
  AND [AllowDisabled] <> 'Y'

