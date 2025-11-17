SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_13_Players_By_Next_Requal_Tier]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_13_Players_By_Next_Requal_Tier]

SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Next_Requal_Tier]
      ,[Next_Requal_Tier_Rank]
      ,[Next_Requal_Upgrade_Tier_Rank]
  FROM [RequalDB].[dbo].[R_13_Players_By_Next_Requal_Tier]
			ORDER BY PlayerID ASC

	SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Next_Requal_Upgrade_Tier_Rank]
  FROM [RequalDB].[dbo].[R_temp_13_Players_By_Next_Requal_Tier]
			ORDER BY PlayerID ASC