--CREATE TABLE public.custom_field_definitions (
--    id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    code text,
--    system_generated text,
--    field_name text,
--    applicable_objects text[],
--    type text
--);

--ADD CONSTRAINT custom_field_definitions_pkey PRIMARY KEY (id);

--CREATE INDEX idx_custom_field_definitions_tid_pid_code_idx ON public.custom_field_definitions USING btree (tenant_id, property_id, code);

--select 
--*
--into StayDWH.dbo.custom_field_definitions_Snapshot
--from OPENQUERY(Stay_PostgreSQL,'
--select 
--  id --text NOT NULL
--, tenant_id --text
--, property_id --text
--, code --text
--, system_generated --text
--, field_name --text
----,  applicable_objects --text[]
--, CAST(array_to_string(applicable_objects, '' , ''''*'') as varchar(200)) as applicable_objects
--, type --text
--from stay_prod.public.custom_field_definitions 
-- LIMIT 5
-- ');

USE [StayDWH]
GO

/****** Object:  Table [dbo].[custom_field_definitions_Snapshot]    Script Date: 4/27/2024 2:15:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[custom_field_definitions_Snapshot](
	[id] [text] NOT NULL,
	[tenant_id] [text] NULL,
	[property_id] [text] NULL,
	[code] [text] NULL,
	[system_generated] [text] NULL,
	[field_name] [text] NULL,
	[applicable_objects] [varchar](200) NULL,
	[type] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



