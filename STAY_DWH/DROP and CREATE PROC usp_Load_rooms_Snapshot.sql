USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_rooms_Snapshot]
AS

TRUNCATE TABLE dbo.rooms ;

INSERT INTO dbo.rooms
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
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

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
'
) ;