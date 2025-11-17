--The first CTE gets the content as a varbinary(max)  
--as well as the other important columns for all reports,  
--data sources and shared datasets.  
WITH ItemContentBinaries AS  
(  
  SELECT  
     ItemID,Name,Type,\[Type\]  
    ,CASE Type  
       WHEN 2 THEN 'Report'  
       WHEN 5 THEN 'Data Source'  
       WHEN 7 THEN 'Report Part'  
       WHEN 8 THEN 'Shared Dataset'  
       ELSE 'Other'  
     END AS TypeDescription
	, ModifiedByID
	, ModifiedDate
    ,CONVERT(varbinary(max),Content) AS Content 
	
  FROM ReportServer_Sep1.dbo.Catalog  
  WHERE Type IN (2,5,7,8)
    AND [Name] LIKE 'PlayersFullList'
),  
--The second CTE strips off the BOM if it exists...  
ItemContentNoBOM AS  
(  
  SELECT  
     ItemID,Name,\[Type\],TypeDescription  
    ,CASE  
       WHEN LEFT(Content,3) = 0xEFBBBF  
         THEN CONVERT(varbinary(max),SUBSTRING(Content,4,LEN(Content)))  
       ELSE  
         Content  
     END AS Content  
  FROM ItemContentBinaries  
)  
--The outer query gets the content in its varbinary, varchar and xml representations...  
SELECT  
   ItemID,Name,\[Type\],TypeDescription  
  ,Content --varbinary  
  ,CONVERT(varchar(max),Content) AS ContentVarchar --varchar  
  ,CONVERT(xml,Content) AS ContentXML --xml  
    
FROM ItemContentNoBOM  
where name like '%{enter part of report name here}%'