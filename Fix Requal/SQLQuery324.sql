---------------------------------------------------------------------------------------------
-- 15a - Populate Table Requal_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15a_Data_Export'
  DROP TABLE dbo.Requal_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
--, mPCT.Current_Tier
, mPCRT.Current_Requal_Tier AS Current_Tier
, mPCRT.Current_Requal_Upgrade_Tier_Rank

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
  THEN (SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
        FROM MV_Next_Requal_Dates 
        WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE' 
		ELSE mPCRT.Current_Requal_Tier 
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

----------------- pick up here 	
----------------- pick up here
----------------- pick up here 	
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  --THEN 'EARNED'
  THEN 99999
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
			  THEN 60000 
			  ELSE 20000 
			  END)
      --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
	    ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier AS INT)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 100
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN 0
        ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
        END)
  END 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
,  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

--, SUBSTRING((
,CASE 
             WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
			 --THEN 'EARNED'
			 THEN 99999
             ELSE (CASE 
                   WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
				   THEN (CASE 
				         WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
						 THEN '60000' 
						 ELSE '20000' 
						 END)
                   --ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
                   ELSE mPCRUT.Points_To_Current_Requal_Upgrade_Tier
				   END)
             END
			 --),1,255)
  AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15a_Data_Export
   
FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

INNER JOIN RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN [RequalDB].[dbo].[MV_Patron_Ratings] AS mPR
ON mPCT.PlayerID = mPR.PlayerID