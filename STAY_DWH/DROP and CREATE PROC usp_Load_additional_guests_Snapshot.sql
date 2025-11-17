USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_additional_guests_Snapshot
AS 

TRUNCATE TABLE dbo.additional_guests ;

INSERT INTO dbo.additional_guests
SELECT 
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --uuid
, CAST(age_category_id as varchar(200)) as age_category_id --text
, CAST(non_registered as int) as non_registered --boolean
, CAST(name as varchar(200)) as name --text
--, CAST(first_name as varchar(200)) as first_name --text
--, CAST(last_name as varchar(200)) as last_name --text
--, CAST(collated_name as varchar(200)) as collated_name --text
--, CAST(middle_initial as varchar(200)) as middle_initial --text
--, CAST(suffix as varchar(200)) as suffix --text
--, CAST(title as varchar(200)) as title --text
--, CAST(primary_address_id as varchar(200)) as primary_address_id --text
--, CAST(primary_email_id as varchar(200)) as primary_email_id --text
--, CAST(primary_phone_id as varchar(200)) as primary_phone_id --text
--, CAST(vip_status as varchar(200)) as vip_status --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text
, CAST(reservation_id as varchar(200)) as reservation_id --text

FROM public.additional_guests

'
)

ORDER BY
  [id]
, [tenant_id]
, [property_id]
, [reservation_id] ;

GO
