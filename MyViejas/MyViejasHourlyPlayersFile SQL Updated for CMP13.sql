/* OLD CODE
SELECT [Acct]
      ,[PlayerID]
      ,REPLACE([FirstName],',','') AS FirstName
      ,REPLACE([LastName],',','') AS LastName
      ,[BirthDt]
      ,[PtsBal]
      ,[Promo1Bal]
      ,StubsBal
  FROM [CMKTDB].[dbo].[viewPlayers]

**/

-- SSIS Package: MyViejasHourlyPlayersFile.dtsx ( SQL Script #2 )

SELECT 
  [Acct]
, [PlayerID]
, CAST(REPLACE([FirstName],',','') AS VARCHAR(25)) AS FirstName
, CAST(REPLACE([LastName],',','') AS VARCHAR(25)) AS LastName
, [BirthDt]
, [PtsBal]
, [Promo1Bal]
, StubsBal

FROM CMKTDB13CPR.CMP13.dbo.viewPlayersViejas WITH (NOLOCK)

--, CAST(REPLACE(wtl.OfferDescription1,',','') AS NVARCHAR(255)) AS OfferDescription1
