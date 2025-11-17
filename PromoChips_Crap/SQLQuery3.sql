USE [iQ-Gaming]
GO

UPDATE [CMP_13-1].[tTableRating]
SET [PromoChips] = 0
GO

SELECT [PromoChips]
FROM [CMP_13-1].[tTableRating_Staging]