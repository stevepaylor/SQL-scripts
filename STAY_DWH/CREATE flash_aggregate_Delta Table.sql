USE [StayDWH]
GO

DROP TABLE IF EXISTS [dbo].[flash_aggregate_Delta]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[flash_aggregate_Delta] ;
GO

CREATE TABLE [dbo].[flash_aggregate_Delta](
	[date] [date] NULL,
	[tenant_id] [varchar](10) NULL,
	[property_id] [varchar](10) NULL,
	[building_name] [varchar](30) NULL,
	[room_type_code] [varchar](30) NULL,
	[rate_code] [varchar](30) NULL,
	[market_segment_code] [varchar](30) NULL,
	[last_updated_at] [datetime2](7) NULL,
	[total_rooms] [int] NULL,
	[off_the_market] [int] NULL,
	[total_available_rooms] [int] NULL,
	[out_of_order] [int] NULL,
	[rentable_rooms] [int] NULL,
	[hold] [int] NULL,
	[departures_remaining_rooms] [int] NULL,
	[departures_remaining_guests] [int] NULL,
	[departures_remaining_adults] [int] NULL,
	[departures_remaining_children] [int] NULL,
	[departures_total_rooms] [int] NULL,
	[departures_total_guests] [int] NULL,
	[departures_total_adults] [int] NULL,
	[departures_total_children] [int] NULL,
	[arrivals_remaining_rooms] [int] NULL,
	[arrivals_remaining_guests] [int] NULL,
	[arrivals_remaining_adults] [int] NULL,
	[arrivals_remaining_children] [int] NULL,
	[arrivals_total_rooms] [int] NULL,
	[arrivals_total_guests] [int] NULL,
	[arrivals_total_adults] [int] NULL,
	[arrivals_total_children] [int] NULL,
	[stay_overs_rooms] [int] NULL,
	[stay_overs_guests] [int] NULL,
	[stay_overs_adults] [int] NULL,
	[stay_overs_children] [int] NULL,
	[no_show_rooms] [int] NULL,
	[no_show_guests] [int] NULL,
	[no_show_adults] [int] NULL,
	[no_show_children] [int] NULL,
	[totals_rooms] [int] NULL,
	[totals_guests] [int] NULL,
	[totals_adults] [int] NULL,
	[totals_children] [int] NULL,
	[same_day_rooms] [int] NULL,
	[same_day_guests] [int] NULL,
	[same_day_adults] [int] NULL,
	[same_day_children] [int] NULL,
	[walkin_rooms] [int] NULL,
	[walkin_guests] [int] NULL,
	[walkin_adults] [int] NULL,
	[walkin_children] [int] NULL,
	[reservations_no_rate_rooms] [int] NULL,
	[no_rate_guests] [int] NULL,
	[no_rate_adults] [int] NULL,
	[no_rate_children] [int] NULL,
	[rooms_vacant] [int] NULL,
	[rooms_sold] [int] NULL,
	[rooms_sold_guests] [int] NULL,
	[rooms_comped] [int] NULL,
	[rooms_comped_guests] [int] NULL,
	[rooms_occupied] [int] NULL,
	[rooms_occupied_guests] [int] NULL,
	[transient_rooms_sold] [int] NULL,
	[transient_rooms_sold_guests] [int] NULL,
	[group_rooms_sold] [int] NULL,
	[group_rooms_sold_guests] [int] NULL,
	[room_type_sold] [int] NULL,
	[groups_not_picked_up] [int] NULL,
	[availability_no_rate_rooms] [int] NULL,
	[room_revenue] [money] NULL,
	[room_revenue_transient] [money] NULL,
	[room_revenue_group] [money] NULL,
	[historic] [varchar](5) NULL,
	[room_revenue_total] [money] NULL,
	[room_revenue_tax] [money] NULL,
	[room_revenue_transient_total] [money] NULL,
	[room_revenue_transient_tax] [money] NULL,
	[room_revenue_group_total] [money] NULL,
	[room_revenue_group_tax] [money] NULL,
	[room_type_name] [varchar](200) NULL,
	[rate_name] [varchar](200) NULL,
	[market_segment_name] [varchar](200) NULL,
	[originated_room_revenue] [money] NULL,
	[originated_room_revenue_transient] [money] NULL,
	[originated_room_revenue_group] [money] NULL,
	[originated_room_revenue_total] [money] NULL,
	[originated_room_revenue_tax] [money] NULL,
	[originated_room_revenue_transient_total] [money] NULL,
	[originated_room_revenue_transient_tax] [money] NULL,
	[originated_room_revenue_group_total] [money] NULL,
	[originated_room_revenue_group_tax] [money] NULL,
	[redemption_stay] [int] NULL
) ON [PRIMARY]
GO

