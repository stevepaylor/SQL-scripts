--TRUNCATE TABLE VIEJAS_Custom_Processes.dbo.iQC_Offers_Live_Save

--INSERT INTO VIEJAS_Custom_Processes.dbo.iQC_Offers_Live_Save
--SELECT *
--FROM [iQ-Gaming].[dbo].[iQC_Offers_Live]

SELECT COUNT(*)
FROM [iQ-Gaming].[dbo].[iQC_Offers_Live]

SELECT COUNT(*)
FROM VIEJAS_Custom_Processes.[dbo].[iQC_Offers_Live_Save]

SELECT COUNT(*)
FROM VIEJAS_Custom_Processes.[dbo].[iQC_Offers_Live_Repl]