SELECT
  [name]
, [owner_sid]
, SUSER_SNAME([jobs].[owner_sid])

FROM [msdb].[dbo].[sysjobs] jobs

SELECT 
  [name]
, [sid]
--, SUSER_SNAME([jobs].[owner_sid])

FROM [master].[sys].[syslogins]
--WHERE [name] IN ('ITappsDBA','DBAdmin','sa')

--SELECT
--  [name]
--, [owner_sid]
--, SUSER_SNAME([jobs].[owner_sid])

--UPDATE [msdb].[dbo].[sysjobs] 
--SET [owner_sid] = 0x01
--WHERE [owner_sid] = 0xA1DA420FB45E824FAC8C27D0D09FFA9A