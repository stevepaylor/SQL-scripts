SELECT vR.[PlayerID], 
       vR.[GamingDt], 
       vR.[DeptID], 
       Sum(vR.[BasePts]) AS BasePts 
   FROM [CRManalytics].[dbo].[tblRatings] AS vR 

   WHERE (((vR.[IsVoid]) = 0))

     AND PlayerID = 956862

   GROUP BY vR.[PlayerID], vR.[GamingDt], vR.[DeptID]
   HAVING ((cast((vR.[GamingDt]) AS DATE) BETWEEN 
      (
         SELECT Min(n2.[Current_Requal_Qualification_Period_Start_Date])
         FROM 
            [MV_Next_Requal_Dates_By_Tier_Type] AS n5
               INNER JOIN [MV_Next_Requal_Dates] AS n2
               ON (n5.[Next_Requal_Date] = n2.[Next_Requal_Date]) AND (n5.[Tier_Type] = n2.[Tier_Type])
      ) AND 
      (
         SELECT Max(n2.[Next_Requal_Qualification_Period_End_Date])
         FROM 
            [MV_Next_Requal_Dates_By_Tier_Type]  AS n5
               INNER JOIN [MV_Next_Requal_Dates]  AS n2
               ON (n5.[Next_Requal_Date] = n2.[Next_Requal_Date]) AND (n5.[Tier_Type] = n2.[Tier_Type])
      )))


