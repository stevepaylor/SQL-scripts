USE [iQ-Gaming]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Hotel.Stay_Reservations_test') AND type in (N'U'))
DROP TABLE IF EXISTS Hotel.Stay_Reservations
GO

/****** Object:  Table .Stay_Reservations_test    Script Date: 9/17/2023 11:14:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Hotel.Stay_Reservations(
	id varchar(200) NOT NULL,
	account_id varchar(200) NULL,
	allocation_id varchar(200) NULL,
	arrival_date date NULL,
	cancellation_date date NULL,
	confirmation_code varchar(200) NULL,
	create_time datetime NULL,
	departure_date date NULL,
	early_arrival bit NULL,
	number_of_adults int NULL,
	number_of_children int NULL,
	primary_guest_first_name varchar(200) NULL,
	primary_guest_last_name varchar(200) NULL,
	primary_guest_id varchar(200) NULL,
	property_id varchar(200) NULL,
	reservation_alias varchar(200) NULL,
	[status] varchar(200) NULL,
	tenant_id varchar(200) NULL,
	guest_type_id varchar(200) NULL,
	market_segment_id varchar(200) NULL,
	source_of_business_id varchar(200) NULL,
	update_time datetime NULL,
	company_id varchar(200) NULL,
	group_id varchar(200) NULL,
	vip_status_id varchar(200) NULL,
	non_registered_guest bit NULL,
	walk_in bit NULL,
	cancellation_policy_id varchar(200) NULL,
	deposit_policy_id varchar(200) NULL,
	booked_by varchar(200) NULL,
	cancellation_code varchar(200) NULL,
	cancellation_reason varchar(200) NULL,
	cancelled_by varchar(200) NULL,
	agent_ids varchar(100) NULL,
	do_not_move_room bit NULL,
	cancellation_policy_overridden_by varchar(200) NULL,
	cancellation_policy_overridden_amount money NULL,
	cancellation_policy_overridden_percentage money NULL,
	overridden_cancellation_policy_id varchar(200) NULL,
	estimated_time_of_arrival datetime NULL,
	estimated_time_of_departure datetime NULL,
	booker_id varchar(200) NULL,
	cancellation_time_utc datetime NULL,
	web_check_in bit NULL,
	suppress_rate bit NULL,
	no_of_documents int NULL,
	share_id varchar(200) NULL,
	no_of_pets int NULL,
	web_check_out bit NULL,
	room_ready_sms_enabled bit NULL,
	web_check_in_sms_enabled bit NULL,
	web_check_out_sms_enabled bit NULL,
	room_feature_preference_names varchar(100) NULL,
	number_of_guests int NULL,
	guest_preference_ids varchar(100) NULL,
	housekeeping_pattern_id varchar(200) NULL,
	early_check_in_time datetime NULL,
	late_checkout_time datetime NULL,
	deposit_policy_amount money NULL,
	deposit_policy_tax money NULL,
	number_of_age_category1 int NULL,
	number_of_age_category2 int NULL,
	deposit_total_due money NULL,
	source_interface_id varchar(200) NULL,
	old_pms_confirmation_code varchar(200) NULL,
	checkin_at datetime NULL,
	checkin_by varchar(200) NULL,
	checkout_at datetime NULL,
	checkout_by varchar(200) NULL,
	do_not_move_reason_description varchar(200) NULL,
	do_not_move_reason_date_time datetime NULL,
	do_not_move_reason_updated_by varchar(200) NULL,
	do_not_move_reason_id varchar(200) NULL,
	_export_ts datetime NULL,
	comp_overridden bit NULL,
	comp_overridden_user varchar(200) NULL,
	player_id varchar(200) NULL,
	_export_create_ts datetime NULL,
	_export_update_ts datetime NULL,
	moved_status bit NULL,
 CONSTRAINT PK_Stay_Reservations_id PRIMARY KEY CLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


