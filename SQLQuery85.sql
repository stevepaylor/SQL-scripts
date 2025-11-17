SELECT
  PlayerID 
, IsVoid 
, GamingDt 
, SUBSTRING(LTRIM(CAST(Deptcode AS CHAR(4))),1,4) AS DeptID 
, BasePts AS BasePts 

FROM viewAwardsViejas

WHERE IsVoid <> 1
  AND IsVoid IS NOT NULL

ORDER BY
  PlayerID 
, IsVoid 
, GamingDt 
, Deptcode