USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE dbo.usp_Load_availability_Snapshot
AS

TRUNCATE TABLE dbo.availability ;

INSERT INTO dbo.availability
SELECT
  [id] --PK

, allocation_id
, [date]
, group_id
, room_type_id
, room_id
, tenant_id
, property_id
, departed
, departure
, not_arrived
, hold
, out_of_order
, off_the_market
, pickup
, sold
, suite_component
, previous_room_type_id
, scheduled_room_move_status
, scheduled_by
, soft_block
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --uuid
, CAST(allocation_id as varchar(200)) as allocation_id --text
, CAST(date as date) as date --date
, CAST(group_id as varchar(200)) as group_id --text
, CAST(room_type_id as varchar(200)) as room_type_id --text
, CAST(room_id as varchar(200)) as room_id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text
, CAST(departed as int) --boolean
, CAST(departure as int) --boolean
, CAST(not_arrived as int) --boolean
, hold --integer
, out_of_order --integer
, off_the_market --integer
, pickup --integer
, sold --integer
, CAST(suite_component as int) as suite_component --boolean
, CAST(previous_room_type_id as varchar(200)) as previous_room_type_id --text
, CAST(scheduled_room_move_status as varchar(200)) as scheduled_room_move_status --text
, CAST(scheduled_by as varchar(200)) as scheduled_by --text
, soft_block --integer
	
FROM public.availability'
) ;