USE [StayDWH]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[properties]') AND type in (N'U'))
DROP TABLE [dbo].[properties]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[properties](
	[id] [varchar](200) NOT NULL,
	[check_in_time] [time](0) NULL,
	[checkout_time] [time](0) NULL,
	[create_time] [datetime] NULL,
	[is_deleted] [int] NULL,
	[tenant_id] [varchar](10) NULL,
	[time_zone] [varchar](200) NULL,
	[update_time] [datetime] NULL,
	[production_property] [int] NULL,
	[first_room_stay_at] [datetime] NULL,
	[first_reservation_created_at] [datetime] NULL,
	[first_room_charge_at] [datetime] NULL,
	[recent_room_stay_at] [datetime] NULL,
	[recent_room_charge_at] [datetime] NULL,
	[recent_reservation_created_at] [datetime] NULL,
	[tenant_name] [varchar](200) NULL,
	[property_name] [varchar](200) NULL,
	[tenant_code] [varchar](200) NULL,
	[property_code] [varchar](200) NULL,
	[language] [varchar](200) NULL,
	[country] [varchar](200) NULL,
	[currency_code] [varchar](200) NULL,
	[long_date_format] [varchar](200) NULL,
	[short_date_format] [varchar](200) NULL,
	[time_format] [varchar](200) NULL,
	[clock_type] [varchar](200) NULL,
	[locale_code] [int] NULL,
	[content_date_format] [varchar](200) NULL,
	[content_time_format] [varchar](200) NULL,
	[accounting_style_required] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
 CONSTRAINT [PK_properties_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_properties_tenant_id] ON [dbo].[properties]
(
	[tenant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


