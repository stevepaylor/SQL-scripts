SELECT [JobName]
      ,[AllowJobToBeDisabled]
      ,[WhoSetAllowed]
      ,[SetAllowedDTM]
  FROM [DBA].[dbo].[Disabled_Job_Allowed_Control]

ORDER BY 
  [AllowJobToBeDisabled]
, [JobName]

GO

UPDATE [DBA].[dbo].[Disabled_Job_Allowed_Control]
SET 
  [WhoSetAllowed] = NULL

WHERE [AllowJobToBeDisabled] = 'N'
  AND ([SetAllowedDTM] IS NULL
	    OR [WhoSetAllowed] = 'Unknown')
GO

UPDATE [DBA].[dbo].[Disabled_Job_Allowed_Control]
SET 
  [WhoSetAllowed] = 'spaylor'
, [SetAllowedDTM] = GETDATE()

WHERE [JobName] IN (
  'DBA - Alert on Log Backup Job is Disabled'
, 'DBA - Backup DIFF (All Databases)'
, 'DBA - Backup FULL (All Databases)'
, 'DBA - Backup LOG (All Databases)'
, 'DBA - DBCC UPDATEUSAGE'
, 'DBA - Failure Job To Test Notifications'
, 'DBA - Test DB Mail - Operators - Notifications'
)
AND [WhoSetAllowed] =  'Initial Load'

GO

SELECT [JobName]
      ,[AllowJobToBeDisabled]
      ,[WhoSetAllowed]
      ,[SetAllowedDTM]
  FROM [DBA].[dbo].[Disabled_Job_Allowed_Control]

ORDER BY 
  [AllowJobToBeDisabled]
, [JobName]
GO

