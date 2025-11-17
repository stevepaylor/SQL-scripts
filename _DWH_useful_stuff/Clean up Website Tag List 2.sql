--TRUNCATE TABLE [iQ-Gaming].[CMP_13-1].Website_Tag_List
--GO

--INSERT INTO [iQ-Gaming].[CMP_13-1].Website_Tag_List
SELECT [TagCode]
      ,[OfferDescription1]
      ,[OfferDescription2]
      ,[OfferDescription3]
      ,[OfferCategory]
      ,[BeginDate]
      ,[EndDate]
      ,[Valid_BeginDate]
      ,[Valid_EndDate]

FROM DWHDB01PR.[iQ-Gaming].[CMP_13-1].[Website_Tag_List_DISTINCT_NOT_NULL]