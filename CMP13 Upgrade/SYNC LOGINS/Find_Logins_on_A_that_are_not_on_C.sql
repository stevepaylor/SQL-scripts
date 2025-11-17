SELECT 
  A.Instance
, C.Instance
, A.[Login]
, A.Pswd
, A.[Sid]
, A.DefalutDB

FROM LoginSync..CMKTDB13Apr_Logins A
LEFT OUTER JOIN LoginSync..CMKTDB13Cpr_Logins C 
ON A.[Login] = C.[Login]

WHERE C.[Login] IS NULL