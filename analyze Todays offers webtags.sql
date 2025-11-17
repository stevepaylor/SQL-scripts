SELECT DISTINCT
  pls.Acct
--, pls.*
, tgs.PlayerID
, tgs.TagCode 
--, tgs.*
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

ORDER BY 
  wtl.BeginDate
, tgs.TagCode