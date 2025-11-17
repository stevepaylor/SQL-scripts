/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id]
      ,[tenant_id]
      ,[property_id]
      ,[date]
      ,[closed]
      ,[created_by]
      ,[created_time]
      ,[Local_ETL_Inserted_TS]
	  ,SWITCHOFFSET([Local_ETL_Inserted_TS]  AT TIME ZONE 'Pacific Standard Time', '+00:00') as Local_ETL_Inserted_TS_UTC
      ,[Local_ETL_Updated_TS]
	  ,SWITCHOFFSET([Local_ETL_Updated_TS]  AT TIME ZONE 'Pacific Standard Time', '+00:00') as Local_ETL_Updated_TS_UTC

  FROM [StayDWH].[dbo].[accounting_dates]

  -- SELECT SWITCHOFFSET(YourOriginalDateTime AT TIME ZONE 'Pacific Standard Time', '+00:00')
-- Either of these will interpret the input in Pacific time, properly account for whether or not DST is in effect, 
-- and then convert to UTC. The result will be a datetimeoffset with a zero offset.
