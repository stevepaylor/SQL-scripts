USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_addresses_Snapshot]
AS

TRUNCATE TABLE dbo.addresses ;

INSERT INTO dbo.addresses
SELECT
  [id] --PK

, [reference_id]
, [tenant_id]
, [type]
, [line1]
, [line2]
, [line3]
, [line4]
, [line5]
, [city]
, [postal_code]
, [country]
, [county]
, [state]
, [private]
, [default]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(2000)) as id --text

, CAST(reference_id as varchar(200)) as reference_id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(type as varchar(200)) as type --text
, CAST(line1 as varchar(200)) as line1 --text
, CAST(line2 as varchar(200)) as line2 --text
, CAST(line3 as varchar(200)) as line3 --text
, CAST(line4 as varchar(200)) as line4 --text
, CAST(line5 as varchar(200)) as line5 --text
, CAST(city as varchar(200)) as city --text
, CAST(postal_code as varchar(200)) as postal_code --text
, CAST(country as varchar(200)) as country --text
, CAST(county as varchar(200)) as county --text
, CAST(state as varchar(200)) as state --text
, CAST(private as int) as private --boolean
, CAST("default" as int) as "default" --boolean

FROM public.addresses
'
) ;