
--IF OBJECT_ID('RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank', 'U') IS NOT NULL 
--BEGIN
--  PRINT 'Drop Table R_NEW_08_Players_By_Current_Requal_Tier_Rank'
--  DROP TABLE RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank
--END

SELECT DISTINCT 
  pr.PlayerID
, pr.[Current_Tier]
--, CT.Tier
, CT.Tier_Type
, CT.Point_Threshold
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(CT.Point_Threshold - pr.[Non-Poker_Base_Points]) as Points_Short_of_Threshold
, CAST(MAX(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank
--, CAST(CT.Tier_Rank AS INT) AS Current_Requal_Tier_Rank

--INTO RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank

FROM RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal pr

INNER JOIN RequalDB.dbo.R_Club_Tiers_NEW AS CT 
ON pr.Current_Tier = CT.Tier

WHERE pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND (CT.Point_Type = 'Non-Poker Base') --OR (CT.Point_Type = 'Poker Base')) 
AND pr.[Non-Poker_Base_Points] >= CT.Point_Threshold
--AND  pr.[Current_Tier] <> CT.Tier
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, pr.[Current_Tier]
, CT.Tier
, CT.Tier_Type
, CT.Point_Threshold
