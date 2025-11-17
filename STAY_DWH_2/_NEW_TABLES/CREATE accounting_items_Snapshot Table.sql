--CREATE TABLE public.accounting_items (
--    tenant_id text NOT NULL,
--    property_id text NOT NULL,
--    id text NOT NULL,
--    type text,
--    alt_system_id text,
--    default_price numeric(19,2),
--    general_ledger_code text,
--    allow_comp boolean,
--    price_look_up_code text,
--    status text,
--    category_id text,
--    room_revenue boolean,
--    subcategory_id text,
--    name text,
--    code text,
--    internal boolean,
--    available_count integer,
--    max_quantity_per_reservation integer,
--    restricted boolean,
--    tax_rate text
--);

--ADD CONSTRAINT accounting_item_pkey PRIMARY KEY (tenant_id, property_id, id);

--select 'accounting_items' as [TABLE], * into StayDWH.dbo.accounting_items_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounting_items LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[accounting_items_Snapshot] ;
GO

CREATE TABLE [dbo].[accounting_items_Snapshot](
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[id] [varchar] (200) NOT NULL,
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
 CONSTRAINT [PK_accounting_items_Snapshot_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
