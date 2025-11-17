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

, [policy_type]
, [code]
, [name]
, [description]
, [charge_type]
, [days]
, [entire_stay]
, [fixed_fee]
, [percent_of_entire_stay]
, [tax_included]
, [active]
, [subscribed_for_email_notification]
, [notify_before_days]
, [subscribed_for_payment_status_notification]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(policy_type as varchar(200)) as policy_type --text
, CAST(code as varchar(200)) as code --text
, CAST(name as varchar(200)) as name --text
, CAST(description as varchar(200)) as description --text
, CAST(charge_type as varchar(200)) as charge_type  --text
, days --integer
, CAST(entire_stay as int) as entire_stay --boolean
, fixed_fee --numeric(19,2)
, percent_of_entire_stay --numeric(19,2)
, CAST(tax_included as int) as tax_included --boolean
, CAST(active as int) as active --boolean
, CAST(subscribed_for_email_notification as int) as subscribed_for_email_notification --boolean
, notify_before_days --integer
, CAST(subscribed_for_payment_status_notification as int) as subscribed_for_payment_status_notification --boolean

FROM public.deposit_policies 
'
) ;