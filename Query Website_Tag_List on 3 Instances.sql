USE CRManalytics
GO 

----TRUNCATE TABLE dbo.Website_Tag_List_SAVE
----GO

SELECT 'MSBIDB01DV', 'Website_Tag_List_SAVE', COUNT(*)
FROM dbo.Website_Tag_List
GO

--INSERT INTO dbo.Website_Tag_List_SAVE
--SELECT *
--FROM dbo.Website_Tag_List
--GO

SELECT 'CASIDB02PR', COUNT(*)
FROM CASIDB02PR.CRManalytics.dbo.Website_Tag_List
GO

SELECT 'MSBIDB01DV', COUNT(*)
FROM dbo.Website_Tag_List
GO

--TRUNCATE TABLE dbo.Website_Tag_List
--GO

--INSERT INTO dbo.Website_Tag_List
--SELECT *
--FROM CASIDB02PR.CRManalytics.dbo.Website_Tag_List
--GO

SELECT 'CASIDB02PR', COUNT(*)
FROM CASIDB02PR.CRManalytics.dbo.Website_Tag_List
GO

SELECT 'MSBIDB01DV', COUNT(*)
FROM dbo.Website_Tag_List
GO

SELECT 'CMKTDB13CPR', COUNT(*)
FROM CMKTDB13CPR.CMP13.dbo.Website_Tag_List
GO
