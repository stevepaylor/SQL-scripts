USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_market_segments_Snapshot
AS 

TRUNCATE TABLE dbo.market_segments ;

INSERT INTO dbo.market_segments
SELECT DISTINCT
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(id as varchar(200)) as id --text
, CAST(name as varchar(200)) as name --text
, CAST(code as varchar(200)) as code --text
, CAST(gl_code as varchar(200)) as gl_code --text
, CAST(active as int) as active --boolean

FROM public.market_segments
'
)

ORDER BY
  [tenant_id]
, [property_id]
, [id] ;

GO