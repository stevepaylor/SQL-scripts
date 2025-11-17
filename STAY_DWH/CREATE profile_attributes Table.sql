USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[profile_attributes] ;
GO

CREATE TABLE [dbo].[profile_attributes](
	[tenant_id] [varchar](200) NOT NULL,
	[property_id] [varchar](200) NOT NULL,
	[reference_id] [varchar](200) NOT NULL,
	[vip_status_id] [varchar](200) NULL,
	[rate_plan_id] [varchar](200) NULL,
	[account_id] [varchar](200) NULL,
	[room_feature_ids] [varchar](200) NULL,
	[guest_preference_ids] [varchar](200) NULL,
	[linked_contact_id] [varchar](200) NULL,
	[id] [varchar](200) NOT NULL,
	[Local_ETL_Inserted_TS] [datetime] NOT NULL,
	[Local_ETL_Updated_TS] [datetime] NOT NULL,
CONSTRAINT [PK_profile_attributes_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_profile_attributes_tenant_id_property_id_id] ON [dbo].[profile_attributes]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_profile_attributes_reference_id] ON [dbo].[profile_attributes]
(
	[reference_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE TABLE public.profile_attributes (
--    tenant_id text,
--    property_id text,
--    reference_id text,
--    vip_status_id text,
--    rate_plan_id text,
--    account_id text,
--    room_feature_ids text[],
--    guest_preference_ids text[],
--    linked_contact_id text,
--    id text NOT NULL
--);

--ADD CONSTRAINT profileattributes_pkey PRIMARY KEY (id);

--CREATE INDEX idx_profileattributes_rid ON public.profile_attributes USING btree (reference_id);

--CREATE INDEX idx_profileattributes_tid_pid_rid ON public.profile_attributes USING btree (tenant_id, property_id, reference_id);
