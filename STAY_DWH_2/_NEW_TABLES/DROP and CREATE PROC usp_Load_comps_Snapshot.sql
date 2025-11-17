USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_comps_Snapshot]
AS

TRUNCATE TABLE dbo.comps ;

INSERT INTO dbo.comps 
SELECT
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [offer_code]
, [offer_name]
, [authorizer_id]
, [authorizer_code]
, [department_id]
, [template_id]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text
, CAST(offer_code  as varchar(200)) as offer_code  --text
, CAST(offer_name  as varchar(200)) as offer_name  --text
, CAST(authorizer_id  as varchar(200)) as authorizer_id  --text
, CAST(authorizer_code  as varchar(200)) as authorizer_code  --text
, CAST(department_id  as varchar(200)) as department_id  --text
, CAST(template_id  as varchar(200)) as template_id  --text

FROM public.comps 
'
) ;