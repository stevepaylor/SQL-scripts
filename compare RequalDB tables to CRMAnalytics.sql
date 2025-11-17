/***************************************************/

---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Next_Requal_Dates
GO
--(4 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Next_Requal_Dates
GO
--(6 row(s) affected)

---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type
GO
--(2 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Next_Requal_Dates_By_Tier_Type
GO
--(2 row(s) affected)

---------------------------------------------------------------------------------------------
-- 03 - Populate tblRatings
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type
GO
--(2 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Next_Requal_Dates_By_Tier_Type
GO
--(2 row(s) affected)

/******************************************************/

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Patron_Ratings_By_Dept
GO
--(522301 row(s) affected) 

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Patron_Ratings_By_Dept
GO
--(521785 row(s) affected) 

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Patron_Ratings
GO
-- (477398 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Patron_Ratings
GO
-- (476929 row(s) affected)

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Players_by_Current_Tier
GO
-- (313748 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Players_by_Current_Tier
GO
-- (1745865 row(s) affected)

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Patron_Ratings_Current_Requal
GO
-- (141451 row(s) affected)


SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Patron_Ratings_Current_Requal
GO
-- (151243 row(s) affected)

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
GO
-- (141451 row(s) affected)


SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Players_By_Current_Requal_Tier_Rank
GO
-- (151243 row(s) affected)

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier
GO
-- (141451 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Players_By_Current_Requal_Tier
GO
-- (151243 row(s) affected)

---------------------------------------------------------------------------------------------
-- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
GO
-- (141268 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
GO
-- (151045 row(s) affected)

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Patron_Ratings_Next_Requal
GO
-- (141451 row(s) affected)
 

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Patron_Ratings_Next_Requal
GO
-- (151243 row(s) affected) 

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
GO
-- (141451 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Players_By_Next_Requal_Tier_Rank
GO
-- (151243 row(s) affected)

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier
GO
-- (141451 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Players_By_Next_Requal_Tier
GO
-- (151243 row(s) affected)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
GO
-- (141268 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
GO
-- (151045 row(s) affected)

---------------------------------------------------------------------------------------------
-- 15 - Populate table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------

SELECT *
FROM RequalDB.dbo.MV_Requal_Meter_Data_Export
GO
-- (313748 row(s) affected)

SELECT *
FROM CASIDB02PR.CRMANALYTICS.dbo.MV_Requal_Meter_Data_Export
GO
-- (1745865 row(s) affected)







