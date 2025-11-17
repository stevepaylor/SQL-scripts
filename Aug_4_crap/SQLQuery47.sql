SELECT 
  [BusinessDate]
, COUNT(*)
--FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Hotel]
FROM [iQ-Gaming].[dbo].[IQC_Player_Daily_Hotel]
 
GROUP BY 
  [BusinessDate]
 
ORDER BY
  [BusinessDate] DESC



SELECT * 
--FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Hotel]
FROM [iQ-Gaming].[dbo].[IQC_Player_Daily_Hotel]
 
WHERE [BusinessDate] >= '2025-07-23'

ORDER BY
  [BusinessDate] DESC
