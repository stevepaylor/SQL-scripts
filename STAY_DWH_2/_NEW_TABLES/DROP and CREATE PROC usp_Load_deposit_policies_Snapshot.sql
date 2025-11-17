USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_deposit_policies_Snapshot]
AS

TRUNCATE TABLE dbo.deposit_policies ;

INSERT INTO dbo.deposit_policies 
SELECT
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [active]
, [code]
, [reason]
, [discount_type]
, [comment]
, [certificate_number]
, [certificate_required]
, [user_id]
, [override_comment]
, [overridden_certificate_number]
, [redeemed_date]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(active as int) as active --boolean
, CAST(code as varchar(200)) as code --text
, CAST(reason as varchar(200)) as reason --text
, CAST(discount_type as varchar(200)) as discount_type  --text
, CAST(comment  as varchar(200)) as comment  --text
, CAST(certificate_number as varchar(200)) as certificate_number  --text
, CAST(certificate_required as int) as certificate_required --boolean
, CAST(user_id  as varchar(200)) as user_id  --text
, CAST(override_comment  as varchar(200)) as override_comment  --text
, CAST(overridden_certificate_number as varchar(200)) as overridden_certificate_number  --text
, redeemed_date --date

FROM public.deposit_policies 
'
) ;