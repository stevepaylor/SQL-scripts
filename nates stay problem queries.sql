INSERT INTO [StayDWH].[dbo].[account_balance_aggregate]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[account_balance_aggregate]

INSERT INTO [StayDWH].[dbo].[accounting_dates]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[accounting_dates]


--INSERT INTO [StayDWH].[dbo].[accounting_dates_Delta]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[accounting_dates_Delta]


--INSERT INTO [StayDWH].[dbo].[accounting_items]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[accounting_items]


--INSERT INTO [StayDWH].[dbo].[accounts]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[accounts]


--INSERT INTO [StayDWH].[dbo].[accounts_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[accounts_Snapshot]


INSERT INTO [StayDWH].[dbo].[additional_guests]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[additional_guests]


INSERT INTO [StayDWH].[dbo].[addresses]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[addresses]


INSERT INTO [StayDWH].[dbo].[allocations]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[allocations]


INSERT INTO [StayDWH].[dbo].[availability]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[availability]


INSERT INTO [StayDWH].[dbo].[booked_reservation_details]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[booked_reservation_details]


INSERT INTO [StayDWH].[dbo].[booking_channels]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[booking_channels]


INSERT INTO [StayDWH].[dbo].[buildings]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[buildings]


INSERT INTO [StayDWH].[dbo].[cancellation_policies]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[cancellation_policies]


--INSERT INTO [StayDWH].[dbo].[cancellation_policies_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[cancellation_policies_Snapshot]


INSERT INTO [StayDWH].[dbo].[categories]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[categories]


--INSERT INTO [StayDWH].[dbo].[categories_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[categories_Snapshot]


INSERT INTO [StayDWH].[dbo].[comp_offer_details]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[comp_offer_details]


--INSERT INTO [StayDWH].[dbo].[comp_offer_details_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[comp_offer_details_Snapshot]


INSERT INTO [StayDWH].[dbo].[comp_offers]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[comp_offers]


--INSERT INTO [StayDWH].[dbo].[comp_offers_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[comp_offers_Snapshot]


INSERT INTO [StayDWH].[dbo].[companies]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[companies]


INSERT INTO [StayDWH].[dbo].[comps]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[comps]


--INSERT INTO [StayDWH].[dbo].[comps_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[comps_Snapshot]


INSERT INTO [StayDWH].[dbo].[countries]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[countries]


INSERT INTO [StayDWH].[dbo].[deposit_policies]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[deposit_policies]


--INSERT INTO [StayDWH].[dbo].[deposit_policies_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[deposit_policies_Snapshot]


--INSERT INTO [StayDWH].[dbo].[emails]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[emails]


--INSERT INTO [StayDWH].[dbo].[flash_aggregate]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[flash_aggregate]


INSERT INTO [StayDWH].[dbo].[flash_aggregate_Delta]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[flash_aggregate_Delta]


--INSERT INTO [StayDWH].[dbo].[flash_aggregate_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[flash_aggregate_Snapshot]


INSERT INTO [StayDWH].[dbo].[folios]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[folios]


--INSERT INTO [StayDWH].[dbo].[folios_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[folios_Snapshot]


INSERT INTO [StayDWH].[dbo].[groups]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[groups]


INSERT INTO [StayDWH].[dbo].[guest_types]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[guest_types]


INSERT INTO [StayDWH].[dbo].[guests]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[guests]


INSERT INTO [StayDWH].[dbo].[ledger_transactions]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[ledger_transactions]


--INSERT INTO [StayDWH].[dbo].[ledger_transactions_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[ledger_transactions_Snapshot]


INSERT INTO [StayDWH].[dbo].[line_items]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[line_items]


--INSERT INTO [StayDWH].[dbo].[line_items_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[line_items_Snapshot]


INSERT INTO [StayDWH].[dbo].[market_segments]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[market_segments]


--INSERT INTO [StayDWH].[dbo].[phones]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[phones]


INSERT INTO [StayDWH].[dbo].[profile_attributes]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[profile_attributes]


INSERT INTO [StayDWH].[dbo].[properties]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[properties]


INSERT INTO [StayDWH].[dbo].[rate_plans]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[rate_plans]


--INSERT INTO [StayDWH].[dbo].[rate_plans_Delta]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[rate_plans_Delta]


INSERT INTO [StayDWH].[dbo].[rate_snapshots]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[rate_snapshots]


--INSERT INTO [StayDWH].[dbo].[rate_snapshots_Delta]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[rate_snapshots_Delta]


INSERT INTO [StayDWH].[dbo].[reservation_loyalties]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[reservation_loyalties]


INSERT INTO [StayDWH].[dbo].[reservations]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[reservations]


INSERT INTO [StayDWH].[dbo].[room_types]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[room_types]


--INSERT INTO [StayDWH].[dbo].[room_types_Delta]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[room_types_Delta]


INSERT INTO [StayDWH].[dbo].[rooms]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[rooms]


--INSERT INTO [StayDWH].[dbo].[rooms_Delta]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[rooms_Delta]


INSERT INTO [StayDWH].[dbo].[source_of_businesses]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[source_of_businesses]


--INSERT INTO [StayDWH].[dbo].[source_of_businesses_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[source_of_businesses_Snapshot]

INSERT INTO [StayDWH].[dbo].[subcategories]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[subcategories]


--INSERT INTO [StayDWH].[dbo].[subcategories_Snapshot]
--SELECT *
--FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[subcategories_Snapshot]


INSERT INTO [StayDWH].[dbo].[vip_statuses]
SELECT *
FROM [DWHDB01PR].[StayDWH_06_14_1225PM].[dbo].[vip_statuses]
