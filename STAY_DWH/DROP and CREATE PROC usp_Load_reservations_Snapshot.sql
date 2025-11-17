USE StayDWH ;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS dbo.usp_Load_reservations_Snapshot ;
GO

CREATE PROCEDURE dbo.usp_Load_reservations_Snapshot
AS

TRUNCATE TABLE dbo.reservations ;


INSERT INTO StayDWH.dbo.reservations
SELECT 
  [id]
, tenant_id
, property_id

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
, reservation_alias
, [status]
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
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(account_id as varchar(200)) as account_id --text
, CAST(allocation_id as varchar(200)) allocation_id --text
, arrival_date --date
, cancellation_date --timestamp without time zone
, CAST(confirmation_code as varchar(200)) as confirmation_code
, create_time --timestamp without time zone
, departure_date --date
, CAST(early_arrival as int) as early_arrival --boolean
, number_of_adults --integer
, number_of_children --integer
, CAST(primary_guest_first_name as varchar(200)) as primary_guest_first_name --text
, CAST(primary_guest_last_name as varchar(200)) as primary_guest_last_name --text
, CAST(primary_guest_id as varchar(200)) as primary_guest_id --text
, CAST(reservation_alias as varchar(200)) as reservation_alias --text
, CAST(status as varchar(200)) as status --text
, CAST(guest_type_id as varchar(200)) as guest_type_id --text
, CAST(market_segment_id as varchar(200)) as market_segment_id --text
, CAST(source_of_business_id as varchar(200)) as source_of_business_id --text
, update_time --timestamp without time zone
, CAST(company_id as varchar(200)) as company_id --text
, CAST(group_id as varchar(200)) as group_id --text
, CAST(vip_status_id as varchar(200)) as vip_status_id --text
, CAST(non_registered_guest as int) as non_registered_guest --boolean
, CAST(walk_in as int) as walk_in --boolean
, CAST(cancellation_policy_id as varchar(200)) as cancellation_policy_id --text
, CAST(deposit_policy_id as varchar(200)) as deposit_policy_id --text
, CAST(booked_by as varchar(200)) as booked_by --text
, CAST(cancellation_code as varchar(200)) as cancellation_code --text
, CAST(cancellation_reason as varchar(200)) as cancellation_reason --text
, CAST(cancelled_by as varchar(200)) as cancelled_by --text
, CAST(agent_ids as varchar(200)) as agent_ids --text[]
, CAST(do_not_move_room as int) as do_not_move_room --boolean
, CAST(cancellation_policy_overridden_by as varchar(200)) as cancellation_policy_overridden_by --text
, cancellation_policy_overridden_amount --numeric
, cancellation_policy_overridden_percentage --numeric
, CAST(overridden_cancellation_policy_id as varchar(200)) as overridden_cancellation_policy_id --text
, estimated_time_of_arrival --timestamp without time zone
, estimated_time_of_departure --timestamp without time zone
, CAST(booker_id as varchar(200)) as booker_id --text
, cancellation_time_utc --timestamp without time zone
, CAST(web_check_in as int) as web_check_in --boolean
, CAST(suppress_rate as int) as suppress_rate --boolean
, no_of_documents --integer
, CAST(share_id as varchar(200)) as share_id --text
, no_of_pets --integer
, CAST(web_check_out as int) as web_check_out --boolean
, CAST(room_ready_sms_enabled as int) as room_ready_sms_enabled --boolean
, CAST(web_check_in_sms_enabled as int) as web_check_in_sms_enabled --boolean
, CAST(web_check_out_sms_enabled as int) as web_check_out_sms_enabled --boolean
, CAST(array_to_string(room_feature_preference_names, '' , ''''*'') as varchar(100)) as room_feature_preference_names  --text[]
, number_of_guests --integer
, CAST(array_to_string(guest_preference_ids, '' , ''''*'') as varchar(100)) as guest_preference_ids --text[]
, CAST(housekeeping_pattern_id as varchar(200)) as housekeeping_pattern_id --text
, early_check_in_time --time without time zone
, late_checkout_time --time without time zone
, deposit_policy_amount --numeric
, deposit_policy_tax --numeric
, number_of_age_category1 --integer
, number_of_age_category2 --integer
, deposit_total_due --numeric
, CAST(source_interface_id as varchar(200)) as source_interface_id --text
, CAST(old_pms_confirmation_code as varchar(200)) as old_pms_confirmation_code --text
, checkin_at --timestamp with time zone
, CAST(checkin_by as varchar(200)) as checkin_by --text
, checkout_at --timestamp with time zone
, CAST(checkout_by as varchar(200)) as checkout_by --text
, CAST(do_not_move_reason_description as varchar(200)) as do_not_move_reason_description --text
, do_not_move_reason_date_time --timestamp without time zone
, CAST(do_not_move_reason_updated_by as varchar(200)) as do_not_move_reason_updated_by --text
, CAST(do_not_move_reason_id as varchar(200)) as do_not_move_reason_id --text
, _export_ts --timestamp with time zone
, CAST(comp_overridden as int) as comp_overridden --boolean
, CAST(comp_overridden_user as varchar(200)) as comp_overridden_user --text
, CAST(player_id as varchar(200)) as player_id --text
, _export_create_ts --timestamp with time zone
, _export_update_ts --timestamp with time zone
, CAST(moved_status as int) as moved_status --boolean
, number_of_age_category3 --integer,
, number_of_age_category4 --integer,
, number_of_age_category5 --integer,
, number_of_age_category6 --integer,
, number_of_age_category7 --integer,
, number_of_age_category8 --integer,
, red_eye_arrival_guest_arrival_date --date
, red_eye_arrival_estimated_time_of_arrival --timestamp without time zone
, CAST(red_eye_arrival_status as varchar(200)) as red_eye_arrival_status --text
, commission_percentage --numeric
, override_policy_amount --numeric(19,2)
, original_policy_amount --numeric(19,2)
, cancellation_fee_amount --numeric(19,2)
, cancellation_amount_charged --numeric(19,2)
, cancellation_policy_overridden_datetime --timestamp without time zone
, CAST(cancellation_policy_override_reason as varchar(200)) as cancellation_policy_override_reason --text
, CAST(original_cancellation_policy as varchar(200)) as original_cancellation_policy --text
, CAST(guest_requested_ada_room_type as int) as guest_requested_ada_room_type --boolean
, CAST(guest_requested_connecting_room_type as int) as guest_requested_connecting_room_type --boolean
, CAST(ada_room_assigned as int) as ada_room_assigned --boolean
, CAST(connecting_room_assigned as int) as connecting_room_assigned --boolean
, CAST(room_assignment_result as varchar(200)) as room_assignment_result --text
, CAST(existing_user_name as varchar(200)) as existing_user_name --text
, CAST(overriding_user_name as varchar(200)) as overriding_user_name --text
, created_date_time --timestamp without time zone

FROM public.reservations
'
) ;