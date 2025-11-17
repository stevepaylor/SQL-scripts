	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,

CREATE NONCLUSTERED INDEX [NCIX_XXXX_tenant_id_property_id_closed] ON StayDWH.dbo.[XXXX]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[closed] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

