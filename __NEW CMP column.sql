SELECT *
FROM [CMP13].[dbo].[tTableRating] WITH (NOLOCK)
WHERE GamingDt > '2024-09-01'
  AND IsVoid = 0
