/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Id]
      ,[CollectionTime]
      ,[ProcessId]
      ,[BlockedById]
      ,[HostName]
      ,[UserName]
      ,[DatabaseName]
      ,[OpenTransMin]
      ,[SqlString]
      ,[QueryPlan]
      ,[WaitTime]
      ,[LastWaitType]
      ,[ObjectList]
      ,[DiskWaitTime]
      ,[PageLifeExpectancy]
      ,[BufferCacheHitRatio]
      ,[vsUserObjectPct]
      ,[vsInternalObjectPct]
      ,[vsUseSpacePct]
      ,[vsFreeSpacePct]
      ,[vsTotalBytes]
      ,[LogSpaceUsed]
      ,[Reads]
  FROM [DBA].[dbo].[WhoIsBlocking]
  where BlockedById like 'Blocker *** 0'
     or BlockedById in ('112','75')

  order by [CollectionTime]

  --DBCC opentran()

  SELECT *
  INTO [DBA].[dbo].[WhoIsBlocking_save_Jan7]
  FROM [DBA].[dbo].[WhoIsBlocking]