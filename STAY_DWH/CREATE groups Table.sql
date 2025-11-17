------------------------------------------------------------------
-- groups
------------------------------------------------------------------
USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[groups] ;
GO

CREATE TABLE [dbo].[groups](
	[id] [varchar](200) NOT NULL,
	[account_id] [varchar](200) NULL,
	[adults_included] [int] NULL,
	[allocation_id] [varchar](200) NULL,
	[booking_status] [varchar](200) NULL,
	[cancellation_policy_id] [varchar](200) NULL,
	[children_included] [int] NULL,
	[create_time] [datetime2](7) NULL,
	[deposit_policy_id] [varchar](200) NULL,
	[end_date] [date] NULL,
	[extra_adult_charge] [money] NULL,
	[extra_children_charge] [money] NULL,
	[group_code] [varchar](200) NULL,
	[group_name] [varchar](200) NULL,
	[rate_plan_id] [varchar](200) NULL,
	[guest_type_id] [varchar](200) NULL,
	[market_segment_id] [varchar](200) NULL,
	[profile_id] [varchar](200) NULL,
	[property_id] [varchar](200) NULL,
	[shoulder_end_date] [date] NULL,
	[shoulder_start_date] [date] NULL,
	[source_of_business_id] [varchar](200) NULL,
	[start_date] [date] NULL,
	[tax_exempt] [int] NULL,
	[tenant_id] [varchar](200) NULL,
	[update_time] [datetime2](7) NULL,
	[confirmation_code] [varchar](200) NULL,
	[released] [int] NULL,
	[profile_type] [varchar](200) NULL,
	[description] [varchar](200) NULL,
	[rolling_release_enabled] [int] NULL,
	[auto_release_enabled] [int] NULL,
	[cut_off_date] [date] NULL,
	[departure_date] [date] NULL,
	[wholesaler] [int] NULL,
	[overridden_arc_rule_id] [varchar](200) NULL,
	[room_blocks_for_shoulder_dates] [int] NULL,
	[allocate_blocks_for_shoulder_dates] [int] NULL,
    [housing_restricted] [int] NULL ,
    [transaction_item_id] [varchar](200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_groups_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


--CREATE TABLE public.groups (
--    id text NOT NULL,
--    account_id text,
--    adults_included integer,
--    allocation_id text,
--    booking_status text,
--    cancellation_policy_id text,
--    children_included integer,
--    create_time timestamp without time zone,
--    deposit_policy_id text,
--    end_date date,
--    extra_adult_charge numeric(19,2),
--    extra_children_charge numeric(19,2),
--    group_code text,
--    group_name text,
--    rate_plan_id text,
--    guest_type_id text,
--    market_segment_id text,
--    profile_id text,
--    property_id text,
--    shoulder_end_date date,
--    shoulder_start_date date,
--    source_of_business_id text,
--    start_date date,
--    tax_exempt boolean,
--    tenant_id text,
--    update_time timestamp without time zone,
--    confirmation_code text,
--    released boolean DEFAULT false,
--    profile_type text,
--    description text,
--    rolling_release_enabled boolean,
--    auto_release_enabled boolean,
--    cut_off_date date,
--    departure_date date,
--    wholesaler boolean,
--    overridden_arc_rule_id text,
--    room_blocks_for_shoulder_dates boolean,
--    allocate_blocks_for_shoulder_dates boolean,
--    housing_restricted boolean,
--    transaction_item_id text
--);

--ADD CONSTRAINT groups_pkey PRIMARY KEY (id);

CREATE NONCLUSTERED INDEX [IX_groups_account_id] ON [dbo].[groups]
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_groups_aid ON public.groups USING btree (account_id);


CREATE NONCLUSTERED INDEX [IX_groups_profile_id] ON [dbo].[groups]
(
	[profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_groups_pid ON public.groups USING btree (profile_id);


CREATE NONCLUSTERED INDEX [IX_groups_tenant_id_property_id_start_date_end_date] ON [dbo].[groups]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[start_date] ASC,
	[end_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_groups_tenant_id_property_id_start_date_end_date ON public.groups USING btree (tenant_id, property_id, start_date, end_date);


CREATE NONCLUSTERED INDEX [IX_groups_tenant_id_property_id_id] ON [dbo].[groups]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_groups_tid_pid_id ON public.groups USING btree (tenant_id, property_id, id);

