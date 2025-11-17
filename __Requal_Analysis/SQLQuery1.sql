SELECT --DISTINCT
--  mPCT.Acct
--, mPCT.PlayerID
--, mPR.GamingDt
----, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
  mPCT.Current_Tier AS Current_Tier
, MAX(mPCT.Current_Tier_Rank) AS Current_Tier_Rank
--, mPCRT.Current_Requal_Tier_Rank 
--, mPCRT.Current_Requal_Upgrade_Tier_Rank
, MAX(mPCRT.Current_Requal_Tier) AS Current_Requal_Tier
, MAX(mPCRUT.Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_NEW_06_Players_by_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.R_NEW_09_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_NEW_05_Patron_Ratings AS mPR
ON mPCT.PlayerID = mPR.PlayerID 

INNER JOIN RequalDB.dbo.R_NEW_R10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

GROUP BY
  mPCT.Current_Tier

ORDER BY
  mPCT.Current_Tier