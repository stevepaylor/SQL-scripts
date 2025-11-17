
SELECT TOP (1000) [Tier_Type]
      ,[Next_Requal_Date]
  FROM [RequalDB].[dbo].[R_02_Next_Requal_Dates_by_Tier_Type]

	SELECT TOP (1000) [Tier_Type]
      ,[Next_Requal_Date]
  FROM [RequalDB].[dbo].[R_temp_02_Next_Requal_Dates_by_Tier_Type]