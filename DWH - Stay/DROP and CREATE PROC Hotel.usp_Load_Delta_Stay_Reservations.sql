USE [iQ-Gaming] ;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


DROP PROCEDURE IF EXISTS Hotel.usp_Load_Delta_Stay_Reservations ;
GO

CREATE PROCEDURE Hotel.usp_Load_Delta_Stay_Reservations
AS

TRUNCATE TABLE Hotel.Stay_Reservations_STAGE
INSERT INTO Hotel.Stay_Reservations_STAGE
SELECT 
  id
, account_id
, allocation_id
, CAST(arrival_date as date) as arrival_date
, CAST(cancellation_date as date) as cancellation_date
, confirmation_code
, CAST(create_time as datetime) as create_time
, CAST(departure_date as date) as departure_date
, CAST(early_arrival as bit) as early_arrival
, number_of_adults
, number_of_children
, primary_guest_first_name
, primary_guest_last_name
, primary_guest_id
, property_id
, reservation_alias
, status
, tenant_id
, guest_type_id
, market_segment_id
, source_of_business_id
, CAST(update_time as datetime) as update_time
, company_id
, group_id
, vip_status_id
, CAST(non_registered_guest as bit) as non_registered_guest
, CAST(walk_in as bit) as walk_in
, cancellation_policy_id
, deposit_policy_id
, booked_by
, cancellation_code
, cancellation_reason
, cancelled_by
, agent_ids
, CAST(do_not_move_room as bit) as do_not_move_room
, cancellation_policy_overridden_by
, CAST(cancellation_policy_overridden_amount as money) as cancellation_policy_overridden_amount
, CAST(cancellation_policy_overridden_percentage as money) as cancellation_policy_overridden_percentage
, overridden_cancellation_policy_id
, CAST(estimated_time_of_arrival as datetime) as estimated_time_of_arrival
, CAST(estimated_time_of_departure as datetime) as estimated_time_of_departure
, booker_id
, CAST(cancellation_time_utc as datetime) as cancellation_time_utc
, CAST(web_check_in as bit) as web_check_in
, CAST(suppress_rate as bit) as suppress_rate
, no_of_documents
, share_id
, no_of_pets
, CAST(web_check_out as bit) as web_check_out
, CAST(room_ready_sms_enabled as bit) as room_ready_sms_enabled
, CAST(web_check_in_sms_enabled as bit) as web_check_in_sms_enabled
, CAST(web_check_out_sms_enabled as bit) as web_check_out_sms_enabled
, room_feature_preference_names
, number_of_guests
, guest_preference_ids
, housekeeping_pattern_id
, CAST(early_check_in_time as datetime) as early_check_in_time
, CAST(late_checkout_time as datetime) as late_checkout_time
, CAST(deposit_policy_amount as money) as deposit_policy_amount
, CAST(deposit_policy_tax as money) as deposit_policy_tax
, number_of_age_category1
, number_of_age_category2
, CAST(deposit_total_due as money) as deposit_total_due
, source_interface_id
, old_pms_confirmation_code
, CAST(checkin_at as datetime) as checkin_at
, checkin_by
, CAST(checkout_at as datetime) as checkout_at
, checkout_by
, do_not_move_reason_description
, CAST(do_not_move_reason_date_time as datetime) as do_not_move_reason_date_time
, do_not_move_reason_updated_by
, do_not_move_reason_id
, CAST(_export_ts as datetime) as _export_ts
, CAST(comp_overridden as bit) as comp_overridden
, comp_overridden_user
, player_id
, CAST(_export_create_ts as datetime) as _export_create_ts
, CAST(_export_update_ts as datetime) as _export_update_ts
, CAST(moved_status as bit) as moved_status

