/****************************************************************************************
Use MERGE command to update the tShoppingPortal table which is replicated

Run every 1 minute
*****************************************************************************************/

MERGE INTO CMP13.[dbo].[tShoppingPortal] AS target
USING (
SELECT TOP 1000
* 
FROM CMP13.dbo.viewPlayersViejas
WHERE LastTripStartTranCodeGamingDt IS NOT NULL
  AND LastTripStartTranCodeGamingDt >= '01/01/2017'
) AS source
ON target.playerid = source.playerid

-- WHEN NOT MATCHED THEN INSERT

WHEN NOT MATCHED THEN INSERT 
(
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
, LastTripStartTranCodeGamingDt
, ReplTS
)
VALUES 
(
  source.playerid
, source.acct 
, source.FirstName 
, source.MiddleInitial
, source.LastName 
, source.ClubStatus 
, source.HomeEmail 
, source.IsEmailSend
, source.HomeAddr1 
, source.HomeAddr2 
, source.HomeCity 
, source.HomeCountryCode 
, source.HomeCountryName 
, source.HomePostalCode 
, source.HomeStateCode 
, source.HomeStateName 
, source.PtsBal
, source.LastTripStartTranCodeGamingDt
, CURRENT_TIMESTAMP
)

-- WHEN MATCHED THEN UPDATE

WHEN MATCHED THEN UPDATE
SET 
  playerid = source.playerid
, acct = source.acct
, FirstName = source.FirstName
, MiddleInitial = source.MiddleInitial
, LastName = source.LastName
, ClubStatus = source.ClubStatus
, HomeEmail = source.HomeEmail
, IsEmailSend = source.IsEmailSend
, HomeAddr1 = source.HomeAddr1
, HomeAddr2 = source.HomeAddr2
, HomeCity = source.HomeCity
, HomeCountryCode = source.HomeCountryCode
, HomeCountryName = source.HomeCountryName
, HomePostalCode = source.HomePostalCode
, HomeStateCode = source.HomeStateCode
, HomeStateName = source.HomeStateName
, PtsBal = source.PtsBal
, LastTripStartTranCodeGamingDt = source.LastTripStartTranCodeGamingDt
, ReplTS = CURRENT_TIMESTAMP

WHEN NOT MATCHED BY source THEN DELETE;