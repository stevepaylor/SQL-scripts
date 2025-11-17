USE StayDWH
GO

DROP TABLE IF  EXISTS StayDWH.dbo.[reservations]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[reservations](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](10) NULL,
	[property_id] [varchar](10) NULL,

	[account_id] [varchar](200) NULL,
	[allocation_id] [varchar](200) NULL,
	[arrival_date] [date] NULL,
	[cancellation_date] [date] NULL,
	[confirmation_code] [varchar](200) NULL,
	[create_time] [datetime] NULL,
	[departure_date] [date] NULL,
	[early_arrival] [int] NULL,
	[number_of_adults] [int] NULL,
	[number_of_children] [int] NULL,
	[primary_guest_first_name] [varchar](200) NULL,
	[primary_guest_last_name] [varchar](200) NULL,
	[primary_guest_id] [varchar](200) NULL,
	[reservation_alias] [varchar](200) NULL,
	[status] [varchar](200) NULL,
	[guest_type_id] [varchar](200) NULL,
	[market_segment_id] [varchar](200) NULL,
	[source_of_business_id] [varchar](200) NULL,
	[update_time] [datetime] NULL,
	[company_id] [varchar](200) NULL,
	[group_id] [varchar](200) NULL,
	[vip_status_id] [varchar](200) NULL,
	[non_registered_guest] [int] NULL,
	[walk_in] [int] NULL,
	[cancellation_policy_id] [varchar](200) NULL,
	[deposit_policy_id] [varchar](200) NULL,
	[booked_by] [varchar](200) NULL,
	[cancellation_code] [varchar](200) NULL,
	[cancellation_reason] [varchar](200) NULL,
	[cancelled_by] [varchar](200) NULL,
	[agent_ids] [varchar](100) NULL,
	[do_not_move_room] [int] NULL,
	[cancellation_policy_overridden_by] [varchar](200) NULL,
	[cancellation_policy_overridden_amount] [money] NULL,
	[cancellation_policy_overridden_percentage] [money] NULL,
	[overridden_cancellation_policy_id] [varchar](200) NULL,
	[estimated_time_of_arrival] [datetime] NULL,
	[estimated_time_of_departure] [datetime] NULL,
	[booker_id] [varchar](200) NULL,
	[cancellation_time_utc] [datetime] NULL,
	[web_check_in] [int] NULL,
	[suppress_rate] [int] NULL,
	[no_of_documents] [int] NULL,
	[share_id] [varchar](200) NULL,
	[no_of_pets] [int] NULL,
	[web_check_out] [int] NULL,
	[room_ready_sms_enabled] [int] NULL,
	[web_check_in_sms_enabled] [int] NULL,
	[web_check_out_sms_enabled] [int] NULL,
	[room_feature_preference_names] [varchar](100) NULL,
	[number_of_guests] [int] NULL,
	[guest_preference_ids] [varchar](100) NULL,
	[housekeeping_pattern_id] [varchar](200) NULL,
	[early_check_in_time] [time](0) NULL,
	[late_checkout_time] [time](0) NULL,
	[deposit_policy_amount] [money] NULL,
	[deposit_policy_tax] [money] NULL,
	[number_of_age_category1] [int] NULL,
	[number_of_age_category2] [int] NULL,
	[deposit_total_due] [money] NULL,
	[source_interface_id] [varchar](200) NULL,
	[old_pms_confirmation_code] [varchar](200) NULL,
	[checkin_at] [datetime] NULL,
	[checkin_by] [varchar](200) NULL,
	[checkout_at] [datetime] NULL,
	[checkout_by] [varchar](200) NULL,
	[do_not_move_reason_description] [varchar](200) NULL,
	[do_not_move_reason_date_time] [datetime] NULL,
	[do_not_move_reason_updated_by] [varchar](200) NULL,
	[do_not_move_reason_id] [varchar](200) NULL,
	[_export_ts] [datetime] NULL,
	[comp_overridden] [int] NULL,
	[comp_overridden_user] [varchar](200) NULL,
	[player_id] [varchar](200) NULL,
	[_export_create_ts] [datetime] NULL,
	[_export_update_ts] [datetime] NULL,
	[moved_status] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_reservations_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_account_id ON reservations USING btree (account_id);
