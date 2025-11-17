USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[comps] ;
GO

DROP TABLE IF EXISTS [dbo].[comps] ;
GO

CREATE TABLE [dbo].[comps](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[active] [varchar](5) NULL,
	[code] [varchar] (200) NULL,
	[reason] [varchar] (200) NULL,
	[discount_type] [varchar] (200) NULL,
	[comment] [varchar] (200) NULL,
	[certificate_number] [varchar] (200) NULL,
	[certificate_required] [varchar](5) NULL,
	[user_id] [varchar] (200) NULL,
	[override_comment] [varchar] (200) NULL,
	[overridden_certificate_number] [varchar] (200) NULL,
	[redeemed_date] [date] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_comps__tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



