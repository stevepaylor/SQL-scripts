DROP TABLE IF EXISTS #Stay_Hotel_Transactions

SELECT SW.Room_comp, SW.Food_Comp + SW.Misc_Comp AS Room_Charges, SW.RATE_DATE, Q.DateId,
CASE WHEN SW.Room_comp = 0 THEN 0 ELSE HCR.WD_Rate END AS WD_Rate,  
CASE WHEN SW.Room_comp = 0 THEN 0 ELSE HCR.WE_Rate END AS WE_Rate, ISNULL(PC.PlayerId, 0) AS PlayerId, SW.RESV_NAME_ID, HCR.RoomCode,
SW.Rate_Code,
SW.Promotions,
ROOM_CATEGORY_LABEL

--INTO #Stay_Hotel_Transactions

FROM [StayDWH].[dbo].iQ_Gaming_Hotel_Transactions SW 
LEFT JOIN [iQ-Gaming].[CMP_13-1].tPlayerCard PC ON SW.MEMBERSHIP_NUMBER = PC.Acct
LEFT JOIN [iQ-Gaming].[VCR].[HotelCompRate] HCR ON SW.ROOM_CATEGORY_LABEL = HCR.ROOMCODE
INNER JOIN [iQ-Gaming].[dbo].IQ_Calendar Q ON SW.RATE_DATE = Q.CalendarDate 

WHERE ISNULL(PC.PlayerId, 0) <> 0

order by RATE_DATE desc
