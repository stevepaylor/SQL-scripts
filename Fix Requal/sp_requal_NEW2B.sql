USE [RequalDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Requal]    Script Date: 9/30/2020 10:55:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER PROCEDURE [dbo].[sp_Requal_NEW2]
--AS
--BEGIN
-- SET NOCOUNT ON -- added to prevent extra result sets from interfering with SELECT statements.

--SET NOCOUNT ON;
 
----------------------------------------------------------------------------------------------------------
-- 01 - Populate Table R_01_Next_Requal_Dates
----------------------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
-----------------------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_01_Next_Requal_Dates', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_01_Next_Requal_Dates'
  DROP TABLE RequalDB.dbo.R_temp_01_Next_Requal_Dates
END

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. 
---------------------------------------------------------------------------------------------

SELECT DISTINCT 
 Tier_Type
,Requal_Month
,Requal_Period_Start_Month
,Requal_Period_End_Month


--****************************************************************************************************************************************************************
-- DateOn1st User Defined Function (UDF) is used to convert an input date to the same date year and month but starting on the first of the month
-- for example, dbo.DateOn1st('2020-01-25') would return '2020-01-01'
-- this was added to simplify the code
--****************************************************************************************************************************************************************

--****************************************************************************************************************************************************************
-- Next_Requal_Date = add months to the current date 
-- months = Requal_Period_End_Month - "month part (MM) from the current date"
-- EXAMPLE: [current date] 2020-10-06 + ( [Requal_Period_End_Month] 12 - [MM from the current date] 10 = 2021-01-01 (DD is set to 01 to have first of the month)
--****************************************************************************************************************************************************************

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(MONTH,- (MONTH(GETDATE()) - Requal_Period_End_Month)+1,dbo.DateOn1st(GETDATE()))
		ELSE DATEADD(MONTH,- (MONTH(GETDATE()) - Requal_Period_End_Month) + Requal_Month +1,dbo.DateOn1st(GETDATE()))
 END AS Next_Requal_Date

--****************************************************************************************************************************************************************
-- Current_Requal_Period_Start_Date = subtract months from current date
-- months = current date month (MM) - Requal_Period_Start_Month (MM)
-- EXAMPLE: [current date MM] 2020-10-06 is 10 - [Requal_Period_Start_Month] 7 = 3 
--          [current date] 2020-10-06 - 3 months = 2020-07-01 (DD is set to 01 to have first of the month)
--****************************************************************************************************************************************************************

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(MONTH,- (MONTH(GETDATE()) - Requal_Period_Start_Month),dbo.DateOn1st(GETDATE()))
		ELSE DATEADD(MONTH,- (MONTH(GETDATE()) - Requal_Period_Start_Month) + Requal_Month,dbo.DateOn1st(GETDATE()))
 END  AS Current_Requal_Period_Start_Date

,CASE Requal_Month
	WHEN 6 
		THEN DATEADD(DAY, - 1,DATEADD(MONTH,- (MONTH(GETDATE()) - Requal_Period_End_Month -1),dbo.DateOn1st(GETDATE())))
		ELSE DATEADD(DAY, - 1,DATEADD(MONTH,- (MONTH(GETDATE()) - Requal_Period_End_Month) + Requal_Month + 1,dbo.DateOn1st(GETDATE())))
 END AS Current_Requal_Period_End_Date
 
INTO RequalDB.dbo.R_temp_01_Next_Requal_Dates

FROM RequalDB.dbo.R_Requal_Dates ;

---------------------------------------------------------------------------------------------
-- 02 - Populate Table R_02_Next_Requal_Dates_by_Tier_Type
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_02_Next_Requal_Dates_by_Tier_Type'
  DROP TABLE RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type
END

SELECT DISTINCT 
  r01.Tier_Type
, MIN(r01.Next_Requal_Date) AS Next_Requal_Date

INTO RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type

FROM RequalDB.dbo.R_temp_01_Next_Requal_Dates r01

GROUP BY r01.Tier_Type ;

---------------------------------------------------------------------------------------------
-- 03 - Populate Table R_03_tblRatings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_03_tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_03_tblRatings'
  DROP TABLE RequalDB.dbo.R_temp_03_tblRatings
END

SELECT DISTINCT 
  CMP1.PlayerID
, CMP1.IsVoid
, CMP1.GamingDt
, CMP1.DeptID4
, CMP1.BasePts 

INTO RequalDB.dbo.R_temp_03_tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal CMP1

WHERE CMP1.GamingDt >= (SELECT MIN(Current_Requal_Period_Start_Date) FROM RequalDB.dbo.R_temp_01_Next_Requal_Dates) ;

---------------------------------------------------------------------------------------------
-- 04 - Populate Table R_04_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_04_Patron_Ratings_By_Dept', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_04_Patron_Ratings_By_Dept'
  DROP TABLE RequalDB.dbo.R_temp_04_Patron_Ratings_By_Dept
END

SELECT 
  r03.PlayerID
, NULL AS IsVoid
, r03.GamingDt
, r03.DeptID4
, MAX(r03.BasePts) AS BasePts

INTO RequalDB.dbo.R_temp_04_Patron_Ratings_By_Dept 

FROM RequalDB.dbo.R_temp_03_tblRatings AS r03 

--WHERE ISNULL(r03.IsVoid,0) = 0
WHERE r03.IsVoid = 0

GROUP BY 
  r03.PlayerID
, r03.GamingDt 
, r03.DeptID4 

HAVING 
CAST((r03.GamingDt) AS DATE) BETWEEN 
(
SELECT MIN(r01a.Current_Requal_Period_Start_Date)
FROM RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type r02a
INNER JOIN R_temp_01_Next_Requal_Dates r01a
ON r02a.Next_Requal_Date = r01a.Next_Requal_Date 
AND r02a.Tier_Type = r01a.Tier_Type
) 
AND 
(
SELECT MAX(r01b.Current_Requal_Period_End_Date)
FROM RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type  r02b
INNER JOIN R_temp_01_Next_Requal_Dates  AS r01b
ON r02b.Next_Requal_Date = r01b.Next_Requal_Date 
AND r02b.Tier_Type = r01b.Tier_Type
)

ORDER BY 
  r03.PlayerID
, r03.GamingDt 
, r03.DeptID4 ;

---------------------------------------------------------------------------------------------
-- 05 - Populate Table R_05_Patron_Ratings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_05_Patron_Ratings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_05_Patron_Ratings'
  DROP TABLE RequalDB.dbo.R_temp_05_Patron_Ratings
END

SELECT DISTINCT 
	r04.PlayerID
, r04.GamingDt

, SUM(
  CASE 
		WHEN r04.DeptID4 <> 'POKR' THEN BasePts
    ELSE 0
  END) 
	AS [Non-Poker_Base_Points]
	
, SUM(
  CASE 
    WHEN r04.DeptID4 = 'POKR' THEN BasePts
    ELSE 0
  END) 
	AS Poker_Base_Points

INTO RequalDB.dbo.R_temp_05_Patron_Ratings

FROM RequalDB.dbo.R_temp_04_Patron_Ratings_By_Dept r04
   
GROUP BY 
	r04.PlayerID
, r04.GamingDt ;

---------------------------------------------------------------------------------------------
-- 06 - Populate Table R_06_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_06_Players_by_Current_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_06_Players_by_Current_Tier'
  DROP TABLE RequalDB.dbo.R_temp_06_Players_by_Current_Tier
END

SELECT DISTINCT 
  CMP2.Acct
, CMP2.PlayerID

, CASE 
    WHEN CT.Tier IS NULL THEN 'BRONZE'
		ELSE CT.Tier
  END
	AS Current_Tier

INTO RequalDB.dbo.R_temp_06_Players_by_Current_Tier

--FROM CMKTDB13DPR.CMP13.dbo.viewPlayersViejas CMP2
FROM CMKTDB13CPR.CMP13.dbo.viewPlayersViejasRequalExt CMP2
LEFT JOIN RequalDB.dbo.R_Club_Tiers CT
ON CMP2.ClubStatus = CT.Tier

WHERE ISNUMERIC(CMP2.Acct) = 1 ;

---------------------------------------------------------------------------------------------
-- 07 - Populate Table R_07_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_07_Patron_Ratings_Current_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_07_Patron_Ratings_Current_Requal'
  DROP TABLE RequalDB.dbo.R_temp_07_Patron_Ratings_Current_Requal
END

SELECT DISTINCT
  r05.PlayerID
, r05.GamingDt
, r06.Current_Tier
, CT.Tier_Type
, SUM(r05.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, SUM(r05.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_temp_07_Patron_Ratings_Current_Requal

FROM RequalDB.dbo.R_temp_05_Patron_Ratings r05

INNER JOIN RequalDB.dbo.R_temp_06_Players_by_Current_Tier r06
ON r05.PlayerID = r06.PlayerID

INNER JOIN RequalDB.dbo.R_Club_Tiers CT
ON r06.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type r02
ON CT.Tier_Type = r02.Tier_Type

INNER JOIN R_01_Next_Requal_Dates r01
ON r02.Next_Requal_Date = r01.Next_Requal_Date
AND r02.Tier_Type = r01.Tier_Type
AND r06.Current_Tier = CT.Tier
--AND (r01.Requal_Month = 6 OR r01.Requal_Month = 12)

WHERE r05.GamingDt BETWEEN r01.Current_Requal_Period_Start_Date AND r01.Current_Requal_Period_End_Date
 -- AND r05.[Non-Poker_Base_Points] IS NOT NULL
	--AND r05.[Non-Poker_Base_Points] > 0

GROUP BY 
  r05.PlayerID
, r05.GamingDt
, r06.Current_Tier
, CT.Tier_Type ;

---------------------------------------------------------------------------------------------
-- 08 - Populate Table R_08_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_08_Players_By_Current_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_08_Players_By_Current_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_temp_08_Players_By_Current_Requal_Tier_Rank
END

SELECT DISTINCT 
  r07.PlayerID
, CT.Tier_Type
, CAST(MIN(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank

INTO RequalDB.dbo.R_temp_08_Players_By_Current_Requal_Tier_Rank

FROM RequalDB.dbo.R_temp_07_Patron_Ratings_Current_Requal r07

INNER JOIN R_Club_Tiers AS CT 
ON r07.Tier_Type = CT.Tier_Type

WHERE r07.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND r07.Poker_Base_Points >= CT.Point_Threshold

GROUP BY 
  r07.PlayerID
, CT.Tier_Type  ; 

---------------------------------------------------------------------------------------------
-- 09 - Populate Table R_09_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_09_Players_By_Current_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_09_Players_By_Current_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_temp_09_Players_By_Current_Requal_Tier
END

SELECT DISTINCT
  r08.PlayerID
, r08.Tier_Type
, CT.Tier AS Current_Requal_Tier
--------, CAST(r08.Current_Requal_Tier_Rank AS INT) AS Current_Requal_Tier_Rank

, CAST(CASE  
          WHEN r08.Current_Requal_Tier_Rank = 5 THEN 3
          ELSE r08.Current_Requal_Tier_Rank - 1
        END 
	AS INT) 
	AS Current_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_temp_09_Players_By_Current_Requal_Tier

FROM RequalDB.dbo.R_temp_08_Players_By_Current_Requal_Tier_Rank AS r08

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON r08.Tier_Type = CT.Tier_Type 
AND r08.Current_Requal_Tier_Rank = CT.Tier_Rank ;

---------------------------------------------------------------------------------------------
-- 10A - Populate Table R_10a_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_10a_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_temp_10a_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  r09.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, SUM(CAST(r07.[Non-Poker_Base_Points] AS INT)) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_temp_10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_temp_09_Players_By_Current_Requal_Tier AS r09

INNER JOIN RequalDB.dbo.R_temp_07_Patron_Ratings_Current_Requal r07
ON r09.PlayerID = r07.PlayerID 

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON r09.Tier_Type = CT.Tier_Type 
AND r09.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

GROUP BY
  r09.PlayerID ;

---------------------------------------------------------------------------------------------
-- 10B - Populate Table R_10b_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_10b_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_10b_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_temp_10b_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  r10a.PlayerID
, r10a.[Non-Poker_Base_Points]

INTO RequalDB.dbo.R_temp_10b_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_temp_10a_Players_By_Current_Requal_Upgrade_Tier r10a ;

---------------------------------------------------------------------------------------------
-- 11 - Populate Table R_11_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_11_Patron_Ratings_Next_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_11_Patron_Ratings_Next_Requal'
  DROP TABLE RequalDB.dbo.R_temp_11_Patron_Ratings_Next_Requal
END

SELECT DISTINCT
  r06.PlayerID
, MAX(r06.Current_Tier) AS Current_Tier 
, MIN(CT.Tier_Type) AS Tier_Type
, MAX(r05.GamingDt) AS GamingDt
, SUM(r05.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(r05.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_temp_11_Patron_Ratings_Next_Requal

FROM RequalDB.dbo.R_temp_06_Players_by_Current_Tier r06

INNER JOIN RequalDB.dbo.R_Club_Tiers CT
ON r06.Current_Tier = CT.Tier 

--------INNER JOIN RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type r02
--------ON CT.Tier_Type = r02.Tier_Type ;

--------INNER JOIN R_01_Next_Requal_Dates r01
--------ON r02.Tier_Type = r01.Tier_Type 
--------AND r02.Next_Requal_Date = r01.Next_Requal_Date 
----------AND r01.Requal_Month = 6

INNER JOIN RequalDB.dbo.R_temp_05_Patron_Ratings r05
ON r06.PlayerID = r05.PlayerID

GROUP BY 
  r06.PlayerID ;

---------------------------------------------------------------------------------------------
-- 12 - Populate Table R_12_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_12_Players_By_Next_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_12_Players_By_Next_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_temp_12_Players_By_Next_Requal_Tier_Rank
END

SELECT DISTINCT 
  r11.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

INTO RequalDB.dbo.R_temp_12_Players_By_Next_Requal_Tier_Rank

FROM RequalDB.dbo.R_temp_11_Patron_Ratings_Next_Requal r11

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON r11.Tier_Type = CT.Tier_Type

WHERE ((r11.[Non-Poker_Base_Points] >= CT.Point_Threshold) 
  AND (CT.Point_Type = 'Non-Poker Base')) 
 OR ((CT.Point_Type = 'Poker Base') 
  AND (r11.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  r11.PlayerID
, CT.Tier_Type ;

---------------------------------------------------------------------------------------------
-- 13 - Populate Table R_13_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_13_Players_By_Next_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_13_Players_By_Next_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_temp_13_Players_By_Next_Requal_Tier
END

SELECT DISTINCT
  r12.PlayerID
, r12.Tier_Type
, CASE 
  WHEN  r12.Next_Requal_Tier_Rank = 5 THEN 3
  ELSE  r12.Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_temp_13_Players_By_Next_Requal_Tier

FROM RequalDB.dbo.R_temp_12_Players_By_Next_Requal_Tier_Rank r12 ;

--------INNER JOIN RequalDB.dbo.R_Club_Tiers CT 
--------ON  r12.Tier_Type = CT.Tier_Type
--------AND  r12.Next_Requal_Tier_Rank = CT.Tier_Rank ;

---------------------------------------------------------------------------------------------
-- 14 - Populate Table R_14_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_temp_14_Players_By_Next_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_14_Players_By_Next_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_temp_14_Players_By_Next_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  r13.PlayerID
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - r11.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
, ISNULL(r11.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_temp_14_Players_By_Next_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_temp_13_Players_By_Next_Requal_Tier r13

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON r13.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND r13.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.R_temp_11_Patron_Ratings_Next_Requal r11
ON r13.PlayerID = r11.PlayerID ;

---------------------------------------------------------------------------------------------
-- 15 - Populate Table R_temp_15_Player_Total_per_GamingDt
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_temp_15_Player_Total_per_GamingDt', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_temp_15_Player_Total_per_GamingDt'
  DROP TABLE RequalDB.dbo.R_temp_15_Player_Total_per_GamingDt
END

SELECT  
 r05.PlayerID
,r05.GamingDt
,SUM(r05.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_temp_15_Player_Total_per_GamingDt

FROM RequalDB.dbo.R_temp_05_Patron_Ratings r05

GROUP BY 
 r05.PlayerID
,r05.GamingDt

ORDER BY 
 r05.PlayerID
,r05.GamingDt ;

---------------------------------------------------------------------------------------------
-- 16a - Populate Table R_16a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_temp_16a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_16a_Data_Export'
  DROP TABLE RequalDB.dbo.R_temp_16a_Data_Export
END

SELECT DISTINCT
  r06.Acct
, r06.PlayerID
, r05.GamingDt
, r06.Current_Tier 
	   
, CASE 
  WHEN r13.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(r14.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN r06.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE r14.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier

, CAST( 
	CASE 
		WHEN r13.Next_Requal_Upgrade_Tier_Rank = '0' 
		THEN -1
		ELSE (CASE 
					WHEN ISNULL(r14.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
					THEN (CASE 
					WHEN r09.Current_Requal_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' )
					THEN 60000 
					ELSE 20000 
					END)
 		ELSE CAST(r14.Points_To_Next_Requal_Upgrade_Tier AS INT)
		END)
  END
	AS bigint)
  AS Points_To_Next_Requal_Upgrade_Tier
   
, ISNULL(r07.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_temp_16a_Data_Export
   
FROM RequalDB.dbo.R_temp_06_Players_by_Current_Tier r06

LEFT OUTER JOIN RequalDB.dbo.R_temp_13_Players_By_Next_Requal_Tier r13
ON r06.PlayerID = r13.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_Club_Tiers CT 
ON r06.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.R_temp_14_Players_By_Next_Requal_Upgrade_Tier r14
ON r06.PlayerID = r14.PlayerID
		 
------LEFT OUTER JOIN RequalDB.dbo.R_temp_02_Next_Requal_Dates_by_Tier_Type r02
------ON CT.Tier_Type = r02.Tier_Type
		 
------LEFT OUTER JOIN RequalDB.dbo.R_temp_01_Next_Requal_Dates r01
------ON r02.Next_Requal_Date = r01.Next_Requal_Date
------AND r02.Tier_Type = r01.Tier_Type
--------AND r01.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.R_temp_09_Players_By_Current_Requal_Tier r09
ON r06.PlayerID = r09.PlayerID

INNER JOIN RequalDB.dbo.R_temp_10b_Players_By_Current_Requal_Upgrade_Tier r10b
ON r06.PlayerID = r10b.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_temp_07_Patron_Ratings_Current_Requal r07
ON r06.PlayerID = r07.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_temp_05_Patron_Ratings r05
ON r06.PlayerID = r05.PlayerID ;

----------------------------------------------------------------------------------
-- 16b - Populate Table R_16b_Data_Export
----------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_temp_16b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_16b_Data_Export'
  DROP TABLE RequalDB.dbo.R_temp_16b_Data_Export
END

SELECT DISTINCT
  r16a.Acct
, r16a.PlayerID
, r16a.GamingDt
, r16a.Current_Tier
, r16a.Next_Requal_Upgrade_Tier
, r16a.Points_To_Next_Requal_Upgrade_Tier
--, MAX(r16a.Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
 
INTO RequalDB.dbo.R_temp_16b_Data_Export

FROM RequalDB.dbo.R_temp_16a_Data_Export r16a

GROUP BY
  r16a.Acct
, r16a.PlayerID
, r16a.GamingDt
, r16a.Current_Tier
, r16a.Next_Requal_Upgrade_Tier
, r16a.Points_To_Next_Requal_Upgrade_Tier ;

---------------------------------------------------------------------------------------------
-- 16c - Populate Table R_16c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_temp_16c_Data_Export_FINAL', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_16c_Data_Export_FINAL'
  DROP TABLE RequalDB.dbo.R_temp_16c_Data_Export_FINAL
END

SELECT 
  r16b.Acct
, r15.PlayerID

, MAX(r16b.Current_Tier) AS Current_Tier
, MAX(r16b.Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier

, MAX(
  CASE
    WHEN r16b.Points_To_Next_Requal_Upgrade_Tier < 0 
		THEN 'EARNED'
		ELSE CAST(r16b.Points_To_Next_Requal_Upgrade_Tier AS varchar(10))
	END)
	AS Points_To_Next_Requal_Upgrade_Tier

--, MAX(r16b.Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier

, SUM(r15.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_temp_16c_Data_Export_FINAL

FROM RequalDB.dbo.R_temp_15_Player_Total_per_GamingDt r15

INNER JOIN RequalDB.dbo.R_temp_16b_Data_Export r16b
ON r15.PlayerID = r16b.PlayerID 
AND r15.GamingDt = r16b.GamingDt

GROUP BY
  r16b.Acct
, r15.PlayerID ;

END
GO