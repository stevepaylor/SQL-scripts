SELECT top 10  
  MVR.PlayerID
, P.Acct
, P.[LastName]
, P.[FirstName]
, P.[MiddleInitial]
, MVR.IsVoid
, MVR.GamingDt
, MVR.DeptID4
, MVR.BasePts

FROM CMP13.DBO.viewMyViejasRequal MVR
JOIN CMP13.[dbo].[tblPlayers] P
  ON MVR.PlayerID = P.[PlayerID]

WHERE P.Acct = 20457512

ORDER BY 
  MVR.PlayerID
, P.Acct
, P.[LastName]
, P.[FirstName]
, P.[MiddleInitial]
, MVR.IsVoid
, MVR.GamingDt
, MVR.DeptID4
, MVR.BasePts