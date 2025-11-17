SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_07_Patron_Ratings_Current_Requal]
WHERE PlayerID = 66

	SELECT COUNT(*)
	  FROM [RequalDB].[dbo].[R_temp_07_Patron_Ratings_Current_Requal]
WHERE PlayerID = 66

SELECT 
  SUM([Non-Poker_Base_Points])
, SUM(Poker_Base_Points)
  FROM [RequalDB].[dbo].[R_07_Patron_Ratings_Current_Requal]
WHERE PlayerID = 66

SELECT 
  SUM([Non-Poker_Base_Points])
, SUM(Poker_Base_Points)
	  FROM [RequalDB].[dbo].[R_temp_07_Patron_Ratings_Current_Requal]
WHERE PlayerID = 66

SELECT
  PlayerID
, [GamingDt]
, SUM([Non-Poker_Base_Points])
, SUM(Poker_Base_Points)
FROM [RequalDB].[dbo].[R_07_Patron_Ratings_Current_Requal]
WHERE PlayerID = 66
GROUP BY
  PlayerID
, [GamingDt]
ORDER BY
  PlayerID
, [GamingDt]

SELECT
  PlayerID
, [GamingDt]
, SUM([Non-Poker_Base_Points])
, SUM(Poker_Base_Points)
	  FROM [RequalDB].[dbo].[R_temp_07_Patron_Ratings_Current_Requal]
WHERE PlayerID = 66
GROUP BY
  PlayerID
, [GamingDt]
ORDER BY
  PlayerID
, [GamingDt]


SELECT TOP (1000) [PlayerID]
      ,[GamingDt]
      ,[Current_Tier]
      ,[Tier_Type]
      ,[Next_Requal_Date]
      ,[Current_Requal_Qualification_Period_Start_Date]
      ,[Current_Requal_Qualification_Period_End_Date]
      ,[Non-Poker_Base_Points]
      ,[Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_07_Patron_Ratings_Current_Requal]

		--WHERE [Non-Poker_Base_Points] > 0
	 --  OR [Poker_Base_Points] > 0

			ORDER BY PlayerID ASC


--WHERE [Non-Poker_Base_Points] IS NOT NULL
--	AND [Non-Poker_Base_Points] > 0



	SELECT TOP (1000) [PlayerID]
	    ,[GamingDt]
      ,[Tier_Type]
      ,[Non-Poker_Base_Points]
      ,[Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_07_Patron_Ratings_Current_Requal]

--WHERE [Non-Poker_Base_Points] IS NOT NULL
--	AND [Non-Poker_Base_Points] > 0