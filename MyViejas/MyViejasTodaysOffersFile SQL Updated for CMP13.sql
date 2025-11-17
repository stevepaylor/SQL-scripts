-- SSIS Package: MyViejasTodaysOffersFile ( SQL Script #3 )

/** OLD CODE

SELECT pls.Acct
	 , tgs.PlayerID, Website_Tag_List.OfferCategory
	 , REPLACE(Website_Tag_List.OfferDescription1,',','') AS OfferDescription1
	 , REPLACE(Website_Tag_List.OfferDescription2,',','') AS OfferDescription2
	 , REPLACE( Website_Tag_List.OfferDescription3,',','') AS OfferDescription3
	 , Website_Tag_List.BeginDate
	 , Website_Tag_List.EndDate
FROM         CRPTDB01PR.CmktDB.dbo.viewPlTags AS tgs with (NOLOCK)INNER JOIN
                      Website_Tag_List with (NOLOCK) ON tgs.TagCode = Website_Tag_List.TagCode INNER JOIN
                      CRPTDB01PR.CmktDB.dbo.viewPlayers AS pls with (NOLOCK) ON tgs.PlayerID = pls.PlayerID
WHERE getdate() between Website_Tag_List.BeginDate and Website_Tag_List.EndDate

**/

SELECT
  pls.Acct
, tgs.PlayerID
, wtl.OfferCategory
, CAST(REPLACE(wtl.OfferDescription1,',','') AS NVARCHAR(255)) AS OfferDescription1
, CAST(REPLACE(wtl.OfferDescription2,',','') AS NVARCHAR(255)) AS OfferDescription2
, CAST(REPLACE( wtl.OfferDescription3,',','') AS NVARCHAR(255)) AS OfferDescription3
, wtl.BeginDate
, wtl.EndDate

FROM CMKTDB13CPR.CMP13.dbo.viewPlTags AS tgs WITH (NOLOCK)

INNER JOIN Website_Tag_List AS wtl WITH (NOLOCK) 
ON tgs.TagCode = wtl.TagCode 

INNER JOIN CMKTDB13CPR.CMP13.dbo.viewPlayersViejas AS pls WITH (NOLOCK) 
ON tgs.PlayerID = pls.PlayerID

WHERE GETDATE() BETWEEN wtl.BeginDate AND wtl.EndDate


----------------------------------------------------

-- truncate table MV_TodaysOffers


