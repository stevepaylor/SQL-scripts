------------------------------------------------------------------
-- vip_statuses
------------------------------------------------------------------
USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[vip_statuses] ;
GO

CREATE TABLE [dbo].[vip_statuses](
	[id] [varchar](200) NOT NULL,
	[active] [int] NULL,
	[code] [varchar](200) NULL,
	[description] [varchar](200) NULL,
	[name] [varchar](200) NULL,
	[property_id] [varchar](200) NULL,
	[tenant_id] [varchar](200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_vip_statuses_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE TABLE public.vip_statuses (
--    id text NOT NULL,
--    active boolean,
--    code text,
--    description text,
--    name text,
--    property_id text,
--    tenant_id text
--);

--ADD CONSTRAINT vip_statuses_pkey PRIMARY KEY (id);

CREATE NONCLUSTERED INDEX [IX_vip_statuses_tenant_id_property_id_id] ON [dbo].[vip_statuses]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
--CREATE INDEX idx_vip_statuses_tid_pid_id ON public.vip_statuses USING btree (tenant_id, property_id, id);