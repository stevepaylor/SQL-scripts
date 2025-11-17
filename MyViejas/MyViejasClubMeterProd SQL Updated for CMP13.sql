--
--
-- DTS package:  MyViejasClubMeterProd.dtsx  ( SQL Script #4 - NOTHING Changed )
--
----------------------------------------------------

delete from [CRManalytics].[dbo].[tblRatings]
 where IsVoid = 1


--------------------------------------------------------


CREATE VIEW [dbo].[Patron_Ratings_Next_Requal]
AS 
  SELECT 
      mP.[PlayerID], 
      mP.[Current_Tier], 
      [Club_Tiers].[Tier_Type], 
      mN.[Next_Requal_Date], 
      mN.[Next_Requal_Qualification_Period_Start_Date], 
      mN.[Next_Requal_Qualification_Period_End_Date], 
      Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
      Sum(pr.[Poker_Base_Points]) AS Poker_Base_Points
   FROM 
      ([MV_Players_By_Current_Tier] AS mP
         INNER JOIN (([Club_Tiers] 
         INNER JOIN [MV_Next_Requal_Dates_By_Tier_Type] AS mNR
         ON [Club_Tiers].[Tier_Type] = mNR.[Tier_Type]) 
         INNER JOIN [MV_Next_Requal_Dates] AS mN
         ON (mNR.[Tier_Type] = mN.[Tier_Type]) 
         AND (mNR.[Next_Requal_Date] = mN.[Next_Requal_Date])) 
         ON mP.[Current_Tier] = [Club_Tiers].[Tier]) 
         INNER JOIN [MV_Patron_Ratings] AS pr
         ON mP.[PlayerID] = pr.[PlayerID]
   WHERE (((pr.[GamingDt]) BETWEEN [Next_Requal_Qualification_Period_Start_Date] AND [Next_Requal_Qualification_Period_End_Date]))
   GROUP BY 
      mP.[PlayerID], 
      mP.[Current_Tier], 
      [Club_Tiers].[Tier_Type], 
      mN.[Next_Requal_Date], 
      mN.[Next_Requal_Qualification_Period_Start_Date], 
      mN.[Next_Requal_Qualification_Period_End_Date]


--------------------------------------------------------


CREATE VIEW [dbo].[Players_By_Current_Requal_Tier]
AS 
   SELECT 
      mP.[PlayerID], 
      mP.[Tier_Type], 
      [Club_Tiers].[Tier] AS Current_Requal_Tier, 
      mP.[Current_Requal_Tier_Rank], 
      (CASE 
         WHEN [Current_Requal_Tier_Rank] = 5 THEN 3
         ELSE [Current_Requal_Tier_Rank] - 1
      END) AS Current_Requal_Upgrade_Tier_Rank
   FROM 
      [MV_Players_By_Current_Requal_Tier_Rank] AS mP
         INNER JOIN [Club_Tiers] 
         ON (mP.[Tier_Type] = [Club_Tiers].[Tier_Type]) AND (mP.[Current_Requal_Tier_Rank] = [Club_Tiers].[Tier_Rank])

----------------------------------------------------

CREATE VIEW [dbo].[Players_By_Current_Requal_Tier_Rank]
AS 
   SELECT pr.[PlayerID], [Club_Tiers].[Tier_Type], Min([Club_Tiers].[Tier_Rank]) AS Current_Requal_Tier_Rank
   FROM 
      [MV_Patron_Ratings_Current_Requal] pr
         INNER JOIN [Club_Tiers] 
         ON pr.[Tier_Type] = [Club_Tiers].[Tier_Type]
   WHERE (((pr.[Non-Poker_Base_Points]) >= [Club_Tiers].[Point_Threshold]) AND (([Club_Tiers].[Point_Type]) = 'Non-Poker Base')) OR ((([Club_Tiers].[Point_Type]) = 'Poker Base') AND ((pr.[Poker_Base_Points]) >= [Club_Tiers].[Point_Threshold]))
   GROUP BY pr.[PlayerID], [Club_Tiers].[Tier_Type]


------------------------------------------------------

CREATE VIEW [dbo].[Players_By_Current_Requal_Upgrade_Tier]
AS 
   SELECT mP.[PlayerID], 
		  [Club_Tiers].[Tier] AS Current_Requal_Upgrade_Tier, 
		  [Point_Threshold] - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier, 
		  1 - ([Point_Threshold] - [Non-Poker_Base_Points]) / [Point_Threshold] 
								AS Points_To_Current_Requal_Upgrade_Tier_Percentage
    FROM 
      ([MV_Players_By_Current_Requal_Tier] AS mP
         INNER JOIN [MV_Patron_Ratings_Current_Requal] mv
         ON mP.[PlayerID] = mv.[PlayerID]) 
         INNER JOIN [Club_Tiers] 
         ON (mP.[Tier_Type] = [Club_Tiers].[Tier_Type]) 
         AND (mP.[Current_Requal_Upgrade_Tier_Rank] = [Club_Tiers].[Tier_Rank])


------------------------------------------------------


CREATE VIEW dbo.[Patron_Ratings_Current_Requal]
AS 
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
   GROUP BY 
      mP.[PlayerID], 
      mP.[Current_Tier], 
      [Club_Tiers].[Tier_Type], 
      mNR.[Next_Requal_Date], 
      mNR.[Current_Requal_Qualification_Period_Start_Date], 
      mNR.[Current_Requal_Qualification_Period_End_Date]


----------------------------------------------------	


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


----------------------------------------------------	


SELECT 
      mPB.[PlayerID], 
      mPB.[Tier_Type], 
      [Club_Tiers].[Tier] AS Next_Requal_Tier, 
      mPB.[Next_Requal_Tier_Rank], 
      (CASE 
         WHEN [Next_Requal_Tier_Rank] = 5 THEN 3
         ELSE [Next_Requal_Tier_Rank] - 1
      END) AS Next_Requal_Upgrade_Tier_Rank
   FROM 
      [MV_Players_By_Next_Requal_Tier_Rank] AS mPB
         INNER JOIN [Club_Tiers] 
         ON (mPB.[Tier_Type] = [Club_Tiers].[Tier_Type]) AND (mPB.[Next_Requal_Tier_Rank] = [Club_Tiers].[Tier_Rank])


----------------------------------------------------	


SELECT 
      mPCT.[Acct], 
      mPCT.[PlayerID], 
      mPCT.[Current_Tier], 
      (CASE 
         WHEN (CASE 
            WHEN mPCRT.[Current_Requal_Tier] IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'N'
         ELSE (CASE 
            WHEN mPCT.[Current_Tier_Rank] <= mPCRT.[Current_Requal_Tier_Rank] THEN 'N'
            ELSE 'Y'
         END)
      END) AS Current_Requal_Message_YN, 
      mNRD.[Current_Requal_Qualification_Period_Start_Date], 
      mNRD.[Current_Requal_Qualification_Period_End_Date], 
      (CASE 
         WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.[Next_Requal_Date] THEN 
            (
               SELECT dateadd(day, -1, Min([MV_Next_Requal_Dates].[Next_Requal_Date]))
               FROM [MV_Next_Requal_Dates]
               WHERE [MV_Next_Requal_Dates].[Next_Requal_Date] > mNRDTT.[Next_Requal_Date] AND mNRDTT.[Tier_Type] = [MV_Next_Requal_Dates].[Tier_Type]
            )
         ELSE dateadd(day, -1, mNRDTT.[Next_Requal_Date])
      END)
      AS Current_Requal_Valid_Through_Date, 
      (CASE 
         WHEN (CASE 
            WHEN mPCRT.[Current_Requal_Tier] IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'BRONZE'
         ELSE (CASE 
            WHEN mPCRT.[Current_Requal_Tier] = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
            ELSE mPCRT.[Current_Requal_Tier]
         END)
      END) AS Current_Requal_Tier, 
      (CASE 
         WHEN mPCRT.[Current_Requal_Upgrade_Tier_Rank] = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPCRUT.[Current_Requal_Upgrade_Tier] IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN [Current_Tier] IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
               ELSE 'SILVER'
            END)
            ELSE mPCRUT.[Current_Requal_Upgrade_Tier]
         END)
      END) AS Current_Requal_Upgrade_Tier, 
      SUBSTRING((CASE 
         WHEN mPCRT.[Current_Requal_Upgrade_Tier_Rank] = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPCRUT.[Points_To_Current_Requal_Upgrade_Tier] IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN [Current_Tier] IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '6000'
               ELSE '2000'
            END)
            ELSE CONVERT(nvarchar(255),mPCRUT.[Points_To_Current_Requal_Upgrade_Tier])
         END)
      END),1,255) AS Points_To_Current_Requal_Upgrade_Tier, 
      mNRD.[Next_Requal_Qualification_Period_Start_Date], 
      (CASE
		WHEN CAST(getdate() AS DATE) > mNRD.[Next_Requal_Qualification_Period_End_Date] THEN mNRD.[Next_Requal_Qualification_Period_End_Date]
		ELSE CAST(getdate() AS DATE)
	   END) AS Next_Requal_Play_Through_Date, 
      mNRD.[Next_Requal_Qualification_Period_End_Date], 
      mNRD.[Next_Requal_Date], 
      (CASE 
         WHEN (CASE 
            WHEN mPNRT.[Next_Requal_Tier] IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'BRONZE'
         ELSE (CASE 
            WHEN mPNRT.[Next_Requal_Tier] = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
            ELSE mPNRT.[Next_Requal_Tier]
         END)
      END) AS Next_Requal_Tier, 
      (CASE 
         WHEN month(getdate()) = month(dateadd(month, -1, mNRD.[Next_Requal_Date])) THEN 'N'
         ELSE (CASE 
            WHEN [Next_Requal_Upgrade_Tier] = 'DO NOT DISPLAY' THEN 'N'
            ELSE 'Y'
         END)
      END) AS Next_Requal_Upgrade_Message_YN, 
      (CASE 
         WHEN mPNRT.[Next_Requal_Upgrade_Tier_Rank] = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.[Next_Requal_Upgrade_Tier] IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN [Current_Tier] IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
               ELSE 'SILVER'
            END)
            ELSE mPNRUT.[Next_Requal_Upgrade_Tier]
         END)
      END) AS Next_Requal_Upgrade_Tier, 
      (CASE 
         WHEN mPNRT.[Next_Requal_Upgrade_Tier_Rank] = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.[Points_To_Next_Requal_Upgrade_Tier] IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN [Current_Tier] IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '6000'
               ELSE '2000'
            END)
            ELSE CONVERT(nvarchar(255),mPNRUT.[Points_To_Next_Requal_Upgrade_Tier])
         END)
      END) AS Points_To_Next_Requal_Upgrade_Tier, 
      (CASE 
         WHEN mPNRT.[Next_Requal_Upgrade_Tier_Rank] = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.[Points_To_Next_Requal_Upgrade_Tier_Percentage] IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN '0'
            ELSE CONVERT(nvarchar(255),mPNRUT.[Points_To_Next_Requal_Upgrade_Tier_Percentage])
         END)
      END) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--   INTO MV_Requal_Meter_Data_Export
   FROM 
      (((((([MV_Players_By_Current_Tier] AS mPCT
         LEFT JOIN [MV_Players_By_Next_Requal_Tier] AS mPNRT
         ON mPCT.[PlayerID] = mPNRT.[PlayerID]) 
         LEFT JOIN [Club_Tiers] 
         ON mPCT.[Current_Tier] = [Club_Tiers].[Tier]) 
         LEFT JOIN [MV_Players_By_Next_Requal_Upgrade_Tier] AS mPNRUT
         ON mPCT.[PlayerID] = mPNRUT.[PlayerID]) 
         LEFT JOIN [MV_Next_Requal_Dates_By_Tier_Type] AS mNRDTT
         ON [Club_Tiers].[Tier_Type] = mNRDTT.[Tier_Type]) 
         LEFT JOIN [MV_Next_Requal_Dates] AS mNRD
         ON (mNRDTT.[Next_Requal_Date] = mNRD.[Next_Requal_Date]) AND (mNRDTT.[Tier_Type] = mNRD.[Tier_Type])) 
         LEFT JOIN [MV_Players_By_Current_Requal_Tier] AS mPCRT
         ON mPCT.[PlayerID] = mPCRT.[PlayerID]) 
         LEFT JOIN [MV_Players_By_Current_Requal_Upgrade_Tier] AS mPCRUT
         ON mPCT.[PlayerID] = mPCRUT.[PlayerID]


