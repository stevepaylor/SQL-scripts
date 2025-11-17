USE [StayDWH]
GO

DROP TABLE IF EXISTS dbo.STAY_ETL_Validation_Total_Counts
GO

------------------------------------------------------------------------------
-- account_balance_aggregate
------------------------------------------------------------------------------
--SELECT 
--  cast('account_balance_aggregate' as varchar(50)) as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
----INTO dbo.STAY_ETL_Validation_Total_Counts
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.account_balance_aggregate')
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'account_balance_aggregate         ' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
INTO dbo.STAY_ETL_Validation_Total_Counts
FROM [StayDWH].[dbo].[account_balance_aggregate]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'account_balance_aggregate' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[account_balance_aggregate]
GO

------------------------------------------------------------------------------
-- accounting_dates
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  cast('accounting_dates' as varchar(50)) as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.accounting_dates')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'accounting_dates' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[accounting_dates]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'accounting_dates' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[accounting_dates]
GO

------------------------------------------------------------------------------
-- accounts
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  cast('accounts' as varchar(50)) as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.accounts')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'accounts' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[accounts]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'accounts' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[accounts]
GO

------------------------------------------------------------------------------
-- additional_guests
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'additional_guests' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.additional_guests')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'additional_guests' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[additional_guests]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'additional_guests' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[additional_guests]

------------------------------------------------------------------------------
-- addresses
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'addresses' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.addresses')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'addresses' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[addresses]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'addresses' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[addresses]

------------------------------------------------------------------------------
-- allocations
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'allocations' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.allocations')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'allocations' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[allocations]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'allocations' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[allocations]

------------------------------------------------------------------------------
-- availability
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'availability' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.availability')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'availability' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[availability]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'availability' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[availability]
GO

------------------------------------------------------------------------------
-- booked_reservation_details
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'booked_reservation_details' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.booked_reservation_details')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'booked_reservation_details' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[booked_reservation_details]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'booked_reservation_details' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[booked_reservation_details]
GO

------------------------------------------------------------------------------
-- booking_channels
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'booking_channels' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.booking_channels')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'booking_channels' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[booking_channels]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'booking_channels' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[booking_channels]
GO
------------------------------------------------------------------------------
-- buildings
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'buildings' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.buildings')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'buildings' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[buildings]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'buildings' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[buildings]

------------------------------------------------------------------------------
-- cancellation_policies
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'cancellation_policies' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.cancellation_policies')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'cancellation_policies' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[cancellation_policies]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'cancellation_policies' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[cancellation_policies]
GO

------------------------------------------------------------------------------
-- categories
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'categories' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.categories')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'categories' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[categories]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'categories' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[categories]
GO

------------------------------------------------------------------------------
-- comp_offer_details
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'comp_offer_details' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.comp_offer_details')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'comp_offer_details' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[comp_offer_details]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'comp_offer_details' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[comp_offer_details]
GO

------------------------------------------------------------------------------
-- comp_offers
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'comp_offers' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.comp_offers')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'comp_offers' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[comp_offers]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'comp_offers' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[comp_offers]
GO

------------------------------------------------------------------------------
-- companies
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'companies' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.companies')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'companies' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[companies]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'companies' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[companies]

------------------------------------------------------------------------------
-- comps
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'comps' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.comps')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'comps' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[comps]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'comps' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[comps]

------------------------------------------------------------------------------
-- countries
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'countries' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.countries')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'countries' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[countries]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'countries' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[countries]

------------------------------------------------------------------------------
-- deposit_policies
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'deposit_policies' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.deposit_policies')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'deposit_policies' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[deposit_policies]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'deposit_policies' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[deposit_policies]

------------------------------------------------------------------------------
-- emails
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'emails' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.emails')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'emails' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[emails]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'emails' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[emails]

------------------------------------------------------------------------------
-- flash_aggregate
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'flash_aggregate' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,
--'SELECT COUNT(*) as ROWS 
--FROM Stay_Prod.public.flash_aggregate
--WHERE last_updated_at >= current_timestamp - interval ''2 hours''
--  AND date IS NOT NULL
--  AND tenant_id IS NOT NULL
--  AND property_id IS NOT NULL
--  AND building_name IS NOT NULL
--  AND room_type_code IS NOT NULL
--  AND rate_code IS NOT NULL
--  AND market_segment_code IS NOT NULL
--  AND last_updated_at IS NOT NULL
--  '
-- )
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'flash_aggregate_Delta' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[flash_aggregate_Delta]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'flash_aggregate' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[flash_aggregate]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'flash_aggregate_Delta' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[flash_aggregate_Delta]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'flash_aggregate' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[flash_aggregate]
GO

------------------------------------------------------------------------------
-- folios
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'folios' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.folios')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'folios' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[folios]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'folios' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[folios]

------------------------------------------------------------------------------
-- groups
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'groups' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.groups')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'groups' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[groups]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'groups' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[groups]

------------------------------------------------------------------------------
-- guest_types
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'guest_types' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.guest_types')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'guest_types' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[guest_types]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'guest_types' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[guest_types]

------------------------------------------------------------------------------
-- guests
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'guests' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.guests')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'guests' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[guests]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'guests' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[guests]

------------------------------------------------------------------------------
-- ledger_transactions
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'ledger_transactions' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.ledger_transactions')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'ledger_transactions' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[ledger_transactions]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'ledger_transactions' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[ledger_transactions]

------------------------------------------------------------------------------
-- line_items
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'line_items' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.line_items')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'line_items' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[line_items]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'line_items' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[line_items]

