SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_06_Players_by_Current_Tier]

	SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_06_Players_by_Current_Tier]

SELECT TOP (1000) [Acct]
      ,[PlayerID]
      ,[Current_Tier]
      ,[Current_Tier_Rank]
  FROM [RequalDB].[dbo].[R_06_Players_by_Current_Tier]
	ORDER BY Acct

SELECT TOP (1000) [Acct]
      ,[PlayerID]
      ,[Current_Tier]
  FROM [RequalDB].[dbo].[R_temp_06_Players_by_Current_Tier]
		ORDER BY Acct