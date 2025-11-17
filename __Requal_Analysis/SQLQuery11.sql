USE [RequalDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



----CREATE PROCEDURE [dbo].[sp_Requal_NEW]
----AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.

SET NOCOUNT ON;
 
----------------------------------------------------------------------------------------------------------
-- 01 - Populate Table R_NEW_01_Next_Requal_Dates
----------------------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
-----------------------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_01_Next_Requal_Dates', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_01_Next_Requal_Dates'
  DROP TABLE RequalDB.dbo.R_NEW_01_Next_Requal_Dates
END

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. 
---------------------------------------------------------------------------------------------
SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

-- 2020-10-02 - spaylor
-- User Defined Function (UDF) DateOn1st is used to convert an input date to the same date year and month but starting on the first of the month
-- for example, dbo.DateOn1st('2020-01-25') would return '2020-01-01'
-- this was added to simplify the code

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_Start_Month),dbo.DateOn1st(GETDATE()))
		ELSE DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_Start_Month),dbo.DateOn1st(GETDATE()))
 END AS Current_Requal_Date

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_Start_Month),dbo.DateOn1st(GETDATE()))
		ELSE DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_Start_Month),dbo.DateOn1st(GETDATE()))
 END  AS Current_Requal_Qualification_Period_Start_Date

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(DAY, - 1,DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month)+1,dbo.DateOn1st(GETDATE())))
		ELSE DATEADD(DAY, - 1,DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month)+1,dbo.DateOn1st(GETDATE())))
 END AS Current_Requal_Qualification_Period_End_Date

 ,CASE Requal_Month
	WHEN 6 
	  THEN DATEADD(MONTH,-(MONTH(GETDATE()))+r.Qualification_Period_End_Month+6,dbo.DateOn1st(GETDATE()))
		ELSE DATEADD(MONTH,-(MONTH(GETDATE()))+r.Qualification_Period_End_Month+6,dbo.DateOn1st(GETDATE()))
 		--ELSE DATEADD(MONTH,-(MONTH(GETDATE()) - Qualification_Period_End_Month) + Requal_Month +1,dbo.DateOn1st(GETDATE()))
 END AS Next_Requal_Date

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month)+6,dbo.DateOn1st(GETDATE()))
		ELSE DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month)+6,dbo.DateOn1st(GETDATE()))
END AS Next_Requal_Qualification_Period_Start_Date

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(DAY, - 1,DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month) +13,dbo.DateOn1st(GETDATE())))
		ELSE DATEADD(DAY, - 1,DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month) +13,dbo.DateOn1st(GETDATE())))
END 
AS Next_Requal_Qualification_Period_End_Date

INTO RequalDB.dbo.R_NEW_01_Next_Requal_Dates

FROM RequalDB.dbo.R_Requal_Dates r

INNER JOIN RequalDB.dbo.R_Clubs c
ON r.Tier_Type = c.Tier_Type ;

---------------------------------------------------------------------------------------------
-- 02 - Populate Table R_NEW_02_Next_Requal_Dates_by_Tier_Type
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_02_Next_Requal_Dates_by_Tier_Type'
  DROP TABLE RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type
END

SELECT DISTINCT 
  n.Tier_Type
, MIN(n.Next_Requal_Date) AS Next_Requal_Date

INTO RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type

FROM RequalDB.dbo.R_NEW_01_Next_Requal_Dates n

--WHERE (((n.Next_Requal_Date) <= getdate()))
   
GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate Table R_NEW_03_tblRatings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_03_tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_03_tblRatings'
  DROP TABLE RequalDB.dbo.R_NEW_03_tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO RequalDB.dbo.R_NEW_03_tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MIN(Current_Requal_Qualification_Period_Start_Date) FROM RequalDB.dbo.R_NEW_01_Next_Requal_Dates)

---------------------------------------------------------------------------------------------
-- 04 - Populate Table R_NEW_04_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_04_Patron_Ratings_By_Dept', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_04_Patron_Ratings_By_Dept'
  DROP TABLE RequalDB.dbo.R_NEW_04_Patron_Ratings_By_Dept
