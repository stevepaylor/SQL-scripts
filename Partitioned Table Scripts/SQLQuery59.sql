SELECT DISTINCT
 [Player_account_number]
--,[FirstName]
--,[LastName]
--,[EmailAddress]
--,[ProgramName]
--,[CampaignName]
--,[Activity]
,[ActivityDate]
--,[FileId]
,COUNT(*)

FROM [vDW].[dbo].[PlayerActivity]

--WHERE [Player_account_number] = '20882048'
--WHERE [Player_account_number] IS NOT NULL
--  AND [Player_account_number] <> ' '
--  AND [ProgramName] IS NOT NULL
--  AND [ProgramName] <> ' '
--  AND [CampaignName] IS NOT NULL
--  AND [CampaignName] <> ' '


GROUP BY
 [Player_account_number]
--------,[FirstName]
--------,[LastName]
--------,[EmailAddress]
--------,[ProgramName]
--------,[CampaignName]
----,[Activity]
,[ActivityDate]
----,[FileId]

HAVING COUNT(*) > 1

ORDER BY
 [Player_account_number]
--------,[FirstName]
--------,[LastName]
--------,[EmailAddress]
--------,[ProgramName]
--------,[CampaignName]
--------,[Activity]
,[ActivityDate]
--------,[FileId]