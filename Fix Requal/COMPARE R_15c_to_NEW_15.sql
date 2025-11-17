SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_15c_Data_Export]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_15_Player_Total_per_GamingDt]


SELECT SUM([Non-Poker_Base_Points])
  FROM [RequalDB].[dbo].[R_15c_Data_Export]

SELECT SUM([Non-Poker_Base_Points])
  FROM [RequalDB].[dbo].[R_15c_Data_Export]


SELECT TOP (1000) [PlayerID]
      ,[GamingDt]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_15c_Data_Export]
ORDER BY PlayerID ASC

SELECT TOP (1000) [PlayerID]
      ,[GamingDt]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_15_Player_Total_per_GamingDt]
	ORDER BY PlayerID ASC