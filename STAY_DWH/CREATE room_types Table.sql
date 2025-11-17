USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[room_types]
GO

CREATE TABLE [dbo].[room_types](
	[id] [varchar](200) NOT NULL,
	[name] [varchar](200) NULL,
	[type_code] [varchar](200) NULL,
	[housekeeping_pattern_id] [varchar](200) NULL,
	[is_ada] [int] NULL,
	[is_virtual] [int] NULL,
	[max_guests] [int] NULL,
	[max_pets] [int] NULL,
	[non_bedded] [int] NULL,
	[default_building_id] [varchar](200) NULL,
	[pets] [int] NULL,
	[property_id] [varchar](200) NULL,
	[room_class_id] [varchar](200) NULL,
	[tenant_id] [varchar](10) NULL,
	[description] [varchar](200) NULL,
	[smoking_allowed] [int] NULL,
	[bed_ids] [varchar](1000) NULL,
	[suite] [int] NULL,
	[is_roh] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--    ADD CONSTRAINT room_types_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_room_types_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- CREATE INDEX idx_room_types_tid_pid_id ON public.room_types USING btree (tenant_id, property_id, id);
CREATE UNIQUE NONCLUSTERED INDEX [IX_room_types_tenant_id_property_id_id] ON [dbo].[room_types]
(
	[tenant_id] ASC,
	property_id ASC,
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

----CREATE TABLE public.room_types (
----    id text NOT NULL,
----    name text,
----    type_code text,
----    housekeeping_pattern_id text,
----    is_ada boolean,
----    is_virtual boolean,
----    max_guests integer,
----    max_pets integer,
----    non_bedded boolean,
----    default_building_id text,
----    pets boolean,
----    property_id text,
----    room_class_id text,
----    tenant_id text,
----    description text,
----    smoking_allowed boolean,
----    bed_ids text[],
----    suite boolean DEFAULT false,
----    is_roh boolean
----);
