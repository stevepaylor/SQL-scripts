USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[booking_channels] ;
GO

CREATE TABLE [dbo].[booking_channels](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](200) NOT NULL,
	[property_id] [varchar](200) NOT NULL,
	[name] [varchar](200) NULL,
	[code] [varchar](200) NULL,
	[interface_id] [varchar](200) NULL,
	[active] [int] NULL,
	[booking_limit] [int] NULL,
	[default_source_of_business_id] [varchar](200) NULL,
	[default_market_segment_id] [varchar](200) NULL,
	[default_guest_type_id] [varchar](200) NULL,
	[third_party_payment] [int] NULL,
	[suppress_rate_info] [int] NULL,
	[require_successful_deposit] [int] NULL,
	[booking_source_id] [varchar](200) NULL,
	[rate_plan_ids] [varchar](200) NULL,
	[auto_send_confirmation_email] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NOT NULL,
	[Local_ETL_Updated_TS] [datetime] NOT NULL,
 CONSTRAINT [PK_booking_channels_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_booking_channels_tenant_id_property_id_id] ON [dbo].[booking_channels]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO




--CREATE TABLE public.booking_channels (
--    id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    name text,
--    code text,
--    interface_id text,
--    active boolean,
--    booking_limit integer,
--    default_source_of_business_id text,
--    default_market_segment_id text,
--    default_guest_type_id text,
--    third_party_payment boolean,
--    suppress_rate_info boolean,
--    require_successful_deposit boolean,
--    booking_source_id text,
--    rate_plan_ids text[],
--    auto_send_confirmation_email boolean
--);

--ADD CONSTRAINT booking_channels_pkey PRIMARY KEY (id);

--CREATE INDEX idx_bookingchannels_tid_pid_id ON public.booking_channels USING btree (tenant_id, property_id, id);