--CREATE TABLE public.categories (
--    tenant_id text NOT NULL,
--    property_id text NOT NULL,
--    id text NOT NULL,
--    name text,
--    code text,
--    htng_description text
--);

--ADD CONSTRAINT categories_pkey PRIMARY KEY (tenant_id, property_id, id);

--select * into StayDWH.dbo.categories_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.categories LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[categories_Snapshot] ;
GO 

CREATE TABLE [dbo].[categories_Snapshot](
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[id] [varchar] (200) NOT NULL,
	[name] [varchar] (200) NULL,
	[code] [varchar] (200) NULL,
	[htng_code] [varchar] (200) NULL,
	[htng_description] [varchar] (200) NULL,
CONSTRAINT [PK_categories_Snapshot_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