CREATE NONCLUSTERED INDEX [IX_reservations_account_id] ON [dbo].[reservations]
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_allocation_id ON reservations USING btree (allocation_id);
CREATE NONCLUSTERED INDEX [IX_reservations_allocation_id] ON [dbo].[reservations]
(
	[allocation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_company_id ON reservations USING btree (company_id);
CREATE NONCLUSTERED INDEX [IX_reservations_company_id] ON [dbo].[reservations]
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_confirmationcode ON reservations USING btree (confirmation_code);
CREATE NONCLUSTERED INDEX [IX_reservations_confirmation_code] ON [dbo].[reservations]
(
	[confirmation_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_create_time ON reservations USING btree (create_time);
CREATE NONCLUSTERED INDEX [IX_reservations_create_time] ON [dbo].[reservations]
(
	[create_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_group_id ON reservations USING btree (group_id);
CREATE NONCLUSTERED INDEX [IX_reservations_group_id] ON [dbo].[reservations]
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_pgid ON reservations USING btree (primary_guest_id);
CREATE NONCLUSTERED INDEX [IX_reservations_primary_guest_id] ON [dbo].[reservations]
(
	[primary_guest_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_tid_pid_created_status ON reservations USING btree (tenant_id, property_id, create_time, status);
CREATE NONCLUSTERED INDEX [IX_reservations_tenant_id_etc] ON [dbo].[reservations]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[create_time],
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_tid_pid_id_arrival_date_departure_date ON reservations USING btree (tenant_id, property_id, arrival_date NULL , departure_date);
CREATE NONCLUSTERED INDEX [IX_reservations_tenant_id_etc_2] ON [dbo].[reservations]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[arrival_date],
	[departure_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservations_tid_pid_pgid ON reservations USING btree (tenant_id, property_id, primary_guest_id);
CREATE NONCLUSTERED INDEX [IX_reservations_tenant_id_etc_3] ON [dbo].[reservations]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[primary_guest_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


----CREATE TABLE public.reservations (
----    id text NOT NULL,
----    account_id text,
----    allocation_id text,
----    arrival_date date,
----    cancellation_date date,
----    confirmation_code text,
----    create_time timestamp without time zone,
----    departure_date date,
----    early_arrival boolean,
----    number_of_adults integer,
----    number_of_children integer,
----    primary_guest_first_name text,
----    primary_guest_last_name text,
----    primary_guest_id text,
----    property_id text,
----    reservation_alias text,
----    status text,
----    tenant_id text,
----    guest_type_id text,
----    market_segment_id text,
----    source_of_business_id text,
----    update_time timestamp without time zone,
----    company_id text,
----    group_id text,
----    vip_status_id text,
----    non_registered_guest boolean,
----    walk_in boolean,
----    cancellation_policy_id text,
----    deposit_policy_id text,
----    booked_by text,
----    cancellation_code text,
----    cancellation_reason text,
----    cancelled_by text,
----    agent_ids text[],
----    do_not_move_room boolean,
----    cancellation_policy_overridden_by text,
----    cancellation_policy_overridden_amount numeric,
----    cancellation_policy_overridden_percentage numeric,
----    overridden_cancellation_policy_id text,
----    estimated_time_of_arrival timestamp without time zone,
----    estimated_time_of_departure timestamp without time zone,
----    booker_id text,
----    cancellation_time_utc timestamp without time zone,
----    web_check_in boolean,
----    suppress_rate boolean,
----    no_of_documents integer,
----    share_id text,
----    no_of_pets integer,
----    web_check_out boolean,
----    room_ready_sms_enabled boolean,
----    web_check_in_sms_enabled boolean,
----    web_check_out_sms_enabled boolean,
----    room_feature_preference_names text[],
----    number_of_guests integer,
----    guest_preference_ids text[],
----    housekeeping_pattern_id text,
----    early_check_in_time time without time zone,
----    late_checkout_time time without time zone,
----    deposit_policy_amount numeric,
----    deposit_policy_tax numeric,
----    number_of_age_category1 integer,
----    number_of_age_category2 integer,
----    deposit_total_due numeric,
----    source_interface_id text,
----    old_pms_confirmation_code text,
----    checkin_at timestamp with time zone,
----    checkin_by text,
----    checkout_at timestamp with time zone,
----    checkout_by text,
----    do_not_move_reason_description text,
----    do_not_move_reason_date_time timestamp without time zone,
----    do_not_move_reason_updated_by text,
----    do_not_move_reason_id text,
----    _export_ts timestamp with time zone,
----    comp_overridden boolean,
----    comp_overridden_user text,
----    player_id text,
----    _export_create_ts timestamp with time zone,
----    _export_update_ts timestamp with time zone,
----    moved_status boolean,
----    number_of_age_category3 integer,
----    number_of_age_category4 integer,
----    number_of_age_category5 integer,
----    number_of_age_category6 integer,
----    number_of_age_category7 integer,
----    number_of_age_category8 integer,
----    red_eye_arrival_guest_arrival_date date,
----    red_eye_arrival_estimated_time_of_arrival timestamp without time zone,
----    red_eye_arrival_status text,
----    commission_percentage numeric,
----    override_policy_amount numeric(19,2),
----    original_policy_amount numeric(19,2),
----    cancellation_fee_amount numeric(19,2),
----    cancellation_amount_charged numeric(19,2),
----    cancellation_policy_overridden_datetime timestamp without time zone,
----    cancellation_policy_override_reason text,
----    original_cancellation_policy text,
----    guest_requested_ada_room_type boolean,
----    guest_requested_connecting_room_type boolean,
----    ada_room_assigned boolean,
----    connecting_room_assigned boolean,
----    room_assignment_result text,
----    existing_user_name text,
----    overriding_user_name text,
----    created_date_time timestamp without time zone
