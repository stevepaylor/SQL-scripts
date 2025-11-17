USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[comp_offer_details] ;
GO

CREATE TABLE [dbo].[comp_offer_details](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NULL,
	[property_id] [varchar] (10) NULL,
	[reservation_id] [varchar] (200) NOT NULL,
	[offer_id] [varchar] (200) NULL,
	[resolution] [varchar] (200) NULL,
	[offer_type] [varchar] (200) NULL,
	[offer_status] [varchar] (200) NULL,
	[offer_date] [date] NULL,
	[player_id] [varchar] (200) NULL,
	[card_id] [varchar] (200) NULL,
	[error] [varchar] (200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
CONSTRAINT [PK_comp_offer_details_id_reservation_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_tid_pid_offer_date_offer_type_resolution ON public.comp_offer_details USING btree (tenant_id, property_id, offer_date, offer_type, resolution);
CREATE NONCLUSTERED INDEX [NCIX_comp_offer_details_tenant_id_property_id_offer_date_offer_type_resolution] ON StayDWH.dbo.[comp_offer_details]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[offer_date] ASC,
	[offer_type] ASC,
	[resolution] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


