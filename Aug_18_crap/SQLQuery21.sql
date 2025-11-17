SELECT [gaming_date]
      
      ,sum([award_CompsUsed_Hotel_Finance]) as fin
      ,sum([award_CompsUsed_Hotel_Mktg]) as mkt
     
  FROM [iQ-Gaming].[Tableau].[player_daily_fact]
  where gaming_date > '8/25/2025'
  group by gaming_date
  order by gaming_date desc
