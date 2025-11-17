SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_08_Players_By_Current_Requal_Tier_Rank]

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_08_Players_By_Current_Requal_Tier_Rank]

SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Current_Requal_Tier_Rank]
  FROM [RequalDB].[dbo].[R_08_Players_By_Current_Requal_Tier_Rank]
ORDER BY PlayerID ASC

	/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PlayerID]
      ,[Tier_Type]
      ,[Current_Requal_Tier_Rank]
  FROM [RequalDB].[dbo].[R_temp_08_Players_By_Current_Requal_Tier_Rank]
	ORDER BY PlayerID ASC