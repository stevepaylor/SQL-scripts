SELECT 
            r.Tier_Type
     ,r.Requal_Month
     ,r.Qualification_Period_Start_Month
     ,r.Qualification_Period_End_Month
     ,(CASE 
         WHEN r.Requal_Month <= month(getdate()) 
            THEN (CAST((CAST(r.[Requal_Month] AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
         ELSE (CAST((CAST(r.[Requal_Month] AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
      END) AS Next_Requal_Date
     ,      dateadd(month, -1 - c.[Earn_Period_Months], (CASE 
														   WHEN r.Requal_Month <= month(getdate()) 
															  THEN (CAST((CAST(r.[Requal_Month] AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
														   ELSE (CAST((CAST(r.[Requal_Month] AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
														 END)) AS Next_Requal_Qualification_Period_Start_Date
     ,DateAdd(dd ,-1,DateAdd(mm,-1,(CASE 
									   WHEN r.Requal_Month <= month(getdate()) 
										  THEN (CAST((CAST(r.[Requal_Month] AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
									   ELSE (CAST((CAST(r.[Requal_Month] AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
									   END))) AS Next_Requal_Qualification_Period_End_Date
     ,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102) AS Current_Requal_Date
     ,DateAdd(mm,- c.[Earn_Period_Months],CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_Start_Date
     , DateAdd(DD,-1,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_End_Date
   FROM 
      dbo.[Requal_Dates] r
         INNER JOIN [Clubs] c
         ON r.[Tier_Type] = c.[Tier_Type];