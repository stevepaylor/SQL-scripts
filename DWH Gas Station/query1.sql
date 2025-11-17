SELECT 
  aw.PlayerID
, aw.GamingDt
, MAX(aw.[PrizeId]) PrizeId
, MAX(pz.PrizeCode) pz_PrizeCode

, sum(case when aw.[PrizeId] = 10271879 then aw.AwardUsed else 0 end)
  as award_GasStation

FROM [CMP_13-1].tAwards aw (Nolock)
LEFT JOIN [CMP_13-1].tPrize pz (Nolock) ON aw.PrizeId = pz.PrizeId

WHERE aw.[PrizeId] = 10271879

GROUP BY 
  aw.PlayerId
, aw.GamingDt
		