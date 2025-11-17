SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_10b_Players_By_Current_Requal_Upgrade_Tier]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_10b_Players_By_Current_Requal_Upgrade_Tier]

SELECT TOP (1000) [PlayerID]
      ,[Current_Requal_Upgrade_Tier]
      ,[Point_Threshold]
      ,[Non-Poker_Base_Points]
      ,[Points_To_Current_Requal_Upgrade_Tier]
      ,[Points_To_Current_Requal_Upgrade_Tier_Percentage]
  FROM [RequalDB].[dbo].[R_10b_Players_By_Current_Requal_Upgrade_Tier]
	ORDER BY PlayerID ASC

	SELECT TOP (1000) [PlayerID]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_10b_Players_By_Current_Requal_Upgrade_Tier]
	ORDER BY PlayerID ASC