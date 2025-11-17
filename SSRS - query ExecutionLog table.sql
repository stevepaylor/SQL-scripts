SELECT  
  c.Name
, c.[Path]
, MAX(l.TimeStart) AS 'Latest Start'
, MIN(l.TimeStart) AS 'Oldest Start'
, DATEDIFF(DAY,MIN(l.TimeStart),MAX(l.TimeStart) +1) AS 'Period of Runs - Days'
, COUNT(*) AS 'Number of Runs'
, COUNT(*) / DATEDIFF(DAY,MIN(l.TimeStart),MAX(l.TimeStart) +1) AS 'Average Runs Per Day'

FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID

WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
  AND Name <> 'ReportCurrentTimestamp'

GROUP BY 
  c.Name
, c.[Path]

ORDER BY 
  MAX(l.TimeStart) DESC
, COUNT(*) / DATEDIFF(DAY,MIN(l.TimeStart),MAX(l.TimeStart) +1) DESC
, c.Name
, c.[Path];