--CREATE TABLE public.inventory_block_maintenance_req_reasons (
--    id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    code text,
--    reason text,
--    description text,
--    active boolean,
--    property_inactivation boolean,
--    deleted boolean,
--    excluded_properties text[],
--    maintenance_services text[],
--    out_of_order boolean,
--    of_the_market boolean,
--    on_hold boolean
--);

--ADD CONSTRAINT inventory_block_maintenance_req_reasons_pkey PRIMARY KEY (id);

--CREATE INDEX idx_inventory_block_maintenance_req_reasons_tid_pid_id ON public.inventory_block_maintenance_req_reasons USING btree (tenant_id, property_id, id);

--select  *
--into StayDWH.dbo.inventory_block_maintenance_req_reasons_Snapshot
--from OPENQUERY(Stay_PostgreSQL,'
--select 
--  id --text NOT NULL
--, tenant_id --text,
--, property_id --text,
--, code --text,
--, reason --text,
--, description --text,
--, active --boolean,
--, property_inactivation --boolean,
--, deleted --boolean,
----, excluded_properties --text[],
--, CAST(array_to_string(excluded_properties, '' , ''''*'') as varchar(200)) as excluded_properties
----, maintenance_services -text[],
--, CAST(array_to_string(maintenance_services, '' , ''''*'') as varchar(200)) as maintenance_services
--, out_of_order --boolean,
--, of_the_market --boolean,
--, on_hold --boolean
--from stay_prod.public.inventory_block_maintenance_req_reasons 
-- LIMIT 5
-- ');

USE [StayDWH]
GO

/****** Object:  Table [dbo].[inventory_block_maintenance_req_reasons_Snapshot]    Script Date: 4/27/2024 2:37:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[inventory_block_maintenance_req_reasons_Snapshot](
	[id] [text] NOT NULL,
	[tenant_id] [text] NULL,
	[property_id] [text] NULL,
	[code] [text] NULL,
	[reason] [text] NULL,
	[description] [text] NULL,
	[active] [varchar](5) NULL,
	[property_inactivation] [varchar](5) NULL,
	[deleted] [varchar](5) NULL,
	[excluded_properties] [varchar](200) NULL,
	[maintenance_services] [varchar](200) NULL,
	[out_of_order] [varchar](5) NULL,
	[of_the_market] [varchar](5) NULL,
	[on_hold] [varchar](5) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

