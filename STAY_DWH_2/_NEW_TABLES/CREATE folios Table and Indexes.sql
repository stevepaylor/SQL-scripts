USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[folios] ;
GO

CREATE TABLE [dbo].[folios](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[default_folio] [varchar](5) NULL,
	[name] [varchar] (200) NULL,
	[account_id] [varchar] (200) NULL,
	[payment_method_id] [varchar] (200) NULL,
	[folio_type] [varchar] (200) NULL,
	[deposit_folio] [varchar](5) NULL,
	[payment_instrument_id] [varchar] (200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_folios_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



