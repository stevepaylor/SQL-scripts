------------------------------------------------------------------
-- companies
------------------------------------------------------------------
USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[companies] ;
GO

CREATE TABLE [dbo].[companies](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](200) NULL,
	[create_time] [datetime2](7) NULL,
	[update_time] [datetime2](7) NULL,
	[archived] [int] NULL,
	[external_profile_id] [varchar](200) NULL,
	[website] [varchar](200) NULL,
	[code] [varchar](200) NULL,
	[name] [varchar](200) NULL,
	[pronounced] [varchar](200) NULL,
	[merge_remnant] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_companies_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_companies_tenant_id_id] ON [dbo].[companies]
(
	[id] ASC,
	[tenant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_companies_tenant_id_update_time] ON [dbo].[companies]
(
	[tenant_id] ASC,
	[update_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



--CREATE TABLE public.companies (
--    id text NOT NULL,
--    tenant_id text,
--    create_time timestamp without time zone,
--    update_time timestamp without time zone,
--    archived boolean,
--    external_profile_id text,
--    website text,
--    code text,
--    name text,
--    pronounced text,
--    merge_remnant boolean
--);

--ADD CONSTRAINT company_pkey PRIMARY KEY (id);

--CREATE INDEX idx_companies_tid_id ON public.companies USING btree (tenant_id, id);

--CREATE INDEX idx_companies_tid_update ON public.companies USING btree (tenant_id, update_time);
