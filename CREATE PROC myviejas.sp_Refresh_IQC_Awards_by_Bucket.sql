USE [iQ-Gaming] ;
GO

CREATE OR ALTER PROCEDURE [myviejas].[sp_Refresh_IQC_Awards_by_Bucket]
AS

TRUNCATE TABLE [iQ-Gaming].[dbo].[IQC_Awards_by_Bucket] ;

INSERT INTO [iQ-Gaming].[dbo].[IQC_Awards_by_Bucket]
SELECT 
  PLAYERID
, GamingDate
, MARKET_GROUP
, SUB_MARKET_GROUP
, AWARD_TYPE
, AWARD_BUCKET
, DATEPART(DAY, GAMINGDATE)/7 + 1 AS [WEEK]
, DATENAME(MONTH, GamingDate) AS [MONTH]
, DATENAME(QUARTER, GAMINGDATE) AS [QUARTER]
, DATENAME(YEAR, GAMINGDATE) AS [YEAR]
, VALUE

FROM [iQ-Gaming].[dbo].[v_IQC_Awards] WITH (NOLOCK)
CROSS APPLY
(
       SELECT 'Marketing', 'Newsletter', 'Bingo', 'Award_BingoCash_ActiveNL', Award_BingoCash_ActiveNL UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Bingo', 'Award_BingoCash_InactiveNL', Award_BingoCash_InactiveNL UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Bingo', 'Award_BingoCash_OuterMarketNL', Award_BingoCash_OuterMarketNL UNION ALL
       SELECT 'Marketing', 'Supplemental', 'Bingo', 'Award_BingoCash_Supplemental', Award_BingoCash_Supplemental UNION ALL
       SELECT 'Discretionary', 'Bingo', 'Bingo', 'award_BingoCash_Discretionary', award_BingoCash_Discretionary UNION ALL
       SELECT 'Special Event', 'Drawing', 'Cash', 'Award_Cash_PromoWinner', Award_Cash_PromoWinner UNION ALL
       SELECT 'Fixed', 'Points', 'Cash', 'Award_Cash_CashBack', Award_Cash_CashBack UNION ALL
       SELECT 'Discretionary', 'Cash', 'Cash', 'Award_Cash_Discretionary', Award_Cash_Discretionary UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Cash', 'Award_Cash_FPConversion', Award_Cash_FPConversion UNION ALL
       SELECT 'Marketing', 'Supplemental', 'Cash', 'Award_Cash_Supplemental', Award_Cash_Supplemental UNION ALL
       SELECT 'Discretionary', 'Cash', 'Other', 'Award_Cash_Other', Award_Cash_Other UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Chips', 'award_PromoChipUsed_ActiveNL', award_PromoChipUsed_ActiveNL UNION ALL
       SELECT 'Discretionary', 'Chips', 'Bacc Rebate', 'award_PromoChipUsed_BaccRebate', award_PromoChipUsed_BaccRebate UNION ALL
       SELECT 'Discretionary', 'Chips', 'Chips', 'award_PromoChipUsed_Discretionary', award_PromoChipUsed_Discretionary UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Chips', 'award_PromoChipUsed_FPConversion', award_PromoChipUsed_FPConversion UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Chips', 'award_PromoChipUsed_INActiveNL', award_PromoChipUsed_INActiveNL UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Chips', 'award_PromoChipUsed_OuterMarketNL', award_PromoChipUsed_OuterMarketNL UNION ALL
       SELECT 'Special Event', 'Drawing', 'Chips', 'award_PromoChipUsed_PromoWinner', award_PromoChipUsed_PromoWinner UNION ALL
       SELECT 'Fixed', 'Points', 'Chips', 'award_PromoChipUsed_PTConversion', award_PromoChipUsed_PTConversion UNION ALL
       SELECT 'Service Recovery', 'Chips', 'Chips', 'award_PromoChipUsed_ServiceRecovery', award_PromoChipUsed_ServiceRecovery UNION ALL
       SELECT 'Marketing', 'Supplemental', 'Chips', 'award_PromoChipUsed_Supplemental', award_PromoChipUsed_Supplemental UNION ALL
       SELECT 'Discretionary', 'Chips', 'Other', 'award_PromoChipUsed_Other', award_PromoChipUsed_Other UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Chips', 'award_PromoChipUsed_FPBus', award_PromoChipUsed_FPBus UNION ALL
       SELECT 'Discretionary', 'FPC', 'FPC', 'award_Comp_Discretionary', award_Comp_Discretionary UNION ALL
       SELECT 'Fixed', 'Tier Benefit', 'Golf', 'award_Comp_GolfBenefit', award_Comp_GolfBenefit UNION ALL
       SELECT 'Service Recovery', 'Comp', 'Comp', 'award_Comp_ServiceRecovery', award_Comp_ServiceRecovery UNION ALL
       SELECT 'Discretionary', 'Comp', 'Other', 'award_Comp_Total_Other_Comp', award_Comp_Total_Other_Comp UNION ALL
       SELECT 'Fixed', 'Tier Benefit', 'Food', 'award_FB_Benefit', award_FB_Benefit UNION ALL
       SELECT 'Marketing', 'Supplemental', 'Food', 'award_FB_Bus', award_FB_Bus UNION ALL
       SELECT 'Discretionary', 'Food', 'Food', 'award_FB_Discretionary', award_FB_Discretionary UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Food', 'award_FB_Marketing', award_FB_Marketing UNION ALL
       SELECT 'Marketing', 'Newsletter', 'Food', 'award_FB_OffProperty', award_FB_OffProperty UNION ALL
       SELECT 'Discretionary', 'Food', 'Host Dine', 'award_FB_HostDine', award_FB_HostDine UNION ALL
       SELECT 'Special Event', 'Drawing', 'Food', 'award_FB_PromoWinner', award_FB_PromoWinner UNION ALL
       SELECT 'Service Recovery', 'Food', 'Food', 'award_FB_ServiceRecovery', award_FB_ServiceRecovery UNION ALL
       SELECT 'Discretionary', 'Food', 'Other', 'Award_FB_Cash_Other', Award_FB_Cash_Other UNION ALL
       SELECT 'Marketing', 'Newsletter', 'FPC', 'award_FPAwarded_ActiveNL', award_FPAwarded_ActiveNL UNION ALL
       SELECT 'Marketing', 'Newsletter', 'FPC', 'award_FPAwarded_InactiveNL', award_FPAwarded_InactiveNL UNION ALL
       SELECT 'Marketing', 'Newsletter', 'FPC', 'award_FPAwarded_OuterMarketNL', award_FPAwarded_OuterMarketNL UNION ALL
       SELECT 'Marketing', 'Supplemental', 'FPC', 'award_FPAwarded_Supplemental', award_FPAwarded_Supplemental UNION ALL
       SELECT 'Marketing', 'Supplemental', 'Bus', 'award_FPAwarded_Bus', award_FPAwarded_Bus UNION ALL
       SELECT 'Discretionary', 'FPC', 'FPC', 'award_FPAwarded_Discretionary', award_FPAwarded_Discretionary UNION ALL
       SELECT 'Hotel', 'Third Party', 'FPC', 'award_FPAwarded_HotelBooking', award_FPAwarded_HotelBooking UNION ALL
       SELECT 'Special Event', 'Drawing', 'FPC', 'award_FPAwarded_PromoWinner', award_FPAwarded_PromoWinner UNION ALL
       SELECT 'Service Recovery', 'FPC', 'FPC', 'award_FPAwarded_ServiceRecovery', award_FPAwarded_ServiceRecovery UNION ALL
       SELECT 'Discretionary', 'FPC', 'Other', 'award_FPAwarded_Other', award_FPAwarded_Other UNION ALL
       SELECT 'Special Event', 'Concert', 'Concert', 'award_Ent_Marketing', award_Ent_Marketing UNION ALL
       SELECT 'Special Event', 'Drawing', 'FPC', 'award_Merchandise_PromoWinner', award_Merchandise_PromoWinner UNION ALL
       SELECT 'Special Event', 'Gift', 'Gift', 'award_Merchandise_Marketing', award_Merchandise_Marketing UNION ALL
       SELECT 'Hotel', 'Room', 'Finance', 'Award_CompsUsed_Hotel_Finance', Award_CompsUsed_Hotel_Finance UNION ALL
       SELECT 'Hotel', 'Room', 'Marketing', 'Award_CompsUsed_Hotel_MKTG', Award_CompsUsed_Hotel_MKTG UNION ALL
       SELECT 'Discretionary', 'Food', 'Hotel Charges', 'Hotel_CompsNoRooms_GrossAmount', Hotel_CompsNoRooms_GrossAmount UNION ALL
       SELECT 'Fixed', 'Tier Benefit', 'Discount', 'Tier_Discount', Tier_Discount
) C (MARKET_GROUP, SUB_MARKET_GROUP, AWARD_TYPE, AWARD_BUCKET, VALUE)

WHERE GamingDate >= '1/1/2022' 
AND ISNULL(VALUE, 0) <> 0

ORDER BY 
  PLAYERID
, GamingDate
, MARKET_GROUP
, SUB_MARKET_GROUP
, AWARD_TYPE
, AWARD_BUCKET

