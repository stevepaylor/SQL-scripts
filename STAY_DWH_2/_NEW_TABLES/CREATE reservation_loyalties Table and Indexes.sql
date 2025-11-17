--CREATE TABLE public.reservation_loyalties (
--    id uuid NOT NULL,
--    reservation_id text,
--    "default" boolean,
--    program_name text,
--    member_number text,
--    tenant_id text,
--    property_id text,
--    loyalty_id text,
--    loyalty_program_name text,
--    tier text
--);

--ADD CONSTRAINT loyalty_pkey PRIMARY KEY (id);

--CREATE INDEX idx_reservation_loyalties_tid_pid_rid ON public.reservation_loyalties USING btree (tenant_id, property_id, reservation_id);

--CREATE INDEX idx_reservationloyalties_rid ON public.reservation_loyalties USING btree (reservation_id);


USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[reservation_loyalties] ;
GO

CREATE TABLE [dbo].[reservation_loyalties](
	[id] [uniqueidentifier] NOT NULL,

	[tenant_id] [varchar](10) NULL,
	[property_id] [varchar](10) NULL,
	[reservation_id] [varchar](200) NULL,
	[default] [int] NULL,
	[program_name] [varchar](200) NULL,
	[member_number] [varchar](200) NULL,
	[loyalty_id] [varchar](200) NULL,
	[loyalty_program_name] [varchar](200) NULL,
	[tier] [varchar](200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_reservation_loyalties_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_reservation_loyalties_rid ON public.reservation_loyalties USING btree (reservation_id);
CREATE NONCLUSTERED INDEX [NCIX_reservation_loyalties_reservation_id] ON [dbo].[reservation_loyalties]
(
	[reservation_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_reservation_loyalties_tid_pid_rid_date ON public.reservation_loyalties USING btree (tenant_id, property_id, reservation_id);
CREATE NONCLUSTERED INDEX [NCIX_reservation_loyalties_tenant_id_property_id_reservation_id_date] ON [dbo].[reservation_loyalties]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[reservation_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

