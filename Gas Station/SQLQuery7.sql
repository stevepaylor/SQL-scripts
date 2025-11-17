SELECT 
  taw.[PlayerId]
, taw.[TranId]
, taw.[PrizeId]
, tpz.PrizeCode
, taw.[PrizeQty]
, taw.[TranCodeId]
, taw.[GamingDt]
, taw.[Shift]
, taw.[AgingDt]
, taw.[PostDtm]
, taw.[ComputerName]
, taw.[EmpID]
, taw.[AuthEmpId]
, taw.[DeptID]
, taw.[CasinoID]
, taw.[AreaID]

FROM [CMP13].[dbo].[tAwards]taw
JOIN [CMP13].[dbo].[tPrize] tpz
  ON  taw.PrizeId = tpz.PrizeId

WHERE taw.[PrizeId] = 10271879
