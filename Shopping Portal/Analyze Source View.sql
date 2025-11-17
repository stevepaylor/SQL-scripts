SELECT TOP 1000
  --LastTripStartTranCodeGamingDt
 COUNT(*)

FROM CMP13.dbo.viewPlayersViejas

WHERE LastTripStartTranCodeGamingDt IS NOT NULL
  AND LastTripStartTranCodeGamingDt >= '01/01/2019'

--GROUP BY 
--  LastTripStartTranCodeGamingDt

--ORDER BY 
--  LastTripStartTranCodeGamingDt DESC