SELECT 
  Acct
, PlayerID
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier

--INTO Requal_15b_Data_Export

FROM dbo.Requal_15a_Data_Export

WHERE PlayerID = '1426933'

GROUP BY
  Acct
, PlayerID
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier

ORDER BY
  Acct
, PlayerID
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier