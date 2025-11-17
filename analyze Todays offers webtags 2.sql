SELECT DISTINCT
  pls.Acct
, pls.*
, tgs.PlayerID
, tgs.TagCode 
, tgs.*
, wtl.OfferCategory
, CAST(REPLACE(wtl.OfferDescription1,',','') AS NVARCHAR(255)) AS OfferDescription1
, CAST(REPLACE(wtl.OfferDescription2,',','') AS NVARCHAR(255)) AS OfferDescription2
, CAST(REPLACE( wtl.OfferDescription3,',','') AS NVARCHAR(255)) AS OfferDescription3
, wtl.BeginDate
, wtl.EndDate
, wtl.*

FROM CMKTDB13CPR.CMP13.dbo.viewPlTags AS tgs WITH (NOLOCK)

INNER JOIN Website_Tag_List AS wtl WITH (NOLOCK) 
ON tgs.TagCode = wtl.TagCode 

INNER JOIN CMKTDB13CPR.CMP13.dbo.viewPlayersViejas AS pls WITH (NOLOCK) 
ON tgs.PlayerID = pls.PlayerID

WHERE GETDATE() BETWEEN wtl.BeginDate AND wtl.EndDate

  AND pls.Acct = '20481710'
  AND wtl.TagCode LIKE '%HotelOffer%'



SELECT *
FROM  [CRManalytics].DBO.Website_Tag_List
WHERE OfferDescription1 LIKE '%One Night in a Deluxe Room!%'
  AND Offerdescription2 LIKE '%Sun-Thu Rate : FREE / Fri-Sat Rate : FREE%'
  AND OfferDescription3 LIKE '%Valid 11%2017%'	
  --AND OfferDescription3 LIKE '%11/26/2017%'
  --AND OfferDescription3 LIKE '%Valid 11/26/2017 - 11/28/2017%'
  AND GETDATE() BETWEEN BeginDate AND EndDate