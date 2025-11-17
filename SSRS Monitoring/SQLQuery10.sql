select s.*, r.*, j.*
from ReportServer.dbo.Subscriptions s
join ReportServer.dbo.ReportSchedule r on r.SubscriptionID = s.SubscriptionID
join msdb.dbo.sysjobs j on j.name = convert(sysname, r.ScheduleID)

where S.Description LIKE '%TOP%'