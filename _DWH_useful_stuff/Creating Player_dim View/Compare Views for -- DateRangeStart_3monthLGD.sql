

SELECT 
  mv.player_id
, CAST(mv.DateRangeStart_3monthLGD as varchar(13)) as MV_DateRangeStart_3monthLGD
, CAST(tb.DateRangeStart_3monthLGD as varchar(13)) as TB_DateRangeStart_3monthLGD
FROM myViejas.player_dim mv
JOIN tableau.player_dim tb
ON mv.player_id = tb.player_id

WHERE CAST(mv.DateRangeStart_3monthLGD as varchar(13)) <> CAST(tb.DateRangeStart_3monthLGD as varchar(13))

SELECT
  COUNT(*)
, DateRangeStart_3monthLGD
FROM myViejas.player_dim 
GROUP BY
DateRangeStart_3monthLGD 
ORDER BY 
DateRangeStart_3monthLGD  ;
GO

SELECT
  COUNT(*)
, DateRangeStart_3monthLGD
FROM tableau.player_dim
GROUP BY
DateRangeStart_3monthLGD 
ORDER BY 
DateRangeStart_3monthLGD  ;
GO
