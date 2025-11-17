SELECT DISTINCT [TagCode]
      ,[OfferDescription1]
      ,[OfferDescription2]
      ,[OfferDescription3]
      ,[OfferCategory]
      ,[BeginDate]
      ,[EndDate]
      ,[Valid_BeginDate]
      ,[Valid_EndDate]
INTO [iQ-Gaming].[CMP_13-1].Website_Tag_List
FROM DWHDB01PR.[iQ-Gaming].[CMP_13-1].[Website_Tag_List_DISTINCT_NOT_NULL]
WHERE TagCode IS NOT NULL

--(147320 rows affected)
--(111448 rows affected)
-- (111447 rows affected)
-- (111440 rows affected)

SELECT COUNT(*), TagCode
FROM [iQ-Gaming].[CMP_13-1].[Website_Tag_List_DISTINCT_NOT_NULL]
GROUP BY TagCode
HAVING COUNT(*) > 1

--SELECT DISTINCT [TagCode]
--FROM [iQ-Gaming].[CMP_13-1].[Website_Tag_List_DISTINCT_NOT_NULL]

SELECT *
FROM [iQ-Gaming].[CMP_13-1].[Website_Tag_List_DISTINCT_NOT_NULL]
WHERE TagCode LIKE 'HI2012AC'
   OR TagCode LIKE 'Hoteloffer%1015HOPN1%'  
   OR TagCode LIKE 'K1017SpookyFeeQual'
   OR TagCode LIKE 'PromoOffer=%0716B0005A%'
