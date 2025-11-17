USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_vip_statuses_Snapshot
AS 

TRUNCATE TABLE dbo.vip_statuses ;

INSERT INTO dbo.vip_statuses
SELECT DISTINCT
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(active as int) as active --boolean
, CAST(code as varchar(200)) as code --text
, CAST(description as varchar(200)) as description --text
, CAST(name as varchar(200)) as name --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text

FROM public.vip_statuses
'
)

ORDER BY
  [tenant_id]
, [property_id]
, [id] ;

GO