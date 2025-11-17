USE RequalDB

SET NOCOUNT ON

---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Next_Requal_Dates', COUNT(*) FROM MV_Next_Requal_Dates
SELECT 'CASIDB02PR - MV_Next_Requal_Dates', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Next_Requal_Dates

---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Next_Requal_Dates_by_Tier_Type', COUNT(*) FROM MV_Next_Requal_Dates_by_Tier_Type
SELECT 'CASIDB02PR - MV_Next_Requal_Dates_by_Tier_Type', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Next_Requal_Dates_by_Tier_Type

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Patron_Ratings_By_Dept', COUNT(*) FROM MV_Patron_Ratings_By_Dept
SELECT 'CASIDB02PR - MV_Patron_Ratings_By_Dept', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Patron_Ratings_By_Dept

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Patron_Ratings', COUNT(*) FROM MV_Patron_Ratings
SELECT 'CASIDB02PR - MV_Patron_Ratings', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Patron_Ratings

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Players_by_Current_Tier', COUNT(*) FROM MV_Players_by_Current_Tier
SELECT 'CASIDB02PR - MV_Players_by_Current_Tier', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Players_by_Current_Tier

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Patron_Ratings_Current_Requal', COUNT(*) FROM MV_Patron_Ratings_Current_Requal
SELECT 'CASIDB02PR - MV_Patron_Ratings_Current_Requal', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Patron_Ratings_Current_Requal

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Players_By_Current_Requal_Tier_Rank', COUNT(*) FROM MV_Players_By_Current_Requal_Tier_Rank
SELECT 'CASIDB02PR - MV_Players_By_Current_Requal_Tier_Rank', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Players_By_Current_Requal_Tier_Rank

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Players_By_Current_Requal_Tier', COUNT(*) FROM MV_Players_By_Current_Requal_Tier
SELECT 'CASIDB02PR - MV_Players_By_Current_Requal_Tier', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Players_By_Current_Requal_Tier

---------------------------------------------------------------------------------------------
-- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Players_By_Current_Requal_Upgrade_Tier', COUNT(*) FROM MV_Players_By_Current_Requal_Upgrade_Tier
SELECT 'CASIDB02PR - MV_Players_By_Current_Requal_Upgrade_Tier', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Players_By_Current_Requal_Upgrade_Tier

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Patron_Ratings_Next_Requal', COUNT(*) FROM MV_Patron_Ratings_Next_Requal
SELECT 'CASIDB02PR - MV_Patron_Ratings_Next_Requal', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Patron_Ratings_Next_Requal

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Players_By_Next_Requal_Tier_Rank', COUNT(*) FROM MV_Players_By_Next_Requal_Tier_Rank
SELECT 'CASIDB02PR - MV_Players_By_Next_Requal_Tier_Rank', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Players_By_Next_Requal_Tier_Rank

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Players_By_Next_Requal_Tier', COUNT(*) FROM MV_Players_By_Next_Requal_Tier
SELECT 'CASIDB02PR - MV_Players_By_Next_Requal_Tier', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Players_By_Next_Requal_Tier

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Players_By_Next_Requal_Upgrade_Tier', COUNT(*) FROM MV_Players_By_Next_Requal_Upgrade_Tier
SELECT 'CASIDB02PR - MV_Players_By_Next_Requal_Upgrade_Tier', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Players_By_Next_Requal_Upgrade_Tier

---------------------------------------------------------------------------------------------
-- 15 - Populate table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------

SELECT 'MSBIDB01DV - MV_Requal_Meter_Data_Export', COUNT(*) FROM MV_Requal_Meter_Data_Export
SELECT 'CASIDB02PR - MV_Requal_Meter_Data_Export', COUNT(*) FROM CASIDB02PR.CRManalytics.dbo.MV_Requal_Meter_Data_Export
