--CREATE TABLE public.phones (
--    id text NOT NULL,
--    reference_id text,
--    tenant_id text,
--    tech_type text,
--    number text,
--    location_type text,
--    country_access_code text,
--    city_area_code text,
--    type text,
--    extension text,
--    sms_provider text,
--    sms_notifications boolean,
--    private boolean,
--    "default" boolean
--);

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[phones] ;
GO

CREATE TABLE [dbo].[phones](
	[id] [varchar](200) NOT NULL,

	[reference_id] [varchar](200) NULL,
	[tenant_id] [varchar](10) NULL,
	[tech_type] [varchar](200) NULL,
	[number] [varchar](200) NULL,
	[location_type] [varchar](200) NULL,
	[country_access_code] [varchar](200) NULL,
	[city_area_code] [varchar](200) NULL,
	[type] [varchar](200) NULL,
	[extension] [varchar](200) NULL,
	[sms_provider] [varchar](200) NULL,
	[sms_notifications] [int] NULL,
	[private] [int] NULL,
	[default] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--ADD CONSTRAINT phone_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_phones_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_phones_refid ON public.phones USING btree (reference_id);
CREATE NONCLUSTERED INDEX [NCIX_phones_reference_id] ON [dbo].[phones]
(
	[reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_phones_tid_refid_id ON public.phones USING btree (tenant_id, reference_id, id);
CREATE NONCLUSTERED INDEX [NCIX_phones_tenant_id_reference_id] ON [dbo].[phones]
(
	[tenant_id] ASC,
	[reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

