USE reportserver
GO

select  c.Name,
s.StartDate,
s.NextRunTime,
s.LastRunTime,
s.EndDate,
s.RecurrenceType,
s.LastRunStatus,
s.MinutesInterval,
s.DaysInterval,
s.WeeksInterval,
s.DaysOfWeek,
s.DaysOfMonth,
s.[Month],
s.MonthlyWeek
from    dbo.catalog c with (nolock)
inner join  dbo.ReportSchedule rs
on  rs.ReportID = c.ItemID
inner join  dbo.Schedule s with (nolock)
on  rs.ScheduleID = s.ScheduleID
--Where c.[Name] like 'big%'
