--CREATE TABLE public.comp_offer_details (
--    id text NOT NULL,
--    reservation_id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    offer_id text,
--    resolution text,
--    offer_type text,
--    offer_status text,
--    offer_date date,
--    player_id text,
--    card_id text,
--    error text
--);

--ADD CONSTRAINT comp_offer_details_pkey PRIMARY KEY (id, reservation_id);

--CREATE INDEX idx_tid_pid_offer_date_offer_type_resolution ON public.comp_offer_details USING btree (tenant_id, property_id, offer_date, offer_type, resolution);

--select * into StayDWH.dbo.comp_offer_details_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comp_offer_details LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[comp_offer_details_Snapshot] ;
GO

CREATE TABLE [dbo].[comp_offer_details_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[reservation_id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NULL,
	[property_id] [varchar] (10) NULL,
	[offer_id] [varchar] (200) NULL,
	[resolution] [varchar] (200) NULL,
	[offer_type] [varchar] (200) NULL,
	[offer_status] [varchar] (200) NULL,
	[offer_date] [date] NULL,
	[player_id] [varchar] (200) NULL,
	[card_id] [varchar] (200) NULL,
	[error] [varchar] (200) NULL,
CONSTRAINT [PK_comp_offer_details_Snapshot_id_reservation_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

