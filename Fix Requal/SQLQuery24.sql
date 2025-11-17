---------------------------------------------------------------------------------------------
-- 06 - Populate Table R_06_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

SELECT DISTINCT 
  vP.Acct
, vP.PlayerID
----, Tier
----, Tier_Rank

, (CASE 
   WHEN (CASE 
         WHEN Tier IS NULL 
		 THEN 1
         ELSE 0
         END) = 1 
   THEN 'BRONZE'
   ELSE Tier
   END) AS Current_Tier
   
, (CASE 
   WHEN (CASE 
         WHEN Tier_Rank IS NULL
		 THEN 1
         ELSE 0
         END) = 1 
   THEN 5
   ELSE Tier_Rank
   END) AS Current_Tier_Rank

----INTO RequalDB.dbo.R_06_Players_by_Current_Tier

FROM --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	 CMKTDB13CPR.CMP13.dbo.viewPlayersViejasRequalExt AS vP
     LEFT JOIN RequalDB.dbo.R_Club_Tiers AS CT
     ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1
  AND vP.PlayerID IN (10506311, 78186, 1037053) 
--AND vP.Acct IN (21134166, 12239681, 20520169) 


---------------------------------------------------------------------------------------------
-- 14 - Populate Table R_14_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

SELECT DISTINCT 
  mPN.PlayerID
, CT.Point_Threshold
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
--, CT.Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier

, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, (1 - (CT.Point_Threshold / CT.Point_Threshold)) AS Points_To_Next_Requal_Upgrade_Tier_Percentage

, ISNULL(mPR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

----INTO RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_13_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.R_11_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID

WHERE mPN.PlayerID IN (10506311, 78186, 1037053) 


---------------------------------------------------------------------------------------------
-- 15a - Populate Table R_15a_Data_Export
---------------------------------------------------------------------------------------------

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
, mPCT.Current_Tier 
----, mPCRT.Current_Requal_Tier AS Current_Tier2

, mPCT.Current_Tier_Rank AS Current_Tier_Rank1
, mPCRT.Current_Requal_Upgrade_Tier_Rank AS Current_Tier_Rank2

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, Min(R_01_Next_Requal_Dates.Next_Requal_Date))
        FROM RequalDB.dbo.R_01_Next_Requal_Dates 
        WHERE R_01_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = R_01_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE' 
		--ELSE mPCRT.Current_Requal_Tier 
		ELSE mPCT.Current_Tier 
		END)
  END 
  AS Current_Requal_Tier
  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(getdate() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier

, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  --THEN 'EARNED'
  THEN -1
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              --WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
			  WHEN mPCRT.Current_Requal_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' )
			  THEN 60000 
			  ELSE 20000 
			  END)
      --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
	  --ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier -ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS INT)
		ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier AS INT)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN '100'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage AS VARCHAR(10))
        END)
  END 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
, ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, CASE WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
	   --THEN 'EARNED'
	   THEN -1
       ELSE (CASE 
             WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
		 	 THEN (CASE 
			      WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
				  THEN 60000 
				  ELSE 20000 
				  END)
             --ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
             ELSE mPCRUT.Points_To_Current_Requal_Upgrade_Tier
		     END)
  END
  AS Points_To_Current_Requal_Upgrade_Tier

----INTO RequalDB.dbo.R_15a_Data_Export
   
FROM RequalDB.dbo.R_06_Players_by_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.R_13_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.R_01_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.R_09_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

INNER JOIN RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_07_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_05_Patron_Ratings AS mPR
ON mPCT.PlayerID = mPR.PlayerID

WHERE mPCT.PlayerID IN (10506311, 78186, 1037053) 



---------------------------------------------------------------------------------------------
-- 15e - Populate Table R_15e_Data_Export_FINAL
---------------------------------------------------------------------------------------------
SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, MAX([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points_MAX]
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier
--, MAX(CAST(Points_To_Current_Requal_Upgrade_Tier AS BIGINT)) AS Points_To_Current_Requal_Upgrade_Tier

----INTO RequalDB.dbo.R_15e_Data_Export_FINAL

FROM RequalDB.dbo.R_15d_Data_Export

WHERE PlayerID IN (10506311, 78186, 1037053) 
--WHERE Acct IN (21134166, 12239681, 20520169) 

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID


SELECT 
  Acct
, PlayerID
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
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage
, [Non-Poker_Base_Points]
, Points_To_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_15e_Data_Export_FINAL

WHERE PlayerID IN (10506311, 78186, 1037053) 
--WHERE Acct IN (21134166, 12239681, 20520169) 


------Acct 12239681 / PlayerID 78186    has 29,905 tier points and is currently Silver.  In order to reach Gold he would need 70,095
------Acct 20520169 / PlayerID 1037053  has 21,970 tier points and is currently Silver.  In order to reach Gold he would need 78,030
------Acct 21134166 / PlayerID 10506311 has current tier points of 4,537 but current tier is Silver.  In order to reach Silver 
------------(as she currently qualifies for Bronze) would be 15,463 to next tier upgrade.
------Acct 60062603 / Player ID 1251485 has 0 points and is Bronze.  In order to reach Silver he would need 20,000
------Account 10008327 / Player ID 287455 has 0 points and is Silver.  In order to reach Silver he would need 20,000.