--CREATE TABLE public.shared_reservations (
--    id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    room_type_id text,
--    room_id text,
--    earliest_arrival date,
--    latest_departure date,
--    reservation_ids text[]
--);

--ADD CONSTRAINT shared_reservations_pkey PRIMARY KEY (id);

--CREATE INDEX idx_shared_reservations_tid_pid_id ON public.shared_reservations USING btree (tenant_id, property_id, id);

--select 
--*
--into StayDWH.dbo.shared_reservations_Snapshot
--from OPENQUERY(Stay_PostgreSQL,'
--select 
--  id --text NOT NULL
--, tenant_id --text,
--, property_id --text,
--, room_type_id --text,
--, room_id --text,
--, earliest_arrival --date,
--, latest_departure --date,
----, reservation_ids --text[]
--, CAST(array_to_string(reservation_ids, '' , ''''*'') as varchar(200)) as reservation_ids
--from stay_prod.public.shared_reservations 
-- LIMIT 5
-- ');

USE [StayDWH]
GO

/****** Object:  Table [dbo].[shared_reservations_Snapshot]    Script Date: 4/27/2024 2:19:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[shared_reservations_Snapshot](
	[id] [text] NOT NULL,
	[tenant_id] [text] NULL,
	[property_id] [text] NULL,
	[room_type_id] [text] NULL,
	[room_id] [text] NULL,
	[earliest_arrival] [date] NULL,
	[latest_departure] [date] NULL,
	[reservation_ids] [varchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

