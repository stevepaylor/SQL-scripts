USE StayDWH ;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS dbo.usp_Load_Delta_reservations ;
GO

CREATE PROCEDURE dbo.usp_Load_Delta_reservations
AS

DROP TABLE IF EXISTS dbo.reservations_Delta

SELECT 
  [id]
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
, [status]
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
, CAST(early_check_in_time as time(0)) as early_check_in_time
, CAST(late_checkout_time as time(0)) as late_checkout_time
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

INTO StayDWH.dbo.reservations_Delta

FROM OPENQUERY(Stay_PostgreSQL,
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
	
FROM public.reservations


WHERE _export_create_ts >= current_timestamp - interval ''2 weeks'''
) ;


----------------------------------------------------------------------------------------
-- Merge delta data into perm table
----------------------------------------------------------------------------------------

MERGE dbo.reservations AS [target]
USING dbo.reservations_Delta AS delta
ON [target].[id] = delta.[id]
WHEN MATCHED 
AND (delta._export_update_ts > SWITCHOFFSET([Local_ETL_Updated_TS]  AT TIME ZONE 'Pacific Standard Time', '+00:00')
     OR delta._export_update_ts > [target]._export_update_ts)
THEN UPDATE SET
    [target].[id] = delta.[id]
  , [target].account_id = delta.account_id
  , [target].allocation_id = delta.allocation_id
  , [target].arrival_date = delta.arrival_date
  , [target].cancellation_date = delta.cancellation_date
  , [target].confirmation_code = delta.confirmation_code
  , [target].create_time = delta.create_time
  , [target].departure_date = delta.departure_date
  , [target].early_arrival = delta.early_arrival
  , [target].number_of_adults = delta.number_of_adults
  , [target].number_of_children = delta.number_of_children
  , [target].primary_guest_first_name = delta.primary_guest_first_name
  , [target].primary_guest_last_name = delta.primary_guest_last_name
  , [target].primary_guest_id = delta.primary_guest_id
  , [target].property_id = delta.property_id
  , [target].reservation_alias = delta.reservation_alias
  , [target].[status] = delta.[status]
  , [target].tenant_id = delta.tenant_id
  , [target].guest_type_id = delta.guest_type_id
  , [target].market_segment_id = delta.market_segment_id
  , [target].source_of_business_id = delta.source_of_business_id
  , [target].update_time = delta.update_time
  , [target].company_id = delta.company_id
  , [target].group_id = delta.group_id
  , [target].vip_status_id = delta.vip_status_id
  , [target].non_registered_guest = delta.non_registered_guest
  , [target].walk_in = delta.walk_in
  , [target].cancellation_policy_id = delta.cancellation_policy_id
  , [target].deposit_policy_id = delta.deposit_policy_id
  , [target].booked_by = delta.booked_by
  , [target].cancellation_code = delta.cancellation_code
  , [target].cancellation_reason = delta.cancellation_reason
  , [target].cancelled_by = delta.cancelled_by
  , [target].agent_ids = delta.agent_ids
  , [target].do_not_move_room = delta.do_not_move_room
  , [target].cancellation_policy_overridden_by = delta.cancellation_policy_overridden_by
  , [target].cancellation_policy_overridden_amount = delta.cancellation_policy_overridden_amount
  , [target].cancellation_policy_overridden_percentage = delta.cancellation_policy_overridden_percentage
  , [target].overridden_cancellation_policy_id = delta.overridden_cancellation_policy_id
  , [target].estimated_time_of_arrival = delta.estimated_time_of_arrival
  , [target].estimated_time_of_departure = delta.estimated_time_of_departure
  , [target].booker_id = delta.booker_id
  , [target].cancellation_time_utc = delta.cancellation_time_utc
  , [target].web_check_in = delta.web_check_in
  , [target].suppress_rate = delta.suppress_rate
  , [target].no_of_documents = delta.no_of_documents
  , [target].share_id = delta.share_id
  , [target].no_of_pets = delta.no_of_pets
  , [target].web_check_out = delta.web_check_out
  , [target].room_ready_sms_enabled = delta.room_ready_sms_enabled
  , [target].web_check_in_sms_enabled = delta.web_check_in_sms_enabled
  , [target].web_check_out_sms_enabled = delta.web_check_out_sms_enabled
  , [target].room_feature_preference_names = delta.room_feature_preference_names
  , [target].number_of_guests = delta.number_of_guests
  , [target].guest_preference_ids = delta.guest_preference_ids
  , [target].housekeeping_pattern_id = delta.housekeeping_pattern_id
  , [target].early_check_in_time = delta.early_check_in_time
  , [target].late_checkout_time = delta.late_checkout_time
  , [target].deposit_policy_amount = delta.deposit_policy_amount
  , [target].deposit_policy_tax = delta.deposit_policy_tax
  , [target].number_of_age_category1 = delta.number_of_age_category1
  , [target].number_of_age_category2 = delta.number_of_age_category2
  , [target].deposit_total_due = delta.deposit_total_due
  , [target].source_interface_id = delta.source_interface_id
  , [target].old_pms_confirmation_code = delta.old_pms_confirmation_code
  , [target].checkin_at = delta.checkin_at
  , [target].checkin_by = delta.checkin_by
  , [target].checkout_at = delta.checkout_at
  , [target].checkout_by = delta.checkout_by
  , [target].do_not_move_reason_description = delta.do_not_move_reason_description
  , [target].do_not_move_reason_date_time = delta.do_not_move_reason_date_time
  , [target].do_not_move_reason_updated_by = delta.do_not_move_reason_updated_by
  , [target].do_not_move_reason_id = delta.do_not_move_reason_id
  , [target]._export_ts = delta._export_ts
  , [target].comp_overridden = delta.comp_overridden
  , [target].comp_overridden_user = delta.comp_overridden_user
  , [target].player_id = delta.player_id
  , [target]._export_create_ts = delta._export_create_ts
  , [target]._export_update_ts = delta._export_update_ts
  , [target].moved_status = delta.moved_status
  , [target].Local_ETL_Updated_TS = CURRENT_TIMESTAMP

WHEN NOT MATCHED THEN INSERT 
( 
  [id]
, account_id
, allocation_id
, arrival_date
, cancellation_date
, confirmation_code
, create_time
, departure_date
, early_arrival
, number_of_adults
, number_of_children
, primary_guest_first_name
, primary_guest_last_name
, primary_guest_id
, property_id
, reservation_alias
, [status]
, tenant_id
, guest_type_id
, market_segment_id
, source_of_business_id
, update_time
, company_id
, group_id
, vip_status_id
, non_registered_guest
, walk_in
, cancellation_policy_id
, deposit_policy_id
, booked_by
, cancellation_code
, cancellation_reason
, cancelled_by
, agent_ids
, do_not_move_room
, cancellation_policy_overridden_by
, cancellation_policy_overridden_amount
, cancellation_policy_overridden_percentage
, overridden_cancellation_policy_id
, estimated_time_of_arrival
, estimated_time_of_departure
, booker_id
, cancellation_time_utc
, web_check_in
, suppress_rate
, no_of_documents
, share_id
, no_of_pets
, web_check_out
, room_ready_sms_enabled
, web_check_in_sms_enabled
, web_check_out_sms_enabled
, room_feature_preference_names
, number_of_guests
, guest_preference_ids
, housekeeping_pattern_id
, early_check_in_time
, late_checkout_time
, deposit_policy_amount
, deposit_policy_tax
, number_of_age_category1
, number_of_age_category2
, deposit_total_due
, source_interface_id
, old_pms_confirmation_code
, checkin_at
, checkin_by
, checkout_at
, checkout_by
, do_not_move_reason_description
, do_not_move_reason_date_time
, do_not_move_reason_updated_by
, do_not_move_reason_id
, _export_ts
, comp_overridden
, comp_overridden_user
, player_id
, _export_create_ts
, _export_update_ts
, moved_status
, Local_ETL_Inserted_TS
) 
VALUES 
( 
  delta.[id]
, delta.account_id
, delta.allocation_id
, delta.arrival_date
, delta.cancellation_date
, delta.confirmation_code
, delta.create_time
, delta.departure_date
, delta.early_arrival
, delta.number_of_adults
, delta.number_of_children
, delta.primary_guest_first_name
, delta.primary_guest_last_name
, delta.primary_guest_id
, delta.property_id
, delta.reservation_alias
, delta.[status]
, delta.tenant_id
, delta.guest_type_id
, delta.market_segment_id
, delta.source_of_business_id
, delta.update_time
, delta.company_id
, delta.group_id
, delta.vip_status_id
, delta.non_registered_guest
, delta.walk_in
, delta.cancellation_policy_id
, delta.deposit_policy_id
, delta.booked_by
, delta.cancellation_code
, delta.cancellation_reason
, delta.cancelled_by
, delta.agent_ids
, delta.do_not_move_room
, delta.cancellation_policy_overridden_by
, delta.cancellation_policy_overridden_amount
, delta.cancellation_policy_overridden_percentage
, delta.overridden_cancellation_policy_id
, delta.estimated_time_of_arrival
, delta.estimated_time_of_departure
, delta.booker_id
, delta.cancellation_time_utc
, delta.web_check_in
, delta.suppress_rate
, delta.no_of_documents
, delta.share_id
, delta.no_of_pets
, delta.web_check_out
, delta.room_ready_sms_enabled
, delta.web_check_in_sms_enabled
, delta.web_check_out_sms_enabled
, delta.room_feature_preference_names
, delta.number_of_guests
, delta.guest_preference_ids
, delta.housekeeping_pattern_id
, delta.early_check_in_time
, delta.late_checkout_time
, delta.deposit_policy_amount
, delta.deposit_policy_tax
, delta.number_of_age_category1
, delta.number_of_age_category2
, delta.deposit_total_due
, delta.source_interface_id
, delta.old_pms_confirmation_code
, delta.checkin_at
, delta.checkin_by
, delta.checkout_at
, delta.checkout_by
, delta.do_not_move_reason_description
, delta.do_not_move_reason_date_time
, delta.do_not_move_reason_updated_by
, delta.do_not_move_reason_id
, delta._export_ts
, delta.comp_overridden
, delta.comp_overridden_user
, delta.player_id
, delta._export_create_ts
, delta._export_update_ts
, delta.moved_status
, CURRENT_TIMESTAMP
);


