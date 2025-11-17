USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_emails_Snapshot]
AS

TRUNCATE TABLE dbo.emails ;

INSERT INTO dbo.emails
SELECT
  [id] --PK

, [reference_id]
, [tenant_id]
, [value]
, [type]
, [private]
, [default]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text

, CAST(reference_id as varchar(200)) as reference_id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(value as varchar(200)) as value --text
, CAST(type as varchar(200)) as type --text
, CAST(private as int) as private --boolean
, CAST("default" as int) as "default" --boolean

FROM public.emails
'
) ;