------------------------------------------------------------------------------
-- market_segments
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'market_segments' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.market_segments')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'market_segments' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[market_segments]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'market_segments' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[market_segments]
GO

------------------------------------------------------------------------------
-- phones
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'phones' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.phones')

GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'phones' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[phones]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'phones' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[phones]
GO

------------------------------------------------------------------------------
-- profile_attributes
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'profile_attributes' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.profile_attributes')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'profile_attributes' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[profile_attributes]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'profile_attributes' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[profile_attributes]
GO

------------------------------------------------------------------------------
-- properties
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'properties' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.properties')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'properties' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[properties]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'properties' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[properties]
GO

------------------------------------------------------------------------------
-- rate_plans
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'rate_plans' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rate_plans')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_plans' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[rate_plans]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_plans' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[rate_plans]
GO

------------------------------------------------------------------------------
-- rate_snapshots
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'rate_snapshots' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rate_snapshots')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_snapshots' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[rate_snapshots]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_snapshots' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[rate_snapshots]
GO

------------------------------------------------------------------------------
-- reservation_loyalties
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'reservation_loyalties' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.reservation_loyalties')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'reservation_loyalties' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[reservation_loyalties]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'reservation_loyalties' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[reservation_loyalties]
GO

------------------------------------------------------------------------------
-- reservations
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'reservations' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.reservations')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'reservations' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[reservations]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'reservations' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[reservations]
GO

------------------------------------------------------------------------------
-- room_types
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'room_types' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.room_types')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'room_types' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[room_types]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'room_types' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[room_types]
GO

------------------------------------------------------------------------------
-- rooms
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'rooms' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rooms')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rooms' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[rooms]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rooms' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[rooms]
GO

------------------------------------------------------------------------------
-- source_of_businesses
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'source_of_businesses' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.source_of_businesses')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'source_of_businesses' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[source_of_businesses]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'source_of_businesses' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[source_of_businesses]
GO

------------------------------------------------------------------------------
-- subcategories
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'subcategories' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.subcategories')
--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'subcategories' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[subcategories]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'subcategories' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[subcategories]
GO

------------------------------------------------------------------------------
-- vip_statuses
------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'vip_statuses' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, *
--, GETDATE() as 'As Of (local time)'
--FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.vip_statuses')

--GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'vip_statuses' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[vip_statuses]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'vip_statuses' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[vip_statuses]
GO

--------------------------------------------------------------------------------
---- vw_comp_offer_details
--------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_comp_offer_details_Original' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_comp_offer_details_Original]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_comp_offer_details' as [Table]
--, 'Prod - DWHDB01pr' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_comp_offer_details]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_comp_offer_details' as [Table]
--, 'QA - DWHDB01qa' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM DWHDB01QA.[StayDWH].[dbo].[vw_comp_offer_details]
--GO

--------------------------------------------------------------------------------
---- vw_Line_items
--------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Line_items_Original' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_Line_items_Original]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Line_items' as [Table]
--, 'Prod - DWHDB01pr' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_Line_items]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Line_items' as [Table]
--, 'QA - DWHDB01qa' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM DWHDB01QA.[StayDWH].[dbo].[vw_Line_items]
--GO

--------------------------------------------------------------------------------
---- vw_Reservations
--------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Reservations_Original' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_Reservations_Original]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Reservations' as [Table]
--, 'Prod - DWHDB01pr' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_Reservations]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Reservations' as [Table]
--, 'QA - DWHDB01qa' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM DWHDB01QA.[StayDWH].[dbo].[vw_Reservations]
--GO

--------------------------------------------------------------------------------
---- vw_Reservations_VIE
--------------------------------------------------------------------------------
--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Reservations_VIE_Original' as [Table]
--, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_Reservations_VIE_Original]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Reservations_VIE' as [Table]
--, 'Prod - DWHDB01pr' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM [StayDWH].[dbo].[vw_Reservations_VIE]
--GO

--INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
--SELECT 
--  'VIEW vw_Reservations_VIE' as [Table]
--, 'QA - DWHDB01qa' as 'Database Location'
--, COUNT(*) as [Rows]
--, GETDATE() as 'As Of (local time)'
--FROM DWHDB01QA.[StayDWH].[dbo].[vw_Reservations_VIE]
--GO

-----------------------------------------------------------------------------------
-- Send Report
-----------------------------------------------------------------------------------
USE StayDWH
GO 

DECLARE @subject_value as VARCHAR(300) = 'STAY DWH ETL Validation Report -- ' + CONVERT(VARCHAR(10),DATEADD(D,-1,CURRENT_TIMESTAMP),101) + '  --  ' + @@SERVERNAME;
--DECLARE @recipients_value VARCHAR(300) =  'nwillan@viejas.com;_itdba@VIEJAS.com;viejas_alerts@readywillingnabel.com;mthompson@viejas.com' ;
DECLARE @recipients_value VARCHAR(300) =  'spaylor@VIEJAS.com' ;

DECLARE @HTML nvarchar(MAX) ;

EXEC DBA.dbo.SpCustomTable2HTML         
  'StayDWH.dbo.STAY_ETL_Validation_Total_Counts'         
, @HTML OUTPUT
, 'style="font:12pt" class="AltListBorder" cellpadding="10" cellspacing="2"'
, 'class="RowHeader"' ;

EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'Alerts'
, @recipients = @recipients_value
, @subject = @subject_value
, @body = @html
, @body_format = 'HTML'
, @query_no_truncate = 1
, @attach_query_result_as_file = 0 ;

GO