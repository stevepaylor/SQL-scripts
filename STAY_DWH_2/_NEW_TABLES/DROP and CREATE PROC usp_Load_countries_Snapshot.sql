USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_countries_Snapshot]
AS

TRUNCATE TABLE dbo.countries ;

INSERT INTO dbo.countries
SELECT
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [owner_id]
, [name]
, [iso_code]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text

, CAST(owner_id as varchar(200)) as owner_id --text
, CAST(name as varchar(200)) as name --text
, CAST(iso_code as varchar(200)) as iso_code --text

FROM public.countries
'
) ;