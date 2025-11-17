select top 1000 
  [playerid]
--, [PrizeId]
 [PrizeCode]

from [iQ-Gaming].[dbo].[v_IQC_Comps]
--WHERE [PrizeId] = 10271879
where prizecode LIKE '%mid%'

select distinct
  --[PrizeId]
 [PrizeCode]
from [iQ-Gaming].[dbo].[v_IQC_Comps]
WHERE [PrizeCode] = 10271879
order by [PrizeCode] 


select top 1000 
  aw.[playerid]
, aw.[PrizeId]
, pz.[PrizeCode]	

FROM [iQ-Gaming].[CMP_13-1].tAwards aw (Nolock)
LEFT JOIN [iQ-Gaming].[CMP_13-1].tPrize pz (Nolock)
ON aw.[PrizeId] = pz.[PrizeId]

WHERE aw.[PrizeId] = 10271879