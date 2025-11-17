SELECT 
 ms.[InstanceName]
--,ms.[Active] AS Instance_Active
,bt.[TemplateID]
,bt.[SQLServerID]
,bt.[Template]
--,bt.[BaselineName]
,bt.[Active] AS Baseline_Template_Active

FROM [SQLdmRepository].[dbo].[BaselineTemplates] bt
JOIN [SQLdmRepository].[dbo].[MonitoredSQLServers] ms
ON bt.SQLServerID = ms.SQLServerID

WHERE ms.[Active] = 1
--WHERE bt.[Active] = 1

ORDER BY 
 ms.[InstanceName] 
,bt.[TemplateID]

--SELECT *
--INTO [SQLdmRepository].[dbo].[BaselineTemplates_Save]
--FROM [SQLdmRepository].[dbo].[BaselineTemplates]

UPDATE [SQLdmRepository].[dbo].[BaselineTemplates]
SET [Active] = 1
--WHERE [Template] LIKE '<?xml version="1.0" encoding="utf-16"?><BaselineTemplate%' 
WHERE [TemplateID] IN
(
SELECT MAX([TemplateID]) 
FROM [SQLdmRepository].[dbo].[BaselineTemplates]
GROUP BY [SQLServerID]
)

DELETE FROM [SQLdmRepository].[dbo].[BaselineTemplates]
WHERE [Template] NOT LIKE '<?xml version="1.0" encoding="utf-16"?><BaselineTemplate%' 