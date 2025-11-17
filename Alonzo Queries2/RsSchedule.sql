
USE reportserver
GO

-- TO GET THE 
select  
rs.ScheduleID,
c.Name,
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
Where c.[Name] like 'GOpeningDay1V2%'


---  Shell     EFAE2EE7-EA3B-4B49-90F2-7B4840B04866
Select top 100 * from Schedule
where ScheduleID='EFAE2EE7-EA3B-4B49-90F2-7B4840B04866'

---  MARCH MADNESS     A0EB60A5-C217-4A05-A2C2-9E2E595590E9
Select top 100 * from Schedule
where ScheduleID='A0EB60A5-C217-4A05-A2C2-9E2E595590E9'


--- Update the END DATE TO THE DESIRED DATE  --- SHELL
--Update Schedule
--set EndDate='2019-03-14 23:00:00.000'
--where ScheduleID='EFAE2EE7-EA3B-4B49-90F2-7B4840B04866'


--- Update the END DATE TO THE DESIRED DATE  --- MARCH MADNESS
--Update Schedule
--set EndDate='2019-03-16 02:00:00.000'
--where ScheduleID='A0EB60A5-C217-4A05-A2C2-9E2E595590E9'


----ScheduleID	Name	StartDate
----EE38B853-C5B4-4D48-AD46-8BA6636807A6	BigWheelDay1	2019-03-15 18:30:00.000
----952D4D94-7D7B-4B08-83B1-2532E5445FF8	BigWheelDay3	2019-03-17 13:30:00.000
----15F7E482-59C3-4B3E-B859-DD16C9963A39	BigWheelDay2	2019-03-16 16:30:00.000

---- DAY ONE
--Update Schedule
--set EndDate='2019-03-16 02:00:00.000'
--where ScheduleID='EE38B853-C5B4-4D48-AD46-8BA6636807A6'

---- DAY TWO
--Update Schedule
--set EndDate='2019-03-17 02:00:00.000'
--where ScheduleID='15F7E482-59C3-4B3E-B859-DD16C9963A39'

---- DAY THREE
--Update Schedule
--set EndDate='2019-03-18 02:00:00.000'
--where ScheduleID='952D4D94-7D7B-4B08-83B1-2532E5445FF8'