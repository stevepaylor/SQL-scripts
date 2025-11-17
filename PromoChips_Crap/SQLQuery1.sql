DROP TABLE IF EXISTS [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips] ;
GO

SELECT 
  [TranID]
, [PromoChips]

--INTO [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips]

FROM [CMKTDB13DPR].[CMP13].[dbo].[tTableRating]

--WHERE [ModifiedDtm] >= '2024-10-22'
WHERE PromoChips <> 0

SELECT COUNT(*)
FROM [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips]

MERGE INTO [iQ-Gaming].[CMP_13-1].[tTableRating] AS Target
USING [iQ-Gaming].[CMP_13-1].[tTableRating_PromoChips] AS Source  
ON (Target.[TranId] = Source.[TranId])

WHEN MATCHED 
THEN UPDATE SET 
Target.[PromoChips] = Source.[PromoChips];
GO

SELECT 
  [PlayerId]
, [GamingDt]
, [TranID]
, [ModifiedDtm]
, [PromoChips]

FROM [iQ-Gaming].[CMP_13-1].[tTableRating]

WHERE [PromoChips] <> 0

ORDER BY
  [PlayerId]
, [GamingDt]
, [TranID]
, [ModifiedDtm]