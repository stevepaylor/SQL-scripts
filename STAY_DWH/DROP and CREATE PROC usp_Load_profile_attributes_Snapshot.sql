USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_profile_attributes_Snapshot
AS 

TRUNCATE TABLE dbo.profile_attributes ;

INSERT INTO dbo.profile_attributes
SELECT DISTINCT
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(reference_id as varchar(200)) as reference_id --text
, CAST(vip_status_id as varchar(200)) as vip_status_id --text
, CAST(rate_plan_id as varchar(200)) as rate_plan_id --text
, CAST(account_id as varchar(200)) as account_id --text
, CAST(array_to_string(room_feature_ids, '' , ''''*'') as varchar(200)) as room_feature_ids --text[]
, CAST(array_to_string(guest_preference_ids, '' , ''''*'') as varchar(200)) as guest_preference_ids --text[]
, CAST(linked_contact_id as varchar(200)) as linked_contact_id --text
, CAST(id as varchar(200)) as id --text

FROM public.profile_attributes
'
)

ORDER BY
  [tenant_id]
, [property_id]
, [id] ;

GO