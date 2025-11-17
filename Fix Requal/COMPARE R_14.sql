SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_14_Players_By_Next_Requal_Upgrade_Tier]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_14_Players_By_Next_Requal_Upgrade_Tier]

SELECT TOP (1000) [PlayerID]
      ,[Point_Threshold]
      ,[Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier_Percentage]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_14_Players_By_Next_Requal_Upgrade_Tier]
				ORDER BY PlayerID ASC

	SELECT TOP (1000) [PlayerID]
      ,[Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_14_Players_By_Next_Requal_Upgrade_Tier]
				ORDER BY PlayerID ASC