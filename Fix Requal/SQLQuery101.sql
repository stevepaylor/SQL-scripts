      ------mP.PlayerID, 
      ------mP.Current_Tier, 
      ------CT.Tier_Type, 
      ------mNR.Next_Requal_Date, 
      ------mNR.Current_Requal_Qualification_Period_Start_Date, 
      ------mNR.Current_Requal_Qualification_Period_End_Date, 
      ------Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
      ------Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

SELECT DISTINCT
  mP.PlayerID
, mP.[Current_Tier]
, CT.[Tier_Type]
, mNR.[Next_Requal_Date]
, mNR.[Current_Requal_Qualification_Period_Start_Date]
, mNR.[Current_Requal_Qualification_Period_End_Date]
----, mPR.[Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

FROM RequalDB.dbo.MV_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.MV_Players_By_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
AND mNR.Requal_Month = 6


WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date
  AND 
  mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

------SELECT DISTINCT  
------  mPR.PlayerID
--------, mPR.Current_Tier
------, mPR.[Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
------, mPR.Poker_Base_Points AS Poker_Base_Points
--------, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
--------, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

------FROM RequalDB.dbo.MV_Patron_Ratings AS mPR

------WHERE PlayerID = '1426933'