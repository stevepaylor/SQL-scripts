USE [ig_business]
GO

SELECT     CAST(transaction_data_id AS int) AS transaction_data_id, tendered_business_period_dim_id, posted_business_period_dim_id, opened_business_period_dim_id, 
                      adjusted_business_period_dim_id, profit_center_dim_id, server_emp_dim_id, meal_period_dim_id, check_type_dim_id, event_dim_id, check_number, 
                      associated_check_number, sales_gross_amount, num_covers, discount_amount, tax_amount, tender_amount, gratuity_amount, tip_amount, service_charge_amount, 
                      transaction_data_tag, table_number, refund_flag, num_seconds_open, cashier_emp_dim_id, opened_date_time, tendered_date_time, opened_terminal_id, 
                      tendered_terminal_id, rounded_amount, opened_terminal_dim_id, tendered_terminal_dim_id, void_state, void_reason_dim_id, authorizing_emp_dim_id, 
                      discount_state, taxable_sales_amount, non_taxable_sales_amount, is_vat_flag, vat_gratuity_amount, vat_service_charge_amount, account_receivable_number, 
                      tax_invoice_number
FROM         dbo.Check_Sales_Detail
GO