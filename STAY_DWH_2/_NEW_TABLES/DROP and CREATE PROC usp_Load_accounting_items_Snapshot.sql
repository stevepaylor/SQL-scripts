USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_accounting_items_Snapshot]
AS

TRUNCATE TABLE dbo.accounting_items ;

INSERT INTO dbo.accounting_items
SELECT
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [type]
, [alt_system_id]
, [default_price]
, [general_ledger_code]
, [allow_comp]
, [price_look_up_code]
, [status]
, [category_id]
, [room_revenue]
, [subcategory_id]
, [name], [code]
, [internal]
, [available_count]
, [max_quantity_per_reservation]
, [restricted]
, [tax_rate]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text

, CAST(type as varchar(200)) as type --text
, CAST(alt_system_id as varchar(200)) as alt_system_id --text
, default_price --numeric(19,2),
, CAST(general_ledger_code as varchar(200)) as general_ledger_code --text
, CAST(allow_comp as int) as allow_comp --boolean
, CAST(price_look_up_code as varchar(200)) as price_look_up_code --text
, CAST(status as varchar(200)) as status --text
, CAST(category_id as varchar(200)) as category_id --text
, CAST(room_revenue as int) as room_revenue --boolean
, CAST(subcategory_id as varchar(200)) as subcategory_id --text
, CAST(name as varchar(200)) as name --text
, CAST(code as varchar(200)) as code --text
, CAST(internal as int) as internal --boolean
, available_count --integer
, max_quantity_per_reservation --integer
, CAST(restricted as int) as restricted --boolean
, CAST(tax_rate as varchar(200)) as tax_rate --text

FROM public.accounting_items
'
) ;