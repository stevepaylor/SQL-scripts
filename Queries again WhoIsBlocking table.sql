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

where [BlockedById] IN ('438','143','Blocker *** 0')
--WHERE [ProcessId] = '438'
--WHERE [CollectionTime] < '2022-01-06 06:00'
--  AND [CollectionTime] > '2022-01-04 06:00'
--  AND [ProcessId] IN ('101','264','283')

--WHERE SqlString LIKE '%CREATE PROCEDURE sp_readrequest%'

--WHERE [HostName] = 'MSBIDB02DV'

order by 
  --[ProcessId]
 [CollectionTime] desc

