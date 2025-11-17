SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_03_tblRatings]
--WHERE PlayerID = 66

SELECT COUNT(*)
FROM [RequalDB].[dbo].[R_temp_03_tblRatings]
--WHERE PlayerID = 66

SELECT SUM(BasePts)
  FROM [RequalDB].[dbo].[R_03_tblRatings]
--WHERE PlayerID = 66

SELECT SUM(BasePts)
  FROM [RequalDB].[dbo].[R_03_tblRatings]
--WHERE PlayerID = 66

SELECT 
  vR.PlayerID AS vR_PlayerID
, r03.PlayerID AS r03_PlayerID
, vR.GamingDt AS vR_GamingDt
, r03.GamingDt AS r03_GamingDt
, vR.DeptID4 AS vR_DeptID4
, R03.DeptID4 AS r03_DeptID4
, vR.BasePts AS R03_BasePts
, r03.BasePts AS R03_BasePts
, vR.IsVoid AS vR_IsVoid

FROM RequalDB.dbo.R_03_tblRatings vR 

LEFT OUTER JOIN RequalDB.dbo.R_temp_03_tblRatings r03
ON vR.PlayerID = r03.PlayerID
AND vR.GamingDt = r03.GamingDt
AND vR.DeptID4 = r03.DeptID4

WHERE r03.PlayerID IS NULL 

--WHERE vR.IsVoid = 0


SELECT TOP (1000) [PlayerID]
      ,[IsVoid]
      ,[GamingDt]
      ,[DeptID4]
      ,[BasePts]
  FROM [RequalDB].[dbo].[R_03_tblRatings]
--WHERE PlayerID = 66
	ORDER BY PlayerID

SELECT TOP (1000) [PlayerID]
      ,[IsVoid]
      ,[GamingDt]
      ,[DeptID4]
      ,[BasePts]
  FROM [RequalDB].[dbo].[R_temp_03_tblRatings]
	--WHERE PlayerID = 66
	ORDER BY PlayerID