FROM OPENQUERY(POSTGRESQL,
'SELECT 
  CAST(id as varchar(200)) as id
, CAST(account_id as varchar(200)) as account_id
, CAST(allocation_id as varchar(200)) allocation_id
, arrival_date
, cancellation_date
, CAST(confirmation_code as varchar(200)) as confirmation_code
, create_time
, departure_date
, early_arrival
, number_of_adults
, number_of_children
, CAST(primary_guest_first_name as varchar(200)) as primary_guest_first_name
, CAST(primary_guest_last_name as varchar(200)) as primary_guest_last_name
, CAST(primary_guest_id as varchar(200)) as primary_guest_id
, CAST( property_id as varchar(200)) as property_id
, CAST(reservation_alias as varchar(200)) as reservation_alias
, CAST(status as varchar(200)) as status
, CAST(tenant_id as varchar(200)) as tenant_id
, CAST(guest_type_id as varchar(200)) as guest_type_id
, CAST(market_segment_id as varchar(200)) as market_segment_id
, CAST(source_of_business_id as varchar(200)) as source_of_business_id
, update_time
, CAST(company_id as varchar(200)) as company_id
, CAST(group_id as varchar(200)) as group_id
, CAST(vip_status_id as varchar(200)) as vip_status_id
, non_registered_guest
, walk_in
, CAST(cancellation_policy_id as varchar(200)) as cancellation_policy_id
, CAST(deposit_policy_id as varchar(200)) as deposit_policy_id
, CAST(vip_status_id as varchar(200)) as booked_by
, CAST(booked_by as varchar(200)) as cancellation_code
, CAST(cancellation_reason as varchar(200)) as cancellation_reason
, CAST(cancelled_by as varchar(200)) as cancelled_by
, CAST(array_to_string(agent_ids, '' , ''''*'') as varchar(100)) as agent_ids
, do_not_move_room
, CAST(cancellation_policy_overridden_by as varchar(200)) as cancellation_policy_overridden_by
, cancellation_policy_overridden_amount
, cancellation_policy_overridden_percentage
, CAST(overridden_cancellation_policy_id as varchar(200)) as overridden_cancellation_policy_id
, estimated_time_of_arrival
, estimated_time_of_departure
, CAST(booker_id as varchar(200)) as booker_id
, cancellation_time_utc
, web_check_in
, suppress_rate
, no_of_documents
, CAST(share_id as varchar(200)) as share_id
, no_of_pets
, web_check_out
, room_ready_sms_enabled
, web_check_in_sms_enabled
, web_check_out_sms_enabled
, CAST(array_to_string(room_feature_preference_names, '' , ''''*'') as varchar(100)) as room_feature_preference_names
, number_of_guests
, CAST(array_to_string(guest_preference_ids, '' , ''''*'') as varchar(100)) as guest_preference_ids
, CAST(housekeeping_pattern_id as varchar(200)) as housekeeping_pattern_id
, early_check_in_time
, late_checkout_time
, deposit_policy_amount
, deposit_policy_tax
, number_of_age_category1
, number_of_age_category2
, deposit_total_due
, CAST(source_interface_id as varchar(200)) as source_interface_id
, CAST(old_pms_confirmation_code as varchar(200)) as old_pms_confirmation_code
, checkin_at
, CAST(checkin_by as varchar(200)) as checkin_by
, checkout_at
, CAST(checkout_by as varchar(200)) as checkout_by
, CAST(do_not_move_reason_description as varchar(200)) as do_not_move_reason_description
, do_not_move_reason_date_time
, CAST(do_not_move_reason_updated_by as varchar(200)) as do_not_move_reason_updated_by
, CAST(do_not_move_reason_id as varchar(200)) as do_not_move_reason_id
, _export_ts
, comp_overridden
, CAST(comp_overridden_user as varchar(200)) as comp_overridden_user
, CAST(player_id as varchar(200)) as player_id
, _export_create_ts
, _export_update_ts
, moved_status
	
FROM public.reservations;'
) ;

----------------------------------------------------------------------------------------
-- Merge staged data into perm table
----------------------------------------------------------------------------------------

TRUNCATE TABLE Hotel.Stay_Reservations ;
INSERT INTO Hotel.Stay_Reservations
SELECT *
FROM Hotel.Stay_Reservations_STAGE 

GO