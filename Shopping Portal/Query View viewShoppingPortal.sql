USE CMP13

SELECT TOP 1000 
  playerid
, acct
, FirstName
, MiddleInitial
, LastName
, ClubStatus
, HomeEmail
, IsEmailSend
, HomeAddr1
, HomeAddr2
, HomeCity
, HomeCountryCode
, HomeCountryName
, HomePostalCode
, HomeStateCode
, HomeStateName
, PtsBal 

----INTO _Dev_ShoppingPortal.dbo.tShoppingPortal

FROM CMP13.dbo.viewPlayersViejas

WHERE LastTripStartTranCodeGamingDt >= '02/01/2020'

----------------------------------
SELECT *

FROM CMP13.dbo.viewShoppingPortal	
