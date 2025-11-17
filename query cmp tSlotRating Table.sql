SELECT DISTINCT
CAST([AllowedPurgeDt] as VARCHAR(50))

FROM [CMP13].[dbo].[tSlotRating]

ORDER BY 
CAST([AllowedPurgeDt] as VARCHAR(50))