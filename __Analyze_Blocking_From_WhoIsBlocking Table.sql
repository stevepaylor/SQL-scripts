/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Id]
      ,[CollectionTime]
      ,[ProcessId]
      ,[BlockedById]
      ,[HostName]
      ,[UserName]
      ,[DatabaseName]
      ,[OpenTransMin]
      --,[SqlString]
      --,[QueryPlan]
      ,[WaitTime]
      ,[LastWaitType]
      --,[ObjectList]
      --,[DiskWaitTime]
      --,[PageLifeExpectancy]
      --,[BufferCacheHitRatio]
      --,[vsUserObjectPct]
      --,[vsInternalObjectPct]
      --,[vsUseSpacePct]
      --,[vsFreeSpacePct]
      --,[vsTotalBytes]
      --,[LogSpaceUsed]
      --,[Reads]
  FROM [DBA].[dbo].[WhoIsBlocking]

  --where [BlockedById] like 'Blocker *** 0'

WHERE [ProcessId] IN (79,93)
   OR [BlockedById] IN ('79','93')

  order by [CollectionTime] desc

SELECT DISTINCT [ProcessId], [SqlString]
FROM [DBA].[dbo].[WhoIsBlocking]
WHERE [ProcessId] IN (79,93)