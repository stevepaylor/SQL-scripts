SELECT CAST([gaming_date] AS DATE) [gaming_date]
      ,COUNT(*) as [Rows]
      ,SUM([award_HotelReservations]) As Reservation
      ,SUM([award_CompsUsed_Hotel_Finance]) [award_CompsUsed_Hotel_Finance]
      ,SUM([award_CompsUsed_Hotel_Mktg]) [award_CompsUsed_Hotel_Mktg]
      ,SUM([award_CompsUsed_Hotel_Folio]) [award_CompsUsed_Hotel_Folio]
      ,SUM([award_CompsUsed_Total_Finance]) [award_CompsUsed_Total_Finance]
      ,SUM([award_CompsUsed_Total_Mktg]) [award_CompsUsed_Total_Mktg]
FROM [iQ-Gaming].[Tableau].[player_daily_fact]
WHERE gaming_date >= '2025-08-26'
GROUP BY gaming_date
ORDER BY gaming_date DESC

SELECT BusinessDate
      ,COUNT(*) as [Rows]
      ,SUM(Award_CompsUsed_Hotel_Finance) Award_CompsUsed_Hotel_Finance
      ,SUM(Hotel_CompsNoRooms_GrossAmount) Hotel_CompsNoRooms_GrossAmount
-- SELECT TOP 10 *
FROM [iQ-Gaming].dbo.[IQC_Player_Daily_Hotel] WITH (NOLOCK)
WHERE SourceSystem ='ST'
AND BusinessDate >= '2025-08-26'
GROUP BY BusinessDate
ORDER BY BusinessDate DESC

