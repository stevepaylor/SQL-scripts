 SELECT
  new.h_reservationID new_h_reservationID
, old.h_reservationID old_h_reservationID
--, new.h_membershipNumber new_h_membershipNumber
--, old.h_membershipNumber old_h_membershipNumber
--, new.h_guestName new_h_guestName
--, old.h_guestName old_h_guestName
--, new.h_numberNights new_h_numberNights
--, old.h_numberNights old_h_numberNights
--, new.h_reservationStatus new_h_reservationStatus
--, old.h_reservationStatus new_h_reservationStatus
--, new.h_arrivalDate new_h_arrivalDate
--, old.h_arrivalDate old_h_arrivalDate
, new.visits_3monthLGD new_visits_3monthLGD
, old.visits_3monthLGD old_visits_3monthLGD
, new.Total_Theo_3monthLGD new_Total_Theo_3monthLGD
, old.Total_Theo_3monthLGD old_Total_Theo_3monthLGD
, new.ADP_3monthLGD new_ADP_3monthLGD
, old.ADP_3monthLGD old_ADP_3monthLGD

 FROM [iQ-Gaming].Opera_5_0.vHotel2 new

 FULL OUTER JOIN  MSBIDB01DV.OperaDm.dbo.vHotel2 old
 ON new.h_reservationID = old.h_reservationID

 WHERE new.h_membershipNumber IN 
 (
  '21025194'
, '20628198'
, '20314765'
, '20345983'
, '12555049'
, '20033228'
, '20468225'
, '20240749'
, '60040849'
, '20047740'
)

  --AND (new.visits_3monthLGD <> old.visits_3monthLGD
  --    OR new.Total_Theo_3monthLGD <> old.Total_Theo_3monthLGD
	 -- OR new.ADP_3monthLGD <> old.ADP_3monthLGD)