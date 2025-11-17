USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[rate_plans]
GO

CREATE TABLE [dbo].[rate_plans](
	[id] [varchar](200) NOT NULL,
	[owner] [varchar](200) NULL,
	[deleted] [int] NULL,
	[update_time] [datetime] NULL,
	[create_time] [datetime] NULL,
	[property_id] [varchar](200) NULL,
	[tenant_id] [varchar](200) NULL,
	[owner_reference_id] [varchar](200) NULL,
	[code] [varchar](200) NULL,
	[name] [varchar](200) NULL,
	[description] [varchar](200) NULL,
	[marketing_description] [varchar](200) NULL,
	[rate_category_id] [varchar](200) NULL,
	[qualified] [int] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[housekeeping_pattern_id] [varchar](200) NULL,
	[booking_start_date] [date] NULL,
	[booking_end_date] [date] NULL,
	[adults_included] [int] NULL,
	[children_included] [int] NULL,
	[master_rate_plan_id] [varchar](200) NULL,
	[rate_calendar_id] [varchar](200) NULL,
	[transaction_item_id] [varchar](200) NULL,
	[deposit_policy_id] [varchar](200) NULL,
	[cancellation_policy_id] [varchar](200) NULL,
	[shoulder_start_date] [date] NULL,
	[shoulder_end_date] [date] NULL,
	[credit_card_auth_rule_settings_id] [varchar](200) NULL,
	[comp_category_id] [varchar](200) NULL,
	[comp_certificate_number] [varchar](200) NULL,
	[comp_reason_comment] [varchar](2000) NULL,
	[min_length_of_stay] [int] NULL,
	[max_length_of_stay] [int] NULL,
	[suppress_rate] [int] NULL,
	[commissionable] [int] NULL,
	[guest_type_id] [varchar](200) NULL,
	[market_segment_id] [varchar](200) NULL,
	[source_of_business_id] [varchar](200) NULL,
	[rate_selector_type] [varchar](200) NULL,
	[component_bundle_ids] [varchar](200) NULL,
	[promo_offer_id] [varchar](200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--     ADD CONSTRAINT rate_plans_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_rate_plans_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_rate_plans_tid_pid_id ON public.rate_plans USING btree (tenant_id, property_id, id);
CREATE UNIQUE NONCLUSTERED INDEX [IX_rate_plans_tenant_id_property_id_id] ON [dbo].[rate_plans]
(
	tenant_id ASC ,
	property_id ASC ,
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--CREATE TABLE public.rate_plans (
--    id text NOT NULL,
--    owner text,
--    deleted boolean,
--    update_time timestamp without time zone,
--    create_time timestamp without time zone,
--    property_id text,
--    tenant_id text,
--    owner_reference_id text,
--    code text,
--    name text,
--    description text,
--    marketing_description text,
--    rate_category_id text,
--    qualified boolean,
--    start_date date,
--    end_date date,
--    housekeeping_pattern_id text,
--    booking_start_date date,
--    booking_end_date date,
--    adults_included integer,
--    children_included integer,
--    master_rate_plan_id text,
--    rate_calendar_id text,
--    transaction_item_id text,
--    deposit_policy_id text,
--    cancellation_policy_id text,
--    shoulder_start_date date,
--    shoulder_end_date date,
--    credit_card_auth_rule_settings_id text,
--    comp_category_id text,
--    comp_certificate_number text,
--    comp_reason_comment text,
--    min_length_of_stay integer,
--    max_length_of_stay integer,
--    suppress_rate boolean,
--    commissionable boolean,
--    guest_type_id text,
--    market_segment_id text,
--    source_of_business_id text,
--    rate_selector_type text,
--    component_bundle_ids text[],
--    promo_offer_id text
--);