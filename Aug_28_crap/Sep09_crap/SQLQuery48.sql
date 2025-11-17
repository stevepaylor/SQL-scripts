SELECT [DATE_KEY]
      ,[award_CompsUsed_Hotel_Finance]
      ,[award_CompsUsed_Hotel_Mktg]
      ,[award_CompsUsed_Hotel_Folio]
      ,[award_CompsUsed_Total_Finance]
      ,[award_CompsUsed_Total_Mktg]

FROM [iQ-Gaming].[player].[tab_daily_fact]

WHERE [DATE_KEY] >= 20250825

ORDER BY [DATE_KEY] DESC

