select
'SubnDesc' = s.Description,
'SubnOwner' = us.UserName,
'LastStatus' = s.LastStatus,
'LastRun' = s.LastRunTime,
'ReportPath' = c.Path,
'ReportModifiedBy' = uc.UserName,
'ScheduleId' = rs.ScheduleId,
'SubscriptionId' = s.SubscriptionID
from ReportServer.dbo.Subscriptions s
join ReportServer.dbo.Catalog c on c.ItemID = s.Report_OID
join ReportServer.dbo.ReportSchedule rs on rs.SubscriptionID = s.SubscriptionID
join ReportServer.dbo.Users uc on uc.UserID = c.ModifiedByID
join ReportServer.dbo.Users us on us.UserID = s.OwnerId
join msdb.dbo.sysjobs j on j.name = CONVERT(nvarchar(128),rs.ScheduleId)

--WHERE s.LastStatus LIKE 'Error%'
--   OR s.LastStatus LIKE 'Failure%'

ORDER BY s.LastRunTime DESC

--Failure sending mail: An error has occurred during report processing.Mail will not be resent.

--select distinct
--'LastStatus' = s.LastStatus
--from ReportServer.dbo.Subscriptions s
