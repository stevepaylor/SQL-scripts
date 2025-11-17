SELECT *
  FROM [ReportServer].[dbo].[ExecutionLog]

  WHERE [TimeStart] > '2025-05-13 06:00'
    --and ReportPath LIKE '%/IT/ITOps%'

  ORDER BY [TimeStart] asc

------------------------------------------------------------------------------------------------

  SELECT *
  FROM [ReportServer].[dbo].[ExecutionLog2]

  WHERE [TimeStart] > '2025-05-13 06:00'
    and ReportPath LIKE '%Bannned%'

  ORDER BY [TimeStart] desc

------------------------------------------------------------------------------------------------

  SELECT *
  FROM [ReportServer].[dbo].[ExecutionLog3]

  WHERE [TimeStart] > '2025-05-13 06:00'
    and ItemPath LIKE '%Bannned%'

  ORDER BY [TimeStart] desc
