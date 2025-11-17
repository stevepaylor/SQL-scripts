SELECT 
  mv.player_id
, mv.DateRangeEnd_3monthLGD as MV_DateRangeEnd_3monthLGD
, tb.DateRangeEnd_3monthLGD as TB_DateRangeEnd_3monthLGD
FROM myViejas.player_dim mv
JOIN tableau.player_dim tb
ON mv.player_id = tb.player_id

WHERE mv.DateRangeEnd_3monthLGD <> tb.DateRangeEnd_3monthLGD

SELECT
  COUNT(*)
, DateRangeEnd_3monthLGD
FROM myViejas.player_dim 
GROUP BY
DateRangeEnd_3monthLGD 
ORDER BY 
DateRangeEnd_3monthLGD  ;
GO

SELECT
  COUNT(*)
, DateRangeEnd_3monthLGD
FROM tableau.player_dim
GROUP BY
DateRangeEnd_3monthLGD 
ORDER BY 
DateRangeEnd_3monthLGD  ;
GO