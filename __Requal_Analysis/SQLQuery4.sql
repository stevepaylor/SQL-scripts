SELECT TOP (1000) [Tier_Type]
      ,[Requal_Month]
      ,[Qualification_Period_Start_Month]
      ,[Qualification_Period_End_Month]
  FROM [RequalDB].[dbo].[R_Requal_Dates] ;

SELECT TOP (1000) [Requal_Month]
      ,[Qualification_Period_Start_Month]
      ,[Qualification_Period_End_Month]
  FROM [RequalDB].[dbo].[R_Requal_Dates_NEW] ;