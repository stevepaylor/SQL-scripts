SELECT 
  tp.acct
, isnull(vv.FirstName, '') AS FirstName
, isnull(vv.LastName, '') AS LastName
, isnull(vv.MiddleInitial, '') AS MiddleInitial
, isnull(vv.MiddleName, '') AS MiddleName
, format(vv.CreatedDtm, 'MM/dd/yy hh:mm tt') AS CreatedDTM
, ep1.TEAM_MEMBER_FIRST_NM + ' ' + ep1.TEAM_MEMBER_LAST_NM + ' #' + eP1.login + ' ' + ep1.position AS Account_Created_By
, format(vv.ModifiedDtm, 'MM/dd/yy hh:mm tt') AS ModifiedDTM
, ep.TEAM_MEMBER_FIRST_NM + ' ' + ep.TEAM_MEMBER_LAST_NM + ' #' + eP.login + ' ' + ep.position AS Last_Modified_By

FROM CMP13.dbo.tPlayer vv

INNER JOIN CMP13.dbo.ViewplayersViejas tp 
ON vv.playerid = tp.playerid

LEFT JOIN CMPAPI.dbo.v_TM ep1 
ON vv.CreatedBy = ep1.EmpId

LEFT JOIN CMPAPI.dbo.v_TM ep 
ON vv.ModifiedBy = ep.EmpId

WHERE tp.acct NOT LIKE '999999%' 
--AND vv.CreatedDtm >= dateadd(dd, -7, getdate()) or vv.ModifiedDtm >= dateadd(dd, -7, getdate()))
  AND vv.firstname NOT LIKE 'VBJ%'
  AND vv.firstname NOT LIKE'%Viejas%'
  AND vv.lastname NOT LIKE '%*table%'
  AND vv.firstname NOT LIKE '%audit%'
  AND vv.lastname NOT LIKE '%test%'
  AND rtrim(vv.lastname) NOT LIKE '%2nd'
  AND rtrim(vv.lastname) NOT LIKE '%3rd'
  AND rtrim(vv.lastname) NOT LIKE '%4th'
  AND rtrim(vv.lastname) NOT LIKE '%11' 
  AND rtrim(vv.lastname) NOT LIKE '%111' 
  AND rtrim(vv.lastname) NOT LIKE '%1V'
  AND rtrim(vv.lastname) NOT LIKE '1-usa'
  AND rtrim(vv.lastname) NOT LIKE '%/w2g%'
  AND rtrim(vv.lastname) NOT LIKE '2-mexico'
  AND (--vv.firstname LIKE '%,%' 
       --OR vv.lastname LIKE '%,%' 
       --OR vv.firstname LIKE '%.'
       --OR vv.lastname LIKE '%.'
            vv.firstname LIKE '%0-9%'
         OR vv.lastname LIKE '%0-9%'
         OR vv.firstname LIKE '%+%' 
         OR vv.lastname LIKE '%+%'
         OR vv.lastname LIKE '%#%'
         OR vv.firstname LIKE '%!%'
         OR vv.firstname LIKE '%@%'
         OR vv.firstname LIKE '%$%'
         OR vv.firstname LIKE '%^%'
         OR vv.firstname LIKE '%&%'
         OR vv.firstname LIKE '%(%'
         OR vv.firstname LIKE '%)%'
         OR vv.firstname LIKE '%%'
         OR vv.firstname LIKE '%%'
         OR vv.firstname LIKE '%{%'
         OR vv.firstname LIKE '%}%'
         OR vv.firstname LIKE '%:%'
         OR vv.firstname LIKE '%;%'
         OR vv.firstname LIKE '%/%'
         OR vv.firstname LIKE '%?%'
         OR vv.lastname LIKE '%%'
         OR vv.lastname LIKE '%%'
         OR vv.lastname LIKE '%{%'
         OR vv.lastname LIKE '%}%'
         OR vv.lastname LIKE '%:%'
         OR vv.lastname LIKE '%;%'
         OR vv.lastname LIKE '%/%'
         OR vv.lastname LIKE '%?%'
         OR vv.lastname LIKE '%!%'
         OR vv.lastname LIKE '%@%'
         OR vv.lastname LIKE '%$%'
         OR vv.lastname LIKE '%^%'
         OR vv.lastname LIKE '%&%'
         OR vv.lastname LIKE '%(%'
         OR vv.lastname LIKE '%)%' 
         OR vv.MiddleName LIKE '%0-9%')

ORDER BY 
vv.ModifiedDtm DESC