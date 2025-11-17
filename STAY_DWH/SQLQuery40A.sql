USE StayDWH
GO

SELECT qa.*
--INTO dbo.flash_aggregate_ADD_to_QA_from_PROD
FROM DWHDB01qa.StayDWH.dbo.flash_aggregate qa
LEFT JOIN StayDWH.dbo.flash_aggregate pr
ON  pr.tenant_id = qa.tenant_id
AND pr.property_id = qa.property_id
AND pr.building_name = qa.building_name
AND pr.room_type_code = qa.room_type_code
AND pr.rate_code = qa.rate_code
AND pr.market_segment_code = qa.market_segment_code
AND pr.date = qa.date
AND pr.last_updated_at = qa.last_updated_at

WHERE pr.last_updated_at is NULL
GO
