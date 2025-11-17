USE [StayDWH]
GO

--ALTER TABLE [dbo].[companies]
--ADD [local_ETL_RowHash] VARBINARY(512); -- Adjust size for your hash algorithm

-- OR OR OR

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
	[local_ETL_RowHash] [varbinary](512) NULL,
 CONSTRAINT [PK_companies] PRIMARY KEY CLUSTERED 
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







