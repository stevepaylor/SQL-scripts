SELECT DISTINCT
  across_metrics.[Table]
, across_metrics.[Schema]
, across_metrics.[Database]
, across_metrics.[AsOfDTTM]
, across_metrics.[SortKey]
, across_metrics.[Metric]
, 'CMKTDB13DPR' = CMKTDB13DPR_fact.Metric_value 
, 'DWHDB01PR' = DWHDB01PR_fact.Metric_value 
, 'DWHDB01QA' = DWHDB01QA_fact.Metric_value 
, 'DWHDB02PR' = DWHDB02PR_fact.Metric_value 
, 'MSBIDB02DV' = MSBIDB02DV_fact.Metric_value 
, 'PLAYERPORTALRDS' = PLAYERPORTALRDS_fact.Metric_value 
, 'PLAYERPORTALRDS_QA' = PLAYERPORTALRDS_QA_fact.Metric_value 

FROM [SystemMaintDB].[dbo].[Repl_ETL_RowCounts_Validation_Metrics] across_metrics (nolock)

LEFT OUTER JOIN [dbo].[Repl_ETL_RowCounts_Validation_Metrics] CMKTDB13DPR_fact (nolock)
ON CMKTDB13DPR_fact.[Server] = 'CMKTDB13DPR'
AND across_metrics.[Table] = CMKTDB13DPR_fact.[Table]
AND across_metrics.[Schema] = CMKTDB13DPR_fact.[Schema]
AND across_metrics.[Database] = CMKTDB13DPR_fact.[Database]
AND across_metrics.[AsOfDTTM] = CMKTDB13DPR_fact.[AsOfDTTM]
AND across_metrics.[Metric] = CMKTDB13DPR_fact.[Metric]

LEFT OUTER JOIN [dbo].[Repl_ETL_RowCounts_Validation_Metrics] DWHDB01PR_fact (nolock)
ON DWHDB01PR_fact.[Server] = 'DWHDB01PR'
AND across_metrics.[Table] = DWHDB01PR_fact.[Table]
AND across_metrics.[Schema] = DWHDB01PR_fact.[Schema]
AND across_metrics.[Database] = CMKTDB13DPR_fact.[Database]
AND across_metrics.[AsOfDTTM] = DWHDB01PR_fact.[AsOfDTTM]
AND across_metrics.[Metric] = DWHDB01PR_fact.[Metric]

LEFT OUTER JOIN [dbo].[Repl_ETL_RowCounts_Validation_Metrics] DWHDB01QA_fact (nolock)
ON DWHDB01QA_fact.[Server] = 'DWHDB01QA'
AND across_metrics.[Table] = DWHDB01QA_fact.[Table]
AND across_metrics.[Schema] = DWHDB01QA_fact.[Schema]
AND across_metrics.[Database] = DWHDB01QA_fact.[Database]
AND across_metrics.[AsOfDTTM] = DWHDB01QA_fact.[AsOfDTTM]
AND across_metrics.[Metric] = DWHDB01QA_fact.[Metric]

LEFT OUTER JOIN [dbo].[Repl_ETL_RowCounts_Validation_Metrics] DWHDB02PR_fact (nolock)
ON DWHDB02PR_fact.[Server] = 'DWHDB02PR'
AND across_metrics.[Table] = DWHDB02PR_fact.[Table]
AND across_metrics.[Schema] = DWHDB02PR_fact.[Schema]
AND across_metrics.[Database] = DWHDB02PR_fact.[Database]
AND across_metrics.[AsOfDTTM] = DWHDB02PR_fact.[AsOfDTTM]
AND across_metrics.[Metric] = DWHDB02PR_fact.[Metric]

LEFT OUTER JOIN [dbo].[Repl_ETL_RowCounts_Validation_Metrics] MSBIDB02DV_fact (nolock)
ON MSBIDB02DV_fact.[Server] = 'MSBIDB02DV'
AND across_metrics.[Table] = MSBIDB02DV_fact.[Table]
AND across_metrics.[Schema] = MSBIDB02DV_fact.[Schema]
AND across_metrics.[Database] = MSBIDB02DV_fact.[Database]
AND across_metrics.[AsOfDTTM] = MSBIDB02DV_fact.[AsOfDTTM]
AND across_metrics.[Metric] = MSBIDB02DV_fact.[Metric]

LEFT OUTER JOIN [dbo].[Repl_ETL_RowCounts_Validation_Metrics] PLAYERPORTALRDS_fact (nolock)
ON PLAYERPORTALRDS_fact.[Server] = 'PLAYERPORTALRDS'
AND across_metrics.[Table] = PLAYERPORTALRDS_fact.[Table]
AND across_metrics.[Schema] = PLAYERPORTALRDS_fact.[Schema]
AND across_metrics.[Database] = PLAYERPORTALRDS_fact.[Database]
AND across_metrics.[AsOfDTTM] = PLAYERPORTALRDS_fact.[AsOfDTTM]
AND across_metrics.[Metric] = PLAYERPORTALRDS_fact.[Metric]

LEFT OUTER JOIN [dbo].[Repl_ETL_RowCounts_Validation_Metrics] PLAYERPORTALRDS_QA_fact (nolock)
ON PLAYERPORTALRDS_QA_fact.[Server] = 'PLAYERPORTALRDS_QA'
AND across_metrics.[Table] = PLAYERPORTALRDS_QA_fact.[Table]
AND across_metrics.[Schema] = PLAYERPORTALRDS_QA_fact.[Schema]
AND across_metrics.[Database] = PLAYERPORTALRDS_QA_fact.[Database]
AND across_metrics.[AsOfDTTM] = PLAYERPORTALRDS_QA_fact.[AsOfDTTM]
AND across_metrics.[Metric] = PLAYERPORTALRDS_QA_fact.[Metric]

ORDER BY
  across_metrics.[Table]
, across_metrics.[Schema]
, across_metrics.[Database]
, across_metrics.[AsOfDTTM]
, across_metrics.[SortKey]
, across_metrics.[Metric]
--, across_metrics.[Server]

GO