/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [AverageRate]
      ,[CurrencyID]
      ,[CurrencyDate]
      ,[EndOfDayRate]
      ,[CurrencyKey]
      ,[DateKey]
      ,[CurrencyAlternateKey]
  FROM [AdventureWorksDW2012].[dbo].[NewFactCurrencyRate]

--TRUNCATE TABLE [AdventureWorksDW2012].[dbo].[NewFactCurrencyRate]