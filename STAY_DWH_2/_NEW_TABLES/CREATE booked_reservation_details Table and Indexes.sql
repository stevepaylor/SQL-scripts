--CREATE TABLE public.booked_reservation_details (
--    id uuid NOT NULL,
--    date date,
--    room_type_id text,
--    rate_plan_id text,
--    rate numeric(19,2),
--    reservation_id text,
--    offer_applied boolean,
--    admin_offer boolean,
--    tenant_id text,
--    property_id text
--);

--ADD CONSTRAINT booked_reservation_details_pkey PRIMARY KEY (id);

--CREATE INDEX idx_booked_reservation_details_rid ON public.booked_reservation_details USING btree (reservation_id);

--CREATE INDEX idx_booked_reservation_details_tid_pid_rid_date ON public.booked_reservation_details USING btree (tenant_id, property_id, reservation_id, date);

USE [StayDWH]
GO

/****** Object:  Table [dbo].[booked_reservation_details]    Script Date: 5/2/2024 11:43:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[booked_reservation_details] ;
GO

CREATE TABLE [dbo].[booked_reservation_details](
	[id] [uniqueidentifier] NOT NULL,
	[tenant_id] [varchar](10) NULL,
	[property_id] [varchar](10) NULL,
	[date] [date] NULL,
	[room_type_id] [varchar](200) NULL,
	[rate_plan_id] [varchar](200) NULL,
	[reservation_id] [varchar](200) NULL,
	[offer_applied] [int] NULL,
	[admin_offer] [int] NULL,
	[rate] [money] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_booked_reservation_details_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_booked_reservation_details_rid ON public.booked_reservation_details USING btree (reservation_id);
CREATE NONCLUSTERED INDEX [NCIX_booked_reservation_details_reservation_id] ON [dbo].[booked_reservation_details]
(
	[reservation_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_booked_reservation_details_tid_pid_rid_date ON public.booked_reservation_details USING btree (tenant_id, property_id, reservation_id, date);
CREATE NONCLUSTERED INDEX [NCIX_booked_reservation_details_tenant_id_property_id_reservation_id_date] ON [dbo].[booked_reservation_details]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[reservation_id] ASC,
	[date] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

