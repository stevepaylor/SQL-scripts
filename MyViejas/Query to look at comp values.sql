SELECT 
  PlayerId
, SUM(tPCB.EarnedComp) AS EarnedComp
, SUM(tPCB.AdjCompCr) AS AdjCompCr
, SUM(tPCB.AdjCompDr) AS AdjCompDr
, SUM(TPCB.CompUsed) AS CompUsed
, SUM(tPCB.ExpireComp) AS ExpireComp
, CAST(ROUND(SUM(tPCB.EarnedComp + tPCB.AdjCompCr - tPCB.AdjCompDr - tPCB.CompUsed - tPCB.ExpireComp),2,1) AS DECIMAL(18,2)) AS 'COMP Bal'

FROM tPlayerCompBal (nolock) tPCB

WHERE (tPCB.EarnedComp + tPCB.AdjCompCr - tPCB.AdjCompDr - tPCB.CompUsed - tPCB.ExpireComp) <> 0

GROUP BY
  PlayerId