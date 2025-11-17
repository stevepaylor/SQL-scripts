/****** Script for SelectTopNRows command from SSMS  ******/
USE it_trn_v1
SELECT TOP (5) [BD_end_dttime] ,[BD_start_dttime] ,[bus_day_id]
  FROM [Business_Day_Dates]
  order by BD_start_dttime desc
 
USE ig_dimension_v1
Select top 5 * from [dbo].[Business_Period_Dimension]
order by business_period_dim_id desc

USE ig_business_v1
select top 10  opened_date_time, * from [dbo].[Check_Sales_Detail] csd
order by csd.opened_date_time desc

USE ig_transaction_v1
select top 100 * from Transaction_Master
order by transaction_data_id desc




