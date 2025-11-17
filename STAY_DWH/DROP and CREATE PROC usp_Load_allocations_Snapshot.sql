USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_allocations_Snapshot
AS 

TRUNCATE TABLE dbo.allocations ;

INSERT INTO dbo.allocations
SELECT 
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(allocation_type as varchar(200)) as allocation_type --text
, create_time --timestamp without time zone
, end_time --timestamp without time zone
, CAST(reference_id as varchar(200)) as reference_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, update_time --timestamp without time zone
, CAST(blocked_by as varchar(200)) as blocked_by --text
, blocked_on --timestamp without time zone
, CAST(cleared_by as varchar(200)) as cleared_by --text
, cleared_on --timestamp without time zone
, start_date --date
, end_date --date
, CAST(reason as varchar(200)) as reason --text
, CAST(room_id as varchar(200)) as room_id --text
, CAST(inventory_block_type as varchar(200)) as inventory_block_type --text
, inventory_expiry_time --time without time zone
, CAST(inventory_block_reason as varchar(200)) as inventory_block_reason --text
, CAST(array_to_string(maintenance_services, '' , ''''*'') as varchar(100)) as maintenance_services --text[]

FROM public.allocations
'
)

ORDER BY
  [id]
, [tenant_id]
, [property_id]
, [room_id] 
, [allocation_type] ;

GO
