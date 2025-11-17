------------------------------------------------------------------
-- guests
------------------------------------------------------------------
USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[guests] ;
GO

CREATE TABLE [dbo].[guests](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](200) NULL,
	[anonymized] [int] NULL,
	[anonymized_message] [varchar](200) NULL,
	[create_time] [datetime2](7) NULL,
	[update_time] [datetime2](7) NULL,
	[archived] [int] NULL,
	[external_profile_id] [varchar](200) NULL,
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[anniversary] [date] NULL,
	[birth_date] [date] NULL,
	[middle_initial] [varchar](200) NULL,
	[suffix] [varchar](200) NULL,
	[title] [varchar](200) NULL,
	[company_title] [varchar](200) NULL,
	[pronunciation] [varchar](200) NULL,
	[gender] [varchar](200) NULL,
	[language] [varchar](200) NULL,
	[alias] [varchar](200) NULL,
	[company_name] [varchar](200) NULL,
	[type] [varchar](200) NULL,
	[player_id] [varchar](200) NULL,
	[code] [varchar](200) NULL,
	[cms_type] [varchar](200) NULL,
	[card_id_available] [int] NULL,
	[gps_id] [varchar](200) NULL,
	[opt_in_for_marketing] [int] NULL,
	[merge_remnant] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_guests_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE TABLE public.guests (
--    id text NOT NULL,
--    tenant_id text,
--    anonymized boolean,
--    anonymized_message text,
--    create_time timestamp without time zone,
--    update_time timestamp without time zone,
--    archived boolean,
--    external_profile_id text,
--    first_name text,
--    last_name text,
--    anniversary date,
--    birth_date date,
--    middle_initial text,
--    suffix text,
--    title text,
--    company_title text,
--    pronunciation text,
--    gender text,
--    language text,
--    alias text,
--    company_name text,
--    type text,
--    player_id text,
--    code text,
--    cms_type text,
--    card_id_available boolean,
--    gps_id text,
--    opt_in_for_marketing boolean,
--    merge_remnant boolean
--);

CREATE NONCLUSTERED INDEX [IX_guests_tenant_id_create_time] ON [dbo].[guests]
(
	[tenant_id] ASC,
	[create_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_guests_tid_createdts_notanonymized ON public.guests USING btree (tenant_id, create_time) WHERE ((anonymized = false) OR (anonymized IS NULL));

CREATE NONCLUSTERED INDEX [IX_guests_tenant_id_id] ON [dbo].[guests]
(
	[tenant_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_guests_tid_id ON public.guests USING btree (tenant_id, id);

CREATE NONCLUSTERED INDEX [IX_guests_tenant_id_update_time] ON [dbo].[guests]
(
	[tenant_id] ASC,
	[update_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_guests_tid_update ON public.guests USING btree (tenant_id, update_time);
