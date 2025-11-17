USE [StayDWH]
GO

DROP TABLE IF EXISTS [dbo].[availability]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[availability](
	[id] [varchar](200) NOT NULL,
	[allocation_id] [varchar](200) NULL,
	[date] [date] NULL,
	[group_id] [varchar](200) NULL,
	[room_type_id] [varchar](200) NULL,
	[room_id] [varchar](200) NULL,
	[tenant_id] [varchar](10) NULL,
	[property_id] [varchar](10) NULL,
	[departed] [int] NULL,
	[departure] [int] NULL,
	[not_arrived] [int] NULL,
	[hold] [int] NULL,
	[out_of_order] [int] NULL,
	[off_the_market] [int] NULL,
	[pickup] [int] NULL,
	[sold] [int] NULL,
	[suite_component] [int] NULL,
	[previous_room_type_id] [varchar](200) NULL,
	[scheduled_room_move_status] [varchar](200) NULL,
	[scheduled_by] [varchar](200) NULL,
	[soft_block] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
-- ADD CONSTRAINT availability_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_availability_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


--CREATE INDEX idx_availability_allocationid_date ON public.availability USING btree (allocation_id, date);
CREATE NONCLUSTERED INDEX [IX_availability_allocation_id_date] ON StayDWH.dbo.[availability]
(
	[allocation_id] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_availability_date ON public.availability USING btree (date);
CREATE NONCLUSTERED INDEX [IX_availability_date] ON StayDWH.dbo.[availability]
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--CREATE INDEX idx_availability_tenant_id_property_id_allocation_id ON public.availability USING btree (tenant_id, property_id, allocation_id);
CREATE NONCLUSTERED INDEX [IX_availability_tenant_id_property_id_allocation_id] ON StayDWH.dbo.[availability]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[allocation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

----CREATE INDEX idx_tid_pid_date ON public.availability USING btree (tenant_id, property_id, date);
CREATE NONCLUSTERED INDEX [IX_availability_tenant_id_property_id_date] ON StayDWH.dbo.[availability]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO