 SELECT
 'NEW' Which_DWH
, h_reservationID
, h_arrivalDate
, h_membershipNumber
, h_guestName
--, h_numberNights
--, h_reservationStatus
, h_arrivalDate
, Total_Theo_3monthLGD
, visits_3monthLGD
, ADP_3monthLGD

 FROM [iQ-Gaming].Opera_5_0.vHotel2

 WHERE h_membershipNumber IN 
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

UNION 

SELECT
 'OLD' Which_DWH
, h_reservationID
, h_arrivalDate
, h_membershipNumber
, h_guestName
--, h_numberNights
--, h_reservationStatus
, h_arrivalDate
, Total_Theo_3monthLGD
, visits_3monthLGD
, ADP_3monthLGD


 FROM MSBIDB01DV.OperaDm.dbo.vHotel2

 WHERE h_membershipNumber IN 
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

ORDER BY 
h_reservationID