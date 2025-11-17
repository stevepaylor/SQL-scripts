USE [StayDWH]
GO

DROP TABLE IF EXISTS [dbo].[flash_aggregate]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[flash_aggregate](
	[ROW_ID] [int] IDENTITY NOT NULL,

	[last_updated_at] [datetime2](7) NOT NULL,
	[date] [date] NOT NULL,
	[tenant_id] [varchar](10) NOT NULL,
	[property_id] [varchar](10) NOT NULL,
	[building_name] [varchar](30) NOT NULL,
	[room_type_code] [varchar](30) NOT NULL,
	[rate_code] [varchar](30) NOT NULL,
	[market_segment_code] [varchar](30) NOT NULL,

	[total_rooms] [int] NULL,
	[off_the_market] [int] NULL,
	[total_available_rooms] [int] NULL,
	[out_of_order] [int] NULL,
	[rentable_rooms] [int] NULL,
	[hold] [int] NULL,
	[departures_remaining_rooms] [int] NULL,
	[departures_remaining_guests] [int] NULL,
	[departures_remaining_adults] [int] NULL,
	[departures_remaining_children] [int] NULL,
	[departures_total_rooms] [int] NULL,
	[departures_total_guests] [int] NULL,
	[departures_total_adults] [int] NULL,
	[departures_total_children] [int] NULL,
	[arrivals_remaining_rooms] [int] NULL,
	[arrivals_remaining_guests] [int] NULL,
	[arrivals_remaining_adults] [int] NULL,
	[arrivals_remaining_children] [int] NULL,
	[arrivals_total_rooms] [int] NULL,
	[arrivals_total_guests] [int] NULL,
	[arrivals_total_adults] [int] NULL,
	[arrivals_total_children] [int] NULL,
	[stay_overs_rooms] [int] NULL,
	[stay_overs_guests] [int] NULL,
	[stay_overs_adults] [int] NULL,
	[stay_overs_children] [int] NULL,
	[no_show_rooms] [int] NULL,
	[no_show_guests] [int] NULL,
	[no_show_adults] [int] NULL,
	[no_show_children] [int] NULL,
	[totals_rooms] [int] NULL,
	[totals_guests] [int] NULL,
	[totals_adults] [int] NULL,
	[totals_children] [int] NULL,
	[same_day_rooms] [int] NULL,
	[same_day_guests] [int] NULL,
	[same_day_adults] [int] NULL,
	[same_day_children] [int] NULL,
	[walkin_rooms] [int] NULL,
	[walkin_guests] [int] NULL,
	[walkin_adults] [int] NULL,
	[walkin_children] [int] NULL,
	[reservations_no_rate_rooms] [int] NULL,
	[no_rate_guests] [int] NULL,
	[no_rate_adults] [int] NULL,
	[no_rate_children] [int] NULL,
	[rooms_vacant] [int] NULL,
	[rooms_sold] [int] NULL,
	[rooms_sold_guests] [int] NULL,
	[rooms_comped] [int] NULL,
	[rooms_comped_guests] [int] NULL,
	[rooms_occupied] [int] NULL,
	[rooms_occupied_guests] [int] NULL,
	[transient_rooms_sold] [int] NULL,
	[transient_rooms_sold_guests] [int] NULL,
	[group_rooms_sold] [int] NULL,
	[group_rooms_sold_guests] [int] NULL,
	[room_type_sold] [int] NULL,
	[groups_not_picked_up] [int] NULL,
	[availability_no_rate_rooms] [int] NULL,
	[room_revenue] [money] NULL,
	[room_revenue_transient] [money] NULL,
	[room_revenue_group] [money] NULL,
	[historic] [varchar](5) NULL,
	[room_revenue_total] [money] NULL,
	[room_revenue_tax] [money] NULL,
	[room_revenue_transient_total] [money] NULL,
	[room_revenue_transient_tax] [money] NULL,
	[room_revenue_group_total] [money] NULL,
	[room_revenue_group_tax] [money] NULL,
	[room_type_name] [varchar](200) NULL,
	[rate_name] [varchar](200) NULL,
	[market_segment_name] [varchar](200) NULL,
	[originated_room_revenue] [money] NULL,
	[originated_room_revenue_transient] [money] NULL,
	[originated_room_revenue_group] [money] NULL,
	[originated_room_revenue_total] [money] NULL,
	[originated_room_revenue_tax] [money] NULL,
	[originated_room_revenue_transient_total] [money] NULL,
	[originated_room_revenue_transient_tax] [money] NULL,
	[originated_room_revenue_group_total] [money] NULL,
	[originated_room_revenue_group_tax] [money] NULL,
	[redemption_stay] [int] NULL,
	[Local_ETL_Number_of_Original_Detail_Rows] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_flash_aggregate] PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_flash_aggregate_key_cols] ON [dbo].[flash_aggregate]
(
	[last_updated_at] ASC ,
	[date] ASC,
	[tenant_id] ASC,
	[property_id] ASC,
	[building_name] ASC,
	[room_type_code] ASC,
	[rate_code] ASC,
	[market_segment_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO