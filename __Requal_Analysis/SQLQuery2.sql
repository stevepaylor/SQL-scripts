--IF OBJECT_ID('RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal', 'U') IS NOT NULL 
--BEGIN
--  PRINT 'Drop Table R_NEW_R11_Patron_Ratings_Next_Requal'
--  DROP TABLE RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal
--END

SELECT DISTINCT
  mP.PlayerID
, MAX(mP.Current_Tier) AS Current_Tier 
, MIN(CT.Tier_Type) AS Tier_Type
, MAX(mN.Next_Requal_Date) AS Next_Requal_Date
, MAX(pr.GamingDt) AS GamingDt
, MAX(mN.Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(mN.Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
--, MAX(mN.Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date
--, MAX(mN.Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(pr.Poker_Base_Points) AS Poker_Base_Points

--INTO RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal

FROM RequalDB.dbo.R_NEW_06_Players_by_Current_Tier AS mP

INNER JOIN RequalDB.dbo.R_Club_Tiers_New CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN RequalDB.dbo.R_NEW_01_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
--AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.R_NEW_05_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

GROUP BY 
  mP.PlayerID ;
