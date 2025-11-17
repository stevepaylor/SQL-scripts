USE [ig_business]
GO

SELECT CAST([transaction_data_id] AS int) AS transaction_data_id
      ,CAST([menu_item_dim_id] AS int) AS menu_item_dim_id
      ,[menu_item_status]
      ,CAST([void_reason_dim_id] AS int) AS void_reason_dim_id
      ,[menu_item_sales_amount]
      ,[menu_item_discount_amount]
      ,[menu_item_quantity]
      ,[emp_dim_id]
      ,[consumed_quantity]
      ,[consumed_cost_amount]
      ,[consumed_weight_amount]
      ,[revenue_cost_amount]
      ,[revenue_weight_amount]
      ,[revenue_quantity]
      ,[calculated_gross_sales_amount]
      ,[calculated_discount_amount]
      ,[sku]
      ,[price]
      ,[hide_on_rrv_report]
  FROM [ig_business].[dbo].[Check_Item_Detail]
GO