----CREATE NONCLUSTERED INDEX [IX__flash_aggregate_Delta_date_tenant_id_property_id] ON [dbo].[flash_aggregate_Delta]
----(
----	[date] ASC,
----	[tenant_id] ASC,
----	[property_id] ASC
----)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
----GO

----CREATE NONCLUSTERED INDEX [IX_flash_aggregate_Delta_last_updated_at] ON [dbo].[flash_aggregate_Delta]
----(
----	[last_updated_at] ASC
----)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
----GO



--CREATE TABLE public.flash_aggregate (
--    date date,
--    tenant_id text,
--    property_id text,
--    building_name text,
--    total_rooms integer,
--    off_the_market integer,
--    total_available_rooms integer,
--    out_of_order integer,
--    rentable_rooms integer,
--    hold integer,
--    departures_remaining_rooms integer,
--    departures_remaining_guests integer,
--    departures_remaining_adults integer,
--    departures_remaining_children integer,
--    departures_total_rooms integer,
--    departures_total_guests integer,
--    departures_total_adults integer,
--    departures_total_children integer,
--    arrivals_remaining_rooms integer,
--    arrivals_remaining_guests integer,
--    arrivals_remaining_adults integer,
--    arrivals_remaining_children integer,
--    arrivals_total_rooms integer,
--    arrivals_total_guests integer,
--    arrivals_total_adults integer,
--    arrivals_total_children integer,
--    stay_overs_rooms integer,
--    stay_overs_guests integer,
--    stay_overs_adults integer,
--    stay_overs_children integer,
--    no_show_rooms integer,
--    no_show_guests integer,
--    no_show_adults integer,
--    no_show_children integer,
--    totals_rooms integer,
--    totals_guests integer,
--    totals_adults integer,
--    totals_children integer,
--    same_day_rooms integer,
--    same_day_guests integer,
--    same_day_adults integer,
--    same_day_children integer,
--    walkin_rooms integer,
--    walkin_guests integer,
--    walkin_adults integer,
--    walkin_children integer,
--    reservations_no_rate_rooms integer,
--    no_rate_guests integer,
--    no_rate_adults integer,
--    no_rate_children integer,
--    rooms_vacant integer,
--    rooms_sold integer,
--    rooms_sold_guests integer,
--    rooms_comped integer,
--    rooms_comped_guests integer,
--    rooms_occupied integer,
--    rooms_occupied_guests integer,
--    transient_rooms_sold integer,
--    transient_rooms_sold_guests integer,
--    group_rooms_sold integer,
--    group_rooms_sold_guests integer,
--    room_type_sold integer,
--    groups_not_picked_up integer,
--    availability_no_rate_rooms integer,
--    room_revenue numeric(19,2),
--    room_revenue_transient numeric(19,2),
--    room_revenue_group numeric(19,2),
--    last_updated_at timestamp with time zone,
--    historic boolean,
--    room_revenue_total numeric,
--    room_revenue_tax numeric,
--    room_revenue_transient_total numeric,
--    room_revenue_transient_tax numeric,
--    room_revenue_group_total numeric,
--    room_revenue_group_tax numeric,
--    room_type_name text,
--    room_type_code text,
--    rate_code text,
--    rate_name text,
--    market_segment_name text,
--    market_segment_code text,
--    originated_room_revenue numeric,
--    originated_room_revenue_transient numeric,
--    originated_room_revenue_group numeric,
--    originated_room_revenue_total numeric,
--    originated_room_revenue_tax numeric,
--    originated_room_revenue_transient_total numeric,
--    originated_room_revenue_transient_tax numeric,
--    originated_room_revenue_group_total numeric,
--    originated_room_revenue_group_tax numeric,
--    redemption_stay integer
--);

----
---- TOC entry 6113 (class 1259 OID 1864657)
---- Name: idx_flash_aggregate_Delta_tid_pid_date_idx; Type: INDEX; Schema: public; Owner: agilysys
----

--CREATE INDEX idx_flash_aggregate_Delta_tid_pid_date_idx ON public.flash_aggregate_Delta USING btree (tenant_id, property_id, date);


