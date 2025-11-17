/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PlayerID]
      ,[Current_Tier]
      ,[Tier_Type]
      ,[Current_Requal_Tier_Rank]
  FROM [RequalDB].[dbo].[R_NEW_08_Players_By_Current_Requal_Tier_Rank]

	WHERE [Current_Tier] <> 'Bronze'

SELECT DISTINCT 
       [Current_Tier]
      ,[Tier_Type]
      ,[Current_Requal_Tier_Rank]
FROM [RequalDB].[dbo].[R_NEW_08_Players_By_Current_Requal_Tier_Rank]

SELECT 
       [Current_Tier]
      ,[Tier_Type]
			,[Current_Requal_Tier_Rank]
		, COUNT(*)
  FROM [RequalDB].[dbo].[R_NEW_08_Players_By_Current_Requal_Tier_Rank]

	GROUP BY 
       [Current_Tier]
      ,[Tier_Type]
			,[Current_Requal_Tier_Rank]