----------------------------------------------------	


SELECT mP.[PlayerID], mP.[GamingDt], Sum((
      CASE 
         WHEN [DeptID] <> 'POKR' THEN [BasePts]
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN [DeptID] = 'POKR' THEN [BasePts]
         ELSE 0
      END)) AS Poker_Base_Points
   FROM [mv_Patron_Ratings_By_Dept] as mP
   GROUP BY mP.[PlayerID], mP.[GamingDt]


----------------------------------------------------	


SELECT mPN.[PlayerID], 
	      [Club_Tiers].[Tier] AS Next_Requal_Upgrade_Tier, 
	      [Point_Threshold] - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
	      1 - ([Point_Threshold] - [Non-Poker_Base_Points]) / [Point_Threshold] AS Points_To_Next_Requal_Upgrade_Tier_Percentage
   FROM 
      ([MV_Players_By_Next_Requal_Tier] AS mPN
         INNER JOIN [Club_Tiers] 
         ON (mPN.[Next_Requal_Upgrade_Tier_Rank] = [Club_Tiers].[Tier_Rank]) AND (mPN.[Tier_Type] = [Club_Tiers].[Tier_Type])) 
         INNER JOIN [MV_Patron_Ratings_Next_Requal] mPR
         ON mPN.[PlayerID] = mPR.[PlayerID]


