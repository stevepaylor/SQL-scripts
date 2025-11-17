/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Acct]
      ,[PlayerID]
      ,[ClubStatus]
      --,[Tier]
      ,[Tier_Rank]
      ,[Current_Tier]
      ,[Current_Tier_Rank]
  FROM [RequalDB].[dbo].[R_NEW_06_Players_by_Current_Tier]

	SELECT
       [ClubStatus]
      ,[Current_Tier]
			, COUNT(*)
  FROM [RequalDB].[dbo].[R_NEW_06_Players_by_Current_Tier]

	GROUP BY
       [ClubStatus]
      ,[Current_Tier]

	ORDER BY
	     [ClubStatus]
      ,[Current_Tier]