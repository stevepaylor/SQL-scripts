TRUNCATE TABLE SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics ;
GO

DROP TABLE IF EXISTS SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_temp ;
GO

SELECT 
  [Table]
--, [Schema]
--, [Database]
--, SourceServer
--, QueryGroup
, AsOfDTTM
, SortKey
, Metric
, MAX(CMKTDB13DPR) CMKTDB13DPR
--, MAX(DWHDB01PR) DWHDB01PR
, MAX(DWHDB01QA) DWHDB01QA
--, MAX(DWHDB02PR) DWHDB02PR
--, MAX(MSBIDB02DV) MSBIDB02DV
--, MAX(PLAYERPORTALRDS) PLAYERPORTALRDS
--, MAX(PLAYERPORTALRDS_QA) PLAYERPORTALRDS_QA

, VarCount_DateDiff =
  CASE 
	WHEN SortKey IN(1,6,7) THEN MAX(CAST(DWHDB01QA as int)) - MAX(CAST(CMKTDB13DPR as int))
	ELSE NULL
  END

, VarPct = 
  CASE
	WHEN SortKey NOT IN(1,6,7) THEN NULL
	WHEN MAX(CAST(CMKTDB13DPR as int)) = 0 THEN NULL
	ELSE FORMAT(MAX(CAST(DWHDB01QA as int)) * 100.0 / MAX(CAST(CMKTDB13DPR as int)) , 'N6')
  END

INTO SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_temp

FROM SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1

WHERE SourceServer = 'CMKTDB13DPR'
  AND SortKey IN(1,6,7)

GROUP BY
  [Table]
, AsOfDTTM
, SortKey
, Metric

------------------------------------------------------------------------------------------------------
UNION ALL
------------------------------------------------------------------------------------------------------

SELECT 
  [Table]
, AsOfDTTM
, SortKey
, Metric
, MAX(CMKTDB13DPR) CMKTDB13DPR
--, MAX(DWHDB01QA) DWHDB01QA

, VarCount_DateDiff = 
  CASE 
	WHEN SortKey IN(2,3) 
	THEN CASE 
	       WHEN MAX(CMKTDB13DPR) NOT IN (NULL,' ')
		   THEN CAST(DATEDIFF(MINUTE,MAX(CONVERT(datetime,CMKTDB13DPR,20)),MAX(CONVERT(datetime,DWHDB01QA,20))) AS numeric(7,4))
		   ELSE NULL
		 END 
	ELSE NULL
  END
  
--, NULL AS VarCount	
--, NULL AS VarPct

FROM SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1 metrics

WHERE SourceServer = 'CMKTDB13DPR'
  AND SortKey NOT IN(1,4,5,6,7)

GROUP BY
  [Table]
, AsOfDTTM
, SortKey
, Metric ;

------------------------------------------------------------------------------------------------------

------INSERT INTO SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics 
----SELECT *

----FROM SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_temp

----ORDER BY
----  [Table]
----, AsOfDTTM
----, SortKey
----, Metric ;
----GO

----DROP TABLE IF EXISTS SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_temp ;
----GO
