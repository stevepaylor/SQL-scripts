SELECT COUNT(*)
  --FROM [RequalDB].[dbo].[R_15d_Data_Export]
	FROM [RequalDB].[dbo].R_15e_Data_Export_FINAL
	where PlayerID = 43

SELECT COUNT(*)
 FROM [RequalDB].[dbo].[R_temp_16c_Data_Export_FINAL]
	where PlayerID = 43


 SELECT 
   SUM(CAST([Non-Poker_Base_Points] AS bigint)) AS [Non-Poker_Base_Points]
--, SUM(CAST(Points_To_Next_Requal_Upgrade_Tier AS bigint)) AS Points_To_Next_Requal_Upgrade_Tier
  --FROM [RequalDB].[dbo].[R_15d_Data_Export]
	FROM [RequalDB].[dbo].R_15e_Data_Export_FINAL
	where PlayerID = 43

	 SELECT 
   SUM(CAST([Non-Poker_Base_Points] AS numeric)) AS [Non-Poker_Base_Points]
, SUM(CAST(Points_To_Next_Requal_Upgrade_Tier AS numeric)) AS Points_To_Next_Requal_Upgrade_Tier
  FROM [RequalDB].[dbo].[R_temp_16c_Data_Export_FINAL]
	where PlayerID = 43

SELECT TOP (1000) [Acct]
      ,[PlayerID]
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
      ,[Non-Poker_Base_Points]
      ,[Points_To_Current_Requal_Upgrade_Tier]
  --FROM [RequalDB].[dbo].[R_15d_Data_Export]
	FROM [RequalDB].[dbo].R_15e_Data_Export_FINAL
	--where PlayerID = 43
	where Points_To_Next_Requal_Upgrade_Tier = 'EARNED'
	order by PlayerID ASC

	SELECT TOP (1000) [Acct]
      ,[PlayerID]
      ,[Current_Tier]
      ,[Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier]
      ,[Non-Poker_Base_Points]
  FROM [RequalDB].[dbo].[R_temp_16c_Data_Export_FINAL]
	--where PlayerID = 43
		where Points_To_Next_Requal_Upgrade_Tier = 'EARNED'
	order by PlayerID ASC