USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--CREATE OR ALTER PROCEDURE [dbo].[usp_Load_flash_aggregate_Delta]
--AS

DROP TABLE IF EXISTS dbo.flash_aggregate_Delta ;

SELECT DISTINCT
  CAST([last_updated_at] as [datetime2]) as  [last_updated_at] -- NOT NULL

, CAST([date] as [date]) as [date]--NOT NULL - PK
, CAST(isnull([tenant_id], 'NULL') as varchar(10)) as [tenant_id] --NOT NULL - PK
, CAST(isnull([property_id], 'NULL') as varchar(10)) as [property_id] --NOT NULL - PK
, CAST(isnull([building_name], 'NULL') as varchar(30)) as [building_name] --NOT NULL - PK
, CAST(isnull([room_type_code], 'NULL') as varchar(30)) as [room_type_code] --NOT NULL - PK
, CAST(isnull([rate_code], 'NULL') as varchar(30)) as [rate_code] --NOT NULL - PK
, CAST(isnull([market_segment_code], 'NULL') as varchar(30)) as [market_segment_code] --NOT NULL - PK

, CAST([total_rooms] as [int]) as  [total_rooms]
, CAST([off_the_market] as [int]) as  [off_the_market]
, CAST([total_available_rooms] as [int]) as  [total_available_rooms]
, CAST([out_of_order] as [int]) as  [out_of_order]
, CAST([rentable_rooms] as [int]) as  [rentable_rooms]
, CAST([hold] as [int]) as  [hold]
, CAST([departures_remaining_rooms] as [int]) as  [departures_remaining_rooms]
, CAST([departures_remaining_guests] as [int]) as  [departures_remaining_guests]
, CAST([departures_remaining_adults] as [int]) as  [departures_remaining_adults]
, CAST([departures_remaining_children] as [int]) as  [departures_remaining_children]
, CAST([departures_total_rooms] as [int]) as  [departures_total_rooms]
, CAST([departures_total_guests] as [int]) as  [departures_total_guests]
, CAST([departures_total_adults] as [int]) as  [departures_total_adults]
, CAST([departures_total_children] as [int]) as  [departures_total_children]
, CAST([arrivals_remaining_rooms] as [int]) as  [arrivals_remaining_rooms]
, CAST([arrivals_remaining_guests] as [int]) as  [arrivals_remaining_guests]
, CAST([arrivals_remaining_adults] as [int]) as  [arrivals_remaining_adults]
, CAST([arrivals_remaining_children] as [int]) as  [arrivals_remaining_children]
, CAST([arrivals_total_rooms] as [int]) as  [arrivals_total_rooms]
, CAST([arrivals_total_guests] as [int]) as  [arrivals_total_guests]
, CAST([arrivals_total_adults] as [int]) as  [arrivals_total_adults]
, CAST([arrivals_total_children] as [int]) as  [arrivals_total_children]
, CAST([stay_overs_rooms] as [int]) as  [stay_overs_rooms]
, CAST([stay_overs_guests] as [int]) as  [stay_overs_guests]
, CAST([stay_overs_adults] as [int]) as  [stay_overs_adults]
, CAST([stay_overs_children] as [int]) as  [stay_overs_children]
, CAST([no_show_rooms] as [int]) as  [no_show_rooms]
, CAST([no_show_guests] as [int]) as  [no_show_guests]
, CAST([no_show_adults] as [int]) as  [no_show_adults]
, CAST([no_show_children] as [int]) as  [no_show_children]
, CAST([totals_rooms] as [int]) as  [totals_rooms]
, CAST([totals_guests] as [int]) as  [totals_guests]
, CAST([totals_adults] as [int]) as  [totals_adults]
, CAST([totals_children] as [int]) as  [totals_children]
, CAST([same_day_rooms] as [int]) as  [same_day_rooms]
, CAST([same_day_guests] as [int]) as  [same_day_guests]
, CAST([same_day_adults] as [int]) as  [same_day_adults]
, CAST([same_day_children] as [int]) as  [same_day_children]
, CAST([walkin_rooms] as [int]) as  [walkin_rooms]
, CAST([walkin_guests] as [int]) as  [walkin_guests]
, CAST([walkin_adults] as [int]) as  [walkin_adults]
, CAST([walkin_children] as [int]) as  [walkin_children]
, CAST([reservations_no_rate_rooms] as [int]) as  [reservations_no_rate_rooms]
, CAST([no_rate_guests] as [int]) as  [no_rate_guests]
, CAST([no_rate_adults] as [int]) as  [no_rate_adults]
, CAST([no_rate_children] as [int]) as  [no_rate_children]
, CAST([rooms_vacant] as [int]) as  [rooms_vacant]
, CAST([rooms_sold] as [int]) as  [rooms_sold]
, CAST([rooms_sold_guests] as [int]) as  [rooms_sold_guests]
, CAST([rooms_comped] as [int]) as  [rooms_comped]
, CAST([rooms_comped_guests] as [int]) as  [rooms_comped_guests]
, CAST([rooms_occupied] as [int]) as  [rooms_occupied]
, CAST([rooms_occupied_guests] as [int]) as  [rooms_occupied_guests]
, CAST([transient_rooms_sold] as [int]) as  [transient_rooms_sold]
, CAST([transient_rooms_sold_guests] as [int]) as  [transient_rooms_sold_guests]
, CAST([group_rooms_sold] as [int]) as  [group_rooms_sold]
, CAST([group_rooms_sold_guests] as [int]) as  [group_rooms_sold_guests]
, CAST([room_type_sold] as [int]) as  [room_type_sold]
, CAST([groups_not_picked_up] as [int]) as  [groups_not_picked_up]
, CAST([availability_no_rate_rooms] as [int]) as  [availability_no_rate_rooms]
, CAST([room_revenue] as [money]) as  [room_revenue]
, CAST([room_revenue_transient] as [money]) as  [room_revenue_transient]
, CAST([room_revenue_group] as [money]) as  [room_revenue_group]
--, CAST([last_updated_at] as [datetime]) as  [last_updated_at]
, CAST([historic] as [varchar] (5)) as  [historic]
, CAST([room_revenue_total] as [money]) as  [room_revenue_total]
, CAST([room_revenue_tax] as [money]) as  [room_revenue_tax]
, CAST([room_revenue_transient_total] as [money]) as  [room_revenue_transient_total]
, CAST([room_revenue_transient_tax] as [money]) as  [room_revenue_transient_tax]
, CAST([room_revenue_group_total] as [money]) as  [room_revenue_group_total]
, CAST([room_revenue_group_tax] as [money]) as  [room_revenue_group_tax]
, CAST([room_type_name] as [varchar] (200)) as  [room_type_name]
--, CAST([room_type_code] as [varchar] (200)) as  [room_type_code]
--, CAST([rate_code] as [varchar] (200)) as  [rate_code]
, CAST([rate_name] as [varchar] (200)) as  [rate_name]
, CAST([market_segment_name] as [varchar] (200)) as  [market_segment_name]
--, CAST([market_segment_code] as [varchar] (200)) as  [market_segment_code]
, CAST([originated_room_revenue] as [money]) as  [originated_room_revenue]
, CAST([originated_room_revenue_transient] as [money]) as  [originated_room_revenue_transient]
, CAST([originated_room_revenue_group] as [money]) as  [originated_room_revenue_group]
, CAST([originated_room_revenue_total] as [money]) as  [originated_room_revenue_total]
, CAST([originated_room_revenue_tax] as [money]) as  [originated_room_revenue_tax]
, CAST([originated_room_revenue_transient_total] as [money]) as  [originated_room_revenue_transient_total]
, CAST([originated_room_revenue_transient_tax] as [money]) as  [originated_room_revenue_transient_tax]
, CAST([originated_room_revenue_group_total] as [money]) as  [originated_room_revenue_group_total]
, CAST([originated_room_revenue_group_tax] as [money]) as  [originated_room_revenue_group_tax]
, CAST([redemption_stay] as [int]) as  [redemption_stay]

