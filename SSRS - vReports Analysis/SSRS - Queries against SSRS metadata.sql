----SELECT COUNT(*),
----       MIN(ExecutionLog.TimeStart)
----FROM [ReportServer].[dbo].ExecutionLog(NOLOCK);

SELECT TOP 10000 c.Name,
               c.[Path],
               l.InstanceName,
               l.ReportID,
               l.UserName,
               l.RequestType,
               l.Format,
               l.Parameters,
               l.TimeStart,
               l.TimeEnd,
               l.TimeDataRetrieval,
               l.TimeProcessing,
               l.TimeRendering,
               l.Source,
               l.Status,
               l.ByteCount,
               l.[RowCount]
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 5 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
ORDER BY l.TimeStart DESC;


-- Counts by users
SELECT count(*), UserName
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
group by UserName
order by count(*) desc

---   Report Counts
SELECT c.Name,
       c.[Path],
       COUNT(*) AS TimesRun,
       MAX(l.TimeStart) AS [LastRun]
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
GROUP BY l.ReportId,
         c.Name,
         c.[Path];



-- Written by Steve Stedman http://SteveStedman.com
SELECT c.Name,
       c.[Path],
       COUNT(*) AS TimesRun,
       MAX(l.TimeStart) AS [LastRun],
(
    SELECT SUBSTRING(
                    (
                        SELECT CAST(', ' AS VARCHAR(MAX))+CAST(c1.Name AS VARCHAR(MAX))
                        FROM [ReportServer].[dbo].[Catalog] AS c
                        INNER JOIN [ReportServer].[dbo].[DataSource] AS d ON c.ItemID = d.ItemID
                        INNER JOIN [ReportServer].[dbo].[Catalog] c1 ON d.Link = c1.ItemID
                        WHERE c.Type = 2
                              AND c.ItemId = l.ReportId
                        FOR XML PATH('')
                    ), 3, 10000000) AS list
) AS DataSources
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
GROUP BY l.ReportId,
         c.Name,
         c.[Path];


-- Written by Steve Stedman http://SteveStedman.com
SELECT c.Name,
       c.[Path],
       COUNT(*) AS TimesRun,
       MAX(l.TimeStart) AS [LastRun],
(
    SELECT SUBSTRING(
                    (
                        SELECT CAST(', ' AS VARCHAR(MAX))+CAST(c1.Name AS VARCHAR(MAX))
                        FROM [ReportServer].[dbo].[Catalog] AS c
                        INNER JOIN [ReportServer].[dbo].[DataSource] AS d ON c.ItemID = d.ItemID
                        INNER JOIN [ReportServer].[dbo].[Catalog] c1 ON d.Link = c1.ItemID
                        WHERE c.Type = 2
                              AND c.ItemId = l.ReportId
                        FOR XML PATH('')
                    ), 3, 10000000) AS list
) AS DataSources,
(
    SELECT SUBSTRING(
                    (
                        SELECT CAST(', ' AS VARCHAR(MAX))+CAST(REPLACE(t.UserName, 'DOMAIN_NAME\', '') AS VARCHAR(MAX))
                        FROM
                        (
                            SELECT TOP 100000 l2.UserName+'('+CAST(COUNT(*) AS VARCHAR(100))+')' AS UserName
                            FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l2
                            WHERE l2.ReportID = l.ReportId
                            GROUP BY l2.UserName
                            ORDER BY COUNT(*) DESC
                        ) AS t
                        FOR XML PATH('')
                    ), 3, 10000000)
) AS UsedBy
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
GROUP BY l.ReportId,
         c.Name,
         c.[Path];


--Reports by count that have been run in the last 24 hours
SELECT c.Name,
       c.[Path],
       COUNT(*) AS TimesRun,
       MAX(l.TimeStart) AS [LastRun]
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
      AND l.TimeStart >= GETDATE() - 1
GROUP BY l.ReportId,
         c.Name,
         c.[Path];


-- Reports by count that have been run in the last 7 days
-- Written by Steve Stedman http://SteveStedman.com
SELECT c.Name,
       c.[Path],
       COUNT(*) AS TimesRun,
       MAX(l.TimeStart) AS [LastRun]
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
      AND l.TimeStart >= GETDATE() - 7
GROUP BY l.ReportId,
         c.Name,
         c.[Path];

--USAGE BY USER
-- Written by Steve Stedman http://SteveStedman.com
SELECT l.UserName,
       COUNT(*) AS TimesRun,
       MAX(l.TimeStart) AS [LastReportRun]
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
GROUP BY l.UserName;
 
-- Reports Datasource
-- Written by Steve Stedman http://SteveStedman.com
SELECT c.name,
       c1.Name datasource,
       c.ItemId
FROM [ReportServer].[dbo].[Catalog] AS c
INNER JOIN [ReportServer].[dbo].[DataSource] AS d ON c.ItemID = d.ItemID
INNER JOIN [ReportServer].[dbo].[Catalog] c1 ON d.Link = c1.ItemID
WHERE c.Type = 2;



-- Written by Steve Stedman http://SteveStedman.com
SELECT TOP 100 c.Name,
               c.[Path],
               AVG(l.TimeDataRetrieval + l.TimeProcessing + l.TimeRendering) / 1000.0 [AverageExecutionTimeSeconds],
               SUM(l.TimeDataRetrieval + l.TimeProcessing + l.TimeRendering) / 1000.0 [TotalExecutionTimeSeconds],
               SUM(l.TimeDataRetrieval + l.TimeProcessing + l.TimeRendering) / 1000.0 / 60 [TotalExecutionTimeMinutes],
               COUNT(*) TimesRun
FROM [ReportServer].[dbo].[ExecutionLog](NOLOCK) AS l
INNER JOIN [ReportServer].[dbo].[Catalog](NOLOCK) AS c ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
GROUP BY c.Name,
         c.[Path],
         l.InstanceName,
         l.ReportID
HAVING AVG(l.TimeDataRetrieval + l.TimeProcessing + l.TimeRendering) / 1000.0 > 1
ORDER BY AVG(l.TimeDataRetrieval + l.TimeProcessing + l.TimeRendering) DESC;
 
-- List the reports with the last time run
-- Written by Steve Stedman http://SteveStedman.com
SELECT c.Name,
       c.[Path],
       MAX(l.TimeStart) AS [LastRun]
FROM [ReportServer].[dbo].[ExecutionLog] AS l WITH (NOLOCK)
INNER JOIN [ReportServer].[dbo].[Catalog] AS c WITH (NOLOCK) ON l.ReportID = C.ItemID
WHERE c.Type = 2 -- Only show reports 1=folder, 2=Report, 3=Resource, 4=Linked Report, 5=Data Source
GROUP BY l.ReportId,
         c.Name,
         c.[Path]
ORDER BY [LastRun] DESC;