SELECT 
  [InstanceName] + ' ' as Instance
, [JobName] + ' ' as Job
, CONVERT(CHAR(10),[LastChangedDTM],120) + '  ' as 'Last Changed On   '
, CONVERT(CHAR(10),[LastCheckedDTM],120) + '  ' as 'Last Checked On   '
, CASE [AllowDisabled] WHEN 'Y' THEN 'Yes' ELSE 'No' END as ' Disable is Allowed ?   '
, CONVERT(CHAR(10),[AllowDisabledSetDTM],120) + '  ' as 'Set to Allow On   '
, [AllowDisabledSetBy] + '  ' as 'Set to Allowed By   '
, CASE [Enabled] WHEN 0 THEN 'Yes' ELSE 'No' END + '  ' as 'Job is Currently Disabled ?'

--INTO dbo.Audit_Report_Allow_Job_Disable

FROM [Job_Tracking].[dbo].[Disabled_Job_Tracking_Centralized]

WHERE [InstanceName] LIKE 'CMKTDB13%PR'