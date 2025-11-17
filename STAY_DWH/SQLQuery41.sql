SELECT QA.*
INTO dbo.flash_aggregate_COMBINED_QA_PR
FROM DWHDB01qa.StayDWH.dbo.flash_aggregate QA

UNION ALL

SELECT PR.*
FROM StayDWH.dbo.flash_aggregate PR

