SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_11_Patron_Ratings_Next_Requal]

	SELECT COUNT(*)
	  FROM [RequalDB].[dbo].[R_temp_11_Patron_Ratings_Next_Requal]

SELECT TOP (1000) [PlayerID]
      ,[Current_Tier]
      ,[Tier_Type]
      ,[Next_Requal_Date]
      ,[GamingDt]
      ,[Next_Requal_Qualification_Period_Start_Date]
      ,[Next_Requal_Qualification_Period_End_Date]
      ,[Non-Poker_Base_Points]
      ,[Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_11_Patron_Ratings_Next_Requal]
	ORDER BY PlayerID ASC

	SELECT TOP (1000) [PlayerID]
      ,[Current_Tier]
      ,[Tier_Type]
      ,[GamingDt]
      ,[Non-Poker_Base_Points]
      ,[Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_11_Patron_Ratings_Next_Requal]
		ORDER BY PlayerID ASC