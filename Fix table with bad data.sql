
SELECT 
  COUNT(*)
, CAST(AllowedPurgeDt AS CHAR(10))

FROM CMP13.dbo.tSlotRating_SWD

WHERE CAST(AllowedPurgeDt AS CHAR(10)) NOT LIKE '20%'

GROUP BY
CAST(AllowedPurgeDt AS CHAR(10))

ORDER BY 
COUNT(*) DESC


SELECT 
  COUNT(*)

FROM CMP13.dbo.tSlotRating_SWD

WHERE CAST(AllowedPurgeDt AS CHAR(30)) NOT LIKE '20%'

--GROUP BY
--CAST(AllowedPurgeDt AS CHAR(30))

--ORDER BY 
--COUNT(*) DESC
