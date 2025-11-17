--===========================================================================================
-- 1) disable the Repl-ETL - StayDWH PostgreSQL Import (every 90 min) job
--
-- 2) Save a copy of the current [dbo].[line_items]
--===========================================================================================

USE [StayDWH]
GO

SELECT *
INTO [dbo].[line_items_SAVE]
FROM [dbo].[line_items]

--===========================================================================================
-- 3) drop the [dbo].[line_items] table
--
-- 4) recreate the [dbo].[line_items] table adding the three new columns:
--	[above_property_payment] [varchar](5) NULL,
--	[early_departure] [varchar](5) NULL,
--	[card_subtype] [varchar](500) NULL,
--============================================================================================

DROP TABLE IF EXISTS [dbo].[line_items]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[line_items](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](10) NOT NULL,
	[property_id] [varchar](10) NOT NULL,
	[account_id] [varchar](200) NULL,
	[amount] [money] NULL,
	[category_id] [varchar](200) NULL,
	[display_date] [date] NULL,
	[folio_id] [varchar](200) NULL,
	[accounting_item_id] [varchar](200) NULL,
	[ledger_id] [varchar](200) NULL,
	[quantity] [int] NULL,
	[room_revenue] [varchar](5) NULL,
	[subcategory_id] [varchar](200) NULL,
	[user_id] [varchar](200) NULL,
	[ledger_lines_ledger_transaction_id] [varchar](200) NULL,
	[folio_lines_ledger_transaction_id] [varchar](200) NULL,
	[tax_reference_id] [varchar](200) NULL,
	[adjustment_reference_id] [varchar](200) NULL,
	[call_type] [varchar](300) NULL,
	[correction_reference_id] [varchar](200) NULL,
	[description] [varchar](500) NULL,
	[free_allowance_amount] [money] NULL,
	[gateway_type] [varchar](300) NULL,
	[gift_card] [varchar](5) NULL,
	[invalid] [varchar](5) NULL,
	[meal_period_id] [varchar](200) NULL,
	[rate_change_comment] [varchar](500) NULL,
	[reason] [varchar](500) NULL,
	[recurring_charge_id] [varchar](200) NULL,
	[reference] [varchar](500) NULL,
	[refund_reference_id] [varchar](200) NULL,
	[reservation_id] [varchar](200) NULL,
	[reverse_tax_total_charge_amount] [money] NULL,
	[reverse_tax] [varchar](5) NULL,
	[room_charge_posting_type] [varchar](500) NULL,
	[source_id] [varchar](200) NULL,
	[transfer_reference_id] [varchar](200) NULL,
	[pantry_item] [varchar](5) NULL,
	[comp_id] [varchar](200) NULL,
	[check_number] [int] NULL,
	[exclude_tax] [varchar](5) NULL,
	[reference_number] [varchar](200) NULL,
	[comp_reference_id] [varchar](200) NULL,
	[room_id] [varchar](200) NULL,
	[routed] [varchar](5) NULL,
	[source_folio_line_item_id] [varchar](200) NULL,
	[payment_method_id] [varchar](200) NULL,
	[posting_rule_id] [varchar](200) NULL,
	[issuer] [varchar](500) NULL,
	[last_four_digits] [varchar](200) NULL,
	[payment_interface_id] [varchar](200) NULL,
	[revised_adjustment_amount] [money] NULL,
	[is_manage_dispute_adjustment] [varchar](5) NULL,
	[corrected_or_adjusted_amount] [money] NULL,
	[deposit_payment_at_booking] [varchar](5) NULL,
	[auth_code] [varchar](500) NULL,
	[above_property_payment] [varchar](5) NULL,
	[early_departure] [varchar](5) NULL,
	[card_subtype] [varchar](500) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_line_items_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--===========================================================================================
-- 5) drop the [dbo].[line_items_Delta] table
--
-- 6) recreate the [dbo].[line_items_Delta] table adding the three new columns:
--	[above_property_payment] [varchar](5) NULL,
--	[early_departure] [varchar](5) NULL,
--	[card_subtype] [varchar](500) NULL,
--============================================================================================

