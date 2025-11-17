--CREATE TABLE public.comp_offers (
--    id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    offer_code text,
--    offer_name text,
--    authorizer_id text,
--    authorizer_code text,
--    department_id text,
--    template_id text
--);

--ADD CONSTRAINT comp_offers_pkey PRIMARY KEY (id);

--CREATE INDEX idx_tid_pid_comp_offers_id ON public.comp_offers USING btree (tenant_id, property_id, id);

--select * into StayDWH.dbo.comp_offers_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_offers LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE  IF EXISTS [dbo].[comp_offers_Snapshot] ;
GO

CREATE TABLE [dbo].[comp_offers_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[offer_code] [varchar] (200) NULL,
	[offer_name] [varchar] (200) NULL,
	[authorizer_id] [varchar] (200) NULL,
	[authorizer_code] [varchar] (200) NULL,
	[department_id] [varchar] (200) NULL,
	[template_id] [varchar] (200) NULL,
 CONSTRAINT [PK_comp_offers_Snapshot] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

