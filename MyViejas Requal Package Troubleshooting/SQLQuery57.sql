--CREATE VIEW dbo.[Patron_Ratings_Current_Requal]
--AS 
   SELECT 
      mP.[PlayerID], 
      mP.[Current_Tier], 
      [Club_Tiers].[Tier_Type], 
      mNR.[Next_Requal_Date], 
      mNR.[Current_Requal_Qualification_Period_Start_Date], 
      mNR.[Current_Requal_Qualification_Period_End_Date], 
      Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
      Sum(mPR.[Poker_Base_Points]) AS Poker_Base_Points
   FROM 
      ([MV_Players_By_Current_Tier] AS mP
         INNER JOIN (([Club_Tiers] 
         INNER JOIN [MV_Next_Requal_Dates_By_Tier_Type] AS mN
         ON [Club_Tiers].[Tier_Type] = mN.[Tier_Type]) 
         INNER JOIN [MV_Next_Requal_Dates] AS mNR
         ON (mN.[Next_Requal_Date] = mNR.[Next_Requal_Date]) 
         AND (mN.[Tier_Type] = mNR.[Tier_Type])) 
         ON mP.[Current_Tier] = [Club_Tiers].[Tier]) 
         INNER JOIN [MV_Patron_Ratings] AS mPR
         ON mP.[PlayerID] = mPR.[PlayerID]
   WHERE (((mPR.[GamingDt]) BETWEEN [Current_Requal_Qualification_Period_Start_Date] 
								AND [Current_Requal_Qualification_Period_End_Date]))

								AND mp.PlayerID = 956862

   GROUP BY 
      mP.[PlayerID], 
      mP.[Current_Tier], 
      [Club_Tiers].[Tier_Type], 
      mNR.[Next_Requal_Date], 
      mNR.[Current_Requal_Qualification_Period_Start_Date], 
      mNR.[Current_Requal_Qualification_Period_End_Date]