INTO dbo.flash_aggregate_Delta

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT DISTINCT 
  last_updated_at --timestamp with time zone

, date --date
, tenant_id --text
, property_id --text
, building_name --text
, room_type_code --text
, rate_code --text
, market_segment_code --text

, total_rooms --integer
, off_the_market --integer
, total_available_rooms --integer
, out_of_order --integer
, rentable_rooms --integer
, hold --integer
, departures_remaining_rooms --integer
, departures_remaining_guests --integer
, departures_remaining_adults --integer
, departures_remaining_children --integer
, departures_total_rooms --integer
, departures_total_guests --integer
, departures_total_adults --integer
, departures_total_children --integer
, arrivals_remaining_rooms --integer
, arrivals_remaining_guests --integer
, arrivals_remaining_adults --integer
, arrivals_remaining_children --integer
, arrivals_total_rooms --integer
, arrivals_total_guests --integer
, arrivals_total_adults --integer
, arrivals_total_children --integer
, stay_overs_rooms --integer
, stay_overs_guests --integer
, stay_overs_adults --integer
, stay_overs_children --integer
, no_show_rooms --integer
, no_show_guests --integer
, no_show_adults --integer
, no_show_children --integer
, totals_rooms --integer
, totals_guests --integer
, totals_adults --integer
, totals_children --integer
, same_day_rooms --integer
, same_day_guests --integer
, same_day_adults --integer
, same_day_children --integer
, walkin_rooms --integer
, walkin_guests --integer
, walkin_adults --integer
, walkin_children --integer
, reservations_no_rate_rooms --integer
, no_rate_guests --integer
, no_rate_adults --integer
, no_rate_children --integer
, rooms_vacant --integer
, rooms_sold --integer
, rooms_sold_guests --integer
, rooms_comped --integer
, rooms_comped_guests --integer
, rooms_occupied --integer
, rooms_occupied_guests --integer
, transient_rooms_sold --integer
, transient_rooms_sold_guests --integer
, group_rooms_sold --integer
, group_rooms_sold_guests --integer
, room_type_sold --integer
, groups_not_picked_up --integer
, availability_no_rate_rooms --integer
, room_revenue --numeric(19,2)
, room_revenue_transient --numeric(19,2)
, room_revenue_group --numeric(19,2)
--, last_updated_at --timestamp with time zone
, historic --boolean,
, room_revenue_total --numeric
, room_revenue_tax --numeric
, room_revenue_transient_total --numeric
, room_revenue_transient_tax --numeric
, room_revenue_group_total --numeric
, room_revenue_group_tax --numeric
, room_type_name --text
--, room_type_code --text
--, rate_code --text
, rate_name --text
, market_segment_name --text
--, market_segment_code --text
, originated_room_revenue --numeric
, originated_room_revenue_transient --numeric
, originated_room_revenue_group --numeric
, originated_room_revenue_total --numeric
, originated_room_revenue_tax --numeric
, originated_room_revenue_transient_total --numeric
, originated_room_revenue_transient_tax --numeric
, originated_room_revenue_group_total --numeric
, originated_room_revenue_group_tax --numeric
, redemption_stay --integer

