SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_05_Patron_Ratings]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_05_Patron_Ratings]

	SELECT
  PlayerID
, [GamingDt]
, SUM([Non-Poker_Base_Points])
, SUM(Poker_Base_Points)
FROM [RequalDB].[dbo].[R_05_Patron_Ratings]
WHERE PlayerID = 66
GROUP BY
  PlayerID
, [GamingDt]
ORDER BY
  PlayerID
, GamingDt

SELECT
  PlayerID
, [GamingDt]
, SUM([Non-Poker_Base_Points])
, SUM(Poker_Base_Points)
	  FROM [RequalDB].[dbo].[R_temp_05_Patron_Ratings]
WHERE PlayerID = 66
GROUP BY
  PlayerID
, [GamingDt]
ORDER BY
  PlayerID
, [GamingDt]


SELECT TOP (1000) [PlayerID]
      ,[GamingDt]
      ,[Non-Poker_Base_Points]
      ,[Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_05_Patron_Ratings]
		ORDER BY PlayerID

SELECT TOP (1000) [PlayerID]
      ,[GamingDt]
      ,[Non-Poker_Base_Points]
      ,[Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_05_Patron_Ratings]
		ORDER BY PlayerID