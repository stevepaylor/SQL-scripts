--CREATE TABLE public.reservation_custom_fields (
--    id uuid NOT NULL,
--    tenant_id text,
--    property_id text,
--    reservation_id text,
--    code text,
--    "values" text[]
--);

--ADD CONSTRAINT reservation_custom_fields_pkey PRIMARY KEY (id);

--CREATE INDEX idx_reservation_custom_fields_tid_pid_resid_idx ON public.reservation_custom_fields USING btree (tenant_id, property_id, reservation_id);

--select *
--into StayDWH.dbo.reservation_custom_fields_Snapshot
--from OPENQUERY(Stay_PostgreSQL,'
--select 
--  id --text NOT NULL
--, tenant_id --text,
--, property_id --text,
--, reservation_id --text,
--, code --text,
----, "values" --text[]
--, CAST(array_to_string("values", '' , ''''*'') as varchar(200)) as "values"
--from stay_prod.public.reservation_custom_fields 
-- LIMIT 5
-- ');

USE [StayDWH]
GO

/****** Object:  Table [dbo].[reservation_custom_fields_Snapshot]    Script Date: 4/27/2024 2:29:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[reservation_custom_fields_Snapshot](
	[id] [uniqueidentifier] NOT NULL,
	[tenant_id] [text] NULL,
	[property_id] [text] NULL,
	[reservation_id] [text] NULL,
	[code] [text] NULL,
	[values] [varchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

