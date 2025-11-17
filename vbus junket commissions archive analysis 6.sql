USE [vBus]
GO

SELECT [TIER_ID]
      ,[TIER_NM]
      ,[GROUP_CD]
      ,[GROUP_NM]
      ,[EVENT_ID]
      ,[ARRIVAL_TS]
      ,[DEPARTURE_TS]
      ,[PLAYER_ID]
      ,[ACCT_NUM]
      ,[LAST_NM]
      ,[FIRST_NM]
      ,[THEORETICAL_WIN_TOTAL]
      ,[CASINO_WIN_TOTAL]
      ,[COMMISSION_ID]
      ,[LOW_THEORETICAL_AMT]
      ,[HIGH_THEORETICAL_AMT]
      ,[COMMISSION_TOTAL]
into [dbo].[JUNKET_COMMISSIONS_ARCHIVE_save]
  FROM [dbo].[JUNKET_COMMISSIONS_ARCHIVE]
GO