DROP TABLE IF  EXISTS [dbo].[line_items_Delta]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[line_items_Delta](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](10) NOT NULL,
	[property_id] [varchar](10) NOT NULL,
	[account_id] [varchar](200) NULL,
	[amount] [money] NULL,
	[category_id] [varchar](200) NULL,
	[display_date] [date] NULL,
	[folio_id] [varchar](200) NULL,
	[accounting_item_id] [varchar](200) NULL,
	[ledger_id] [varchar](200) NULL,
	[quantity] [int] NULL,
	[room_revenue] [varchar](5) NULL,
	[subcategory_id] [varchar](200) NULL,
	[user_id] [varchar](200) NULL,
	[ledger_lines_ledger_transaction_id] [varchar](200) NULL,
	[folio_lines_ledger_transaction_id] [varchar](200) NULL,
	[tax_reference_id] [varchar](200) NULL,
	[adjustment_reference_id] [varchar](200) NULL,
	[call_type] [varchar](300) NULL,
	[correction_reference_id] [varchar](200) NULL,
	[description] [varchar](500) NULL,
	[free_allowance_amount] [money] NULL,
	[gateway_type] [varchar](300) NULL,
	[gift_card] [varchar](5) NULL,
	[invalid] [varchar](5) NULL,
	[meal_period_id] [varchar](200) NULL,
	[rate_change_comment] [varchar](500) NULL,
	[reason] [varchar](500) NULL,
	[recurring_charge_id] [varchar](200) NULL,
	[reference] [varchar](500) NULL,
	[refund_reference_id] [varchar](200) NULL,
	[reservation_id] [varchar](200) NULL,
	[reverse_tax_total_charge_amount] [money] NULL,
	[reverse_tax] [varchar](5) NULL,
	[room_charge_posting_type] [varchar](500) NULL,
	[source_id] [varchar](200) NULL,
	[transfer_reference_id] [varchar](200) NULL,
	[pantry_item] [varchar](5) NULL,
	[comp_id] [varchar](200) NULL,
	[check_number] [int] NULL,
	[exclude_tax] [varchar](5) NULL,
	[reference_number] [varchar](200) NULL,
	[comp_reference_id] [varchar](200) NULL,
	[room_id] [varchar](200) NULL,
	[routed] [varchar](5) NULL,
	[source_folio_line_item_id] [varchar](200) NULL,
	[payment_method_id] [varchar](200) NULL,
	[posting_rule_id] [varchar](200) NULL,
	[issuer] [varchar](500) NULL,
	[last_four_digits] [varchar](200) NULL,
	[payment_interface_id] [varchar](200) NULL,
	[revised_adjustment_amount] [money] NULL,
	[is_manage_dispute_adjustment] [varchar](5) NULL,
	[corrected_or_adjusted_amount] [money] NULL,
	[deposit_payment_at_booking] [varchar](5) NULL,
	[auth_code] [varchar](500) NULL,
	[above_property_payment] [varchar](5) NULL,
	[early_departure] [varchar](5) NULL,
	[card_subtype] [varchar](500) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_line_items_delta_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--===========================================================================================
-- 7) alter the [dbo].[usp_Load_line_items_Delta] stored proc
--   Add the three new columns at the spots
--   Comment out the WHERE clause so that the newly re-created table is loaded from scratch 
--
-- 8) recreate the [dbo].[line_items_Delta] table adding the three new columns:
--	[above_property_payment] [varchar](5) NULL,
--	[early_departure] [varchar](5) NULL,
--	[card_subtype] [varchar](500) NULL,
--============================================================================================

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_Load_line_items_Delta]
AS
------------------------------------------------------------------------------------------------
-- Get the delta since the last time the data was loaded.  Select all rows with the display_date
-- >= the max display_date in the permanent table
------------------------------------------------------------------------------------------------
TRUNCATE TABLE dbo.line_items_Delta

INSERT INTO dbo.line_items_Delta 
SELECT 
  [id] --PK
, [tenant_id] --PK
, [property_id] --PK

