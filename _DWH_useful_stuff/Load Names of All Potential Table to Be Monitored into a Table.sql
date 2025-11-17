-- DWHDB01PR

--USE [iQ-Gaming]
--GO

--TRUNCATE TABLE [SystemMaintDB].[dbo].[All_Tables_DWHDB01PR]

--INSERT INTO [SystemMaintDB].dbo.[All_Tables_DWHDB01PR]

--SELECT
--  @@SERVERNAME AS Server_Name
--, 'iQ-Gaming' AS Database_Name
--, s.[name] AS Schema_Name
--, t.NAME AS Table_Name

--INTO [SystemMaintDB].dbo.[All_Tables_DWHDB01PR]

--FROM sys.tables t

--INNER JOIN sys.schemas s 
--ON t.schema_id = s.schema_id

--INNER JOIN sys.indexes i 
--ON t.OBJECT_ID = i.object_id

--INNER JOIN sys.partitions p 
--ON i.object_id = p.OBJECT_ID 
--AND i.index_id = p.index_id

--INNER JOIN sys.allocation_units a 
--ON p.partition_id = a.container_id

--WHERE i.OBJECT_ID > 255
--  AND s.[name] IN ('CMP_13-1','config','DBM','Opera_5_0', 'player','slot','stage','table_games','vDW2','REPL')
--  AND t.[name] NOT LIKE '%staging%'
--  AND i.index_id IN (0,1)

--GROUP BY s.[name], t.NAME

--ORDER BY 
--  Server_Name
--, Database_Name
--, s.[name]
--, t.NAME





 -- DWHDB01QA

--SELECT
--  @@SERVERNAME AS Server_Name
--, 'iQ-Gaming' AS Database_Name
--, s.[name] AS Schema_Name
--, t.NAME AS Table_Name

--INTO [SystemMaintDB].dbo.[All_Tables_DWHDB01QA]

--FROM DWHDB01QA.[iQ-Gaming].sys.tables t

--INNER JOIN DWHDB01QA.[iQ-Gaming].sys.schemas s 
--ON t.schema_id = s.schema_id

--INNER JOIN DWHDB01QA.[iQ-Gaming].sys.indexes i 
--ON t.OBJECT_ID = i.object_id

--INNER JOIN DWHDB01QA.[iQ-Gaming].sys.partitions p 
--ON i.object_id = p.OBJECT_ID 
--AND i.index_id = p.index_id

--INNER JOIN DWHDB01QA.[iQ-Gaming].sys.allocation_units a 
--ON p.partition_id = a.container_id

--WHERE i.OBJECT_ID > 255
--  AND s.[name] IN ('CMP_13-1','config','DBM','Opera_5_0', 'player','slot','stage','table_games','vDW2','REPL')
--  AND t.[name] NOT LIKE '%staging%'
--  AND i.index_id IN (0,1)

--GROUP BY s.[name], t.NAME

--ORDER BY 
--  Server_Name
--, Database_Name
--, s.[name]
--, t.NAME










 --CMKTDB13DPR

INSERT INTO [SystemMaintDB].dbo.[All_Tables_All_Servers]

SELECT
  'CMKTDB13DPR' AS Server_Name
, 'CMP13' AS Database_Name
, s.[name] AS Schema_Name
, t.NAME AS Table_Name

--INTO [SystemMaintDB].dbo.[All_Tables_All_Servers]

FROM CMKTDB13DPR.CMP13.sys.tables t

INNER JOIN CMKTDB13DPR.CMP13.sys.schemas s 
ON t.schema_id = s.schema_id

INNER JOIN CMKTDB13DPR.CMP13.sys.indexes i 
ON t.OBJECT_ID = i.object_id

INNER JOIN CMKTDB13DPR.CMP13.sys.partitions p 
ON i.object_id = p.OBJECT_ID 
AND i.index_id = p.index_id

INNER JOIN CMKTDB13DPR.CMP13.sys.allocation_units a 
ON p.partition_id = a.container_id

WHERE i.OBJECT_ID > 255
  AND t.[name] IN (SELECT Table_Name from [SystemMaintDB].[dbo].[All_Tables_DWHDB01QA])
  AND t.[name] NOT IN (SELECT Table_Name from [SystemMaintDB].[dbo].[All_Tables_DWHDB01PR])
  --AND t.[name] NOT LIKE '%staging%'
  AND i.index_id IN (0,1)

GROUP BY s.[name], t.NAME

ORDER BY 
  Server_Name
, Database_Name
, s.[name]
, t.NAME

-- MSBIDB01DV

--SELECT
--  'MSBIDB01DV' AS Server_Name
--, 'vDW' AS Database_Name
--, s.[name] AS Schema_Name
--, t.NAME AS Table_Name

--INTO [SystemMaintDB].dbo.[All_Tables_MSBIDB01DV]

--FROM MSBIDB02DV.vDW.sys.tables t

--INNER JOIN MSBIDB02DV.vDW.sys.schemas s 
--ON t.schema_id = s.schema_id

--INNER JOIN MSBIDB02DV.vDW.sys.indexes i 
--ON t.OBJECT_ID = i.object_id

----INNER JOIN MSBIDB02DV.vDW.partitions p 
----ON i.object_id = p.OBJECT_ID 
----AND i.index_id = p.index_id

----INNER JOIN MSBIDB02DV.vDW.allocation_units a 
----ON p.partition_id = a.container_id

--WHERE i.OBJECT_ID > 255
--  AND t.[name] IN (SELECT Table_Name from [SystemMaintDB].[dbo].[All_Tables_DWHDB01QA])
--  --AND t.[name] NOT LIKE '%staging%'
--  AND i.index_id IN (0,1)

--GROUP BY s.[name], t.NAME

--ORDER BY 
--  Server_Name
--, Database_Name
--, s.[name]
--, t.NAME





-- PLAYERPORTALRDS

--SELECT
--  'PLAYERPORTALRDS' AS Server_Name
--, 'app' AS Database_Name
--, s.[name] AS Schema_Name
--, t.NAME AS Table_Name

--INTO [SystemMaintDB].dbo.[All_Tables_PLAYERPORTALRDS]

--FROM PLAYERPORTALRDS_QA.app.sys.tables t

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.schemas s 
--ON t.schema_id = s.schema_id

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.indexes i 
--ON t.OBJECT_ID = i.object_id

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.partitions p 
--ON i.object_id = p.OBJECT_ID 
--AND i.index_id = p.index_id

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.allocation_units a 
--ON p.partition_id = a.container_id

--WHERE i.OBJECT_ID > 255
--  AND t.[name] IN (SELECT Table_Name from [SystemMaintDB].[dbo].[All_Tables_DWHDB01PR])
--  AND i.index_id IN (0,1)

--GROUP BY s.[name], t.NAME

--ORDER BY 
--  Server_Name
--, Database_Name
--, s.[name]
--, t.NAME






-- PLAYERPORTALRDS_QA

--INSERT INTO [SystemMaintDB].dbo.[All_Tables_PLAYERPORTALRDS_QA]

--SELECT
--  'PLAYERPORTALRDS_QA' AS Server_Name
--, 'app' AS Database_Name
--, s.[name] AS Schema_Name
--, t.NAME AS Table_Name

--INTO [SystemMaintDB].dbo.[All_Tables_PLAYERPORTALRDS_QA]

--FROM PLAYERPORTALRDS_QA.app.sys.tables t

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.schemas s 
--ON t.schema_id = s.schema_id

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.indexes i 
--ON t.OBJECT_ID = i.object_id

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.partitions p 
--ON i.object_id = p.OBJECT_ID 
--AND i.index_id = p.index_id

--INNER JOIN PLAYERPORTALRDS_QA.app.sys.allocation_units a 
--ON p.partition_id = a.container_id

--WHERE i.OBJECT_ID > 255
--  AND t.[name] IN (SELECT Table_Name from [SystemMaintDB].[dbo].[All_Tables_DWHDB01PR])
--  AND i.index_id IN (0,1)

--GROUP BY s.[name], t.NAME

--ORDER BY 
--  Server_Name
--, Database_Name
--, s.[name]
--, t.NAME