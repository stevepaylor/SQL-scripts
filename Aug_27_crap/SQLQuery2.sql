SELECT cast([gaming_date] as DATE) as gaming_date
      ,[award_HotelReservations]
      ,[award_CompsUsed_Hotel_Finance]
      ,[award_CompsUsed_Hotel_Mktg]
      ,[award_CompsUsed_Hotel_Folio]
      ,[award_CompsUsed_Total_Finance]
      ,[award_CompsUsed_Total_Mktg]
FROM [iQ-Gaming].[Tableau].[player_daily_fact]

WHERE gaming_date = '2025-08-25'


SELECT cast([gaming_date] as DATE) as gaming_date
      , SUM([award_HotelReservations]) AS award_HotelReservations
      , SUM([award_CompsUsed_Hotel_Finance]) AS award_CompsUsed_Hotel_Finance
      , SUM([award_CompsUsed_Hotel_Mktg]) AS award_CompsUsed_Hotel_Mktg
      , SUM([award_CompsUsed_Hotel_Folio]) AS award_CompsUsed_Hotel_Folio
      , SUM([award_CompsUsed_Total_Finance]) AS award_CompsUsed_Total_Finance
      , SUM([award_CompsUsed_Total_Mktg]) AS award_CompsUsed_Total_Mktg 

FROM [iQ-Gaming].[Tableau].[player_daily_fact]

WHERE gaming_date = '2025-08-25'

GROUP BY gaming_date