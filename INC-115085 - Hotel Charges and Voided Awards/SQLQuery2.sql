SELECT A.[PlayerId]
, B.Acct
      ,[BusinessDate]
      ,[BusinessDateID]
      ,[Award_CompsUsed_Hotel_MKTG]
      ,[Award_CompsUsed_Hotel_Finance]
      ,[Hotel_CompsNoRooms_GrossAmount]
      ,[MarketingOffer]
      ,[DiscretionaryOffer]
      ,[RainMakerOffer]
  FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Hotel] A
  JOIN [iQ-Gaming].[CMP_13-1].[tPlayerCard] B
    ON A.PlayerId = B.PlayerId

  WHERE B.Acct = 12552384
  --WHERE A.[PlayerId] = 105

ORDER BY [BusinessDate] DESC
