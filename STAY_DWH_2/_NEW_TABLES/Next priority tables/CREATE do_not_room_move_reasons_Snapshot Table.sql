--CREATE TABLE public.do_not_room_move_reasons (
--    id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    code text,
--    reason text,
--    description text,
--    active boolean,
--    property_inactivation boolean,
--    excluded_properties text[],
--    deleted boolean
--);

--ADD CONSTRAINT do_not_room_move_reasons_pkey PRIMARY KEY (id);

--CREATE INDEX idx_do_not_room_move_reasons_tid_pid_id ON public.do_not_room_move_reasons USING btree (tenant_id, property_id, id);

--select *
--into StayDWH.dbo.do_not_room_move_reasons_Snapshot
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
----, excluded_properties --text[],
--, CAST(array_to_string(excluded_properties, '' , ''''*'') as varchar(200)) as excluded_properties
--,  deleted --boolean
--from stay_prod.public.do_not_room_move_reasons 
-- LIMIT 5
-- ');

USE [StayDWH]
GO

/****** Object:  Table [dbo].[do_not_room_move_reasons_Snapshot]    Script Date: 4/27/2024 2:34:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[do_not_room_move_reasons_Snapshot](
	[id] [text] NOT NULL,
	[tenant_id] [text] NULL,
	[property_id] [text] NULL,
	[code] [text] NULL,
	[reason] [text] NULL,
	[description] [text] NULL,
	[active] [varchar](5) NULL,
	[property_inactivation] [varchar](5) NULL,
	[excluded_properties] [varchar](200) NULL,
	[deleted] [varchar](5) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



