USE [ig_business]
GO

SELECT CAST([transaction_data_id] AS int) AS transaction_data_id
      ,[tender_dim_id]
      ,[tender_sequence_id]
      ,[credit_type_id]
      ,[tender_amount]
      ,[change_amount]
      ,[received_amount]
      ,[breakage_amount]
      ,[tip_amount]
      ,[additional_tender_data]
      ,[coupon_dim_id]
      ,[authorizing_emp_dim_id]
      ,[coupon_quantity]
      ,[posting_account]
      ,[ar_ti_val]
  FROM [ig_business].[dbo].[Check_Tender_Detail]
GO


