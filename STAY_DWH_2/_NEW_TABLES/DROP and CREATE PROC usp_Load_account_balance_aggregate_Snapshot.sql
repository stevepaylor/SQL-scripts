USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_account_balance_aggregate_Snapshot]
AS

TRUNCATE TABLE dbo.account_balance_aggregate ;

INSERT INTO dbo.account_balance_aggregate
SELECT
  [date]
, [tenant_id] --PK
, [property_id] --PK
, [account_id] --PK
, [ledger_name] --PK

, [last_updated_at]
, [historic]
, [recurring_charge]
, [sub_total]
, [tax]
, [paid]
, [total]
, [rr_charges]
, [rr_transfers]
, [nrr_charges]
, [nrr_transfers]
, [rr_charges_tax]
, [rr_transfers_tax]
, [nrr_charges_tax]
, [nrr_transfers_tax]
, [rr_routing_charges]
, [nrr_routing_charges]
, [rr_routing_charges_tax]
, [nrr_routing_charges_tax]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  date --date --PK
, CAST(tenant_id as varchar(200)) as tenant_id --text --PK
, CAST(property_id as varchar(200)) as property_id --text --PK
, CAST(account_id as varchar(200)) as account_id --text --PK
, cast(coalesce(ledger_name, ''null'') as varchar(200)) as ledger_name --text --PK

, last_updated_at --timestamp with time zone
, CAST(historic as int) as historic --boolean
, CAST(recurring_charge as int) as recurring_charge --boolean

, sub_total --numeric
, tax --numeric
, paid --numeric
, total --numeric
, rr_charges --numeric
, rr_transfers --numeric
, nrr_charges --numeric
, nrr_transfers --numeric
, rr_charges_tax --numeric
, rr_transfers_tax --numeric
, nrr_charges_tax--numeric
, nrr_transfers_tax --numeric
, rr_routing_charges --numeric
, nrr_routing_charges --numeric
, rr_routing_charges_tax --numeric
, nrr_routing_charges_tax --numeric

FROM public.account_balance_aggregate
'
) ;