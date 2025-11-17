USE [StayDWH]
GO

DROP TABLE IF EXISTS [dbo].[rate_snapshots]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[rate_snapshots](
	[id] [date] NOT NULL,
	[reservation_id] [varchar](200) NOT NULL,
	[adults_included] [int] NULL,
	[original_pre_occupancy_rate] [money] NULL,
	[children_included] [int] NULL,
	[date] [date] NULL,
	[extra_adult_charge] [money] NULL,
	[extra_children_charge] [money] NULL,
	[overridden] [int] NULL,
	[pre_occupancy_rate] [money] NULL,
	[property_id] [varchar](10) NULL,
	[room_type_code] [varchar](10) NULL,
	[room_type_id] [varchar](200) NULL,
	[room_type_name] [varchar](200) NULL,
	[tenant_id] [varchar](10) NULL,
	[rate_plan_id] [varchar](200) NULL,
	[transaction_item_id] [varchar](200) NULL,
	[comp_id] [varchar](200) NULL,
	[calculated_pre_occupancy_rate] [money] NULL,
	[actual_rate] [money] NULL,
	[comp_rate] [money] NULL,
	[offer_amount] [money] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
-- ADD CONSTRAINT rate_snapshot_pkey PRIMARY KEY (id, reservation_id);
) ON [PRIMARY]
GO
-- CONSTRAINT [PK_rate_snapshots_id_reservation_id] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC,
--	[reservation_id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--CREATE INDEX idx_rate_snapshots_date ON public.rate_snapshots USING btree (date);
CREATE NONCLUSTERED INDEX [IX_rate_snapshots_date] ON StayDWH.dbo.[rate_snapshots]
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_rate_snapshots_tid_pid_resid ON public.rate_snapshots USING btree (tenant_id, property_id, reservation_id);
CREATE NONCLUSTERED INDEX [IX_rate_snapshots_tenant_id_property_id_reservation_id] ON StayDWH.dbo.[rate_snapshots]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_ratesnapshots_rid_date ON public.rate_snapshots USING btree (reservation_id, date);
CREATE UNIQUE NONCLUSTERED INDEX [IX_rate_snapshots_reservation_id_date] ON StayDWH.dbo.[rate_snapshots]
(
	[reservation_id] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_ratesnapshots_tid_pid_date ON public.rate_snapshots USING btree (tenant_id, property_id, date);
CREATE NONCLUSTERED INDEX [IX_rate_snapshots_tenant_id_property_id_date] ON StayDWH.dbo.[rate_snapshots]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_ratssh_cid ON public.rate_snapshots USING btree (comp_id);
CREATE NONCLUSTERED INDEX [IX_rate_snapshots_comp_id] ON StayDWH.dbo.[rate_snapshots]
(
	[comp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

-- replaces primary key which had duplicate errors arise during load --spaylor

--CREATE INDEX idx_ratesnapshots_rid_date ON public.rate_snapshots USING btree (id, reservation_id);
CREATE UNIQUE NONCLUSTERED INDEX [IX_rate_snapshots_id_reservation_id] ON StayDWH.dbo.[rate_snapshots]
(
	[id] ASC,
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--CREATE TABLE public.rate_snapshots (
--    id text NOT NULL,
--    reservation_id text NOT NULL,
--    adults_included integer,
--    original_pre_occupancy_rate numeric(19,2),
--    children_included integer,
--    date date,
--    extra_adult_charge numeric(19,2),
--    extra_children_charge numeric(19,2),
--    overridden boolean,
--    pre_occupancy_rate numeric(19,2),
--    property_id text,
--    room_type_code text,
--    room_type_id text,
--    room_type_name text,
--    tenant_id text,
--    rate_plan_id text,
--    transaction_item_id text,
--    comp_id text,
--    calculated_pre_occupancy_rate numeric(19,2),
--    actual_rate numeric,
--    comp_rate numeric(19,2),
--    offer_amount numeric
--);
