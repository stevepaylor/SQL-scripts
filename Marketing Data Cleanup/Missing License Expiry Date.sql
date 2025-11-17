SELECT
  tt.playerid
, vv.Acct AS Account
, vv.FirstName + ' ' + vv.LastName AS Guest
, tt.IdentTypeId
, tt.PlayerIdentity
, tt.ExpireDt

FROM CMP13.dbo.tPlayerIdentType tt

LEFT JOIN CMP13.dbo.viewPlayersViejas vv 
ON tt.Playerid = vv.PlayerId

WHERE vv.acct IS NOT NULL 
  AND ExpireDt IS NULL

ORDER BY 
ExpireDt