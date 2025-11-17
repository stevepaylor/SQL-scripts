USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[deposit_policies] ;
GO

CREATE TABLE [dbo].[deposit_policies](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[policy_type] [varchar] (200) NULL,
	[code] [varchar] (200) NULL,
	[name] [varchar] (200) NULL,
	[description] [varchar] (200) NULL,
	[charge_type] [varchar] (200) NULL,
	[days] [int] NULL,
	[entire_stay] [varchar](5) NULL,
	[fixed_fee] [money] NULL,
	[percent_of_entire_stay] [money] NULL,
	[tax_included] [varchar](5) NULL,
	[active] [varchar](5) NULL,
	[subscribed_for_email_notification] [varchar](5) NULL,
	[notify_before_days] [int] NULL,
	[subscribed_for_payment_status_notification] [varchar](5) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_deposit_policies_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO