USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[accounting_items] ;
GO

CREATE TABLE [dbo].[accounting_items](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[type] [varchar] (200) NULL,
	[alt_system_id] [varchar] (200) NULL,
	[default_price] [numeric](19, 2) NULL,
	[general_ledger_code] [varchar] (200) NULL,
	[allow_comp] [varchar](5) NULL,
	[price_look_up_code] [varchar] (200) NULL,
	[status] [varchar] (200) NULL,
	[category_id] [varchar] (200) NULL,
	[room_revenue] [varchar](5) NULL,
	[subcategory_id] [varchar] (200) NULL,
	[name] [varchar] (200) NULL,
	[code] [varchar] (200) NULL,
	[internal] [varchar](5) NULL,
	[available_count] [int] NULL,
	[max_quantity_per_reservation] [int] NULL,
	[restricted] [varchar](5) NULL,
	[tax_rate] [varchar] (200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_accounting_items_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
