--CREATE TABLE public.addresses (
--    id text NOT NULL,
--    reference_id text,
--    tenant_id text,
--    type text,
--    line1 text,
--    line2 text,
--    line3 text,
--    line4 text,
--    line5 text,
--    city text,
--    postal_code text,
--    country text,
--    county text,
--    state text,
--    private boolean,
--    "default" boolean
--);

--ADD CONSTRAINT address_pkey PRIMARY KEY (id);

--CREATE INDEX idx_addresses_refid ON public.addresses USING btree (reference_id);

--CREATE INDEX idx_addresses_tid_refid_id ON public.addresses USING btree (tenant_id, reference_id, id);

USE [StayDWH]
GO

DROP TABLE IF EXISTS [dbo].[addresses] ;
GO

CREATE TABLE [dbo].[addresses](
	[id] [varchar](200) NOT NULL,

	[reference_id] [varchar](200) NULL,
	[tenant_id] [varchar](10) NULL,
	[type] [varchar](200) NULL,
	[line1] [varchar](200) NULL,
	[line2] [varchar](200) NULL,
	[line3] [varchar](200) NULL,
	[line4] [varchar](200) NULL,
	[line5] [varchar](200) NULL,
	[city] [varchar](200) NULL,
	[postal_code] [varchar](200) NULL,
	[country] [varchar](200) NULL,
	[county] [varchar](200) NULL,
	[state] [varchar](200) NULL,
	[private] [int] NULL,
	[default] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--ADD CONSTRAINT address_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_addresses_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_addresses_refid ON public.addresses USING btree (reference_id);
CREATE NONCLUSTERED INDEX [NCIX_addresses_reference_id] ON [dbo].[addresses]
(
	[reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_addresses_tid_refid_id ON public.addresses USING btree (tenant_id, reference_id, id);
CREATE NONCLUSTERED INDEX [NCIX_addresses_tenant_id_reference_id] ON [dbo].[addresses]
(
	[tenant_id] ASC,
	[reference_id] ASC,
	[id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO