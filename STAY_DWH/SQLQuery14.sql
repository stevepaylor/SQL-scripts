------------------------------------------------------------------
-- vip_statuses
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[vip_statuses]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(active as int) as active --boolean
, CAST(code as varchar(200)) as code --text
, CAST(description as varchar(200)) as description --text
, CAST(name as varchar(200)) as name --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text

FROM public.vip_statuses
'
)

------------------------------------------------------------------
-- market_segments
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[market_segments]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(id as varchar(200)) as id --text
, CAST(name as varchar(200)) as name --text
, CAST(code as varchar(200)) as code --text
, CAST(gl_code as varchar(200)) as gl_code --text
, CAST(active as int) as active --boolean

FROM public.market_segments
'
)

------------------------------------------------------------------
-- guests
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[guests]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(anonymized as int) as anonymized --boolean
, CAST(anonymized_message as varchar(200)) as anonymized_message --text
, create_time
, update_time
, CAST(archived as int) as archived --boolean
, CAST(external_profile_id as varchar(200)) as external_profile_id --text
, CAST(first_name as varchar(200)) as first_name --text
, CAST(last_name as varchar(200)) as last_name --text
, anniversary
, birth_date
, CAST(middle_initial as varchar(200)) as middle_initial --text
, CAST(suffix as varchar(200)) as suffix --text
, CAST(title as varchar(200)) as title --text
, CAST(company_title as varchar(200)) as company_title --text
, CAST(pronunciation as varchar(200)) as pronunciation --text
, CAST(gender as varchar(200)) as gender --text
, CAST(language as varchar(200)) as language --text
, CAST(alias as varchar(200)) as alias --text
, CAST(company_name as varchar(200)) as company_name --text
, CAST(type as varchar(200)) as type --text
, CAST(player_id as varchar(200)) as player_id --text
, CAST(code as varchar(200)) as code --text
, CAST(cms_type as varchar(200)) as cms_type --text
, CAST(card_id_available as int) as card_id_available --boolean
, CAST(gps_id as varchar(200)) as gps_id --text
, CAST(opt_in_for_marketing as int) as opt_in_for_marketing --boolean
, CAST(merge_remnant as int) as merge_remnant --boolean

FROM public.guests
'
)

------------------------------------------------------------------
-- guest_types
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[guest_types]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(id as varchar(200)) as id --text
, CAST(name as varchar(200)) as name --text
, CAST(code as varchar(200)) as code --text
, CAST(gl_code as varchar(200)) as gl_code --text
, CAST(active as int) as active --boolean

FROM public.guest_types
'
)

------------------------------------------------------------------
-- groups
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[groups]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(account_id as varchar(200)) as account_id --text
, adults_included
, CAST(allocation_id as varchar(200)) as allocation_id --text
, CAST(booking_status as varchar(200)) as booking_status --text
, CAST(cancellation_policy_id as varchar(200)) as cancellation_policy_id --text
, children_included
, create_time
, CAST(deposit_policy_id as varchar(200)) as deposit_policy_id --text
, end_date
, extra_adult_charge
, extra_children_charge
, CAST(group_code as varchar(200)) as group_code --text
, CAST(group_name as varchar(200)) as group_name --text
, CAST(rate_plan_id as varchar(200)) as rate_plan_id --text
, CAST(guest_type_id as varchar(200)) as guest_type_id --text
, CAST(market_segment_id as varchar(200)) as market_segment_id --text
, CAST(profile_id as varchar(200)) as profile_id --text
, CAST(property_id as varchar(200)) as property_id --text
, shoulder_end_date
, shoulder_start_date
, CAST(source_of_business_id as varchar(200)) as source_of_business_id --text
, start_date
, CAST(tax_exempt as int) as tax_exempt --boolean
, CAST(tenant_id as varchar(200)) as tenant_id --text
, update_time
, CAST(confirmation_code as varchar(200)) as confirmation_code --text
, CAST(released as int) as released --boolean
, CAST(profile_type as varchar(200)) as profile_type --text
, CAST(description as varchar(200)) as description --text
, CAST(rolling_release_enabled as int) as rolling_release_enabled --boolean
, CAST(auto_release_enabled as int) as auto_release_enabled --boolean
, cut_off_date
, departure_date
, CAST(wholesaler as int) as wholesaler --boolean
, CAST(overridden_arc_rule_id as varchar(200)) as overridden_arc_rule_id --text
, CAST(room_blocks_for_shoulder_dates as int) as room_blocks_for_shoulder_dates --boolean
, CAST(allocate_blocks_for_shoulder_dates as int) as allocate_blocks_for_shoulder_dates --boolean

FROM public.groups
'
)

------------------------------------------------------------------
-- companies
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[companies]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, create_time
, update_time
, CAST(archived as int) as archived --boolean
, CAST(external_profile_id as varchar(200)) as external_profile_id --text
, CAST(website as varchar(200)) as website --text
, CAST(code as varchar(200)) as code --text
, CAST(name as varchar(200)) as name --text
, CAST(pronounced as varchar(200)) as pronounced --text
, CAST(merge_remnant as int) as merge_remnant --boolean

FROM public.companies
'
)

------------------------------------------------------------------
-- allocations
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[allocations]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(allocation_type as varchar(200)) as allocation_type --text
, create_time
, end_time
, CAST(reference_id as varchar(200)) as reference_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, update_time
, CAST(blocked_by as varchar(200)) as blocked_by --text
, blocked_on
, CAST(cleared_by as varchar(200)) as cleared_by --text
, cleared_on
, start_date
, end_date
, CAST(reason as varchar(200)) as reason --text
, CAST(room_id as varchar(200)) as room_id --text
, CAST(inventory_block_type as varchar(200)) as inventory_block_type --text
, inventory_expiry_time
, CAST(inventory_block_reason as varchar(200)) as inventory_block_reason --text
, CAST(array_to_string(maintenance_services, '' , ''''*'') as varchar(100)) as maintenance_services

FROM public.allocations
'
)

------------------------------------------------------------------
-- additional_guests
------------------------------------------------------------------
SELECT *
INTO [StayDWH].[dbo].[additional_guests]
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(age_category_id as varchar(200)) as age_category_id --text
, CAST(non_registered as int) as non_registered --boolean
, CAST(name as varchar(200)) as name --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(reservation_id as varchar(200)) as reservation_id --text
-- , first_name, last_name, collated_name, middle_initial, suffix, title, primary_address_id, primary_email_id, primary_phone_id, vip_status 

FROM public.additional_guests
'
)


