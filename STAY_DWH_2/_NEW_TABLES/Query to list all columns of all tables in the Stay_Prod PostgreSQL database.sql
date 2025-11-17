---------------------------------------------------------------------------------------------------------------------------
-- 3/21/24 - spaylor
--
-- Queries to view every table available in the Stay_Prod database in the Cloud (Azure) which is a PostgreSQL database.
-- 
-- To see more than 5 rows, change the number of the LIMIT keyword on each query to the number of rows you would like to see.
-- or remove the keyword and value completely to return all rows.
--
-- Some tables have columns of an array datatype which SQL Server cannot handle.  Queries with the columns listed and using a 
-- CAST function to convert the data to something SQL Server can handle have been created for those tables.
--
-- 8 of the tables are already being imported into the local StayDWH database.  Query those tables there to see the database with a standary SQL Server query.
--
-- The tables are listed in alphabetical order
--
------------------------------------------------------------------------------------------------------------------------------

select 'account_balance_aggregate' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.account_balance_aggregate LIMIT 5');

select 'account_balance_aggregate_staletracking' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.account_balance_aggregate_staletracking LIMIT 5');

--'accounting_dates' all ready imported to StayDWH database

select 'accounting_item_folio_posting_codes' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounting_item_folio_posting_codes LIMIT 5');

select 'accounting_item_restricted_room_types' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounting_item_restricted_room_types LIMIT 5');

select 'accounting_item_source_meal_periods' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounting_item_source_meal_periods LIMIT 5');

select 'accounting_item_tax_classes' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounting_item_tax_classes LIMIT 5');

select 'accounting_items' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounting_items LIMIT 5');

select 'accounts' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounts LIMIT 5');

select 'additional_guests' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.additional_guests LIMIT 5');

select 'addresses' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.addresses LIMIT 5');

select 'age_categories' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.age_categories LIMIT 5');

select 'agent_commissions' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.agent_commissions LIMIT 5');

select 'agents' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.agents LIMIT 5');

select 'aggregate_stale_run_status' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.aggregate_stale_run_status LIMIT 5');

select 'allocations' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.allocations LIMIT 5');

select 'allowance_combinations' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.allowance_combinations LIMIT 5');

select 'amount_by_date_ranges' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.amount_by_date_ranges LIMIT 5');

select 'ar_deposits' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ar_deposits LIMIT 5');

select 'ar_settings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ar_settings LIMIT 5');

select 'associated_rooms' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.associated_rooms LIMIT 5');

--'availability'  all ready imported to StayDWH database

select 'beds' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.beds LIMIT 5');

select 'booked_reservation_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.booked_reservation_details LIMIT 5');

--select 'booking_channels' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.booking_channels LIMIT 5');
select 
'booking_channels' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, tenant_id --text
, property_id --text
, name --text
, code --text
, interface_id --text
, active --boolean
, booking_limit --integer
, default_source_of_business_id --text
, default_market_segment_id --text
, default_guest_type_id --text
, third_party_payment --boolean
, suppress_rate_info --boolean
, require_successful_deposit --boolean
, booking_source_id --text
--, rate_plan_ids --text[]
, CAST(array_to_string(rate_plan_ids, '' , ''''*'') as varchar(200)) as rate_plan_ids
, auto_send_confirmation_email --boolean
from stay_prod.public.booking_channels 
LIMIT 5
');

select 'buildings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.buildings LIMIT 5');

select 'cancellation_policies' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.cancellation_policies LIMIT 5');

select 'categories' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.categories LIMIT 5');

select 'comments' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comments LIMIT 5');

select 'comp_accounting_mappings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_accounting_mappings LIMIT 5');

select 'comp_authorizers' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_authorizers LIMIT 5');

select 'comp_department_item_ids' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_department_item_ids LIMIT 5');

select 'comp_departments' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_departments LIMIT 5');

select 'comp_offer_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_offer_details LIMIT 5');

select 'comp_offers' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_offers LIMIT 5');

select 'companies' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.companies LIMIT 5');

select 'component_bundles' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.component_bundles LIMIT 5');

select 'component_rate_snapshots' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.component_rate_snapshots LIMIT 5');

select 'components' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.components LIMIT 5');

select 'comps' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comps LIMIT 5');

select 'countries' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.countries LIMIT 5');

--select 'custom_field_definitions' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.custom_field_definitions LIMIT 5');
select 
'custom_field_definitions' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, tenant_id --text
, property_id --text
, code --text
, system_generated --text
, field_name --text
--,  applicable_objects --text[]
, CAST(array_to_string(applicable_objects, '' , ''''*'') as varchar(200)) as applicable_objects
, type --text
from stay_prod.public.custom_field_definitions 
 LIMIT 5
 ');

select 'databasechangelog' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.databasechangelog LIMIT 5');

select 'databasechangeloglock' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.databasechangeloglock LIMIT 5');

select 'deposit_policies' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.deposit_policies LIMIT 5');

select 'deposit_snapshots' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.deposit_snapshots LIMIT 5');

select 'dispute_ar_transactions' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.dispute_ar_transactions LIMIT 5');

--select 'do_not_room_move_reasons' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.do_not_room_move_reasons LIMIT 5');
select 
'do_not_room_move_reasons' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, tenant_id --text,
, property_id --text,
, code --text,
, reason --text,
, description --text,
, active --boolean,
, property_inactivation --boolean,
--, excluded_properties --text[],
, CAST(array_to_string(excluded_properties, '' , ''''*'') as varchar(200)) as excluded_properties
,  deleted --boolean
from stay_prod.public.do_not_room_move_reasons 
 LIMIT 5
 ');

select 'emails' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.emails LIMIT 5');

select 'feature_setting' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.feature_setting LIMIT 5');

select 'fiscal_years' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.fiscal_years LIMIT 5');

select 'flash_aggregate' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.flash_aggregate LIMIT 5');

select 'flash_aggregate_staletracking' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.flash_aggregate_staletracking LIMIT 5');

select 'folios' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.folios LIMIT 5');

select 'groups' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.groups LIMIT 5');

select 'guest_loyalties' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.guest_loyalties LIMIT 5');

select 'guest_satisfactions' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.guest_satisfactions LIMIT 5');

select 'guest_types' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.guest_types LIMIT 5');

select 'guests' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.guests LIMIT 5');

select 'hk_completion_costs' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hk_completion_costs LIMIT 5');

select 'hk_guest_service_types' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hk_guest_service_types LIMIT 5');

select 'hk_last_day_services' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hk_last_day_services LIMIT 5');

select 'hk_room_conditions' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hk_room_conditions LIMIT 5');

select 'hk_service_occurrence_days' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hk_service_occurrence_days LIMIT 5');

select 'hk_service_patterns' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hk_service_patterns LIMIT 5');

select 'hk_service_types' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hk_service_types LIMIT 5');

select 'hkg_service_requests' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.hkg_service_requests LIMIT 5');

select 'housekeeping_staff' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.housekeeping_staff LIMIT 5');

--select 'inventory_block_maintenance_req_reasons' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.inventory_block_maintenance_req_reasons');
select 
'inventory_block_maintenance_req_reasons' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, tenant_id --text,
, property_id --text,
, code --text,
, reason --text,
, description --text,
, active --boolean,
, property_inactivation --boolean,
, deleted --boolean,
--, excluded_properties --text[],
, CAST(array_to_string(excluded_properties, '' , ''''*'') as varchar(200)) as excluded_properties
--, maintenance_services -text[],
, CAST(array_to_string(maintenance_services, '' , ''''*'') as varchar(200)) as maintenance_services
, out_of_order --boolean,
, of_the_market --boolean,
, on_hold --boolean
from stay_prod.public.inventory_block_maintenance_req_reasons 
 LIMIT 5
 ');

select 'inventory_item_allocations' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.inventory_item_allocations LIMIT 5');

select 'invoice_charges' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.invoice_charges LIMIT 5');

select 'invoice_payments' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.invoice_payments LIMIT 5');

select 'invoice_refunds' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.invoice_refunds LIMIT 5');

select 'invoices' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.invoices LIMIT 5');

select 'ledger_balances' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ledger_balances LIMIT 5');

select 'ledger_settings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ledger_settings LIMIT 5');

select 'ledger_transaction_history' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ledger_transaction_history LIMIT 5');

select 'ledger_transactions' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ledger_transactions LIMIT 5');

select 'line_items' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.line_items LIMIT 5');

select 'linked_contacts' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.linked_contacts LIMIT 5');

select 'lost_business_trackings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.lost_business_trackings LIMIT 5');

select 'maintenance_services' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.maintenance_services LIMIT 5');

select 'maintenance_staff' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.maintenance_staff LIMIT 5');

select 'market_channels' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.market_channels LIMIT 5');

select 'market_segments' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.market_segments LIMIT 5');

select 'marketing_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.marketing_details LIMIT 5');

select 'marketsegment_aggregate_staletracking' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.marketsegment_aggregate_staletracking LIMIT 5');

select 'meal_periods' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.meal_periods LIMIT 5');

select 'mt_service_types' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.mt_service_types LIMIT 5');

select 'ota_metrics' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ota_metrics LIMIT 5');

select 'outlets' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.outlets LIMIT 5');

select 'owner_rates' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.owner_rates LIMIT 5');

select 'owner_rev_par' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.owner_rev_par LIMIT 5');

select 'owner_type_categorizations' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.owner_type_categorizations LIMIT 5');

select 'pace_aggregate' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.pace_aggregate LIMIT 5');

select 'pace_aggregate_staletracking' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.pace_aggregate_staletracking LIMIT 5');

select 'package_folio_allowances' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.package_folio_allowances LIMIT 5');

select 'pantry_items' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.pantry_items LIMIT 5');

select 'pantry_line_items' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.pantry_line_items LIMIT 5');

select 'partner_profiles' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.partner_profiles LIMIT 5');

select 'payment_instruments' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.payment_instruments LIMIT 5');

select 'payment_methods' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.payment_methods LIMIT 5');

select 'payment_settings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.payment_settings LIMIT 5');

select 'periods' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.periods LIMIT 5');

select 'pet_info' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.pet_info LIMIT 5');

select 'pet_rate_snapshots' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.pet_rate_snapshots LIMIT 5');

select 'pets' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.pets LIMIT 5');

select 'phones' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.phones LIMIT 5');

select 'player_retail_ratings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.player_retail_ratings LIMIT 5');

select 'policy_schedules' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.policy_schedules LIMIT 5');

select 'price_notes' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.price_notes LIMIT 5');

--select 'profile_attributes' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.profile_attributes LIMIT 5');
select 
'profile_attributes' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select
  id --text NOT NULL
, tenant_id --text,
, property_id --text,
, reference_id --text,
, vip_status_id --text,
, rate_plan_id --text,
, account_id --text,
--, room_feature_ids --text[],
, CAST(array_to_string(room_feature_ids, '' , ''''*'') as varchar(200)) as room_feature_ids
--, guest_preference_ids --text[],
, CAST(array_to_string(guest_preference_ids, '' , ''''*'') as varchar(200)) as guest_preference_ids
, linked_contact_id --text,
from stay_prod.public.profile_attributes 
 LIMIT 5
 ');


select 'profile_options' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.profile_options LIMIT 5');

--'properties'  all ready imported to StayDWH database

select 'rate_calendars' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.rate_calendars LIMIT 5');

select 'rate_categories' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.rate_categories LIMIT 5');

select 'rate_override_reasons' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.rate_override_reasons LIMIT 5');

--'rate_plans'  all ready imported to StayDWH database

--'rate_snapshots'  all ready imported to StayDWH database

select 'rate_strategies' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.rate_strategies LIMIT 5');

select 'rates' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.rates LIMIT 5');

select 'recurring_charge_component_instances' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.recurring_charge_component_instances LIMIT 5');

select 'recurring_charge_instances' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.recurring_charge_instances LIMIT 5');

--select 'recurring_charges' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.recurring_charges LIMIT 5');
select 
'recurring_charges' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, account_id --text,
, original_amount --numeric(19,2),
, auto_recurring_item_id --text,
, end_date --date,
, folio_id --text,
, invalid --boolean,
, item_id --text,
, property_id --text,
, original_quantity --integer,
, room_charge --boolean,
, source_id --text,
, start_date --date,
, tenant_id --text,
, arrival_date --date,
, departure_date --date,
, estimated_subtotal --numeric(19,2),
, estimated_tax --numeric(19,2),
, pet_reference_id --text,
, nights --integer,
, frequency_type --text,
--, occurrence_days --integer[],
, CAST(array_to_string(occurrence_days, '' , ''''*'') as varchar(200)) as occurrence_days
, auto_recurring_item_status --text,
, reference_id --text,
, charge_type --text,
, transport_charge_reference_id --text
from stay_prod.public.recurring_charges 
 LIMIT 5
 ');

select 'res_marketing_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.res_marketing_details LIMIT 5');

select 'res_rate_change_history' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.res_rate_change_history LIMIT 5');

select 'res_rate_change_history_domain' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.res_rate_change_history_domain LIMIT 5');

select 'reservation_age_categories' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.reservation_age_categories LIMIT 5');

--select 'reservation_custom_fields' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.reservation_custom_fields LIMIT 5');
select 
'reservation_custom_fields' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, tenant_id --text,
, property_id --text,
, reservation_id --text,
, code --text,
--, "values" --text[]
, CAST(array_to_string("values", '' , ''''*'') as varchar(200)) as "values"
from stay_prod.public.reservation_custom_fields 
 LIMIT 5
 ');

select 'reservation_hk_events' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.reservation_hk_events LIMIT 5');

select 'reservation_housekeeping_history' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.reservation_housekeeping_history LIMIT 5');

select 'reservation_loyalties' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.reservation_loyalties LIMIT 5');

-- 'reservations'  all ready imported to StayDWH database

select 'revenue_aggregate' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.revenue_aggregate LIMIT 5');

select 'revenue_by_market_segment_aggregate' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.revenue_by_market_segment_aggregate LIMIT 5');

select 'revoked_key_info' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.revoked_key_info LIMIT 5');

select 'room_blocks' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_blocks LIMIT 5');

select 'room_classes' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_classes LIMIT 5');

select 'room_features' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_features LIMIT 5');

--select 'room_move_reasons' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_move_reasons LIMIT 5');
select 
'room_move_reasons' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, tenant_id --text,
, property_id --text,
, code --text,
, reason --text,
, description --text,
, active --boolean,
, property_inactivation --boolean,
, deleted --boolean,
--, excluded_properties --text[],
, CAST(array_to_string(excluded_properties, '' , ''''*'') as varchar(200)) as excluded_properties
, category --text
from stay_prod.public.room_move_reasons  
 LIMIT 5
 ');

select 'room_moved_info' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_moved_info LIMIT 5');

select 'room_type_blocks' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_type_blocks LIMIT 5');

select 'room_type_blocks_adult_occupancies' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_type_blocks_adult_occupancies LIMIT 5');

select 'room_type_change_tracking_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_type_change_tracking_details LIMIT 5');

select 'room_type_modifications' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_type_modifications LIMIT 5');
-- 'room_types'  all ready imported to StayDWH database

select 'room_types_room_features' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_types_room_features LIMIT 5');

select 'room_upgrade_config' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.room_upgrade_config LIMIT 5');

--'rooms'  all ready imported to StayDWH database

select 'rooms_room_features' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.rooms_room_features LIMIT 5');

select 'scheduled_rooms' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.scheduled_rooms LIMIT 5');

select 'share_day_wise_info' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.share_day_wise_info LIMIT 5');

--select 'shared_reservations' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.shared_reservations LIMIT 5');
select 
'shared_reservations' as [TABLE], * 
from OPENQUERY(Stay_PostgreSQL,'
select 
  id --text NOT NULL
, tenant_id --text,
, property_id --text,
, room_type_id --text,
, room_id --text,
, earliest_arrival --date,
, latest_departure --date,
--, reservation_ids --text[]
, CAST(array_to_string(reservation_ids, '' , ''''*'') as varchar(200)) as reservation_ids
from stay_prod.public.shared_reservations 
 LIMIT 5
 ');

select 'sms_preferences' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.sms_preferences LIMIT 5');

select 'source_of_businesses' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.source_of_businesses LIMIT 5');

select 'states' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.states LIMIT 5');

select 'subcategories' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.subcategories LIMIT 5');

select 'third_party_confirmations' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.third_party_confirmations LIMIT 5');

select 'transaction_item_revenue_aggregate' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.transaction_item_revenue_aggregate LIMIT 5');

select 'transaction_item_revenue_aggregate_staletracking' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.transaction_item_revenue_aggregate_staletracking LIMIT 5');

select 'transport_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.transport_details LIMIT 5');

select 'transport_info' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.transport_info LIMIT 5');

select 'travel_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.travel_details LIMIT 5');

select 'travel_location' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.travel_location LIMIT 5');

select 'travel_type' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.travel_type LIMIT 5');

select 'upgrade_rates' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.upgrade_rates LIMIT 5');

select 'vehicle_details' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.vehicle_details LIMIT 5');

select 'vip_statuses' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.vip_statuses LIMIT 5');

select 'waitlist_inquiries' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.waitlist_inquiries LIMIT 5');

select 'waitlist_inquiry_age_categories' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.waitlist_inquiry_age_categories LIMIT 5');

select 'waitlist_inquiry_buildings' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.waitlist_inquiry_buildings LIMIT 5');

select 'waitlist_inquiry_rate_plans' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.waitlist_inquiry_rate_plans LIMIT 5');

select 'waitlist_inquiry_reasons' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.waitlist_inquiry_reasons LIMIT 5');

select 'waitlist_inquiry_room_types' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.waitlist_inquiry_room_types LIMIT 5');

select 'waitlist_inquiry_rooms' as [TABLE], * from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.waitlist_inquiry_rooms LIMIT 5');