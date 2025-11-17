SELECT 
  [RATE_DATE]
, COUNT(*) as Record_count
, SUM([Room_Comp]) as [Room_Comp]
, SUM([Food_Comp]) as [Food_Comp]
, SUM([Misc_Comp]) as [Misc_Comp]

FROM [StayDWH].[dbo].[vw_Name_Reservation]

WHERE RATE_DATE BETWEEN '2025-09-05' AND '2025-09-07'

GROUP BY RATE_DATE 
ORDER BY RATE_DATE DESC

SELECT [BusinessDate]
      , count(*) as record_count
      ,sum([Award_CompsUsed_Hotel_MKTG]) as [Award_CompsUsed_Hotel_MKTG]
      ,sum([Award_CompsUsed_Hotel_Finance]) as [Award_CompsUsed_Hotel_Finance]
      ,sum([Hotel_CompsNoRooms_GrossAmount]) as [Hotel_CompsNoRooms_GrossAmount]
      ,sum([MarketingOffer]) as [MarketingOffer]
      ,sum([DiscretionaryOffer]) as [DiscretionaryOffer]
      ,sum([RainMakerOffer]) as [RainMakerOffer]

  FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Hotel]

  where [BusinessDate] BETWEEN '2025-09-05' AND '2025-09-07'

  GROUP BY BusinessDate

  ORDER BY BusinessDate DESC

  SELECT [gaming_date]
      
      ,sum([award_CompsUsed_Hotel_Finance]) as fin
      ,sum([award_CompsUsed_Hotel_Mktg]) as mkt
     
  FROM [iQ-Gaming].[Tableau].[player_daily_fact]
  where gaming_date > '9/4/2025'
  group by gaming_date
  order by gaming_date desc
