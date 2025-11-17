--CREATE TABLE public.countries (
--    id text NOT NULL,
--    tenant_id text NOT NULL,
--    property_id text NOT NULL,
--    owner_id text,
--    name text,
--    iso_code text
--);

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[countries] ;
GO

CREATE TABLE [dbo].[countries](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](10) NOT NULL,
	[property_id] [varchar](200) NOT NULL,

	[owner_id] [varchar](200) NULL,
	[name] [varchar](200) NULL,
	[iso_code] [varchar](200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--ADD CONSTRAINT country_pkey PRIMARY KEY (id, tenant_id, property_id);
 CONSTRAINT [PK_countries_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_countries_tid_pid_ownerid ON public.countries USING btree (tenant_id, property_id, owner_id);
CREATE NONCLUSTERED INDEX [NCIX_countries_tenant_id_property_id_owner_id] ON StayDWH.dbo.[countries]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[owner_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
