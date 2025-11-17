USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[additional_guests]
GO

CREATE TABLE [dbo].[additional_guests](
	[id] [varchar](200) NOT NULL,
	[age_category_id] [varchar](200) NULL,
	[non_registered] [int] NULL,
	[name] [varchar](200) NULL,
	--[first_name] [varchar](200) NULL,
	--[last_name] [varchar](200) NULL,
	--[collated_name] [varchar](200) NULL,
	--[middle_initial] [varchar](200) NULL,
	--[suffix] [varchar](200) NULL,
	--[title] [varchar](200) NULL,
	--[primary_address_id] [varchar](200) NULL,
	--[primary_email_id] [varchar](200) NULL,
	--[primary_phone_id] [varchar](200) NULL,
	--[vip_status] [varchar](200) NULL,
	[tenant_id] [varchar](200) NULL,
	[property_id] [varchar](200) NULL,
	[reservation_id] [varchar](200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_additional_guests_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_additional_guests_tenant_id_property_id_reservation_id] ON [dbo].[additional_guests]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_additional_guests_reservation_id] ON [dbo].[additional_guests]
(
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--CREATE TABLE public.additional_guests (
--    id uuid NOT NULL,
--    age_category_id text,
--    non_registered boolean,
--    name text,
--    first_name text,
--    last_name text,
--    collated_name text,
--    middle_initial text,
--    suffix text,
--    title text,
--    primary_address_id text,
--    primary_email_id text,
--    primary_phone_id text,
--    vip_status text,
--    tenant_id text,
--    property_id text,
--    reservation_id text
--);

--ALTER TABLE ONLY public.additional_guests
--    ADD CONSTRAINT additionalguests_pkey PRIMARY KEY (id);

--CREATE INDEX idx_additional_guests_tid_pid_rid ON public.additional_guests USING btree (tenant_id, property_id, reservation_id);

--CREATE INDEX idx_additionalguests_rid ON public.additional_guests USING btree (reservation_id);


