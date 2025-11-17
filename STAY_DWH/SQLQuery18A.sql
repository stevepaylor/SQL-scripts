USE StayDWH
GO

SELECT pr.*
INTO dbo.flash_aggregate_ADD_to_QA_from_PROD
FROM DWHDB01PR.StayDWH.dbo.flash_aggregate pr
LEFT JOIN StayDWH.dbo.flash_aggregate qa
ON  pr.tenant_id = qa.tenant_id
AND pr.property_id = qa.property_id
AND pr.building_name = qa.building_name
AND pr.room_type_code = qa.room_type_code
AND pr.rate_code = qa.rate_code
AND pr.market_segment_code = qa.market_segment_code
AND pr.date = qa.date
AND pr.last_updated_at = qa.last_updated_at

WHERE qa.tenant_id is NULL
GO


INSERT INTO StayDWH.dbo.flash_aggregate
SELECT *
FROM dbo.flash_aggregate_ADD_to_QA_from_PROD
GO
