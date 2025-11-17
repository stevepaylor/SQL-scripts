USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[cancellation_policies] ;
GO

CREATE TABLE [dbo].[cancellation_policies](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[code] [varchar] (200) NULL,
	[accounting_item_id] [varchar] (200) NULL,
	[description] [varchar] (200) NULL,
	[days_before_arrival] [int] NULL,
	[days_after_booking] [int] NULL,
	[arrival_time] [int] NULL,
	[flat_fee] [money] NULL,
	[percentage] [money] NULL,
	[nights] [int] NULL,
	[match_deposit_policy] [varchar](5) NULL,
	[tax_inclusive] [varchar](5) NULL,
	[active] [varchar](5) NULL,
	[policy_type] [varchar] (200) NULL,
	[reference_id] [varchar] (200) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_cancellation_policies_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
