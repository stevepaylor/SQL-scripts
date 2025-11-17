USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE dbo.usp_Load_room_types_Snapshot
AS

TRUNCATE TABLE dbo.room_types ;

INSERT INTO dbo.room_types
SELECT
  [id] --PK

, [name]
, [type_code]
, [housekeeping_pattern_id]
, [is_ada]
, [is_virtual]
, [max_guests]
, [max_pets]
, [non_bedded]
, [default_building_id]
, [pets]
, [property_id]
, [room_class_id]
, [tenant_id]
, [description]
, [smoking_allowed]
, [bed_ids]
, [suite]
, [is_roh]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(name as varchar(200)) as name --text
, CAST(type_code as varchar(200)) as type_code --text
, CAST(housekeeping_pattern_id as varchar(200)) as housekeeping_pattern_id --text
, CAST(is_ada as int) as is_ada --boolean
, CAST(is_virtual as int) as is_virtual --boolean
, max_guests --integer
, max_pets --integer
, CAST(non_bedded as int) as non_bedded --boolean
, CAST(default_building_id as varchar(200)) as default_building_id --text
, CAST(pets as int) as pets --boolean
, CAST(property_id as varchar(200)) as property_id --text
, CAST(room_class_id as varchar(200)) as room_class_id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(description as varchar(200)) as description --text
, CAST(smoking_allowed as int) as smoking_allowed --boolean
, CAST(array_to_string(bed_ids, '' , ''''*'') as varchar(1000)) as bed_ids --text[]
, CAST(suite as int) as suite --boolean
, CAST(is_roh as int) as is_roh --boolean

FROM public.room_types
'
) ;