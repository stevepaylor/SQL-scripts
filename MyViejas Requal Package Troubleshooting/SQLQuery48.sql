SELECT n.[Tier_Type], Min(n.[Next_Requal_Date]) AS Next_Requal_Date
   FROM [MV_Next_Requal_Dates] n
   WHERE (((n.[Next_Requal_Date]) > getdate()))
   GROUP BY n.[Tier_Type]