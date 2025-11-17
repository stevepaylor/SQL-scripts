SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_12_Players_By_Next_Requal_Tier_Rank]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_12_Players_By_Next_Requal_Tier_Rank]

SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Next_Requal_Tier_Rank]
  FROM [RequalDB].[dbo].[R_12_Players_By_Next_Requal_Tier_Rank]
		ORDER BY PlayerID ASC

SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Next_Requal_Tier_Rank]
  FROM [RequalDB].[dbo].[R_temp_12_Players_By_Next_Requal_Tier_Rank]
		ORDER BY PlayerID ASC