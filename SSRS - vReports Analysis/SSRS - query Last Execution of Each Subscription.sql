SELECT
c.Name AS ReportName,
su.Description AS SubscriptionDesc,
su.EventType AS SubscriptionType,
su.LastStatus,
su.LastRunTime,
sch.Name AS ScheduleName,
sch.EventType AS ScheduleType,
CASE sch.RecurrenceType
WHEN 1 THEN 'Once'
WHEN 2 THEN 'Hourly'
WHEN 4 THEN 'Daily/Weekly'
WHEN 5 THEN 'Monthly'
END AS ScheduleFrequency,
su.Parameters
FROM
ReportServer.dbo.Subscriptions su
JOIN
ReportServer.dbo.Catalog c ON su.Report_OID = c.ItemID
JOIN
ReportServer.dbo.ReportSchedule rsc ON rsc.ReportID = c.ItemID AND rsc.SubscriptionID = su.SubscriptionID
JOIN
ReportServer.dbo.Schedule sch ON rsc.ScheduleID = sch.ScheduleID
ORDER BY
su.LastRunTime DESC;