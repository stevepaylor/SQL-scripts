SELECT 
  [RATE_DATE]
, [Reservation_id]
, [Room_Comp]
, [Food_Comp]
, [Misc_Comp]

FROM [StayDWH].[dbo].[vw_Name_Reservation]

WHERE RATE_DATE BETWEEN '2025-08-10' AND '2025-08-19'
  --AND (ISNULL([Room_Comp],0) <> 0
  --     OR ISNULL([Food_Comp],0) <> 0
  --     OR ISNULL([Misc_Comp],0) <> 0)

 ORDER BY RATE_DATE DESC


