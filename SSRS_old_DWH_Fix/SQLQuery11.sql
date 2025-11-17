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
	
  FROM ReportServer_jul1.dbo.Catalog  
  WHERE Type IN (2,5,7,8)
    AND [Name] LIKE 'PlayersFullList'