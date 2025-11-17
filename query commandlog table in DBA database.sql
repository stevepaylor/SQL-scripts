/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID]
      ,[DatabaseName]
      ,[SchemaName]
      ,[ObjectName]
      ,[ObjectType]
      ,[IndexName]
      ,[IndexType]
      ,[StatisticsName]
      ,[PartitionNumber]
      ,[ExtendedInfo]
      ,[Command]
      ,[CommandType]
      ,[StartTime]
      ,[EndTime]
      ,[ErrorNumber]
      ,[ErrorMessage]
  FROM [DBA].[dbo].[CommandLog]

	WHERE [DatabaseName] = 'CMP13'
	  AND [CommandType] LIKE 'BACKUP_DATABASE'

	SELECT MIN([StartTime])
	FROM [DBA].[dbo].[CommandLog]