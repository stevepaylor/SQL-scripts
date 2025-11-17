USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE dbo.usp_Load_rate_plans_Snapshot
AS

TRUNCATE TABLE dbo.rate_plans ;

INSERT INTO dbo.rate_plans
SELECT
  id -- PK

, [owner]
, deleted
, update_time
, create_time
, property_id
, tenant_id
, owner_reference_id
, code
, [name]
, [description]
, marketing_description
, rate_category_id
, qualified
, [start_date]
, end_date
, housekeeping_pattern_id
, booking_start_date
, booking_end_date
, adults_included
, children_included
, master_rate_plan_id
, rate_calendar_id
, transaction_item_id
, deposit_policy_id
, cancellation_policy_id
, shoulder_start_date
, shoulder_end_date
, credit_card_auth_rule_settings_id
, comp_category_id
, comp_certificate_number
, comp_reason_comment
, min_length_of_stay
, max_length_of_stay
, suppress_rate
, commissionable
, guest_type_id
, market_segment_id
, source_of_business_id
, rate_selector_type
, component_bundle_ids
, promo_offer_id
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(owner as varchar(200)) as owner --text
, CAST(deleted as int) as deleted --boolean
, update_time --time without time zone
, create_time --time without time zone
, CAST(property_id as varchar(200)) as property_id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(owner_reference_id as varchar(200)) as owner_reference_id --text
, CAST(code as varchar(200)) as code --text
, CAST(name as varchar(200)) as name --text
, CAST(description as varchar(200)) as description --text
, CAST(marketing_description as varchar(200)) as marketing_description --text
, CAST(rate_category_id as varchar(200)) as rate_category_id --text
, CAST(qualified as int) as qualified --boolean
, CAST(start_date as date) as start_date --date
, CAST(end_date as date) as end_date --date
, CAST(housekeeping_pattern_id as varchar(200)) as housekeeping_pattern_id --text
, CAST(booking_start_date as date) as booking_start_date --date
, CAST(booking_end_date as date) as booking_end_date --date
, adults_included --integer
, children_included --integer
, CAST(master_rate_plan_id as varchar(200)) as master_rate_plan_id --text
, CAST(rate_calendar_id as varchar(200)) as rate_calendar_id --text
, CAST(transaction_item_id as varchar(200)) as transaction_item_id --text
, CAST(deposit_policy_id as varchar(200)) as deposit_policy_id --text
, CAST(cancellation_policy_id as varchar(200)) as cancellation_policy_id --text
, CAST(shoulder_start_date as date) as shoulder_start_date --date
, CAST(shoulder_end_date as date) as shoulder_end_date --date
, CAST(credit_card_auth_rule_settings_id as varchar(200)) as credit_card_auth_rule_settings_id --text
, CAST(comp_category_id as varchar(200)) as comp_category_id --text
, CAST(comp_certificate_number as varchar(200)) as comp_certificate_number --text
, CAST(comp_reason_comment as varchar(2000)) as comp_reason_comment --text
, min_length_of_stay --integer
, max_length_of_stay --integer
, CAST(suppress_rate as int) as suppress_rate --boolean
, CAST(commissionable as int) as commissionable --boolean
, CAST(guest_type_id as varchar(200)) as guest_type_id --text
, CAST(market_segment_id as varchar(200)) as market_segment_id --text
, CAST(source_of_business_id as varchar(200)) as source_of_business_id --text
, CAST(rate_selector_type as varchar(200)) as rate_selector_type --text
, CAST(component_bundle_ids as varchar(200)) as component_bundle_ids --text
, CAST( promo_offer_id as varchar(200)) as  promo_offer_id --text

FROM public.rate_plans
'
) ;
