USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_profile_attributes_Snapshot
AS 

TRUNCATE TABLE dbo.profile_attributes ;

INSERT INTO dbo.profile_attributes
SELECT DISTINCT
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(name as varchar(200)) as name --text
, CAST(code as varchar(200)) as code --text
, CAST(interface_id as varchar(200)) as interface_id --text
, CAST(active as int) as active --boolean
, booking_limit --integer
, CAST(default_source_of_business_id as varchar(200)) as default_source_of_business_id --text
, CAST(default_market_segment_id as varchar(200)) as default_market_segment_id --text
, CAST(default_guest_type_id as varchar(200)) as default_guest_type_id --text
, CAST(third_party_payment as int) as third_party_payment --boolean
, CAST(suppress_rate_info as int) as suppress_rate_info --boolean
, CAST(require_successful_deposit as int) as require_successful_deposit --boolean
, CAST(booking_source_id as varchar(200)) as booking_source_id --text
, CAST(array_to_string(rate_plan_ids, '' , ''''*'') as varchar(200)) as rate_plan_ids  --text[]
, CAST(auto_send_confirmation_email as int) as auto_send_confirmation_email --boolean

FROM public.profile_attributes
'
)

ORDER BY
  [tenant_id]
, [property_id]
, [id] ;

GO