, [account_id]
, [amount]
, [category_id]
, [display_date]
, [folio_id]
, [accounting_item_id]
, [ledger_id]
, [quantity]
, [room_revenue]
, [subcategory_id]
, [user_id]
, [ledger_lines_ledger_transaction_id]
, [folio_lines_ledger_transaction_id]
, [tax_reference_id]
, [adjustment_reference_id]
, [call_type]
, [correction_reference_id]
, [description]
, [free_allowance_amount]
, [gateway_type]
, [gift_card]
, [invalid]
, [meal_period_id]
, [rate_change_comment]
, [reason]
, [recurring_charge_id]
, [reference]
, [refund_reference_id]
, [reservation_id]
, [reverse_tax_total_charge_amount]
, [reverse_tax]
, [room_charge_posting_type]
, [source_id]
, [transfer_reference_id]
, [pantry_item]
, [comp_id]
, [check_number]
, [exclude_tax]
, [reference_number]
, [comp_reference_id]
, [room_id]
, [routed]
, [source_folio_line_item_id]
, [payment_method_id]
, [posting_rule_id]
, [issuer]
, [last_four_digits]
, [payment_interface_id]
, [revised_adjustment_amount]
, [is_manage_dispute_adjustment]
, [corrected_or_adjusted_amount]
, [deposit_payment_at_booking]
, [auth_code]

-----------------------------------------------------------------------
-- add three new columns
-----------------------------------------------------------------------
, [above_property_payment]
, [early_departure]
, [card_subtype]

, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text

, CAST(account_id as varchar(200)) as account_id --text
, amount --numeric(19,2)
, CAST(category_id as varchar(200)) as category_id --text
, display_date --date
, CAST(folio_id as varchar(200)) as folio_id --text
, CAST(accounting_item_id as varchar(200)) as accounting_item_id --text
, CAST(ledger_id as varchar(200)) as ledger_id --text
, quantity --integer
, CAST(room_revenue as int) as room_revenue --boolean
, CAST(subcategory_id as varchar(200)) as subcategory_id --text
, CAST(user_id as varchar(200)) as user_id --text
, CAST(ledger_lines_ledger_transaction_id as varchar(200)) as ledger_lines_ledger_transaction_id --text
, CAST(folio_lines_ledger_transaction_id as varchar(200)) as folio_lines_ledger_transaction_id --text
, CAST(tax_reference_id as varchar(200)) as tax_reference_id --text
, CAST(adjustment_reference_id as varchar(200)) as adjustment_reference_id --text
, CAST(call_type as varchar(200)) as call_type --text
, CAST(correction_reference_id as varchar(200)) as correction_reference_id --text
, CAST(description as varchar(500)) as description --text
, free_allowance_amount --numeric(19,2)
, CAST(gateway_type as varchar(300)) as gateway_type --text
, CAST(gift_card as int) as gift_card --boolean
, CAST(invalid as int) as invalid --boolean
, CAST(meal_period_id as varchar(200)) as meal_period_id --text
, CAST(rate_change_comment as varchar(500)) as rate_change_comment --text
, CAST(reason as varchar(500)) as reason --text
, CAST(recurring_charge_id as varchar(200)) as recurring_charge_id --text
, CAST(reference as varchar(500)) as reference --text
, CAST(refund_reference_id as varchar(200)) as refund_reference_id --text
, CAST(reservation_id as varchar(200)) as reservation_id --text
, reverse_tax_total_charge_amount --numeric(19,2)
, CAST(reverse_tax as int) as reverse_tax --boolean
, CAST(room_charge_posting_type as varchar(500)) as room_charge_posting_type --text
, CAST(source_id as varchar(200)) as source_id --text
, CAST(transfer_reference_id as varchar(200)) as transfer_reference_id --text
, CAST(pantry_item as int) as pantry_item --boolean
, CAST(comp_id as varchar(200)) as comp_id --text
, check_number --bigint
, CAST(exclude_tax as int) as exclude_tax --boolean
, CAST(reference_number as varchar(200)) as reference_number --text
, CAST(comp_reference_id as varchar(200)) as comp_reference_id --text
, CAST(room_id as varchar(200)) as room_id --text
, CAST(routed as int) as routed --boolean
, CAST(source_folio_line_item_id as varchar(200)) as source_folio_line_item_id --text
, CAST(payment_method_id as varchar(200)) as payment_method_id --text
, CAST(posting_rule_id as varchar(200)) as posting_rule_id --text
, CAST(issuer as varchar(500)) as issuer --text
, CAST(last_four_digits as varchar(200)) as last_four_digits --text
, CAST(payment_interface_id as varchar(200)) as payment_interface_id --text
, revised_adjustment_amount --numeric(19,2)
, CAST(is_manage_dispute_adjustment as int) as is_manage_dispute_adjustment --boolean
, corrected_or_adjusted_amount --numeric(19,2)
, CAST(deposit_payment_at_booking as int) as deposit_payment_at_booking --payment_interface_id
, CAST(auth_code as varchar(500)) as auth_code --text

