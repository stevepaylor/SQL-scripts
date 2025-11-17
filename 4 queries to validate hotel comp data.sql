SET NOCOUNT ON ;

SELECT 'StayDWH iQ_Gaming_Hotel_Transactions Table' ;
SELECT 
  [RATE_DATE]
, COUNT(*) as [Record_count]
, SUM([Room_Comp]) as [Room_Comp]
, SUM([Food_Comp]) as [Food_Comp]
, SUM([Misc_Comp]) as [Misc_Comp]

FROM [StayDWH].[dbo].[iQ_Gaming_Hotel_Transactions]

WHERE [RATE_DATE] >= DATEADD(DAY,-5,GETDATE())
  AND [RATE_DATE] <= GETDATE()

GROUP BY [RATE_DATE]
ORDER BY [RATE_DATE] DESC ;

---------------------------------------------------------------

SELECT 'StayDWH vw_Name_Reservation View' ;
SELECT 
  [RATE_DATE]
, COUNT(*) as [Record_count]
, SUM([Room_Comp]) as [Room_Comp]
, SUM([Food_Comp]) as [Food_Comp]
, SUM([Misc_Comp]) as [Misc_Comp]

FROM [StayDWH].[dbo].[vw_Name_Reservation]

WHERE [RATE_DATE] >= DATEADD(DAY,-5,GETDATE())
  AND [RATE_DATE] <= GETDATE()

GROUP BY [RATE_DATE]
ORDER BY [RATE_DATE] DESC

---------------------------------------------------------------

SELECT 'iQ-Gaming v_IQC_Player_Daily_Hotel View' ;
SELECT 
  [BusinessDate]
, COUNT(*) as [Record_count]
, SUM([Award_CompsUsed_Hotel_MKTG]) as [Award_CompsUsed_Hotel_MKTG]
, SUM([Award_CompsUsed_Hotel_Finance]) as [Award_CompsUsed_Hotel_Finance]
, SUM([Hotel_CompsNoRooms_GrossAmount]) as [Hotel_CompsNoRooms_GrossAmount]
, SUM([MarketingOffer]) as [MarketingOffer]
, SUM([DiscretionaryOffer]) as [DiscretionaryOffer]
, SUM([RainMakerOffer]) as [RainMakerOffer]

FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Hotel]

WHERE [BusinessDate] >= DATEADD(DAY,-5,GETDATE())
  AND [BusinessDate] <= GETDATE()

GROUP BY [BusinessDate]
ORDER BY [BusinessDate] DESC

---------------------------------------------------------------

SELECT 'iQ-Gaming Tableau.player_daily_fact View' ;
SELECT 
  [gaming_date]
, SUM([award_CompsUsed_Hotel_Finance]) as fin
, SUM([award_CompsUsed_Hotel_Mktg]) as mkt
, SUM([slot_total_bet]) as coinin
     
FROM [iQ-Gaming].[Tableau].[player_daily_fact]

WHERE [gaming_date] >= DATEADD(DAY,-5,GETDATE())
  AND [gaming_date] <= GETDATE()

GROUP BY [gaming_date]
ORDER BY [gaming_date] DESC