USE CMP13;  
GO 
 
SET NUMERIC_ROUNDABORT OFF;  
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,  
    QUOTED_IDENTIFIER, ANSI_NULLS ON;  
GO  

--Create view with schemabinding. 
 
IF OBJECT_ID ('viewMyViejasRequal', 'view') IS NOT NULL  

DROP VIEW viewMyViejasRequal ;  
GO 
 
CREATE VIEW viewMyViejasRequal  
WITH SCHEMABINDING  
AS  
SELECT 
  AW.PlayerID
, AW.IsVoid
, AW.GamingDt
, CAST(SUBSTRING(DP.DeptCode,1,4) AS CHAR(4)) AS DeptID4 
, SUM(ISNULL(PP.BasePts,0)) AS BasePts
, COUNT_BIG(*) as NumRecs

FROM dbo.tAwards AW 
JOIN dbo.tDept DP on AW.DeptID = DP.DeptId
JOIN dbo.tPlayerPoints PP on AW.TranId = PP.TranId

WHERE AW.IsVoid <> 1
  AND AW.IsVoid IS NOT NULL

GROUP BY
  AW.PlayerID
, AW.IsVoid
, AW.GamingDt
, CAST(SUBSTRING(DP.DeptCode,1,4) AS CHAR(4)) 

GO

--Create an index on the view to support the MyViejas Requal SSIS package  
CREATE UNIQUE CLUSTERED INDEX CL_IX_MyViejasRequal  
ON viewMyViejasRequal 
( PlayerID
, IsVoid
, GamingDt
, DeptID4)
GO