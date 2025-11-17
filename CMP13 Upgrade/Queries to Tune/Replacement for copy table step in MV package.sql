SELECT
  V1.PlayerID 
, V1.IsVoid 
, V1.GamingDt 
, V1.DeptID 
, V2.BasePts

FROM  CMP13..viewAllRatingsViejasNoAwardsNoGMT AS V1
LEFT OUTER JOIN CMP13..viewAllRatingsViejas AS V2
ON  V1.PlayerID = V2.PlayerID
AND V1.IsVoid = V2.IsVoid
AND V1.GamingDt = V2.GamingDt
AND V1.DeptID = V2.DeptID

WHERE V1.IsVoid <> 1

ORDER BY
  V1.PlayerID 
, V1.IsVoid 
, V1.GamingDt 
, V1.DeptID 