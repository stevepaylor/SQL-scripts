--IF OBJECT_ID('RequalDB.dbo.R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
--BEGIN
--  PRINT 'Drop Table R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier'
--  DROP TABLE RequalDB.dbo.R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier
--END

SELECT DISTINCT 
  mP.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, MAX(CT.Point_Threshold) AS Point_Threshold
, SUM(CAST(mv.[Non-Poker_Base_Points] AS INT)) AS [Non-Poker_Base_Points]

--INTO RequalDB.dbo.R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_NEW_09_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

GROUP BY
  mP.PlayerID ;
