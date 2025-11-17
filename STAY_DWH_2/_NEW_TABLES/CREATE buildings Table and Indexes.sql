--CREATE TABLE public.buildings (
--    id text NOT NULL,
--    building_code text,
--    name text,
--    property_id text,
--    tenant_id text,
--    description text
--);


USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[buildings] ;
GO

CREATE TABLE [dbo].[buildings](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](10) NULL,
	[property_id] [varchar](10) NULL,
	[building_code] [varchar](200) NULL,
	[name] [varchar](200) NULL,
	[description] [varchar](200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
-- ADD CONSTRAINT buildings_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_buildings_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_buildings_tenant_id_property_id ON public.buildings USING btree (tenant_id, property_id);
CREATE NONCLUSTERED INDEX [NCIX_buildings_tenant_id_property_id] ON [dbo].[buildings]
(
	[tenant_id] ASC,
	[property_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO