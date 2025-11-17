/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PlayerID]
      ,[Current_Tier]
      ,[Tier]
      ,[Tier_Type]
      ,[Point_Threshold]
      ,[Non-Poker_Base_Points]
      ,[Points_Short_of_Threshold]
      ,[Current_Requal_Tier_Rank]
  FROM [RequalDB].[dbo].[R_NEW_08_Players_By_Current_Requal_Tier_Rank]

	WHERE [Current_Requal_Tier_Rank] <> '6'

	--AND Point_Threshold > 0 

	--AND Points_Short_of_Threshold > 0