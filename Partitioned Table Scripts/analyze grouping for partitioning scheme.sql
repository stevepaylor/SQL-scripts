USE [PartitionThis] ;
GO

SELECT 
 CONVERT(CHAR(6), [ActivityDate], 112) AS ActivityYYYYMM
 --CAST([ActivityDate] AS CHAR(6)) AS ActivityYYYYMM
,COUNT(*)

--FROM [vDW].[dbo].[PlayerActivity]
FROM [PartitionThis].[dbo].[PlayerActivity_Partitioned]

GROUP BY
  CONVERT(CHAR(6), [ActivityDate], 112)
	--CAST([ActivityDate] AS CHAR(6))

ORDER BY
  CONVERT(CHAR(6), [ActivityDate], 112)
	--CAST([ActivityDate] AS CHAR(6))



SELECT 
 CONVERT(CHAR(4), [ActivityDate], 112) AS ActivityYYYY
 --CAST([ActivityDate] AS CHAR(6)) AS ActivityYYYYMM
,COUNT(*)

--FROM [vDW].[dbo].[PlayerActivity]
FROM [PartitionThis].[dbo].[PlayerActivity_Partitioned]

GROUP BY
  CONVERT(CHAR(4), [ActivityDate], 112)
	--CAST([ActivityDate] AS CHAR(6))

ORDER BY
  CONVERT(CHAR(4), [ActivityDate], 112)
	--CAST([ActivityDate] AS CHAR(6))


SELECT 
  CONVERT(CHAR(4), [ActivityDate], 112) + 'Q' + CAST(DATEPART(QUARTER, [ActivityDate]) AS CHAR(1)) AS ActivityQTR
 --CAST([ActivityDate] AS CHAR(6)) AS ActivityYYYYMM
,COUNT(*) AS ActivityDateCount

--FROM [vDW].[dbo].[PlayerActivity]
FROM [PartitionThis].[dbo].[PlayerActivity_Partitioned]

GROUP BY
  CONVERT(CHAR(4), [ActivityDate], 112) + 'Q' + CAST(DATEPART(QUARTER, [ActivityDate]) AS CHAR(1))
--  CONVERT(CHAR(4), [ActivityDate], 112)
--, DATEPART(QUARTER, [ActivityDate])

ORDER BY
  CONVERT(CHAR(4), [ActivityDate], 112) + 'Q' + CAST(DATEPART(QUARTER, [ActivityDate]) AS CHAR(1))
--  CONVERT(CHAR(4), [ActivityDate], 112)
--, DATEPART(QUARTER, [ActivityDate])