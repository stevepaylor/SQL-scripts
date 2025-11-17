USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_folios_Snapshot]
AS

TRUNCATE TABLE dbo.folios ;

INSERT INTO dbo.folios 
SELECT
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [default_folio]
, [name]
, [account_id]
, [payment_method_id]
, [folio_type]
, [deposit_folio]
, [payment_instrument_id]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(default_folio as int) as default_folio --boolean
, CAST(name as varchar(200)) as name --text
, CAST(account_id as varchar(200)) as account_id --text
, CAST(payment_method_id as varchar(200)) as payment_method_id  --text
, CAST(folio_type as varchar(200)) as folio_type  --text
, CAST(deposit_folio as int) as deposit_folio --boolean
, CAST(payment_instrument_id as varchar(200)) as payment_instrument_id --text

FROM public.folios 
'
) ;