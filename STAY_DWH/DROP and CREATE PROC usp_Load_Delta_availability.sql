USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS dbo.usp_Load_Delta_availability ;
GO

CREATE PROCEDURE dbo.usp_Load_Delta_availability
AS

DROP TABLE IF EXISTS dbo.availability_Delta ;

SELECT
  [id]
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

INTO dbo.availability_Delta

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


----------------------------------------------------------------------------------------
-- Merge delta data into perm table
----------------------------------------------------------------------------------------

MERGE dbo.availability AS [target]
USING dbo.availability_Delta AS delta
ON [target].[id] = delta.[id]
WHEN MATCHED 
AND (   [target].allocation_id <> delta.allocation_id
     OR [target].[date] <> delta.[date]
     OR [target].group_id <> delta.group_id
     OR [target].room_type_id <> delta.room_type_id
     OR [target].room_id <> delta.room_id
     OR [target].tenant_id <> delta.tenant_id
     OR [target].property_id <> delta.property_id
     OR [target].departed <> delta.departed 
     OR [target].departure <> delta.departure
     OR [target].not_arrived <> delta.not_arrived
     OR [target].hold <> delta.hold
     OR [target].out_of_order <> delta.out_of_order
     OR [target].off_the_market <> delta.off_the_market
     OR [target].pickup <> delta.pickup
     OR [target].sold <> delta.sold
     OR [target].suite_component <> delta.suite_component
     OR [target].previous_room_type_id <> delta.previous_room_type_id
     OR [target].scheduled_room_move_status <> delta.scheduled_room_move_status
     OR [target].scheduled_by <> delta.scheduled_by 
     OR [target].soft_block <> delta.soft_block
	)
THEN UPDATE SET

  [target].[id] = delta.[id]
, [target].allocation_id = delta.allocation_id
, [target].[date] = delta.[date]
, [target].group_id = delta.group_id
, [target].room_type_id = delta.room_type_id
, [target].room_id = delta.room_id
, [target].tenant_id = delta.tenant_id
, [target].property_id = delta.property_id
, [target].departed = delta.departed 
, [target].departure = delta.departure
, [target].not_arrived = delta.not_arrived
, [target].hold = delta.hold
, [target].out_of_order = delta.out_of_order
, [target].off_the_market = delta.off_the_market
, [target].pickup = delta.pickup
, [target].sold = delta.sold
, [target].suite_component = delta.suite_component
, [target].previous_room_type_id = delta.previous_room_type_id
, [target].scheduled_room_move_status = delta.scheduled_room_move_status
, [target].scheduled_by = delta.scheduled_by 
, [target].soft_block = delta.soft_block
, [target].Local_ETL_Updated_TS = CURRENT_TIMESTAMP

WHEN NOT MATCHED THEN INSERT 
( 
  [id]
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
, Local_ETL_Inserted_TS
) 
VALUES 
( 
  delta.[id]
, delta.allocation_id
, delta.[date]
, delta.group_id
, delta.room_type_id
, delta.room_id
, delta.tenant_id
, delta.property_id
, delta.departed
, delta.departure
, delta.not_arrived
, delta.hold
, delta.out_of_order
, delta.off_the_market
, delta.pickup
, delta.sold
, delta.suite_component
, delta.previous_room_type_id
, delta.scheduled_room_move_status
, delta.scheduled_by
, delta.soft_block
, CURRENT_TIMESTAMP
);