END

SELECT 
  vR.PlayerID
, NULL AS IsVoid
, vR.GamingDt
, vR.DeptID4
, MAX(vR.BasePts) AS BasePts

INTO RequalDB.dbo.R_NEW_04_Patron_Ratings_By_Dept 

FROM RequalDB.dbo.R_NEW_03_tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4 

HAVING 
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN R_NEW_01_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type  AS n5
INNER JOIN R_NEW_01_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4 ;

---------------------------------------------------------------------------------------------
-- 05 - Populate Table R_NEW_05_Patron_Ratings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_05_Patron_Ratings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_05_Patron_Ratings'
  DROP TABLE RequalDB.dbo.R_NEW_05_Patron_Ratings
END

SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID4 <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID4 = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points

INTO RequalDB.dbo.R_NEW_05_Patron_Ratings

FROM RequalDB.dbo.R_NEW_04_Patron_Ratings_By_Dept as mP
  
GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate Table R_NEW_06_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

------IF OBJECT_ID('RequalDB.dbo.R_NEW_06_Players_by_Current_Tier', 'U') IS NOT NULL 
------BEGIN
------  PRINT 'Drop Table R_NEW_06_Players_by_Current_Tier'
------  DROP TABLE RequalDB.dbo.R_NEW_06_Players_by_Current_Tier
------END

------SELECT DISTINCT 
------  vP.Acct
------, vP.PlayerID
----------, Tier
----------, Tier_Rank

------, (CASE 
------   WHEN (CASE 
------         WHEN Tier IS NULL 
------		 THEN 1
------         ELSE 0
------         END) = 1 
------   THEN 'BRONZE'
------   ELSE Tier
------   END) AS Current_Tier
   
------, (CASE 
------   WHEN (CASE 
------         WHEN Tier_Rank IS NULL
------		 THEN 1
------         ELSE 0
------         END) = 1 
------   THEN 5
------   ELSE Tier_Rank
------   END) AS Current_Tier_Rank

------INTO RequalDB.dbo.R_NEW_06_Players_by_Current_Tier

------FROM --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
------	 CMKTDB13CPR.CMP13.dbo.viewPlayersViejasRequalExt AS vP
------     LEFT JOIN RequalDB.dbo.R_Club_Tiers AS CT
------     ON vP.ClubStatus = CT.Tier

------WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 06 - Populate Table R_NEW_06_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_06_Players_by_Current_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_06_Players_by_Current_Tier'
  DROP TABLE RequalDB.dbo.R_NEW_06_Players_by_Current_Tier
END

SELECT DISTINCT 
  vP.Acct
, vP.PlayerID
, vP.ClubStatus
, CT.Tier
, CT.Tier_Rank

,	 CASE WHEN vP.ClubStatus IS NULL 
			  THEN 'BRONZE'
				ELSE UPPER(vP.ClubStatus)
   END AS Current_Tier
   
, (CASE WHEN CT.Tier_Rank IS NULL
		    THEN 5
				ELSE CT.Tier_Rank
   END) AS Current_Tier_Rank

INTO RequalDB.dbo.R_NEW_06_Players_by_Current_Tier

FROM --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	 CMKTDB13CPR.CMP13.dbo.viewPlayersViejasRequalExt AS vP
     LEFT JOIN RequalDB.dbo.R_Club_Tiers_New AS CT
     ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1
  AND vP.ClubStatus NOT IN ('INACTIVE','GIFTCARD')



---------------------------------------------------------------------------------------------
-- 07 - Populate Table R_NEW_07_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_07_Patron_Ratings_Current_Requal'
  DROP TABLE RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal
END

SELECT DISTINCT
  mPR.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal

FROM RequalDB.dbo.R_NEW_05_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.R_NEW_06_Players_by_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN R_NEW_01_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
--AND (mNR.Requal_Month = 6 OR mNR.Requal_Month = 12)

WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date

GROUP BY 
  mPR.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date ;

---------------------------------------------------------------------------------------------
-- 08 - Populate Table R_NEW_08_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_08_Players_By_Current_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank
END

------SELECT DISTINCT 
------  pr.PlayerID
------, pr.[Current_Tier]
------, CT.Tier
------, CT.Tier_Type
------, pr.[Non-Poker_Base_Points] 
------,
--------, CAST(MAX(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank
------, CAST(CT.Tier_Rank AS INT) AS Current_Requal_Tier_Rank

------INTO RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank

------FROM RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal pr

------INNER JOIN R_Club_Tiers_New AS CT 
------ON pr.Current_Tier = CT.Tier

------WHERE 
------pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
------AND (CT.Point_Type = 'Non-Poker Base') --OR (CT.Point_Type = 'Poker Base')) 
------AND pr.Poker_Base_Points >= CT.Point_Threshold
--------AND PlayerID = '1426933'

--------GROUP BY 
--------  pr.PlayerID
--------, CT.Tier_Type  

SELECT DISTINCT 
  pr.PlayerID
, pr.[Current_Tier]
, CT.Tier
, CT.Tier_Type
, CT.Point_Threshold
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(CT.Point_Threshold - pr.[Non-Poker_Base_Points]) as Points_Short_of_Threshold
, CAST(MAX(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank
--, CAST(CT.Tier_Rank AS INT) AS Current_Requal_Tier_Rank

INTO RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank

FROM RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal pr

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT 
ON pr.Current_Tier = CT.Tier

WHERE pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND (CT.Point_Type = 'Non-Poker Base') --OR (CT.Point_Type = 'Poker Base')) 
AND pr.[Non-Poker_Base_Points] >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, pr.[Current_Tier]
, CT.Tier
, CT.Tier_Type
, CT.Point_Threshold

---------------------------------------------------------------------------------------------
-- 09 - Populate Table R_NEW_09_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_09_Players_By_Current_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_09_Players_By_Current_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_NEW_09_Players_By_Current_Requal_Tier
END

SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, CAST(mP.Current_Requal_Tier_Rank AS INT) AS Current_Requal_Tier_Rank
--, CAST((CASE 
--        WHEN mP.Current_Requal_Tier_Rank IN (0,1) THEN 0
--        WHEN mP.Current_Requal_Tier_Rank = 2 THEN 1
--				WHEN mP.Current_Requal_Tier_Rank = 7 THEN 7
--				WHEN mP.Current_Requal_Tier_Rank = 7 THEN 7
--				ELSE mP.Current_Requal_Tier_Rank - 1
--   END) AS INT) AS Current_Requal_Upgrade_Tier_Rank

, CAST((CASE 
        WHEN mP.Current_Requal_Tier_Rank IN (0,1) THEN 0
        WHEN mP.Current_Requal_Tier_Rank = 2 THEN 1
				WHEN mP.Current_Requal_Tier_Rank = 3 THEN 2
				WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
				WHEN mP.Current_Requal_Tier_Rank = 6 THEN 6
				WHEN mP.Current_Requal_Tier_Rank = 7 THEN 7 
				ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS INT) AS Current_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_NEW_09_Players_By_Current_Requal_Tier

FROM RequalDB.dbo.R_NEW_08_Players_By_Current_Requal_Tier_Rank AS mP

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank

---------------------------------------------------------------------------------------------
-- 10A - Populate Table R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mP.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, MAX(CT.Point_Threshold) AS Point_Threshold
, SUM(CAST(mv.[Non-Poker_Base_Points] AS INT)) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_NEW_09_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT
--ON mP.Tier_Type = CT.Tier_Type 
ON mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

GROUP BY
  mP.PlayerID ;

---------------------------------------------------------------------------------------------
-- 10B - Populate Table R_NEW_R10b_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_R10b_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R10b_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_NEW_R10b_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  PlayerID
, Current_Requal_Upgrade_Tier
, Point_Threshold 
, [Non-Poker_Base_Points]
, CAST(Point_Threshold - [Non-Poker_Base_Points] AS BIGINT) AS Points_To_Current_Requal_Upgrade_Tier
, CASE
		WHEN Point_Threshold = 0
		THEN 100
 		ELSE CAST((1 - (Point_Threshold - [Non-Poker_Base_Points])) / Point_Threshold AS NUMERIC(6,2)) 
	END
AS Points_To_Current_Requal_Upgrade_Tier_Percentage

--INTO RequalDB.dbo.R_NEW_R10b_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_NEW_R10a_Players_By_Current_Requal_Upgrade_Tier ;

---------------------------------------------------------------------------------------------
-- 11 - Populate Table R_NEW_R11_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R11_Patron_Ratings_Next_Requal'
  DROP TABLE RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal
END

SELECT DISTINCT
  mP.PlayerID
, MAX(mP.Current_Tier) AS Current_Tier 
, MIN(CT.Tier_Type) AS Tier_Type
, MAX(mN.Next_Requal_Date) AS Next_Requal_Date
, MAX(pr.GamingDt) AS GamingDt
, MAX(mN.Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(mN.Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
--, MAX(mN.Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date
--, MAX(mN.Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(pr.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal

FROM RequalDB.dbo.R_NEW_06_Players_by_Current_Tier AS mP

INNER JOIN RequalDB.dbo.R_Club_Tiers_New CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN RequalDB.dbo.R_NEW_01_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
--AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.R_NEW_05_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

GROUP BY 
  mP.PlayerID ;

---------------------------------------------------------------------------------------------
-- 12 - Populate Table R_NEW_R12_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_R12_Players_By_Next_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R12_Players_By_Next_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_NEW_R12_Players_By_Next_Requal_Tier_Rank
END

SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

INTO RequalDB.dbo.R_NEW_R12_Players_By_Next_Requal_Tier_Rank

FROM RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal AS mPR

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type ;

---------------------------------------------------------------------------------------------
-- 13 - Populate Table R_NEW_R13_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_R13_Players_By_Next_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R13_Players_By_Next_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_NEW_R13_Players_By_Next_Requal_Tier
END

SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_NEW_R13_Players_By_Next_Requal_Tier

FROM RequalDB.dbo.R_NEW_R12_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank ;

---------------------------------------------------------------------------------------------
-- 14 - Populate Table R_NEW_R14_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_R14_Players_By_Next_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R14_Players_By_Next_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_NEW_R14_Players_By_Next_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mPN.PlayerID
, CT.Point_Threshold
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
--, CT.Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier

, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, (1 - (CT.Point_Threshold / CT.Point_Threshold)) AS Points_To_Next_Requal_Upgrade_Tier_Percentage

, ISNULL(mPR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_NEW_R14_Players_By_Next_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_NEW_R13_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.R_NEW_R11_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID ;

---------------------------------------------------------------------------------------------
-- 15a - Populate Table R_NEW_R15a_Data_Export
---------------------------------------------------------------------------------------------
--IF OBJECT_ID('RequalDB.dbo.R_NEW_R15a_Data_Export', 'U') IS NOT NULL 
--BEGIN
--  PRINT 'Drop Table R_NEW_R15a_Data_Export'
--  DROP TABLE RequalDB.dbo.R_NEW_R15a_Data_Export
--END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
, mPCT.Current_Tier 
, mPCT.Current_Tier_Rank

, mPCRT.Current_Requal_Tier

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
  THEN (SELECT dateadd(day, -1, Min(R_NEW_01_Next_Requal_Dates.Next_Requal_Date))
        FROM RequalDB.dbo.R_NEW_01_Next_Requal_Dates 
        WHERE R_NEW_01_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = R_NEW_01_Next_Requal_Dates.Tier_Type)
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

--INTO RequalDB.dbo.R_NEW_R15a_Data_Export
   
FROM RequalDB.dbo.R_NEW_06_Players_by_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.R_NEW_R13_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_Club_Tiers_New AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.R_NEW_R14_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_NEW_02_Next_Requal_Dates_by_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.R_NEW_01_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.R_NEW_09_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

INNER JOIN RequalDB.dbo.R_NEW_R10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_NEW_07_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_NEW_05_Patron_Ratings AS mPR
ON mPCT.PlayerID = mPR.PlayerID ;

----------------------------------------------------------------------------------
-- 15b - Populate Table R_NEW_R15b_Data_Export
----------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_NEW_R15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R15b_Data_Export'
  DROP TABLE RequalDB.dbo.R_NEW_R15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, CAST(Requal_Month AS INT) AS Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date

--, Current_Requal_Tier

, CASE 
  WHEN Points_To_Next_Requal_Upgrade_Tier > 0
  THEN Current_Requal_Upgrade_Tier
  ELSE Current_Requal_Tier
  END
  AS Current_Requal_Tier

, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier

, CAST(Points_To_Next_Requal_Upgrade_Tier AS bigint) AS Points_To_Next_Requal_Upgrade_Tier
--, MAX(CASE
--  WHEN Points_To_Next_Requal_Upgrade_Tier <= 0
--  THEN 'EARNED'
--  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier AS bigint)
--  END)
--  AS Points_To_Next_Requal_Upgrade_Tier

--, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(CASE 
  WHEN Points_To_Next_Requal_Upgrade_Tier_Percentage = '100' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier_Percentage AS NVARCHAR(10))
        END)
  END) 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage

--, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier_MAX

, MAX(CASE
	  --WHEN Points_To_Current_Requal_Upgrade_Tier = 99999
	  WHEN Points_To_Current_Requal_Upgrade_Tier <= 0
	  THEN 'EARNED'
	  ELSE CAST(Points_To_Current_Requal_Upgrade_Tier AS NVARCHAR(10))
	  END)
	  AS Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.R_NEW_R15b_Data_Export

FROM RequalDB.dbo.R_NEW_R15a_Data_Export

GROUP BY
  Acct
, PlayerID
, GamingDt
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
, Points_To_Next_Requal_Upgrade_Tier
--, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table R_NEW_R15c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_NEW_R15c_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R15c_Data_Export'
  DROP TABLE RequalDB.dbo.R_NEW_R15c_Data_Export
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_NEW_R15c_Data_Export
FROM RequalDB.dbo.R_NEW_05_Patron_Ratings

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt ;

---------------------------------------------------------------------------------------------
-- 15d - Populate Table R_NEW_R15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_NEW_R15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R15d_Data_Export'
  DROP TABLE RequalDB.dbo.R_NEW_R15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, CAST(b.Requal_Month AS INT) AS Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO RequalDB.dbo.R_NEW_R15d_Data_Export

FROM RequalDB.dbo.R_NEW_R15c_Data_Export c

INNER JOIN RequalDB.dbo.R_NEW_R15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate Table R_NEW_R15e_Data_Export_FINAL
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_NEW_R15e_Data_Export_FINAL', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_NEW_R15e_Data_Export_FINAL'
  DROP TABLE RequalDB.dbo.R_NEW_R15e_Data_Export_FINAL
END

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

INTO RequalDB.dbo.R_NEW_R15e_Data_Export_FINAL

FROM RequalDB.dbo.R_NEW_R15d_Data_Export

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

--------------------------------------------------------------------------------------------------------
-- 15f - Populate LEGACY Table MV_Requal_Meter_Data_Export
--
-- Must have a legacy copy of the final table by this name to facilitate legacy processes that expect it.
--
---------------------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.NEW_MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.NEW_MV_Requal_Meter_Data_Export'
  DROP TABLE RequalDB.dbo.NEW_MV_Requal_Meter_Data_Export
END

SELECT DISTINCT
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

INTO RequalDB.dbo.NEW_MV_Requal_Meter_Data_Export

FROM RequalDB.dbo.R_NEW_R15e_Data_Export_FINAL

END
GO


