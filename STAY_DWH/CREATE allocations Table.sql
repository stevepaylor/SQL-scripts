USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[allocations] ;
GO 

CREATE TABLE [dbo].[allocations](
	[id] [varchar](200) NOT NULL,
	[allocation_type] [varchar](200) NULL,
	[create_time] [datetime2](7) NULL,
	[end_time] [time](0) NULL,
	[reference_id] [varchar](200) NULL,
	[property_id] [varchar](200) NULL,
	[tenant_id] [varchar](200) NULL,
	[update_time] [datetime2](7) NULL,
	[blocked_by] [varchar](200) NULL,
	[blocked_on] [datetime2](7) NULL,
	[cleared_by] [varchar](200) NULL,
	[cleared_on] [datetime2](7) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[reason] [varchar](200) NULL,
	[room_id] [varchar](200) NULL,
	[inventory_block_type] [varchar](200) NULL,
	[inventory_expiry_time] [time](0) NULL,
	[inventory_block_reason] [varchar](200) NULL,
	[maintenance_services] [varchar](100) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_allocations_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_allocations_tenant_id,_property_id_id] ON [dbo].[allocations]
(
	[id] ASC,
	[property_id] ASC,
	[tenant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_allocations_tenant_id,_property_id_room_id_allocation_type] ON [dbo].[allocations]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[room_id] ASC,
	[allocation_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--CREATE TABLE public.allocations (
--    id text NOT NULL,
--    allocation_type text,
--    create_time timestamp without time zone,
--    end_time time without time zone,
--    reference_id text,
--    property_id text,
--    tenant_id text,
--    update_time timestamp without time zone,
--    blocked_by text,
--    blocked_on timestamp without time zone,
--    cleared_by text,
--    cleared_on timestamp without time zone,
--    start_date date,
--    end_date date,
--    reason text,
--    room_id text,
--    inventory_block_type text,
--    inventory_expiry_time time without time zone,
--    inventory_block_reason text,
--    maintenance_services text[],
--);

--    ADD CONSTRAINT allocations_pkey PRIMARY KEY (id);

--CREATE INDEX idx_allocations_tid_pid_id ON public.allocations USING btree (tenant_id, property_id, id);

--CREATE INDEX idx_allocations_tid_pid_roomid_allocationtype ON public.allocations USING btree (tenant_id, property_id, room_id, allocation_type);