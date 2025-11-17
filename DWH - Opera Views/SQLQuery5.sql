SELECT
 'NEW' Which_DWH
, h_reservationID
, h_arrivalDate
, h_membershipNumber
, PlayerId
, h_guestName
--, h_numberNights
--, h_reservationStatus
, h_arrivalDate
, Total_Theo_3monthLGD
, visits_3monthLGD
, ADP_3monthLGD

FROM [iQ-Gaming].Opera_5_0.vHotel_temp_new -- same content as vHotel view

WHERE h_reservationID IN 
 (
  '1650989'
, '1654889'
, '1657190'
, '1646973'
, '1657180'
, '1650969'
, '1653851'
, '1657837'
, '1637626'
, '1657171'
)

UNION 

SELECT
 'OLD' Which_DWH
, h_reservationID
, h_arrivalDate
, h_membershipNumber
, NULL PlayerId
, h_guestName
--, h_numberNights
--, h_reservationStatus
, h_arrivalDate
, Total_Theo_3monthLGD
, visits_3monthLGD
, ADP_3monthLGD


FROM MSBIDB01DV.OperaDm.dbo.vHotel

WHERE h_reservationID IN 
 (
  '1650989'
, '1654889'
, '1657190'
, '1646973'
, '1657180'
, '1650969'
, '1653851'
, '1657837'
, '1637626'
, '1657171'
)

ORDER BY 
h_reservationID