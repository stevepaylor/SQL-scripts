DECLARE @GamingDt  datetime ; -- Steve added this for testing 
--SET @GamingDt = '04/01/2023' ;  -- Steve added this for testing 

SELECT DISTINCT 
  tPC.Acct
, tA.PlayerId
, tP.FirstName
, tP.LastName
, tP.Nickname
, tPT.PlayerTypeName
, tPz.PrizeName
, tPz.PrizeClubState
, tP.ClubState
, tP.ClubStateQualifyingDate
, tP.ClubStateExpiryDate
, CAST(tA.ModifiedDtm AS DATE) ModifiedDt --, CAST(tA.CreatedDtm AS SMALLDATETIME) CreatedDtm

FROM tAwards tA WITH (NOLOCK)

LEFT JOIN tPrize tPz WITH (NOLOCK) 
ON tA.PrizeId=tPz.PrizeId

LEFT JOIN tPlayer tP WITH (NOLOCK) 
ON tA.PlayerId=tP.PlayerId

LEFT JOIN tPlayerCard tPC WITH (NOLOCK) 
ON tP.PlayerId=tPC.PlayerId

LEFT JOIN tPlayerType tPT WITH (NOLOCK) 
ON tP.PlayerTypeId=tPT.PlayerTypeId

WHERE tA.PrizeId IN( SELECT PrizeId FROM tprize WITH (NOLOCK) WHERE PrizeClubState NOT IN(0) ) 
AND GamingDt >= @GamingDt
AND ClubStateExpiryDate <= DATEADD(DAY,1,CAST(GETDATE() AS DATE))
AND PrizeClubState NOT IN(40)

ORDER BY
  tPz.PrizeClubState
,FirstName
,LastName

----------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT 
  tPC.Acct
, tA.PlayerId
, tP.FirstName
, tP.LastName
, tP.Nickname
, tPT.PlayerTypeName
, tPz.PrizeName
, tPz.PrizeClubState
, tP.ClubState
, tP.ClubStateQualifyingDate
, tP.ClubStateExpiryDate
, CAST(tA.ModifiedDtm AS DATE) ModifiedDt --, CAST(tA.CreatedDtm AS SMALLDATETIME) CreatedDtm

FROM tAwards tA WITH (NOLOCK) 

LEFT JOIN tPrize tPz WITH (NOLOCK) 
ON tA.PrizeId=tPz.PrizeId

LEFT JOIN tPlayer tP WITH (NOLOCK) 
ON tA.PlayerId=tP.PlayerId

LEFT JOIN tPlayerCard tPC WITH (NOLOCK) 
ON tP.PlayerId=tPC.PlayerId

LEFT JOIN tPlayerType tPT WITH (NOLOCK) 
ON tP.PlayerTypeId=tPT.PlayerTypeId

WHERE tA.PrizeId IN( SELECT PrizeId FROM tprize WITH (NOLOCK) WHERE PrizeClubState NOT IN(0) ) 
AND GamingDt >= @GamingDt
AND ClubStateExpiryDate > DATEADD(DAY,90,CAST(GETDATE() AS DATE))
AND PrizeClubState NOT IN(40,49,59)

ORDER BY
  tPz.PrizeClubState
,FirstName
,LastName

--------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT
  tPC.Acct
, tP.PlayerId
, tP.FirstName
, tP.LastName
, tP.Nickname
, tP.ClubState
, tP.PlayerTypeId
, tPT.PlayerTypeName
, tP.ClubStateQualifyingDate
, tP.ClubStateExpiryDate /*, tPCSH.OldClubState, tPCSH.NewClubState,tPCSH.ExpiryDate,tPCSH.ModifiedBy, CAST(tPCSH.ModifiedDtm AS DATE) ModifiedDt */

FROM tPlayerClubStateHistory tPCSH WITH (NOLOCK)

LEFT JOIN tPlayer tP WITH (NOLOCK) 
ON tPCSH.PlayerId=tP.PlayerId

LEFT JOIN tPlayerCard tPC WITH (NOLOCK) 
ON tP.PlayerId=tPC.PlayerId

LEFT JOIN tPlayerType tPT WITH (NOLOCK) 
ON tP.PlayerTypeId=tPT.PlayerTypeId

LEFT JOIN tEmp tE WITH (NOLOCK) 
ON tPCSH.ModifiedBy=tE.EmpId

WHERE Acct IS NOT NULL
AND ClubStateExpiryDate > DATEADD(DAY,90,QualifyingDate)
AND tPCSH.ModifiedBy NOT IN(838)
AND tPCSH.QualifyingDate > CAST(DATEADD(DAY,-1,GETDATE()) AS DATE)
AND NewClubState NOT IN(40,49,59)
AND Position NOT LIKE '%Market%'

ORDER BY 
  tP.PlayerTypeId
, tP.ClubState
, FirstName
, LastName


