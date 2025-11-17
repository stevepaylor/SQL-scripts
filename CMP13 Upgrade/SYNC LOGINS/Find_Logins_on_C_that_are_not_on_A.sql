SELECT 
  C.Instance
, A.Instance
, C.[Login]
, C.Pswd
, C.[Sid]
, C.DefalutDB

FROM LoginSync..CMKTDB13Cpr_Logins C
LEFT OUTER JOIN LoginSync..CMKTDB13Apr_Logins A 
ON C.[Login] = A.[Login]

WHERE A.[Login] IS NULL