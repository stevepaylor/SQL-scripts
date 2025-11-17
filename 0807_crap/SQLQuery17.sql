USE [StayDWH]
GO

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
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

INTO dbo.line_items_0201_PLUS

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

FROM public.line_items

WHERE display_date >= ''2025-02-01''::date
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
      ,delta.[Local_ETL_Inserted_TS]
      ,delta.[Local_ETL_Updated_TS]

FROM [StayDWH].[dbo].[line_items_0201_PLUS] delta

LEFT OUTER JOIN [StayDWH].[dbo].[line_items] perm
ON delta.[id] = perm.[id]

WHERE perm.[id] IS NULL

--07/24
--(3128 rows affected)
--(2276 rows affected)

--07/25
--(4069 rows affected)
--(2853 rows affected)

--07/26
--(3947 rows affected)
--(2861 rows affected)

--07/27
--(3917 rows affected)
--(2699 rows affected)

--07/28
--(2969 rows affected)
--(2051 rows affected)

--07/29
--(2694 rows affected)
--(1526 rows affected)

--07/30
--(2594 rows affected)
--(1939 rows affected)

--07/31
--(3003 rows affected)
--(2230 rows affected)

--08/01
--(3779 rows affected)
--(2636 rows affected)

--08/02
--(3902 rows affected)
--(2732 rows affected)

--08/03
--(3822 rows affected)
--(2366 rows affected)

--08/04
--(2624 rows affected)
--(1574 rows affected)

--08/05
--(442 rows affected)
--(6 rows affected)

--07/24+++
--(40890 rows affected)
--(0 rows affected)

----07/01+++
--(111476 rows affected)
--(154 rows affected)

----06/01+++
--(201146 rows affected)
--(15 rows affected)