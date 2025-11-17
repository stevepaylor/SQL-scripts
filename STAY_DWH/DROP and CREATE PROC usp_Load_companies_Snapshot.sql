USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_companies_Snapshot
AS 

TRUNCATE TABLE dbo.companies ;

INSERT INTO dbo.companies
SELECT 
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, create_time --timestamp without time zone
, update_time --timestamp without time zone
, CAST(archived as int) as archived --boolean
, CAST(external_profile_id as varchar(200)) as external_profile_id --text
, CAST(website as varchar(200)) as website --text
, CAST(code as varchar(200)) as code --text
, CAST(name as varchar(200)) as name --text
, CAST(pronounced as varchar(200)) as pronounced --text
, CAST(merge_remnant as int) as merge_remnant --boolean

FROM public.companies
'
)

ORDER BY
  [id]
, [tenant_id]
, [update_time] ;

GO