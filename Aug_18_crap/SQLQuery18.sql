SELECT [PlayerId]
      ,[BusinessDate]
      ,[BusinessDateID]
      ,[Award_CompsUsed_Hotel_MKTG]
      ,[Award_CompsUsed_Hotel_Finance]
      ,[Hotel_CompsNoRooms_GrossAmount]
      ,[MarketingOffer]
      ,[DiscretionaryOffer]
      ,[RainMakerOffer]
  FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Hotel]

  where [BusinessDate] BETWEEN '2025-08-26' AND '2025-08-28'

  ORDER BY BusinessDate DESC
