USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS dbo.usp_Load_Delta_rooms ;
GO

CREATE PROCEDURE [dbo].[usp_Load_Delta_rooms]
AS

DROP TABLE IF EXISTS dbo.rooms_Delta ;

SELECT
  [id]
, [is_ada]
, [last_sell]
, [reset_value]
, [rack_number]
, [room_number]
, [room_type_id]
, [building_id]
, [floor_id]
, CAST([create_time] as datetime) as create_time
, [property_id]
, [tenant_id]
, CAST([update_time] as datetime) as update_time
, [total_days_occupied]
, [housekeeping_room_condition]
, [occupancy_status]
, [start_date]
, [end_date]
, [suite]
, [description]
, [connecting_room_ids]
, [no_of_associated_rooms]

INTO dbo.rooms_Delta

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(is_ada as int) as is_ada --boolean
, CAST(last_sell as int) as last_sell --boolean
, reset_value --integer
, rack_number --integer
, CAST(room_number as varchar(200)) as room_number --text
, CAST(room_type_id as varchar(200)) as room_type_id --text
, CAST(building_id as varchar(200)) as building_id --text
, CAST(floor_id as varchar(200)) as floor_id --text
, create_time --timestamp without time zone
, CAST(property_id as varchar(200)) as property_id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, update_time --timestamp without time zone
, total_days_occupied --integer
, CAST(housekeeping_room_condition as varchar(200)) as housekeeping_room_condition --text
, CAST(occupancy_status as varchar(200)) as occupancy_status --text
, CAST(start_date as date) as start_date --date
, CAST(end_date as date) as end_date --date
, CAST(suite as int) as suite --boolean
, CAST(description as varchar(200)) as description --text
, CAST(array_to_string(connecting_room_ids, '' , ''''*'') as varchar(1000)) as connecting_room_ids --text[]
, no_of_associated_rooms --integer

FROM public.rooms

WHERE create_time >= current_timestamp - interval ''2 hours''
   OR update_time >= current_timestamp - interval ''2 hours'''
) ;

----------------------------------------------------------------------------------------
-- Merge delta data into perm table
----------------------------------------------------------------------------------------

MERGE dbo.rooms AS [target]
USING dbo.rooms_Delta AS delta
ON [target].[id] = delta.[id]
WHEN MATCHED 
AND (   [target].[is_ada] <> delta.[is_ada]
     OR [target].[last_sell] <> delta.[last_sell]
     OR [target].[reset_value] <> delta.[reset_value]
     OR [target].[rack_number] <> delta.[rack_number]
     OR [target].[room_number] <> delta.[room_number]
     OR [target].[room_type_id] <> delta.[room_type_id]
     OR [target].[building_id] <> delta.[building_id]
     OR [target].[floor_id] <> delta.[floor_id]
     OR [target].[create_time] <> delta.[create_time]
     OR [target].[property_id] <> delta.[property_id]
     OR [target].[tenant_id] <> delta.[tenant_id]
     OR [target].[update_time] <> delta.[update_time]
     OR [target].[total_days_occupied] <> delta.[total_days_occupied]
     OR [target].[housekeeping_room_condition] <> delta.[housekeeping_room_condition]
     OR [target].[occupancy_status] <> delta.[occupancy_status]
     OR [target].[start_date] <> delta.[start_date]
     OR [target].[end_date] <> delta.[end_date]
     OR [target].[suite] <> delta.[suite]
     OR [target].[description] <> delta.[description]
     OR [target].[connecting_room_ids] <> delta.[connecting_room_ids]
	)
THEN UPDATE SET
  [target].[id] = delta.[id]
, [target].[is_ada] = delta.[is_ada]
, [target].[last_sell] = delta.[last_sell]
, [target].[reset_value] = delta.[reset_value]
, [target].[rack_number] = delta.[rack_number]
, [target].[room_number] = delta.[room_number]
, [target].[room_type_id] = delta.[room_type_id]
, [target].[building_id] = delta.[building_id]
, [target].[floor_id] = delta.[floor_id]
, [target].[create_time] = delta.[create_time]
, [target].[property_id] = delta.[property_id]
, [target].[tenant_id] = delta.[tenant_id]
, [target].[update_time] = delta.[update_time]
, [target].[total_days_occupied] = delta.[total_days_occupied]
, [target].[housekeeping_room_condition] = delta.[housekeeping_room_condition]
, [target].[occupancy_status] = delta.[occupancy_status]
, [target].[start_date] = delta.[start_date]
, [target].[end_date] = delta.[end_date]
, [target].[suite] = delta.[suite]
, [target].[description] = delta.[description]
, [target].[connecting_room_ids] = delta.[connecting_room_ids]
, [target].[no_of_associated_rooms] = delta.[no_of_associated_rooms]
, [target].Local_ETL_Updated_TS = CURRENT_TIMESTAMP

WHEN NOT MATCHED THEN INSERT 
( 
  [id]
, [is_ada]
, [last_sell]
, [reset_value]
, [rack_number]
, [room_number]
, [room_type_id]
, [building_id]
, [floor_id]
, [create_time]
, [property_id]
, [tenant_id]
, [update_time]
, [total_days_occupied]
, [housekeeping_room_condition]
, [occupancy_status]
, [start_date]
, [end_date]
, [suite]
, [description]
, [connecting_room_ids]
, [no_of_associated_rooms]
, Local_ETL_Inserted_TS
) 
VALUES 
( 
  delta.[id]
, delta.[is_ada]
, delta.[last_sell]
, delta.[reset_value]
, delta.[rack_number]
, delta.[room_number]
, delta.[room_type_id]
, delta.[building_id]
, delta.[floor_id]
, delta.[create_time]
, delta.[property_id]
, delta.[tenant_id]
, delta.[update_time]
, delta.[total_days_occupied]
, delta.[housekeeping_room_condition]
, delta.[occupancy_status]
, delta.[start_date]
, delta.[end_date]
, delta.[suite]
, delta.[description]
, delta.[connecting_room_ids]
, delta.[no_of_associated_rooms]
, CURRENT_TIMESTAMP
);
