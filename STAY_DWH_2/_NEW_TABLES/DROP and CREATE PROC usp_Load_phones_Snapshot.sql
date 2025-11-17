USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_phones_Snapshot]
AS

TRUNCATE TABLE dbo.phones ;

INSERT INTO dbo.phones
SELECT
  [id] --PK

, [reference_id]
, [tenant_id]
, [tech_type]
, [number]
, [location_type]
, [country_access_code]
, [city_area_code]
, [type]
, [extension]
, [sms_provider]
, [sms_notifications]
, [private]
, [default]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text

, CAST(reference_id as varchar(200)) as reference_id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(tech_type as varchar(200)) as tech_type --text
, CAST(number as varchar(200)) as number --text
, CAST(location_type as varchar(200)) as location_type --text
, CAST(country_access_code as varchar(200)) as country_access_code --text
, CAST(city_area_code as varchar(200)) as city_area_code --text
, CAST(type as varchar(200)) as type --text
, CAST(extension as varchar(200)) as extension --text
, CAST(sms_provider as varchar(200)) as sms_provider --text
, CAST(sms_notifications as int) as sms_notifications --boolean
, CAST(private as int) as private --boolean
, CAST("default" as int) as "default" --boolean

FROM public.phones
'
) ;