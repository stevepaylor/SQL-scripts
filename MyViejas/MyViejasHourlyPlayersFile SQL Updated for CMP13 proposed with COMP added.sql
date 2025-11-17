/* OLD CODE
SELECT Acct
      ,PlayerID
      ,REPLACE(FirstName,',','') AS FirstName
      ,REPLACE(LastName,',','') AS LastName
      ,BirthDt
      ,PtsBal
      ,Promo1Bal
      ,StubsBal
  FROM CMKTDB.dbo.viewPlayers

**/

-- SSIS Package: MyViejasHourlyPlayersFile.dtsx ( SQL Script #2 )

SELECT 
  vPV.Acct
, vPV.PlayerID
, MAX(CAST(REPLACE(vPV.FirstName,',','') AS VARCHAR(25))) AS FirstName
, MAX(CAST(REPLACE(vPV.LastName,',','') AS VARCHAR(25))) AS LastName
, MAX(vPV.BirthDt) AS BirthDt
, SUM(vPV.PtsBal) AS PtsBal
, SUM(vPV.Promo1Bal) AS Promo1Bal
, SUM(vPV.StubsBal) AS StubsBal
, CAST(ROUND(SUM((tPCB.EarnedComp + tPCB.AdjCompCr - tPCB.AdjCompDr - tPCB.CompUsed - tPCB.ExpireComp)*-1),2,1) AS DECIMAL(18,2)) as 'CompBal'

FROM CMKTDB13CPR.CMP13.dbo.viewPlayersViejas vPV WITH (NOLOCK)

INNER JOIN 	tPlayerCompBal (nolock) tPCB
ON vPV.PlayerID = tPCB.PlayerID 

WHERE (tPCB.EarnedComp + tPCB.AdjCompCr - tPCB.AdjCompDr - tPCB.CompUsed - tPCB.ExpireComp) <> 0

GROUP BY
  vPV.Acct
, vPV.PlayerID

ORDER BY
  vPV.Acct
, vPV.PlayerID