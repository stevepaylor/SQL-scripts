SELECT
  aw.[TranId]
, aw.GamingDt
, aw.PlayerID
, aw.[PrizeId]
, pz.PrizeCode

, count(*)

, sum(case when aw.[PrizeId] = 10271879 then aw.AwardUsed else 0 end)
  as award_GasStation

FROM [iQ-Gaming].[CMP_13-1].tAwards aw (Nolock)
LEFT JOIN [iQ-Gaming].[CMP_13-1].tPrize pz (Nolock) ON aw.PrizeId = pz.PrizeId

WHERE aw.[PrizeId] = 10271879

GROUP BY 
  aw.[TranId]
, aw.GamingDt
, aw.PlayerID
, aw.[PrizeId]
, pz.PrizeCode

--having count(*) >1 
