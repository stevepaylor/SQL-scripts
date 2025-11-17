--CREATE TABLE public.folios (
--    id text NOT NULL,
--    default_folio boolean,
--    name text,
--    property_id text,
--    tenant_id text,
--    account_id text,
--    payment_method_id text,
--    folio_type text,
--    deposit_folio boolean,
--    payment_instrument_id text
--);

--ADD CONSTRAINT folios_pkey PRIMARY KEY (id);

--CREATE INDEX idx_folios_tenant_id_property_id_account_id ON public.folios USING btree (tenant_id, property_id, account_id);

--select * into StayDWH.dbo.folios_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.folios LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[folios_Snapshot] ;
GO

CREATE TABLE [dbo].[folios_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[default_folio] [varchar](5) NULL,
	[name] [varchar] (200) NULL,
	[property_id] [varchar] (10) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[account_id] [varchar] (200) NULL,
	[payment_method_id] [varchar] (200) NULL,
	[folio_type] [varchar] (200) NULL,
	[deposit_folio] [varchar](5) NULL,
	[payment_instrument_id] [varchar] (200) NULL,
 CONSTRAINT [PK_folios_Snapshot_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



