--CREATE TABLE public.comps (
--    id text NOT NULL,
--    active boolean,
--    code text,
--    reason text,
--    discount_type text,
--    comment text,
--    certificate_number text,
--    certificate_required boolean,
--    user_id text,
--    override_comment text,
--    overridden_certificate_number text,
--    redeemed_date date,
--    tenant_id text,
--    property_id text
--);

--ADD CONSTRAINT comps_pkey PRIMARY KEY (id);

--CREATE INDEX idx_comps_tid_pid_id ON public.comps USING btree (tenant_id, property_id, id);

--select * into StayDWH.dbo.comps_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.comps LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[comps_Snapshot] ;
GO

DROP TABLE IF EXISTS [dbo].[comps_Snapshot] ;
GO

CREATE TABLE [dbo].[comps_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[active] [varchar](5) NULL,
	[code] [varchar] (200) NULL,
	[reason] [varchar] (200) NULL,
	[discount_type] [varchar] (200) NULL,
	[comment] [varchar] (200) NULL,
	[certificate_number] [varchar] (200) NULL,
	[certificate_required] [varchar](5) NULL,
	[user_id] [varchar] (200) NULL,
	[override_comment] [varchar] (200) NULL,
	[overridden_certificate_number] [varchar] (200) NULL,
	[redeemed_date] [date] NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
 CONSTRAINT [PK_comps_Snapshot__tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



