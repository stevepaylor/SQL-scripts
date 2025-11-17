/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP(10) 
       [ARRIVAL_TS]
      ,[DEPARTURE_TS]
      ,[PLAYER_ID]

  FROM [vBus].[dbo].[JUNKET_COMMISSIONS]

  ORDER BY
       [ARRIVAL_TS] DESC
      ,[DEPARTURE_TS] 
      ,[PLAYER_ID]
GO

SELECT TOP(10) 
       [ARRIVAL_TS]
      ,[DEPARTURE_TS]
      ,[PLAYER_ID]

  FROM [vBus].[dbo].[JUNKET_COMMISSIONS_ARCHIVE]

  ORDER BY
       [ARRIVAL_TS] DESC
      ,[DEPARTURE_TS] 
      ,[PLAYER_ID]
GO