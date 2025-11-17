USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_accounts_Snapshot]
AS

TRUNCATE TABLE dbo.accounts ;

INSERT INTO dbo.accounts
SELECT 
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [name]
, [number]
, [account_status]
, [account_type]
, [create_time]
, [reference_id]
, [update_time]
, [user_id]
, [default_payment_method_id]
, [credit_limit]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(property_id as varchar(200)) as property_id --text

, CAST(name as varchar(200)) as name --text
, CAST(number as varchar(200)) as number --text
, CAST(account_status as varchar(200)) as account_status --text
, CAST(account_type as varchar(200)) as account_type --text
, create_time --timestamp without time zone
, CAST(reference_id as varchar(200)) as reference_id --text
, update_time --timestamp without time zone
, CAST(user_id as varchar(200)) as user_id --text
, CAST(default_payment_method_id as varchar(200)) as default_payment_method_id --text
, credit_limit --numeric(19,2)

FROM public.accounts
'
) ;