SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_15b_Data_Export]

	SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_16b_Data_Export]


SELECT TOP (1000) [Acct]
      ,[PlayerID]
      ,[GamingDt]
      ,[Requal_Month]
      ,[Current_Tier]
      ,[Current_Requal_Message_YN]
      ,[Current_Requal_Qualification_Period_Start_Date]
      ,[Current_Requal_Qualification_Period_End_Date]
      ,[Current_Requal_Valid_Through_Date]
      ,[Current_Requal_Tier]
      ,[Current_Requal_Upgrade_Tier]
      ,[Next_Requal_Qualification_Period_Start_Date]
      ,[Next_Requal_Play_Through_Date]
      ,[Next_Requal_Qualification_Period_End_Date]
      ,[Next_Requal_Date]
      ,[Next_Requal_Tier]
      ,[Next_Requal_Upgrade_Message_YN]
      ,[Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier_Percentage]
      ,[Points_To_Current_Requal_Upgrade_Tier]
  FROM [RequalDB].[dbo].[R_15b_Data_Export]
WHERE PlayerID = 1717
ORDER BY PlayerID ASC

	SELECT TOP (1000) [Acct]
      ,[PlayerID]
      ,[GamingDt]
      ,[Current_Tier]
      ,[Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier]
  FROM [RequalDB].[dbo].[R_temp_16b_Data_Export]
		WHERE PlayerID = 1717
		ORDER BY PlayerID ASC