USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_groups_Snapshot
AS 

TRUNCATE TABLE dbo.groups ;

INSERT INTO dbo.groups
SELECT 
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(account_id as varchar(200)) as account_id --text
, adults_included --integer
, CAST(allocation_id as varchar(200)) as allocation_id --text
, CAST(booking_status as varchar(200)) as booking_status --text
, CAST(cancellation_policy_id as varchar(200)) as cancellation_policy_id --text
, children_included  --integer
, create_time  --timestamp without time zone
, CAST(deposit_policy_id as varchar(200)) as deposit_policy_id --text
, end_date --date
, extra_adult_charge --numeric(19,2)
, extra_children_charge --numeric(19,2)
, CAST(group_code as varchar(200)) as group_code --text
, CAST(group_name as varchar(200)) as group_name --text
, CAST(rate_plan_id as varchar(200)) as rate_plan_id --text
, CAST(guest_type_id as varchar(200)) as guest_type_id --text
, CAST(market_segment_id as varchar(200)) as market_segment_id --text
, CAST(profile_id as varchar(200)) as profile_id --text
, CAST(property_id as varchar(200)) as property_id --text
, shoulder_end_date --date
, shoulder_start_date --date
, CAST(source_of_business_id as varchar(200)) as source_of_business_id --text
, start_date --date
, CAST(tax_exempt as int) as tax_exempt --boolean
, CAST(tenant_id as varchar(200)) as tenant_id --text
, update_time --timestamp without time zone
, CAST(confirmation_code as varchar(200)) as confirmation_code --text
, CAST(released as int) as released --boolean
, CAST(profile_type as varchar(200)) as profile_type --text
, CAST(description as varchar(200)) as description --text
, CAST(rolling_release_enabled as int) as rolling_release_enabled --boolean
, CAST(auto_release_enabled as int) as auto_release_enabled --boolean
, cut_off_date --date
, departure_date --date
, CAST(wholesaler as int) as wholesaler --boolean
, CAST(overridden_arc_rule_id as varchar(200)) as overridden_arc_rule_id --text
, CAST(room_blocks_for_shoulder_dates as int) as room_blocks_for_shoulder_dates --boolean
, CAST(allocate_blocks_for_shoulder_dates as int) as allocate_blocks_for_shoulder_dates --boolean
, CAST(housing_restricted as int) as housing_restricted --boolean
, CAST(transaction_item_id as varchar(200)) as transaction_item_id --text

FROM public.groups
'
)

ORDER BY
  [id]
, [tenant_id]
, [account_id]
, [profile_id]
, [start_date]
, [end_date] ;

GO