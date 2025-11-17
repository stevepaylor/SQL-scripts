USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_categories_Snapshot]
AS

TRUNCATE TABLE dbo.categories ;

INSERT INTO dbo.categories
SELECT
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [code]
, [accounting_item_id]
, [description]
, [days_before_arrival]
, [days_after_booking]
, [arrival_time]
, [flat_fee]
, [percentage]
, [nights]
, [match_deposit_policy]
, [tax_inclusive]
, [active]
, [policy_type]
, [reference_id]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(code  as varchar(200)) as code  --text
, CAST(accounting_item_id as varchar(200)) as accounting_item_id --text
, CAST(description as varchar(200)) as description --text
, days_before_arrival --integer
, days_after_booking --integer
, arrival_time --integer
, flat_fee --numeric(19,2)
, percentage --numeric(19,2)
, nights --integer
, CAST(match_deposit_policy as int) as match_deposit_policy --boolean
, CAST(tax_inclusive as int) as tax_inclusive --boolean
, CAST(active as int) as active --boolean
, CAST(policy_type as varchar(200)) as policy_type --text
, CAST(reference_id as varchar(200)) as reference_id --text

FROM public.categories
'
) ;