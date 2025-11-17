USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[rooms]
GO

CREATE TABLE [dbo].[rooms](
	[id] [varchar](200) NOT NULL,
	[is_ada] [int] NULL,
	[last_sell] [int] NULL,
	[reset_value] [int] NULL,
	[rack_number] [int] NULL,
	[room_number] [varchar](200) NULL,
	[room_type_id] [varchar](200) NULL,
	[building_id] [varchar](200) NULL,
	[floor_id] [varchar](200) NULL,
	[create_time] [datetime] NULL,
	[property_id] [varchar](200) NULL,
	[tenant_id] [varchar](10) NULL,
	[update_time] [datetime] NULL,
	[total_days_occupied] [int] NULL,
	[housekeeping_room_condition] [varchar](200) NULL,
	[occupancy_status] [varchar](200) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[suite] [int] NULL,
	[description] [varchar](200) NULL,
	[connecting_room_ids] [varchar](1000) NULL,
	[no_of_associated_rooms] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_rooms_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- CREATE INDEX idx_rooms_tid_pid_id ON public.rooms USING btree (tenant_id, property_id, id);
CREATE UNIQUE NONCLUSTERED INDEX [IX_rooms_tenant_id_property_id_id] ON [dbo].[rooms]
(
	[tenant_id] ASC,
	property_id ASC,
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE TABLE public.rooms (
--    id text NOT NULL,
--    is_ada boolean,
--    last_sell boolean,
--    reset_value integer,
--    rack_number integer,
--    room_number text,
--    room_type_id text,
--    building_id text,
--    floor_id text,
--    create_time timestamp without time zone,
--    property_id text,
--    tenant_id text,
--    update_time timestamp without time zone,
--    total_days_occupied integer,
--    housekeeping_room_condition text,
--    occupancy_status text,
--    start_date date,
--    end_date date,
--    suite boolean DEFAULT false,
--    description text,
--    connecting_room_ids text[],
--    no_of_associated_rooms integer
--)

