SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_10a_Players_By_Current_Requal_Upgrade_Tier]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_10a_Players_By_Current_Requal_Upgrade_Tier]

SELECT TOP (1000) [PlayerID]
      ,[Current_Requal_Upgrade_Tier]
      ,[Point_Threshold]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_10a_Players_By_Current_Requal_Upgrade_Tier]

ORDER BY PlayerID ASC

	SELECT TOP (1000) [PlayerID]
      ,[Current_Requal_Upgrade_Tier]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_10a_Players_By_Current_Requal_Upgrade_Tier]

	ORDER BY PlayerID ASC