FROM public.flash_aggregate

WHERE last_updated_at >= current_timestamp - interval ''2 hours''
  AND last_updated_at IS NOT NULL

--WHERE last_updated_at IS NOT NULL

ORDER BY
  last_updated_at 
, date
, tenant_id
, property_id
, building_name
, room_type_code
, rate_code
, market_segment_code
'
) 

ORDER BY
  [last_updated_at]
, [date]
, [tenant_id]
, [property_id]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code] ;

--(84493 rows affected)
--(84493 rows affected)
--(4180 rows affected)

----------------------------------------------------------------------------------------
-- Insert delta data into perm table 
----------------------------------------------------------------------------------------
INSERT INTO dbo.flash_aggregate
SELECT DISTINCT
  [last_updated_at] 

, [date]
, [tenant_id]
, [property_id]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code]

, [total_rooms]
, [off_the_market]
, [total_available_rooms]
, [out_of_order]
, [rentable_rooms]
, [hold]
, [departures_remaining_rooms]
, [departures_remaining_guests]
, [departures_remaining_adults]
, [departures_remaining_children]
, [departures_total_rooms]
, [departures_total_guests]
, [departures_total_adults]
, [departures_total_children]
, [arrivals_remaining_rooms]
, [arrivals_remaining_guests]
, [arrivals_remaining_adults]
, [arrivals_remaining_children]
, [arrivals_total_rooms]
, [arrivals_total_guests]
, [arrivals_total_adults]
, [arrivals_total_children]
, [stay_overs_rooms]
, [stay_overs_guests]
, [stay_overs_adults]
, [stay_overs_children]
, [no_show_rooms]
, [no_show_guests]
, [no_show_adults]
, [no_show_children]
, [totals_rooms]
, [totals_guests]
, [totals_adults]
, [totals_children]
, [same_day_rooms]
, [same_day_guests]
, [same_day_adults]
, [same_day_children]
, [walkin_rooms]
, [walkin_guests]
, [walkin_adults]
, [walkin_children]
, [reservations_no_rate_rooms]
, [no_rate_guests]
, [no_rate_adults]
, [no_rate_children]
, [rooms_vacant]
, [rooms_sold]
, [rooms_sold_guests]
, [rooms_comped]
, [rooms_comped_guests]
, [rooms_occupied]
, [rooms_occupied_guests]
, [transient_rooms_sold]
, [transient_rooms_sold_guests]
, [group_rooms_sold]
, [group_rooms_sold_guests]
, [room_type_sold]
, [groups_not_picked_up]
, [availability_no_rate_rooms]
, [room_revenue]
, [room_revenue_transient]
, [room_revenue_group]
, [historic]
, [room_revenue_total]
, [room_revenue_tax]
, [room_revenue_transient_total]
, [room_revenue_transient_tax]
, [room_revenue_group_total]
, [room_revenue_group_tax]
, [room_type_name]
, [rate_name]
, [market_segment_name]
, [originated_room_revenue]
, [originated_room_revenue_transient]
, [originated_room_revenue_group]
, [originated_room_revenue_total]
, [originated_room_revenue_tax]
, [originated_room_revenue_transient_total]
, [originated_room_revenue_transient_tax]
, [originated_room_revenue_group_total]
, [originated_room_revenue_group_tax]
, [redemption_stay]
, 1 as [Local_ETL_Number_of_Original_Detail_Rows]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM [StayDWH].[dbo].[flash_aggregate_Delta]

WHERE [last_updated_at] > (SELECT MAX([last_updated_at]) FROM [StayDWH].[dbo].[flash_aggregate]) ;

--(84493 rows affected)
--(0 rows affected)
--(0 rows affected)

DROP TABLE IF EXISTS dbo.flash_aggregate_Delta ;