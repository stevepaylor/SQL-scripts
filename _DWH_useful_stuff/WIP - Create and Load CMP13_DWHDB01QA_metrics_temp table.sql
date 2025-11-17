SELECT 
  [Table]
, AsOfDTTM
, SortKey
, Metric
, CMKTDB13DPR
, DWHDB01QA

, 
 CASE 
	WHEN DWHDB01QA <> NULL AND DWHDB01QA <> ' ' 
	THEN ISDATE(CAST(DWHDB01QA AS datetime))
	ELSE NULL
  END

, ISDATE(GETDATE())


--, VarCount_DateDiff =
--  CASE 
--	WHEN SortKey IN(2,3) THEN 
--	CAST(
--	     DATEDIFF(
--		          MINUTE,MAX(CONVERT(datetime,CMKTDB13DPR,20)),
--				         MAX(
--						     CONVERT(datetime,DWHDB01QA,20))
--				  ) AS numeric(7,4))
--	ELSE NULL
--  END
  
--, NULL AS VarCount	
--, NULL AS VarPct

FROM SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1 metrics

WHERE SourceServer = 'CMKTDB13DPR'
  AND SortKey NOT IN(1,4,5,6,7)
  AND [Table] NOT IN ('tStorage','tAccum1DayComp')

--GROUP BY
--  [Table]
--, AsOfDTTM
--, SortKey
--, Metric ;

------------------------------------------------------------------------------------------------------

--INSERT INTO SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics 
--SELECT *

--FROM SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_temp

--ORDER BY
--  [Table]
--, AsOfDTTM
--, SortKey
--, Metric ;
GO