-- add three new columns
, CAST(above_property_payment as varchar(5)) as above_property_payment  --text
, CAST(early_departure as varchar(5)) as early_departure  --text
, CAST(card_subtype as varchar(500)) as card_subtype  --text

FROM public.line_items

-----------------------------------------------------------------------
-- comment out the where clause to  allow a full load from scratch
-----------------------------------------------------------------------
--WHERE display_date >= current_timestamp - interval ''120 days''

'
) ;

--------------------------------------------------------------------------------------------
-- INSERT delta table into the perm table -- where the new row does not already exist in the 
-- perm table. 
---------------------------------------------------------------------------------------------
INSERT INTO [StayDWH].dbo.line_items
SELECT delta.[id]
      ,delta.[tenant_id]
      ,delta.[property_id]
      ,delta.[account_id]
      ,delta.[amount]
      ,delta.[category_id]
      ,delta.[display_date]
      ,delta.[folio_id]
      ,delta.[accounting_item_id]
      ,delta.[ledger_id]
      ,delta.[quantity]
      ,delta.[room_revenue]
      ,delta.[subcategory_id]
      ,delta.[user_id]
      ,delta.[ledger_lines_ledger_transaction_id]
      ,delta.[folio_lines_ledger_transaction_id]
      ,delta.[tax_reference_id]
      ,delta.[adjustment_reference_id]
      ,delta.[call_type]
      ,delta.[correction_reference_id]
      ,delta.[description]
      ,delta.[free_allowance_amount]
      ,delta.[gateway_type]
      ,delta.[gift_card]
      ,delta.[invalid]
      ,delta.[meal_period_id]
      ,delta.[rate_change_comment]
      ,delta.[reason]
      ,delta.[recurring_charge_id]
      ,delta.[reference]
      ,delta.[refund_reference_id]
      ,delta.[reservation_id]
      ,delta.[reverse_tax_total_charge_amount]
      ,delta.[reverse_tax]
      ,delta.[room_charge_posting_type]
      ,delta.[source_id]
      ,delta.[transfer_reference_id]
      ,delta.[pantry_item]
      ,delta.[comp_id]
      ,delta.[check_number]
      ,delta.[exclude_tax]
      ,delta.[reference_number]
      ,delta.[comp_reference_id]
      ,delta.[room_id]
      ,delta.[routed]
      ,delta.[source_folio_line_item_id]
      ,delta.[payment_method_id]
      ,delta.[posting_rule_id]
      ,delta.[issuer]
      ,delta.[last_four_digits]
      ,delta.[payment_interface_id]
      ,delta.[revised_adjustment_amount]
      ,delta.[is_manage_dispute_adjustment]
      ,delta.[corrected_or_adjusted_amount]
      ,delta.[deposit_payment_at_booking]
      ,delta.[auth_code]

-----------------------------------------------------------------------
-- add three new columns
-----------------------------------------------------------------------
	  ,delta.[above_property_payment]
	  ,delta.[early_departure] [varchar]
	  ,delta.[card_subtype]

      ,delta.[Local_ETL_Inserted_TS]
      ,delta.[Local_ETL_Updated_TS]

FROM [StayDWH].[dbo].[line_items_Delta] delta

LEFT OUTER JOIN [StayDWH].[dbo].[line_items] perm
ON delta.[id] = perm.[id]

WHERE perm.[id] IS NULL

--===========================================================================================
-- 9) RUN the [dbo].[usp_Load_line_items_Delta] stored proc to load all data from scratch
--
-- 10) UNCOMMENT the WHERE clause and re-compile 
--============================================================================================


WHERE display_date >= current_timestamp - interval ''120 days''

