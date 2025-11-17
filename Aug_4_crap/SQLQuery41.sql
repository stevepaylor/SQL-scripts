SELECT
  SW.Room_comp
, SW.Food_Comp
, SW.Misc_Comp
, SW.RATE_DATE
, SW.RESV_NAME_ID
, SW.ROOM_CATEGORY_LABEL
, SW.Rate_Code
, SW.Promotions
, SW.OFFER_STATUS
, SW.MEMBERSHIP_NUMBER


FROM [DWHDB01PR].[StayDWH].[dbo].vw_Name_Reservation SW (NOLOCK)

WHERE SW.RATE_DATE between '2025-07-22' and '2025-08-04'
  AND SW.OFFER_STATUS = 'REDEEMED'
  --AND (ISNULL(SW.Food_Comp,0) <> 0 OR ISNULL(SW.Misc_Comp,0) <> 0 OR ISNULL(SW.Room_comp,0) <> 0)

ORDER BY SW.RATE_DATE desc