----------------------------------------------------	


SELECT mPR.[PlayerID], [Club_Tiers].[Tier_Type], Min([Club_Tiers].[Tier_Rank]) AS Next_Requal_Tier_Rank
   FROM 
      [MV_Patron_Ratings_Next_Requal] AS mPR
         INNER JOIN [Club_Tiers] 
         ON mPR.[Tier_Type] = [Club_Tiers].[Tier_Type]
   WHERE (((mPR.[Non-Poker_Base_Points]) >= [Club_Tiers].[Point_Threshold]) AND (([Club_Tiers].[Point_Type]) = 'Non-Poker Base')) OR ((([Club_Tiers].[Point_Type]) = 'Poker Base') AND ((mPR.[Poker_Base_Points]) >= [Club_Tiers].[Point_Threshold]))
   GROUP BY mPR.[PlayerID], [Club_Tiers].[Tier_Type]


----------------------------------------------------	


SELECT n.[Tier_Type], Min(n.[Next_Requal_Date]) AS Next_Requal_Date
   FROM [MV_Next_Requal_Dates] n
   WHERE (((n.[Next_Requal_Date]) > getdate()))
   GROUP BY n.[Tier_Type]


----------------------------------------------------	


SELECT vP.[Acct], vP.[PlayerID], (
      CASE 
         WHEN (
            CASE 
               WHEN [Tier] IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE [Tier]
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN [Tier_Rank] IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE [Tier_Rank]
      END) AS Current_Tier_Rank
   FROM 
      [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejas] AS vP
         LEFT JOIN [Club_Tiers] 
         ON vP.[ClubStatus] = [Club_Tiers].[Tier]


----------------------------------------------------	

/***  OLD CODE

SELECT vR.[PlayerID], 
       vR.[GamingDt], 
       vR.[DeptID], 
       Sum(vR.[BasePts]) AS BasePts 
   FROM [CRManalytics].[dbo].[tblRatings] AS vR 
   WHERE (((vR.[IsVoid]) = 0))
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

**/

SELECT vR.[PlayerID], 
       vR.[GamingDt], 
       vR.[DeptID], 
       Sum(vR.[BasePts]) AS BasePts 
   FROM [CRManalytics].[dbo].[tblRatings] AS vR 
   WHERE (((vR.[IsVoid]) = 0))
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

truncate table [MV_Patron_Ratings]
truncate table [MV_Patron_Ratings_By_Dept]
truncate table [MV_Patron_Ratings_Current_Requal]
truncate table [MV_Patron_Ratings_Next_Requal]
truncate table [MV_Players_By_Current_Requal_Tier]
truncate table [MV_Players_By_Current_Requal_Tier_Rank]
truncate table [MV_Players_By_Current_Requal_Upgrade_Tier]
truncate table [MV_Players_by_Current_Tier]
truncate table [MV_Players_By_Next_Requal_Tier]
truncate table [MV_Players_By_Next_Requal_Tier_Rank]
truncate table [MV_Players_By_Next_Requal_Upgrade_Tier]
truncate table [MV_Requal_Meter_Data_Export]
truncate table [tblRatings]
truncate table MV_Next_Requal_Dates
truncate table MV_Next_Requal_Dates_by_Tier_Type


************************************/