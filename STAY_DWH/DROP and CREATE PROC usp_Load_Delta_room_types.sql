USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS dbo.usp_Load_Delta_room_types ;
GO

CREATE PROCEDURE [dbo].[usp_Load_Delta_room_types]
AS

DROP TABLE IF EXISTS dbo.room_types_Delta ;

SELECT
  [id]
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

INTO dbo.room_types_Delta

FROM OPENQUERY(POSTGRESQL,
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

----------------------------------------------------------------------------------------
-- Merge delta data into perm table
----------------------------------------------------------------------------------------

MERGE dbo.room_types AS [target]
USING dbo.room_types_Delta AS delta
ON [target].[id] = delta.[id]
WHEN MATCHED 
AND (   [target].[name] <> delta.[name]
     OR [target].[type_code] <> delta.[type_code]
     OR [target].[housekeeping_pattern_id] <> delta.[housekeeping_pattern_id]
     OR [target].[is_ada] <> delta.[is_ada]
     OR [target].[is_virtual] <> delta.[is_virtual]
     OR [target].[max_guests] <> delta.[max_guests]
     OR [target].[max_pets] <> delta.[max_pets]
     OR [target].[non_bedded] <> delta.[non_bedded]
     OR [target].[default_building_id] <> delta.[default_building_id]
     OR [target].[pets] <> delta.[pets]
     OR [target].[property_id] <> delta.[property_id]
     OR [target].[room_class_id] <> delta.[room_class_id]
     OR [target].[tenant_id] <> delta.[tenant_id]
     OR [target].[description] <> delta.[description]
     OR [target].[smoking_allowed] <> delta.[smoking_allowed]
     OR [target].[bed_ids] <> delta.[bed_ids]
     OR [target].[suite] <> delta.[suite]
     OR [target].[is_roh] <> delta.[is_roh]
	)
THEN UPDATE SET
  [target].[id] = delta.[id]
, [target].[name] = delta.[name]
, [target].[type_code] = delta.[type_code]
, [target].[housekeeping_pattern_id] = delta.[housekeeping_pattern_id]
, [target].[is_ada] = delta.[is_ada]
, [target].[is_virtual] = delta.[is_virtual]
, [target].[max_guests] = delta.[max_guests]
, [target].[max_pets] = delta.[max_pets]
, [target].[non_bedded] = delta.[non_bedded]
, [target].[default_building_id] = delta.[default_building_id]
, [target].[pets] = delta.[pets]
, [target].[property_id] = delta.[property_id]
, [target].[room_class_id] = delta.[room_class_id]
, [target].[tenant_id] = delta.[tenant_id]
, [target].[description] = delta.[description]
, [target].[smoking_allowed] = delta.[smoking_allowed]
, [target].[bed_ids] = delta.[bed_ids]
, [target].[suite] = delta.[suite]
, [target].[is_roh] = delta.[is_roh]
, [target].Local_ETL_Updated_TS = CURRENT_TIMESTAMP

WHEN NOT MATCHED THEN INSERT 
( 
  [id]
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
, [Local_ETL_Inserted_TS]
) 
VALUES 
( 
  delta.[id]
, delta.[name]
, delta.[type_code]
, delta.[housekeeping_pattern_id]
, delta.[is_ada]
, delta.[is_virtual]
, delta.[max_guests]
, delta.[max_pets]
, delta.[non_bedded]
, delta.[default_building_id]
, delta.[pets]
, delta.[property_id]
, delta.[room_class_id]
, delta.[tenant_id]
, delta.[description]
, delta.[smoking_allowed]
, delta.[bed_ids]
, delta.[suite]
, delta.[is_roh]
, CURRENT_TIMESTAMP
);
