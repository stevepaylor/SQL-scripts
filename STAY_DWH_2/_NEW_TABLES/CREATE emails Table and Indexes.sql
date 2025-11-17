--CREATE TABLE public.emails (
--    id text NOT NULL,
--    reference_id text,
--    tenant_id text,
--    value text,
--    type text,
--    private boolean,
--    "default" boolean
--);


USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[emails] ;
GO

CREATE TABLE [dbo].[emails](
	[id] [varchar](200) NOT NULL,
	[reference_id] [varchar](200) NULL,
	[tenant_id] [varchar](10) NULL,
	[value] [varchar](200) NULL,
	[type] [varchar](200) NULL,
	[private] [int] NULL,
	[default] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
-- ADD CONSTRAINT emails_pkey PRIMARY KEY (id);
 CONSTRAINT [PK_emails_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_emails_refid ON public.emails USING btree (reference_id);
CREATE NONCLUSTERED INDEX [NCIX_emails_reference_id] ON [dbo].[emails]
(
	[reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_emails_tid_refid_id ON public.emails USING btree (tenant_id, reference_id, id);
CREATE NONCLUSTERED INDEX [NCIX_emails_tenant_id_reference_id] ON [dbo].[emails]
(
	[tenant_id] ASC,
	[reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
