USE StayDWH
GO

DROP TABLE IF EXISTS dbo.accounting_dates
GO

USE StayDWH
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.[accounting_dates](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](10) NULL,
	[property_id] [varchar](10) NULL,
	[date] [date] NULL,
	[closed] [int] NULL,
	[created_by] [varchar](200) NULL,
	[created_time] [datetime] NULL,
    [Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
--ADD CONSTRAINT PK_accounting_dates_id PRIMARY KEY (id);
 CONSTRAINT [PK_accounting_dates_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX NCIX_accounting_dates_on_tenant_id_property_id_id ON STAY.accounting_dates USING btree (tenant_id, property_id, id);
CREATE NONCLUSTERED INDEX [NCIX_accounting_dates_on_id_tenant_id_property_id] ON StayDWH.dbo.[accounting_dates]
(
	[id] ASC,
	[tenant_id] ASC,
	[property_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_accountingdates_tid_pid_opened ON STAY.accounting_dates USING btree (tenant_id, property_id, closed) WHERE ((closed IS NULL) OR (closed = false));
CREATE NONCLUSTERED INDEX [NCIX_accounting_dates_tenant_id_property_id_OPEN] ON StayDWH.dbo.[accounting_dates]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[closed] ASC
)
WHERE ([closed]<>(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

----CREATE TABLE public.accounting_dates (
----    id text NOT NULL,
----    tenant_id text,
----    property_id text,
----    date date,
----    closed boolean,
----    created_by text,
----    created_time timestamp without time zone
----);
