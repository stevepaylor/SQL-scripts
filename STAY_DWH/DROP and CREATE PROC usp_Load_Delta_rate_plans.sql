USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS dbo.usp_Load_Delta_rate_plans ;
GO

CREATE PROCEDURE dbo.usp_Load_Delta_rate_plans
AS

DROP TABLE IF EXISTS dbo.rate_plans_Delta ;

SELECT
  id
, [owner]
, deleted
, CAST(update_time as datetime) as update_time
, CAST(create_time as datetime) as create_time
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

INTO dbo.rate_plans_Delta

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

WHERE create_time >= current_timestamp - interval ''2 hours''
   OR update_time >= current_timestamp - interval ''2 hours'''
) ;

----------------------------------------------------------------------------------------
-- Merge delta data into perm table
----------------------------------------------------------------------------------------

MERGE dbo.rate_plans AS [target]
USING dbo.rate_plans_Delta AS delta
ON [target].[id] = delta.[id]
WHEN MATCHED 
AND (   [target].[owner] <> delta.[owner]
     OR [target].[deleted ] <> delta.[deleted ]
     OR [target].update_time <> delta.[update_time]
     OR [target].create_time <> delta.[create_time]
     OR [target].property_id <> delta.[property_id]
     OR [target].tenant_id <> delta.[tenant_id]
     OR [target].owner_reference_id <> delta.[owner_reference_id]
     OR [target].code <> delta.[code]
     OR [target].[name] <> delta.[name]
     OR [target].[description] <> delta.[description]
     OR [target].marketing_description <> delta.[marketing_description]
     OR [target].rate_category_id <> delta.[rate_category_id]
     OR [target].qualified <> delta.[qualified]
     OR [target].[start_date] <> delta.[start_date]
     OR [target].end_date <> delta.[end_date]
     OR [target].housekeeping_pattern_id <> delta.[housekeeping_pattern_id]
     OR [target].booking_start_date <> delta.[booking_start_date]
     OR [target].booking_end_date <> delta.[booking_end_date]
     OR [target].adults_included <> delta.[adults_included]
     OR [target].children_included <> delta.[children_included]
     OR [target].master_rate_plan_id <> delta.[master_rate_plan_id]
     OR [target].rate_calendar_id <> delta.[rate_calendar_id]
     OR [target].transaction_item_id <> delta.[transaction_item_id]
     OR [target].deposit_policy_id <> delta.[deposit_policy_id]
     OR [target].cancellation_policy_id <> delta.[cancellation_policy_id]
     OR [target].shoulder_start_date <> delta.[shoulder_start_date]
     OR [target].shoulder_end_date <> delta.[shoulder_end_date]
     OR [target].credit_card_auth_rule_settings_id <> delta.[credit_card_auth_rule_settings_id]
     OR [target].comp_category_id <> delta.[comp_category_id]
     OR [target].comp_certificate_number <> delta.[comp_certificate_number]
     OR [target].comp_reason_comment <> delta.[comp_reason_comment]
     OR [target].min_length_of_stay <> delta.[min_length_of_stay]
     OR [target].max_length_of_stay <> delta.[max_length_of_stay]
     OR [target].suppress_rate <> delta.[suppress_rate]
     OR [target].commissionable <> delta.[commissionable]
     OR [target].guest_type_id <> delta.[guest_type_id]
     OR [target].market_segment_id <> delta.[market_segment_id]
     OR [target].source_of_business_id <> delta.[source_of_business_id]
     OR [target].rate_selector_type <> delta.[rate_selector_type]
     OR [target].component_bundle_ids <> delta.[component_bundle_ids]
     OR [target].promo_offer_id <> delta.[promo_offer_id]
	)
THEN UPDATE SET
  [target].[id] = delta.[id]
, [target].[owner] = delta.[owner]
, [target].deleted = delta.[deleted]
, [target].update_time = delta.[update_time]
, [target].create_time = delta.[create_time]
, [target].property_id = delta.[property_id]
, [target].tenant_id = delta.[tenant_id]
, [target].owner_reference_id = delta.[owner_reference_id]
, [target].code = delta.[code]
, [target].[name] = delta.[name]
, [target].[description] = delta.[description]
, [target].marketing_description = delta.[marketing_description]
, [target].rate_category_id = delta.[rate_category_id]
, [target].qualified = delta.[qualified]
, [target].[start_date] = delta.[start_date]
, [target].end_date = delta.[end_date]
, [target].housekeeping_pattern_id = delta.[housekeeping_pattern_id]
, [target].booking_start_date = delta.[booking_start_date]
, [target].booking_end_date = delta.[booking_end_date]
, [target].adults_included = delta.[adults_included]
, [target].children_included = delta.[children_included]
, [target].master_rate_plan_id = delta.[master_rate_plan_id]
, [target].rate_calendar_id = delta.[rate_calendar_id]
, [target].transaction_item_id = delta.[transaction_item_id]
, [target].deposit_policy_id = delta.[deposit_policy_id]
, [target].cancellation_policy_id = delta.[cancellation_policy_id]
, [target].shoulder_start_date = delta.[shoulder_start_date]
, [target].shoulder_end_date = delta.[shoulder_end_date]
, [target].credit_card_auth_rule_settings_id = delta.[credit_card_auth_rule_settings_id]
, [target].comp_category_id = delta.[comp_category_id]
, [target].comp_certificate_number = delta.[comp_certificate_number]
, [target].comp_reason_comment = delta.[comp_reason_comment]
, [target].min_length_of_stay = delta.[min_length_of_stay]
, [target].max_length_of_stay = delta.[max_length_of_stay]
, [target].suppress_rate = delta.[suppress_rate]
, [target].commissionable = delta.[commissionable]
, [target].guest_type_id = delta.[guest_type_id]
, [target].market_segment_id = delta.[market_segment_id]
, [target].source_of_business_id = delta.[source_of_business_id]
, [target].rate_selector_type = delta.[rate_selector_type]
, [target].component_bundle_ids = delta.[component_bundle_ids]
, [target].promo_offer_id = delta.[promo_offer_id]
, [target].Local_ETL_Updated_TS = CURRENT_TIMESTAMP

WHEN NOT MATCHED THEN INSERT 
( 
  [id]
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
, Local_ETL_Inserted_TS
) 
VALUES 
( 
  delta.[id]
, delta.[owner]
, delta.[deleted]
, delta.[update_time]
, delta.[create_time]
, delta.[property_id]
, delta.[tenant_id]
, delta.[owner_reference_id]
, delta.[code]
, delta.[name]
, delta.[description]
, delta.[marketing_description]
, delta.[rate_category_id]
, delta.[qualified]
, delta.[start_date]
, delta.[end_date]
, delta.[housekeeping_pattern_id]
, delta.[booking_start_date]
, delta.[booking_end_date]
, delta.[adults_included]
, delta.[children_included]
, delta.[master_rate_plan_id]
, delta.[rate_calendar_id]
, delta.[transaction_item_id]
, delta.[deposit_policy_id]
, delta.[cancellation_policy_id]
, delta.[shoulder_start_date]
, delta.[shoulder_end_date]
, delta.[credit_card_auth_rule_settings_id]
, delta.[comp_category_id]
, delta.[comp_certificate_number]
, delta.[comp_reason_comment]
, delta.[min_length_of_stay]
, delta.[max_length_of_stay]
, delta.[suppress_rate]
, delta.[commissionable]
, delta.[guest_type_id]
, delta.[market_segment_id]
, delta.[source_of_business_id]
, delta.[rate_selector_type]
, delta.[component_bundle_ids]
, delta.[promo_offer_id]
, CURRENT_TIMESTAMP
);


