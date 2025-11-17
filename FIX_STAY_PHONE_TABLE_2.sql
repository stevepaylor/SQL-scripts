--SELECT * /*SW.Room_comp, SW.Food_Comp + SW.Misc_Comp AS Room_Charges, SW.RATE_DATE, Q.DateId,
--CASE WHEN SW.Room_comp = 0 THEN 0 ELSE HCR.WD_Rate END AS WD_Rate,  
--CASE WHEN SW.Room_comp = 0 THEN 0 ELSE HCR.WE_Rate END AS WE_Rate, ISNULL(PC.PlayerId, 0) AS PlayerId, SW.RESV_NAME_ID, HCR.RoomCode,
--SW.Rate_Code,
--SW.Promotions*/
----INTO #Stay_Hotel_Transactions 
--FROM [DWHDB01PR].[StayDWH].[dbo].vw_Name_Reservation SW (NOLOCK)
--LEFT JOIN [CMP_13-1].tPlayerCard PC ON SW.MEMBERSHIP_NUMBER = PC.Acct
--LEFT JOIN [VCR].[HotelCompRate] HCR ON SW.ROOM_CATEGORY_LABEL = HCR.ROOMCODE
--INNER JOIN [dbo].IQ_Calendar Q ON SW.RATE_DATE = Q.CalendarDate 
--WHERE SW.OFFER_STATUS = 'REDEEMED'
--AND SW.RATE_DATE >= DATEADD(day,-3,GETDATE()) --'2024-03-18' This was the date we went live with Stay in the event we need to rebuild
----AND SW.RATE_DATE >=  '2024-03-18'
----AND SW.RATE_DATE BETWEEN  '2024-03-18' AND '2024-06-18'
----AND (ISNULL(SW.Food_Comp,0) <> 0 OR ISNULL(SW.Misc_Comp,0) <> 0 OR ISNULL(SW.Room_comp,0) <> 0)
--AND PlayerId = 10837083
--ORDER BY PlayerID

select * from [DWHDB01PR].[StayDWH].[dbo].phones where number in ('6195699098','6199017596')
--update phones set [default] = 0 where id = '685c6df75246566a1414b0bc'

SELECT TOP 1000 *
FROM [DWHDB01PR].[StayDWH].[dbo].vw_Name_Reservation (NOLOCK)
--WHERE Reservation_id = '685c6df75246566a1414b0bf'
--WHERE Reservation_id = '685c6df75246566a1414b0bf'

SELECT --TOP 1000 
  res.Reservation_id
, res.GUEST_PHONE as RES_Guest_Phone
, ph.number as PH_Phone_Number
, ph.[id] as PH_id
, ph.reference_id as PH_reference_id
, ph.[default] as PH_default

FROM [DWHDB01PR].[StayDWH].[dbo].vw_Name_Reservation res (NOLOCK)
JOIN [DWHDB01PR].[StayDWH].[dbo].phones ph --(NOLOCK)
ON res.GUEST_PHONE = ph.number --('6195699098','6199017596')

WHERE res.GUEST_PHONE <> 'X'