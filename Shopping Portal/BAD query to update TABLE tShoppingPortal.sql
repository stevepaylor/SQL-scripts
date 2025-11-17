
--DROP TABLE CMP13.dbo.tShoppingPortal

INSERT INTO CMP13.[dbo].[tShoppingPortal]
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
, LastTripStartTranCodeGamingDt
, CURRENT_TIMESTAMP AS ReplTS

--INTO CMP13.[dbo].[tShoppingPortal]

FROM CMP13.dbo.viewPlayersViejas

WHERE LastTripStartTranCodeGamingDt IS NOT NULL
  AND LastTripStartTranCodeGamingDt >= '01/01/2018'
GO

--ALTER TABLE CMP13.dbo.tShoppingPortal ADD CONSTRAINT
--	PK_tShoppingPortal PRIMARY KEY CLUSTERED 
--	(
--	playerid
--	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--GO

--ALTER TABLE CMP13.dbo.tShoppingPortal SET (LOCK_ESCALATION = TABLE)
--GO

