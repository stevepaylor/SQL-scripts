USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_subcategories_Snapshot]
AS

TRUNCATE TABLE dbo.subcategories ;

INSERT INTO dbo.subcategories 
SELECT 
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [name]
, [code]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(name as varchar(200)) as name --text
, CAST(code as varchar(200)) as code --text

FROM public.subcategories 
'
) ;