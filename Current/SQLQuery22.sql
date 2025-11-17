SELECT 
  AW.PlayerID
, AW.IsVoid
, AW.GamingDt
, CAST(SUBSTRING(DP.DeptCode,1,4) AS CHAR(4)) AS DeptID4 
, SUM(ISNULL(PP.BasePts,0)) AS BasePts
, COUNT_BIG(*) as NumRecs

FROM dbo.tAwards AW 
JOIN dbo.tDept DP on AW.DeptID = DP.DeptId
JOIN dbo.tPlayerPoints PP on AW.TranId = PP.TranId

WHERE AW.IsVoid <> 1
  AND AW.IsVoid IS NOT NULL

GROUP BY
  AW.PlayerID
, AW.IsVoid
, AW.GamingDt
, CAST(SUBSTRING(DP.DeptCode,1,4) AS CHAR(4)) 

-- (3809454 row(s) affected)