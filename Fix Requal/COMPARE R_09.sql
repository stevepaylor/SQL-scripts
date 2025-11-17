	SELECT COUNT(*)
	FROM [RequalDB].[dbo].[R_09_Players_By_Current_Requal_Tier]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_09_Players_By_Current_Requal_Tier]

SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Current_Requal_Tier]
      ,[Current_Requal_Tier_Rank]
      ,[Current_Requal_Upgrade_Tier_Rank]
  FROM [RequalDB].[dbo].[R_09_Players_By_Current_Requal_Tier]

SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Current_Requal_Tier]
      ,[Current_Requal_Upgrade_Tier_Rank]
  FROM [RequalDB].[dbo].[R_temp_09_Players_By_Current_Requal_Tier]