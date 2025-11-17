USE [ig_business]
GO

SELECT CAST([transaction_data_id] AS int) AS transaction_data_id
      ,CAST([discount_dim_id] AS int) AS discount_dim_id
      ,[discount_sequence_id]
      ,[authorizing_emp_dim_id]
      ,[discount_amount]
      ,[extra_text]
  FROM [ig_business].[dbo].[Check_Discount_Detail]


GO


