USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_comp_offer_details_Snapshot]
AS

TRUNCATE TABLE dbo.comp_offer_details ;

INSERT INTO dbo.comp_offer_details
SELECT
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [name]
, [code]
, [htng_code]
, [htng_description]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(name  as varchar(200)) as name --text
, CAST(code  as varchar(200)) as code --text
, CAST(htng_code  as varchar(200)) as htng_code --text
, CAST(htng_description  as varchar(200)) as htng_description --text

FROM public.comp_offer_details
'
) ;